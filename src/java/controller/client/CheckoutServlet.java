/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import configuration.VNPayConfig;
import constants.OrderStatus;
import dao.AccountDAO;
import dao.AddressDAO;
import dao.CartDAO;
import dao.OrderDAO;
import dao.OrderDetailDAO;
import dao.PaymentDAO;
import dao.ProductDAO;
import dao.ProductVariantSizeDAO;
import email_config.EmailUtility;
import jakarta.servlet.ServletContext;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import javax.mail.MessagingException;
import model.Account;
import model.Address;
import model.CartRAW;
import model.Order;
import model.PaymentMethod;
import model.ProductVariantSize;

/**
 *
 * @author hoaht
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/cart/infor/save"})
public class CheckoutServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CheckoutServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private String host;
    private String port;
    private String user;
    private String pass;

    public void init() {
        // reads SMTP server setting from web.xml file
        ServletContext context = getServletContext();
        host = context.getInitParameter("host");
        port = context.getInitParameter("port");
        user = context.getInitParameter("user");
        pass = context.getInitParameter("pass");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PaymentDAO paymentDAO = new PaymentDAO();
        OrderDAO orderDAO = new OrderDAO();
        OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
        AccountDAO accountDAO = new AccountDAO();
        ProductDAO productDAO = new ProductDAO();
        CartDAO cartDAO = new CartDAO();
        AddressDAO addressDAO = new AddressDAO();
        ProductVariantSizeDAO productVariantSizeDAO = new ProductVariantSizeDAO();

        HttpSession session = request.getSession(false);
        String emailLogined = (String) session.getAttribute("uName");

        String order_id = VNPayConfig.getRandomNumber(8);
        while (orderDAO.isHasOrderId(order_id)) {
            order_id = VNPayConfig.getRandomNumber(8);
        }
        
        String paymentMethod = request.getParameter("paymentMethod");
        PaymentMethod payment = paymentDAO.getPaymentByPaymentMethod(paymentMethod);

        Account account = accountDAO.getAccountByEmail(emailLogined);
        List<CartRAW> cartRAWs = cartDAO.listAll(account.getId());

        boolean isValidCart = true;
        for (CartRAW cartRAW : cartRAWs) {
            if (productVariantSizeDAO.getProductVariantSizeById(cartRAW.getPvsId()).getQuantityInStock() < cartRAW.getQuantity()) {
                isValidCart = false;
            }
        }

        if (!isValidCart) {
            request.setAttribute("error_quantity", true);
            request.setAttribute("account", account);
            List<PaymentMethod> paymentMethods = paymentDAO.listAll();

            request.setAttribute("paymentMethods", paymentMethods);
            request.getRequestDispatcher("/views/client/CartCheckoutForm.jsp").forward(request, response);
            return;
        }
        
        Address addressChoosen = addressDAO.getAddressChoosenByAccID(account.getId());

        Order order = new Order(order_id, null, null, OrderStatus.SUBMITTED, null, addressChoosen.getFullName(), emailLogined, addressChoosen.getAddress(), addressChoosen.getTel(), account, payment, null, false);
        orderDAO.addNewOrder(order);
        
        int total = 0;
        for (CartRAW cartRAW : cartRAWs) {
            ProductVariantSize productVariantSize = productVariantSizeDAO.getProductVariantSizeById(cartRAW.getPvsId());

            total += productVariantSize.getProductVariant().getPrice() * cartRAW.getQuantity();
        }

        session.setAttribute("recentOrder", order_id);

        if (paymentMethod.equalsIgnoreCase("VNPay")) {
            response.sendRedirect(request.getContextPath() + "/payment?order_id=" + order_id + "&amount=" + total);
        } else {
//            orderDAO.assignOrderToMarketer(order_id);

            for (CartRAW cartRAW : cartRAWs) {
                ProductVariantSize productVariantSize = productVariantSizeDAO.getProductVariantSizeById(cartRAW.getPvsId());

                // add order detail of order
                orderDetailDAO.addNewOrderDetail(order_id, cartRAW.getPvsId(), cartRAW.getQuantity(), productVariantSize.getProductVariant().getPrice());

                // update status of cart item
                cartDAO.updateStatus(productVariantSize.getId(), account.getId());

                // update quantity of product
                // bookDAO.updateQuantity(book.getId(), book.getQuantityInStock() - cartRAW.getQuantity());
                
                // update hold of product
                productVariantSizeDAO.updateHoldingQuantity(productVariantSize.getId(), productVariantSize.getQuantityHolding()+ cartRAW.getQuantity());
            }
            
            try {
                String htmlContent = "<h1>Your order has been sent</h1>";
                htmlContent += "View your order here: <a href='http://localhost:8080/ShoesShop/orders'>Invoice</a>";

                EmailUtility.sendEmailHTMLContent(host, port, user, pass, account.getEmail(), "Shoe Shop Invoice", htmlContent);
            } catch (MessagingException e) {
                e.printStackTrace();
            }
            response.sendRedirect(request.getContextPath() + "/cart/completion");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
