/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.client;

import dao.FeedbackDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.FeedbackDto;
import model.Product;
import model.ProductVariant;
import model.ProductVariantSize;

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
        int productId = Integer.parseInt(request.getParameter("id"));
        String variantIdParam = request.getParameter("product_variant_id");
        Integer selectedVariantId = null;
        if (variantIdParam != null && !variantIdParam.isEmpty()) {
            try {
                selectedVariantId = Integer.parseInt(variantIdParam);
            } catch (NumberFormatException e) {
                selectedVariantId = null;
            }
        }

        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productId);

        // Lấy tất cả feedback của các ProductVariantSize thuộc product này
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        List<ProductVariant> variants = product.getProductvariants();
        List<FeedbackDto> allFeedbacks = new ArrayList<>();
        double totalRating = 0;
        int countRating = 0;
        for (ProductVariant variant : variants) {
            for (ProductVariantSize pvs : variant.getProductvariantsizes()) {
                List<FeedbackDto> feedbacks = feedbackDAO.getFeedbacksByProductVariantSize(pvs.getId());
                for (FeedbackDto fb : feedbacks) {
                    allFeedbacks.add(fb);
                    totalRating += fb.getRatedStar();
                    countRating++;
                }
            }
        }
        double avgRating = countRating > 0 ? (totalRating / countRating) : 0;

        request.setAttribute("detail_product", product);
                request.setAttribute("variants", variants);

        request.setAttribute("allFeedbacks", allFeedbacks);
        request.setAttribute("avgRating", avgRating);
        if (selectedVariantId != null) {
            request.setAttribute("selected_variant_id", selectedVariantId);
        }
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
