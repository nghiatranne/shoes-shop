/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.OrderFeatures;

import constants.OrderStatus;
import dao.AccountDAO;
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
import java.util.Map;
import model.Account;
import model.Order;
import model.OrderRAW2;
import model.OrderRAW3;

/**
 *
 * @author hoaht
 */
@WebServlet(name = "ListOrderServlet", urlPatterns = {"/admin/orders"})
public class ListOrderServlet extends HttpServlet {

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
            out.println("<title>Servlet ListOrderServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListOrderServlet at " + request.getContextPath() + "</h1>");
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

        String uname = (String) session.getAttribute("uName");

        AccountDAO accountDAO = new AccountDAO();
        OrderDAO orderDAO = new OrderDAO();

        Account account = accountDAO.getAccountByEmail(uname);
        int acc_id = account.getId();

        String orderName = request.getParameter("searchQuery");
        String fullName = request.getParameter("orderName");  
        String status = request.getParameter("status");
        
        String createDate = request.getParameter("createDateFirst");
        String createDate1 = request.getParameter("createDateSecond");

        List<OrderRAW2> listOrderByAdmin;
        List<OrderRAW3> listOrderForSaleManager;
        List<OrderRAW3> listOrderForWarehouse;

        float subTotal = 0;
        if ((boolean) session.getAttribute("isSaleManager")) {
            System.out.println("---> sale manager go here");
            if (orderName != null && !orderName.isEmpty()) {
                listOrderForSaleManager = orderDAO.listOrderByOrderName(orderName);
            } else if (fullName != null && !fullName.isEmpty()) {
                listOrderForSaleManager = orderDAO.listOrderByOrderName(fullName);
            } else if (status != null && !status.isEmpty()) {
                listOrderForSaleManager = orderDAO.listOrderByStatus(Integer.parseInt(status));
            } else if (createDate != null && !createDate.isBlank() && !createDate1.isBlank()) {
                listOrderForSaleManager = orderDAO.listOrderByDate(createDate, createDate1);
            } else {
                listOrderForSaleManager = orderDAO.listOrderByStatus(OrderStatus.statusToInt(OrderStatus.SUBMITTED));
            }

            request.setAttribute("orders", listOrderForSaleManager);
            for (OrderRAW3 orderRAW3 : listOrderForSaleManager) {
                subTotal += orderRAW3.getTotalCost();
            }
        }

        if ((boolean) session.getAttribute("isSale")) {
            System.out.println("---> sale go here");
            if (orderName != null && !orderName.isEmpty()) {
                listOrderByAdmin = orderDAO.listOrderByOrderName(acc_id, orderName);
            } else if (fullName != null && !fullName.isEmpty()) {
                listOrderByAdmin = orderDAO.listOrderByOrderName(acc_id, fullName);
            } else if (status != null && !status.isEmpty()) {
                listOrderByAdmin = orderDAO.listOrderByStatus(acc_id, Integer.parseInt(status));
            } else if (createDate != null && !createDate.isBlank() && !createDate1.isBlank()) {
                listOrderByAdmin = orderDAO.listOrderByDate(acc_id, createDate, createDate1);
            } else {
                listOrderByAdmin = orderDAO.listOrderByStatus(acc_id, OrderStatus.statusToInt(OrderStatus.SUBMITTED));
            }

            request.setAttribute("orders", listOrderByAdmin);
            for (OrderRAW2 orderRAW2 : listOrderByAdmin) {
                subTotal += orderRAW2.getTotalCost();
            }
        }

        if ((boolean) session.getAttribute("isWarehouse")) {
            System.out.println("---> warehouse go here");

            if (orderName != null && !orderName.isEmpty()) {
                listOrderForWarehouse = orderDAO.listOrderByOrderName(orderName);
            } else if (fullName != null && !fullName.isEmpty()) {
                listOrderForWarehouse = orderDAO.listOrderByOrderName(fullName);
            } else if (status != null && !status.isEmpty() && (Integer.parseInt(status) == 1 || Integer.parseInt(status) == 2 || Integer.parseInt(status) == 3 || Integer.parseInt(status) == 4 || Integer.parseInt(status) == 5 || Integer.parseInt(status) == -1 || Integer.parseInt(status) == -2)) {
                listOrderForWarehouse = orderDAO.listOrderByStatus(Integer.parseInt(status));
            } else if (createDate != null && !createDate.isBlank() && !createDate1.isBlank()) {
                listOrderForWarehouse = orderDAO.listOrderByDate(createDate, createDate1);
            } else {
                listOrderForWarehouse = orderDAO.listOrderByStatus(OrderStatus.statusToInt(OrderStatus.CONFIRMED));
            }

            request.setAttribute("orders", listOrderForWarehouse);
            for (OrderRAW3 orderRAW3 : listOrderForWarehouse) {
                subTotal += orderRAW3.getTotalCost();
            }
        }
        
        if (status != null && !status.isEmpty()) {
            request.setAttribute("statusCur", OrderStatus.intToStatus(Integer.parseInt(status)));
        } else {
            request.setAttribute("statusCur", OrderStatus.SUBMITTED);
        }

        request.setAttribute("subTotal", subTotal);

        List<Order> orderNameList = orderDAO.listAllOrderName();

        request.setAttribute("orderName", orderNameList);
        request.getRequestDispatcher("/views/admin/ListOrder.jsp").forward(request, response);
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
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        AccountDAO accountDAO = new AccountDAO();
        OrderDAO orderDAO = new OrderDAO();
        String searchQuery = request.getParameter("searchQuery");

        if (searchQuery == null || searchQuery.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Search query cannot be empty");
            return;
        }

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("uName") == null) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You need to login to view orders!");
            return;
        }
        String uname = (String) session.getAttribute("uName");

        Account account = accountDAO.getAccountByEmail(uname);
        int acc_id = account.getId();
        Map<Order, Float> listOrderByAdmin = orderDAO.searchOrders(acc_id, searchQuery);
        List<Order> orderNameList = orderDAO.listAllOrderName();
        request.setAttribute("orders", listOrderByAdmin);
        request.setAttribute("orderName", orderNameList);

        request.getRequestDispatcher("/views/admin/ListOrder.jsp").forward(request, response);
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
