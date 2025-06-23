/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import dao.AccountDAO;
import dao.AddressDAO;
import dao.OrderDAO;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Set;
import model.Account;
import model.Address;
import model.Order;
import model.OrderDetailUser;

/**
 *
 * @author hoaht
 */
@WebServlet(name="OrderDetailServlet", urlPatterns={"/orders/order-detail"})
public class OrderDetailServlet extends HttpServlet {

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
            out.println("<title>Servlet OrderDetailServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderDetailServlet at " + request.getContextPath() + "</h1>");
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
        AccountDAO accountDAO = new AccountDAO();
        AddressDAO addressDAO = new AddressDAO();
        
        String orderID = request.getParameter("id");
        
        HttpSession session = request.getSession(false);
        
        String uEmail = (String) session.getAttribute("uName");
        Account acc = accountDAO.getAccountByEmail(uEmail);
        if (acc != null) {
            List<Address> addresses = addressDAO.listAllAddressByAccount(acc.getId());

            request.setAttribute("addresses", addresses);
        }
        
        OrderDAO orderDAO = new OrderDAO();
        Order detailOrder = orderDAO.getOrderByOrderID(orderID);
        Set<OrderDetailUser> orderDetailUsers = orderDAO.getOrderDetailProductVariantSizeByOrderIDWithFeedbackStatus(orderID, acc.getId());
        
        request.setAttribute("detailOrder", detailOrder);
        request.setAttribute("orderDetails", orderDetailUsers);
        
        for (OrderDetailUser orderDetailUser : orderDetailUsers) {
            System.out.println("------>" + orderDetailUser.isFeedback());
        }
        
        float sub_total = 0;
        for (OrderDetailUser od : orderDetailUsers) {
            sub_total += od.getOrderDetail().getPrice() * od.getOrderDetail().getQuantity();
        }
        request.setAttribute("sub_total", sub_total);
        
        request.getRequestDispatcher("/views/client/OrderDetail.jsp").forward(request, response);
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
