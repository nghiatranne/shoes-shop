/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.PostFeatures;

import constants.FileLocation;
import dao.AccountDAO;
import dao.CategoryDAO;
import dao.PostDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.Account;
import model.Post;
import token.TokenGenerator;

/**
 *
 * @author hoaht
 */
@WebServlet(name = "EditPostServlet", urlPatterns = {"/admin/posts/edit"})
@MultipartConfig(
        location = FileLocation.POST_IMAGE_LOCATION,
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 11
)
public class EditPostServlet extends HttpServlet {

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
            out.println("<title>Servlet EditPostServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditPostServlet at " + request.getContextPath() + "</h1>");
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
        int postId = Integer.parseInt(request.getParameter("id"));
        PostDAO postDAO = new PostDAO();
        Post post = postDAO.getPost(postId);

        CategoryDAO categoryDAO = new CategoryDAO();
        request.setAttribute("categories", categoryDAO.listAllCategory());

        request.setAttribute("post", post);

        request.getRequestDispatcher("/views/admin/EditPost.jsp").forward(request, response);
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
        PostDAO postDAO = new PostDAO();

        String thumbnail_fileName = request.getParameter("old-thumbnail");
        if (request.getParameter("notUpdateThumbnail") == null) {
            Part part = request.getPart("thumbnail");
            String token = TokenGenerator.generateToken();
            thumbnail_fileName = "img_" + token + ".jpg";
            part.write(thumbnail_fileName);
        }

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String postId = request.getParameter("postId");

        if (content == null || content.length() == 0) {
            CategoryDAO categoryDAO = new CategoryDAO();
            request.setAttribute("categories", categoryDAO.listAllCategory());

            request.setAttribute("invalid_content", true);

            request.getRequestDispatcher("/views/admin/AddPost.jsp").forward(request, response);
            return;
        }

        String[] list_category_choose = request.getParameterValues("list_category_choose");

        Post p = new Post(0, title, thumbnail_fileName, content, true, null, null, null, null);

        postDAO.removeAllPostCategory(Integer.parseInt(postId));

        postDAO.updatePost(Integer.parseInt(postId), p, list_category_choose);

        response.sendRedirect(request.getContextPath() + "/admin/posts/post?id=" + postId);
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
