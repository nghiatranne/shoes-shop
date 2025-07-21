/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin.FeedbackFeatures;

import dao.FeedbackDAO;
import dao.ProductDAO;
import dao.ProductVariantDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Feedback;
import model.Product;
import model.ProductVariant;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ListFeedbackServlet", urlPatterns = {"/admin/feedbacks"})
public class ListFeedbackServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet ListFeedbackServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListFeedbackServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        ProductVariantDAO productVariantDAO = new ProductVariantDAO();
        
        String search = request.getParameter("q");
        String status = request.getParameter("status");
        String product = request.getParameter("product");
        String ratedStar = request.getParameter("ratedStar");
        String sort = request.getParameter("sort") != null ? request.getParameter("sort") : "fullName";
        String order = request.getParameter("order") != null ? request.getParameter("order") : "asc";

        List<ProductVariant> productVariants = productVariantDAO.getAllProductVariants();
        List<Feedback> feedbacks;

       
        if ((search == null || search.isEmpty()) &&
            (status == null || status.isEmpty()) &&
            (product == null || product.isEmpty()) &&
            (ratedStar == null || ratedStar.isEmpty())) {
            feedbacks = feedbackDAO.getAllFeedBacks(sort, order);
        } else {
           
            search = search != null ? search : "";
            status = status != null ? status : "";
            product = product != null ? product : "";
            ratedStar = ratedStar != null ? ratedStar : "";

            feedbacks = feedbackDAO.getFeedbacks(search.trim(), status, product, ratedStar, sort, order);
        }

        request.setAttribute("feedbacks", feedbacks);
        request.setAttribute("productVariants", productVariants);
        request.setAttribute("sort", sort);
        request.setAttribute("order", order);

        request.getRequestDispatcher("/views/admin/ListFeedback.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
