/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.api.cart_api;

import com.google.gson.Gson;
import dao.AccountDAO;
import dao.CartDAO;
import dao.ProductVariantSizeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

/**
 *
 * @author hoaht
 */
@WebServlet(name="AddToCartAPI", urlPatterns={"/api/cart/add"})
public class AddToCartAPI extends HttpServlet {
   
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
            out.println("<title>Servlet AddToCartAPI</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddToCartAPI at " + request.getContextPath () + "</h1>");
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
        processRequest(request, response);
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
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("uName") == null) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You need to login to add to cart!");
            return;
        }
        
        String uname = (String) session.getAttribute("uName");
        
        AccountDAO accountDAO = new AccountDAO();
        Account account = accountDAO.getAccountByEmail(uname);
        
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int sizeId = Integer.parseInt(request.getParameter("sizeId"));
        int variantId = Integer.parseInt(request.getParameter("variantId"));


        int acc_id = account.getId();
        
        ProductVariantSizeDAO productVariantSizeDAO = new ProductVariantSizeDAO();
        
        ProductVariantSize productVariantSize = productVariantSizeDAO.getProductVariantSizesByProductVariantId(variantId, sizeId);
        
        CartDAO cartDAO = new CartDAO();
        cartDAO.addToCart(productVariantSize.getId(), acc_id, quantity);
        
        Gson gson = new Gson();
        java.util.HashMap<String, Object> resp = new java.util.HashMap<>();
        resp.put("success", true);
        resp.put("msg", "Add to cart success!");
        response.getWriter().write(gson.toJson(resp));
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
