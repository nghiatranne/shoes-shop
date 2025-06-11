/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.AccountDAO;
import dao.PostDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author hoaht
 */
@WebServlet(name = "MarketerDashboard", urlPatterns = {"/admin/marketer-dashboard"})
public class MarketerDashboard extends HttpServlet {

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
            out.println("<title>Servlet MarketerDashboard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MarketerDashboard at " + request.getContextPath() + "</h1>");
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
        SimpleDateFormat sf = new SimpleDateFormat("dd/MM/yyyy");
//        PostDAO postDAO = new PostDAO();
//        BookDAO bookDAO = new BookDAO();
        AccountDAO accountDAO = new AccountDAO();
//        FeedbackDAO feedbackDAO = new FeedbackDAO();

//        int totalNewPostToday = postDAO.getTotalNewPostToday();
//        int totalPost = postDAO.getTotalPost();
//
//        int totalBookCreateToday = bookDAO.getTotalBookCreateToday();
//        int totalBook = bookDAO.getTotalBook();

        int totalCustomerToday = accountDAO.getTotalCustomerToday();
        int totalCustomer = accountDAO.getTotalCustomer();

//        int totalFeedbackToday = feedbackDAO.getTotalFeedbackToday();
//        int totalFeedback = feedbackDAO.getTotalFeedback();

//        request.setAttribute("totalNewPostToday", totalNewPostToday);
//        request.setAttribute("totalPost", totalPost);
//
//        request.setAttribute("totalBookCreateToday", totalBookCreateToday);
//        request.setAttribute("totalBook", totalBook);
//
//        request.setAttribute("totalCustomerToday", totalCustomerToday);
//        request.setAttribute("totalCustomer", totalCustomer);
//
//        request.setAttribute("totalFeedbackToday", totalFeedbackToday);
//        request.setAttribute("totalFeedback", totalFeedback);

//        List<BookRAW> listBookWithTotalSaveToCart = new ArrayList<>();
//        if (request.getParameter("dateFrom") != null && request.getParameter("dateTo") != null && !request.getParameter("dateFrom").isBlank() && !request.getParameter("dateTo").isBlank()) {
//            Date dateFrom;
//            Date dateTo;
//
//            try {
//                dateFrom = sf.parse(request.getParameter("dateFrom"));
//                dateTo = sf.parse(request.getParameter("dateTo"));
//
//                request.setAttribute("dateFrom", request.getParameter("dateFrom"));
//                request.setAttribute("dateTo", request.getParameter("dateTo"));
//
//                listBookWithTotalSaveToCart = bookDAO.listAllBookWithTotalSaveToCart(dateFrom, dateTo);
//            } catch (ParseException e) {
//                e.printStackTrace();
//            }
//        } else {
//            listBookWithTotalSaveToCart = bookDAO.listAllBookWithTotalSaveToCart();
//        }

//        request.setAttribute("books", listBookWithTotalSaveToCart);

        request.getRequestDispatcher("/views/admin/MarketerDashboard.jsp").forward(request, response);
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
