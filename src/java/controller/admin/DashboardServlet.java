/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.StatisticsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import model.CustomerStatistics;
import model.FeedbackStatistics;
import model.OrderStatistics;
import model.OrderTrend;
import model.RevenueStatistics;

/**
 *
 * @author hoaht
 */
@WebServlet(name = "DashboardServlet", urlPatterns = {"/admin/dashboard"})
public class DashboardServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet HomepageServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomepageServlet at " + request.getContextPath() + "</h1>");
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
        StatisticsDAO st = new StatisticsDAO();

        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        Date startDate;
        Date endDate;

        if (startDateStr != null && !startDateStr.isEmpty()) {
            startDate = Date.valueOf(startDateStr);
        } else {
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.DAY_OF_YEAR, -7);
            startDate = new Date(cal.getTimeInMillis());
        }

        if (endDateStr != null && !endDateStr.isEmpty()) {
            endDate = Date.valueOf(endDateStr);
        } else {
            endDate = new Date(System.currentTimeMillis());
        }

        OrderStatistics stats = st.getOrderStatistics(startDate, endDate);

        RevenueStatistics revenueStats = new RevenueStatistics();
        revenueStats.setTotalRevenue(st.getTotalRevenue(startDate, endDate));
        revenueStats.setRevenueByCategory(st.getRevenueByCategory(startDate, endDate));

        CustomerStatistics customerStats = new CustomerStatistics();
        customerStats.setNewRegisteredCustomers(st.getNewRegisteredCustomers(startDate, endDate));
        customerStats.setNewBoughtCustomers(st.getNewBoughtCustomers(startDate, endDate));

        FeedbackStatistics feedbackStats = new FeedbackStatistics();
        feedbackStats.setAverageStars(st.getAverageRating(startDate, endDate));
        Map<String, Double> averageRatingByCategory = st.getAverageRatingByCategory(startDate, endDate);

        List<OrderTrend> orderTrends = st.getOrderTrend(startDate, endDate);

        request.setAttribute("orderStats", stats);
        request.setAttribute("revenueStats", revenueStats);
        request.setAttribute("customerStats", customerStats);
        request.setAttribute("feedbackStats", feedbackStats);
        request.setAttribute("averageRatingByCategory", averageRatingByCategory);
        request.setAttribute("orderTrend", orderTrends);
        request.setAttribute("startDate", startDateStr);
        request.setAttribute("endDate", endDateStr);
        request.getRequestDispatcher("/views/admin/Dashboard.jsp").forward(request, response);
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
