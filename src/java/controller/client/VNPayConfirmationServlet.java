/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import dao.AccountDAO;
import dao.CartDAO;
import dao.OrderDAO;
import dao.OrderDetailDAO;
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
import java.util.logging.Level;
import javax.mail.MessagingException;
import model.Account;
import model.CartRAW;
import java.util.logging.Logger;
import model.ProductVariantSize;

/**
 *
 * @author hoaht
 */
@WebServlet(name = "VNPayConfirmationServlet", urlPatterns = {"/vnpay/confirmation"})
public class VNPayConfirmationServlet extends HttpServlet {

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
            out.println("<title>Servlet VNPayConfirmationServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VNPayConfirmationServlet at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountDAO accountDAO = new AccountDAO();
        CartDAO cartDAO = new CartDAO();
        ProductVariantSizeDAO productVariantSizeDAO = new ProductVariantSizeDAO();
        OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
        OrderDAO orderDAO = new OrderDAO();

        HttpSession session = request.getSession(false);
        String uname = (String) session.getAttribute("uName");

        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        String vnp_TxnRef = request.getParameter("vnp_TxnRef");
        String vnp_TransactionStatus = request.getParameter("vnp_TransactionStatus");

        if (vnp_ResponseCode.equals("00") && vnp_TransactionStatus.equals("00")) {
            orderDAO.updateOrderPaidStatus(vnp_TxnRef);

            Account account = accountDAO.getAccountByEmail(uname);
            List<CartRAW> cartRAWs = cartDAO.listAll(account.getId());
            
//            orderDAO.assignOrderToMarketer(vnp_TxnRef);

            for (CartRAW cartRAW : cartRAWs) {
                ProductVariantSize productVariantSize = productVariantSizeDAO.getProductVariantSizeById(cartRAW.getPvsId());

                // add order detail of order
                orderDetailDAO.addNewOrderDetail(vnp_TxnRef, cartRAW.getPvsId(), cartRAW.getQuantity(), productVariantSize.getProductVariant().getPrice());

                // update status of cart item
                cartDAO.updateStatus(productVariantSize.getId(), account.getId());

                // update quantity of product
                productVariantSizeDAO.updateQuantity(productVariantSize.getId(), productVariantSize.getQuantityInStock() - cartRAW.getQuantity());
            }

            try {
                String htmlContent = "<!DOCTYPE html>"
                        + "<html>"
                        + "<head>"
                        + "<meta charset='UTF-8'>" // Ensure the content is encoded in UTF-8
                        + "<style>"
                        + "body {font-family: Arial, sans-serif;}"
                        + ".container {width: 80%; margin: auto; border: 1px solid #ccc; padding: 20px;}"
                        + ".header {background-color: #f2f2f2; padding: 10px; text-align: center;}"
                        + ".content {margin-top: 20px;}"
                        + ".footer {margin-top: 20px; text-align: center; font-size: 12px; color: #777;}"
                        + "</style>"
                        + "</head>"
                        + "<body>"
                        + "<div class='container'>"
                        + "<div class='header'>"
                        + "<h2>Shoes Shop</h2>"
                        + "</div>"
                        + "<div class='content'>"
                        + "<h3>Confirm successful payment</h3>"
                        + "<p>Hi there,</p>"
                        + "<p>Thank you for shopping at Shoes Shop. We would like to confirm that your order has been successfully paid.</p>"
                        + "<p>Order number: <a href='http://localhost:8080/ShoesShop/orders'><strong>" + vnp_TxnRef + "</strong></a></p>"
                        + "<p>Order details and shipping information will be sent to this email and notified via SMS as soon as possible.</p>"
                        + "</div>"
                        + "<div class='footer'>"
                        + "<p>Do you need support? Contact us: support@shoesshop.com</p>"
                        + "</div>"
                        + "</div>"
                        + "</body>"
                        + "</html>";
                EmailUtility.sendEmailHTMLContent(host, port, user, pass, uname, "Shoes Shop Invoice", htmlContent);
            } catch (MessagingException ex) {
                Logger.getLogger(VNPayConfirmationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            response.sendRedirect(request.getContextPath() + "/cart/completion");
        } else {
            orderDAO.removeOrder(vnp_TxnRef);
            session.removeAttribute("recentOrder");
            session.setAttribute("paid_canceled", true);
            
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
