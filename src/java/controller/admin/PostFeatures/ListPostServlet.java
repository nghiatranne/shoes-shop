/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin.PostFeatures;

import dao.AccountDAO;
import dao.CategoryDAO;
import dao.PostDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Category;
import model.Post;

/**
 *
 * @author hoaht
 */
@WebServlet(name="ListPostServlet", urlPatterns={"/admin/posts"})
public class ListPostServlet extends HttpServlet {
   
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
            out.println("<title>Servlet ListPostServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListPostServlet at " + request.getContextPath () + "</h1>");
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
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("uName") == null) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You need to login to view list posts!");
            return;
        }
        
        PostDAO postDAO = new PostDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        AccountDAO accountDAO = new AccountDAO();
        
        List<Account> accounts = accountDAO.listAllSorted("SALE");
        
        request.setAttribute("accounts", accounts);
        
        List<Post> posts;
        
        String q = request.getParameter("q");
        String cId = request.getParameter("c_id");
        String a_id = request.getParameter("a_id");
        
        if (request.getParameter("q") != null && request.getParameter("q").length() != 0) {
            posts = postDAO.listAllPostsWithTitle(q);
        } else if (cId != null && cId.length() != 0) {
            request.setAttribute("idChoose", cId);
            posts = postDAO.listAllPostsWithCId(Integer.parseInt(cId));
        } else if (request.getParameter("a_id") != null && request.getParameter("a_id").length() != 0) {
            request.setAttribute("acIdChoose", a_id);
            posts = postDAO.listAllPostsWithAId(Integer.parseInt(a_id));
        } else {
            posts = postDAO.listAllPosts();
        }
        
        request.setAttribute("posts", posts);
        
        List<Category> categories = categoryDAO.listAllCategory();
        request.setAttribute("categories", categories);
        
        request.getRequestDispatcher("/views/admin/ListPost.jsp").forward(request, response);
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
