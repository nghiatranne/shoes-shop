/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin.CustomerFeatures;

import dao.AccountDAO;
import dao.ChangeHistoryDAO;
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
import model.ChangeHistory;

/**
 *
 * @author Admin
 */
@WebServlet(name = "DetailCustomerServlet", urlPatterns = {"/admin/customers/customer"})
public class DetailCustomerServlet extends HttpServlet {
   
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
            out.println("<title>Servlet DetailCustomerServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DetailCustomerServlet at " + request.getContextPath () + "</h1>");
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
        try {
            int accountId = Integer.parseInt(request.getParameter("id"));
            AccountDAO accountDAO = new AccountDAO();
            ChangeHistoryDAO changeHistoryDAO = new ChangeHistoryDAO();
            Account accountDetail = accountDAO.getAccount(accountId);
            HttpSession session = request.getSession();
            String uEmail = (String) session.getAttribute("uName");
            Account userAccount = accountDAO.getAccountByEmail(uEmail);
            List<ChangeHistory> changeHistories = changeHistoryDAO.getChangeHistoriesByAccountId(accountId,userAccount.getId());
            request.setAttribute("account_detail", accountDetail);
            request.setAttribute("changeHistory", changeHistories);
            request.getRequestDispatcher("/views/admin/DetailCustomer.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();

        }
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
        HttpSession session = request.getSession();
        String uEmail = (String) session.getAttribute("uName");

        try {
            int accountId = Integer.parseInt(request.getParameter("id"));
            String fullName = request.getParameter("fullname");
            String email = request.getParameter("email");
            String telephone = request.getParameter("mobile");
            String address = request.getParameter("address");
            
            String gender = null;
            if (request.getParameter("gender") != null) {
                gender = Boolean.parseBoolean(request.getParameter("gender")) ? "Male" : "Female";
            }

            AccountDAO accountDAO = new AccountDAO();
            Account userAccount = accountDAO.getAccountByEmail(uEmail);

            Account updatedAccount = new Account(accountId, null, fullName, email, null, gender, address, null, telephone, null, null, null, null, null, null, null, null, null, null);
            accountDAO.updateAccountCustomer(updatedAccount, accountId);
            
            ChangeHistoryDAO changeHistoryDAO = new ChangeHistoryDAO();
            ChangeHistory changeHistory = new ChangeHistory(0, new java.util.Date(), userAccount, email, fullName, gender != null ? gender.equalsIgnoreCase("Male") : null, telephone);

            changeHistoryDAO.insert(changeHistory);

            response.sendRedirect(request.getContextPath() + "/admin/customers");
        } catch (Exception e) {
            e.printStackTrace();

        }
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
