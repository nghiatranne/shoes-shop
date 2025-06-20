/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.client;

import constants.NumberPerPage;
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
import model.*;
import dao.BrandDAO;
import dao.CategoryDAO;

/**
 *
 * @author admin
 */
@WebServlet(name="ProductFilterServlet", urlPatterns={"/products"})
public class ProductFilterServlet extends HttpServlet {
   
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
            out.println("<title>Servlet ProductFilterServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductFilterServlet at " + request.getContextPath () + "</h1>");
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
        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        BrandDAO brandDAO = new BrandDAO();
        List<Category> categories = categoryDAO.listAllCategory();
        List<Brand> brands = brandDAO.listAllBrand();
        request.setAttribute("categories", categories);
        request.setAttribute("brands", brands);

        // Parse filter params
        String[] categoryParams = request.getParameterValues("category");
        String[] brandParams = request.getParameterValues("brand");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String ratingStr = request.getParameter("rating");
        String key = request.getParameter("key");

        List<Integer> categoryIds = new ArrayList<>();
        if (categoryParams != null) {
            for (String s : categoryParams) {
                try { categoryIds.add(Integer.parseInt(s)); } catch (Exception ex) {}
            }
        }
        List<Integer> brandIds = new ArrayList<>();
        if (brandParams != null) {
            for (String s : brandParams) {
                try { brandIds.add(Integer.parseInt(s)); } catch (Exception ex) {}
            }
        }
        Double minPrice = null;
        if (minPriceStr != null && !minPriceStr.isEmpty()) {
            try { minPrice = Double.parseDouble(minPriceStr); } catch (Exception ex) {}
        }
        Double maxPrice = null;
        if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
            try { maxPrice = Double.parseDouble(maxPriceStr); } catch (Exception ex) {}
        }
        Integer rating = null;
        if (ratingStr != null && !ratingStr.equals("all") && !ratingStr.isEmpty()) {
            try { rating = Integer.parseInt(ratingStr); } catch (Exception ex) {}
        }

        List<Product> products = productDAO.getFilterProduct(categoryIds, brandIds, minPrice, maxPrice, rating, key);

        int numPerPage = NumberPerPage.SIZE.getValue();
        int numProducts = products.size();
        int numPages = (int) Math.ceil((double) numProducts / numPerPage);
        int currentPage;
        try {
            currentPage = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
            currentPage = 1;
        }
        int start = (currentPage - 1) * numPerPage;
        int end = Math.min(start + numPerPage, numProducts);
        List<Product> productsOnPage = products.subList(Math.max(0, start), Math.max(0, end));
        request.setAttribute("products", productsOnPage);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("numPages", numPages);
        request.getRequestDispatcher("/views/client/layout/ListProduct.jsp").forward(request, response);
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
