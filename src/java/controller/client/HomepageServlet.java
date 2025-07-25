/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

//import dao.BookDAO;
import dao.PostDAO;
import dao.ProductDAO;
import dao.SliderDAO;
import dao.FeedbackDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import model.Post;
import model.Product;
import model.Slider;

/**
 *
 * @author hoaht
 */
@WebServlet(name = "HomepageServlet", urlPatterns = {"/homepage"})
public class HomepageServlet extends HttpServlet {

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
        System.out.println("This is home page");
        SliderDAO sliderDao = new SliderDAO();
        ProductDAO productDAO = new ProductDAO();
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        List<Slider> sliders = sliderDao.getAllSliders();
        List<Product> newProducts = productDAO.listNewProducts();
        List<Product> bestSellers = productDAO.listBestSellingProducts(8);
        // Tạo map lưu rating trung bình và số review cho từng sản phẩm
        Map<Integer, Double> productAvgRating = new HashMap<>();
        Map<Integer, Integer> productReviewCount = new HashMap<>();
        for (Product p : newProducts) {
            double avg = feedbackDAO.getAverageRatingByProduct(p.getId());
            int count = feedbackDAO.getTotalReviewsByProduct(p.getId());
            productAvgRating.put(p.getId(), avg);
            productReviewCount.put(p.getId(), count);
        }
        for (Product p : bestSellers) {
            if (!productAvgRating.containsKey(p.getId())) {
                double avg = feedbackDAO.getAverageRatingByProduct(p.getId());
                int count = feedbackDAO.getTotalReviewsByProduct(p.getId());
                productAvgRating.put(p.getId(), avg);
                productReviewCount.put(p.getId(), count);
            }
        }
        request.setAttribute("sliders", sliders);
        request.setAttribute("newProducts", newProducts);
        request.setAttribute("bestSellers", bestSellers);
        request.setAttribute("productAvgRating", productAvgRating);
        request.setAttribute("productReviewCount", productReviewCount);
        request.getRequestDispatcher("/views/client/Homepage.jsp").forward(request, response);
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
