/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import dao.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.PasswordHasher;

/**
 *
 * @author HP
 */
@WebServlet(name = "ChangePassServlet", urlPatterns = {"/profile/change-pass"})
public class ChangePassServlet extends HttpServlet {

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
            out.println("<title>Servlet ChangePassServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePassServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("uName");
        if (email == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        request.setAttribute("email", email);
        request.getRequestDispatcher("/views/client/ChangePass.jsp").forward(request, response);
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
        AccountDAO a = new AccountDAO();
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("uName");
        if (email == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        request.setAttribute("email", email); // Set lại email trước khi kiểm tra lỗi

        // Validate new password and confirm password match
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("message", "New password and confirm password do not match.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("/views/client/ChangePass.jsp").forward(request, response);
            return;
        }

        // Validate old password
        if (!a.checkOldPassword(email, PasswordHasher.hashPassword(oldPassword))) {
            request.setAttribute("message", "Old password is incorrect.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("/views/client/ChangePass.jsp").forward(request, response);
            return;
        }

        // Update new password
        boolean updated = a.updatePassword(email, PasswordHasher.hashPassword(newPassword));
        if (updated) {
            request.setAttribute("message", "Password changed successfully.");
            request.setAttribute("messageType", "success");
        } else {
            request.setAttribute("message", "Failed to change password.");
            request.setAttribute("messageType", "error");
        }
        request.getRequestDispatcher("/views/client/ChangePass.jsp").forward(request, response);
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
