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
import java.util.List;
import model.Account;
//import model.Book;
import model.Role;
import util.PasswordHasher;

/**
 *
 * @author hoaht
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

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
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("/views/client/LoginForm.jsp").forward(request, response);
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
        AccountDAO accountDAO = new AccountDAO();
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String hashedPassword = PasswordHasher.hashPassword(password);
        
        boolean status = true;
        boolean isExisted = false;
        boolean isAdmin = false;
        boolean isMaketer = false;
        boolean isSale = false;
        boolean isSaleManager = false;
        boolean isWarehouse = false;
        
        List<Account> accounts = accountDAO.listAllEmailPass();
        for (Account a : accounts) {
            if (email.equals(a.getEmail()) && hashedPassword.equals(a.getPassword())) {

                isExisted = true;
                status = a.getStatus();
                for (Role role : a.getRoles()) {
                    if (role.getRole_name().equalsIgnoreCase("ADMIN")) {
                        isAdmin = true;
                    }
                    if (role.getRole_name().equalsIgnoreCase("MARKETER")) {
                        isMaketer = true;
                    }
                    if (role.getRole_name().equalsIgnoreCase("SALE")) {
                        isSale = true;
                    }
                    if (role.getRole_name().equalsIgnoreCase("SALE MANAGER")) {
                        isSaleManager = true;
                    }
                    if (role.getRole_name().equalsIgnoreCase("WAREHOUSE")) {
                        isWarehouse = true;
                    }
                }
                
                break;
            }
        }
        
        if (isExisted && status) {
            HttpSession session = request.getSession();
            session.setAttribute("uName", email);
            session.setAttribute("isAdmin", isAdmin);
            session.setAttribute("isMaketer", isMaketer);
            session.setAttribute("isSale", isSale);
            session.setAttribute("isSaleManager", isSaleManager);
            session.setAttribute("isWarehouse", isWarehouse);
            
            response.sendRedirect(request.getContextPath() + "/homepage");
        } else {
            request.setAttribute("error", !isExisted);
            request.setAttribute("authen", !status);
            request.getRequestDispatcher("/views/client/LoginForm.jsp").forward(request, response);
        }
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
