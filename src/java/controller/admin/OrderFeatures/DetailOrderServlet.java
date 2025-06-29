/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.OrderFeatures;

import constants.OrderStatus;
import controller.client.VNPayConfirmationServlet;
import dao.AccountDAO;
import dao.OrderDAO;
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
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import javax.mail.MessagingException;
import model.Order;
import model.OrderDetail;
import model.OrderDetailRAW;
import model.SaleRAW;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hoaht
 */
@WebServlet(name = "DetailOrderServlet", urlPatterns = {"/admin/orders/order"})
public class DetailOrderServlet extends HttpServlet {

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
            out.println("<title>Servlet DetailOrderServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DetailOrderServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("uName") == null) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You need to login to view orders!");
            return;
        }

        OrderDAO orderDAO = new OrderDAO();
        String order_id = request.getParameter("order_id");
        AccountDAO accountDAO = new AccountDAO();

        String saleNameManageOrder = orderDAO.getSaleNameByOrderID(order_id);
        Order order = orderDAO.getDetailOrderByOrderId(order_id);
        List<OrderDetailRAW> orderDetailRAWs = orderDAO.getListOrderDetailByOrderID(order_id);

        List<SaleRAW> accountsRoleSale = accountDAO.getListAccountRoleSale();

        request.setAttribute("oder_by_id", order);
        request.setAttribute("orderDetailRAWs", orderDetailRAWs);
        request.setAttribute("accountsRoleSale", accountsRoleSale);

        float subTotal = 0;
        for (OrderDetail od : order.getOrderDetails()) {
            subTotal += od.getPrice() * od.getQuantity();
        }

        request.setAttribute("subtotal", subTotal);

        List<OrderStatus> orderStatuses = new ArrayList<>();

        if ((boolean) session.getAttribute("isSale") || (boolean) session.getAttribute("isSaleManager")) {
            switch (order.getStatus()) {
                case SUBMITTED: {
                    if (order.isPaid()) {
                        orderStatuses.add(OrderStatus.CONFIRMED);
                    } else {
                        orderStatuses.add(OrderStatus.CONFIRMED);
                        orderStatuses.add(OrderStatus.REJECTED);
                    }
                }
                case PACKAGING:
                    orderStatuses.add(OrderStatus.SHIPPING);
                case SHIPPING: {
                    orderStatuses.add(OrderStatus.SHIPPED);
                    orderStatuses.add(OrderStatus.CANCELED);
                }
                case SHIPPED:
                    orderStatuses.add(OrderStatus.COMPLETED);
                default: {
                }
            }
        }

        if ((boolean) session.getAttribute("isWarehouse")) {
            switch (order.getStatus()) {
                case CONFIRMED: {
                    orderStatuses.add(OrderStatus.PACKAGING);
                }
                case PACKAGING:
                    orderStatuses.add(OrderStatus.SHIPPING);
                default: {
                }
            }
        }

        request.setAttribute("list_status", orderStatuses);
        request.setAttribute("realStatus", order.getStatus());
        request.setAttribute("saleNameManageOrder", saleNameManageOrder);

        request.getRequestDispatcher("/views/admin/DetailOrder.jsp").forward(request, response);
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
        OrderDAO orderDAO = new OrderDAO();
        ProductVariantSizeDAO productVariantSizeDAO = new ProductVariantSizeDAO();

        String order_id = request.getParameter("order_id");
        String order_status = request.getParameter("order_status");

        HttpSession session = request.getSession(false);

        boolean b = OrderStatus.isOrderStatus(order_status);
        if (b) {
            OrderStatus new_status = OrderStatus.valueOf(order_status);

            if (new_status == OrderStatus.REJECTED || new_status == OrderStatus.CANCELED) {
                orderDAO.updateStatusOrder(new_status, order_id);

                Set<OrderDetail> orderDetails = orderDAO.getOrderDetailProductVariantSizeByOrderID(order_id);

                for (OrderDetail od : orderDetails) {
                    productVariantSizeDAO.updateQuantity(od.getProductVariantSize().getId(), od.getProductVariantSize().getQuantityInStock() + od.getQuantity());
                }
                session.setAttribute("update_status_success", true);
                session.setAttribute("order_id_updated", order_id);
                response.sendRedirect(request.getContextPath() + "/admin/orders");
                return;
            }

            if ((new_status == OrderStatus.PACKAGING || new_status == OrderStatus.SHIPPING)) {
                if (session.getAttribute("isWarehouse") != null) {
                    boolean isUpdate = orderDAO.updateStatusOrder(new_status, order_id);
                    if (isUpdate) {
                        session.setAttribute("update_status_success", true);
                        session.setAttribute("order_id_updated", order_id);
                        response.sendRedirect(request.getContextPath() + "/admin/orders");
                        return;
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/orders/order?order_id=" + order_id);
                    return;
                }
            }

            if (new_status == OrderStatus.SHIPPED) {
                Order order = orderDAO.getOrderByOrderID(order_id);
                String email = order.getEmail();
                String fullName = order.getFullName();
                
                try {
                    String htmlContent = "<!DOCTYPE html>"
                            + "<html>"
                            + "<head>"
                            + "<meta charset='UTF-8'>"
                            + "<style>"
                            + "body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f4f4; color: #333; margin: 0; padding: 20px; }"
                            + "h1 { color: #0254EB; }"
                            + "p { line-height: 1.5; }"
                            + "a { color: #0254EB; text-decoration: underline; }"
                            + "a:hover { background-color: #013880; }"
                            + ".container { background-color: #ffffff; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }"
                            + "</style>"
                            + "</head>"
                            + "<body>"
                            + "<div class='container'>"
                            + "<h1>Order Confirmation</h1>"
                            + "<p>Dear " + fullName + ",</p>"
                            + "<p>Thank you for your purchase at Athena Bookstore! We are pleased to inform you that your order <b>ID #" + order_id + "</b> has been <strong>shipped successfully</strong>.</p>"
                            + "<p>We would love to hear your thoughts about your shopping experience! <a href='http://localhost:8080/BookShopping/orders/order-detail?id=" + order_id + "'>Click here to completed your order.</a></p>"
                            + "<p>Should you have any questions or need further assistance, please do not hesitate to contact us.</p>"
                            + "<p>Warm regards,<br>Athena Bookstore Team</p>"
                            + "</div>"
                            + "</body>"
                            + "</html>";
                    EmailUtility.sendEmailHTMLContent(host, port, user, pass, email, "Athena Bookstore Completed", htmlContent);
                } catch (MessagingException ex) {
                    Logger.getLogger(VNPayConfirmationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                boolean isUpdate = orderDAO.updateStatusOrder(new_status, order_id);
                orderDAO.updateOrderPaidStatus(order_id);
                if (isUpdate) {
                    session.setAttribute("update_status_success", true);
                    session.setAttribute("order_id_updated", order_id);
                    response.sendRedirect(request.getContextPath() + "/admin/orders");
                    return;
                }
            }

            boolean isUpdate = orderDAO.updateStatusOrder(new_status, order_id);
            if (isUpdate) {
                session.setAttribute("update_status_success", true);
                session.setAttribute("order_id_updated", order_id);
                response.sendRedirect(request.getContextPath() + "/admin/orders");
            }
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
