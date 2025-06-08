/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.AccountFeatures;

import dao.AccountDAO;
import dao.RoleDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author hoaht
 */
@WebServlet(name = "AssignRoleAccountServlet", urlPatterns = {"/admin/accounts/assign-role"})
public class AssignRoleAccountServlet extends HttpServlet {

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
            out.println("<title>Servlet AssignRoleAccountServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AssignRoleAccountServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        int acc_id = Integer.parseInt(request.getParameter("acc_id"));
        String roleIdStr = request.getParameter("role_id");
        String status = request.getParameter("status");

        RoleDAO roleDAO = new RoleDAO();
        AccountDAO accountDAO = new AccountDAO();

        // Xử lý thay đổi role nếu có
        if (roleIdStr != null && !roleIdStr.isEmpty() && !roleIdStr.equals("Select role to assign")) {
            try {
                int role_id = Integer.parseInt(roleIdStr);
                roleDAO.assignRoleToAccount(acc_id, role_id);
            } catch (NumberFormatException e) {
                e.printStackTrace(); // Hoặc xử lý lỗi theo cách khác nếu cần
            }
        }

        // Xử lý thay đổi trạng thái
        if (status != null) {
            int statusValue = status.equals("available") ? 1 : 0;
            accountDAO.changeStatusToAccount(acc_id, statusValue);
        }

        response.sendRedirect(request.getContextPath() + "/admin/accounts/account?id=" + acc_id);
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
