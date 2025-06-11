/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.client;

import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Product;

/**
 *
 * @author admin
 */
@WebServlet(name="ProductDetailServlet", urlPatterns={"/products/product-detail"})
public class ProductDetailServlet extends HttpServlet {
   
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
            out.println("<title>Servlet ProductDetailServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductDetailServlet at " + request.getContextPath () + "</h1>");
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

        int productId = Integer.parseInt(request.getParameter("productId"));
        
        ProductDAO productDAO = new ProductDAO();
        
//        int quantitySold = ProductDAO.getSoldQuantityByIsbn(productId);
          Product product = productDAO.getProductById(productId);
//        FeedbackDAO fb = new FeedbackDAO();
//        List<Feedback> listF = fb.getFeedbacksByISBN(book_isbn);
            List<Product> listBookRelated = productDAO.listBookRelated(productId);

//        double averageRating = fb.getAverageRating(book_isbn);
//        int totalReviews = fb.getTotalReviews(book_isbn);
//
//        int count5Star = fb.getCountByStar(book_isbn, 5);
//        int count4Star = fb.getCountByStar(book_isbn, 4);
//        int count3Star = fb.getCountByStar(book_isbn, 3);
//        int count2Star = fb.getCountByStar(book_isbn, 2);
//        int count1Star = fb.getCountByStar(book_isbn, 1);

//        int percent5Star = totalReviews > 0 ? (count5Star * 100 / totalReviews) : 0;
//        int percent4Star = totalReviews > 0 ? (count4Star * 100 / totalReviews) : 0;
//        int percent3Star = totalReviews > 0 ? (count3Star * 100 / totalReviews) : 0;
//        int percent2Star = totalReviews > 0 ? (count2Star * 100 / totalReviews) : 0;
//        int percent1Star = totalReviews > 0 ? (count1Star * 100 / totalReviews) : 0;

        request.setAttribute("product_related", listBookRelated);
        request.setAttribute("detail_product", product);
//        request.setAttribute("detail_book_stock", bookStockDAO.getBookStock(book_isbn));
//        request.setAttribute("list_feedback", listF);
//        request.setAttribute("quantitySold", quantitySold);
//        request.setAttribute("averageRating", averageRating);
//        request.setAttribute("totalReviews", totalReviews);
//        request.setAttribute("count5Star", count5Star);
//        request.setAttribute("count4Star", count4Star);
//        request.setAttribute("count3Star", count3Star);
//        request.setAttribute("count2Star", count2Star);
//        request.setAttribute("count1Star", count1Star);
//        request.setAttribute("percent5Star", percent5Star);
//        request.setAttribute("percent4Star", percent4Star);
//        request.setAttribute("percent3Star", percent3Star);
//        request.setAttribute("percent2Star", percent2Star);
//        request.setAttribute("percent1Star", percent1Star);

        request.getRequestDispatcher("/views/client/layout/DetailProduct.jsp").forward(request, response);
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
