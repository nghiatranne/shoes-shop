/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.api.address_api;

import com.google.gson.Gson;
import dao.AccountDAO;
import dao.AddressDAO;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Address;
import model.MsgAddress;

/**
 *
 * @author hoaht
 */
@WebServlet(name="AddAddressServlet", urlPatterns={"/api/address/add"})
public class AddAddressServlet extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddAddressServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddAddressServlet at " + request.getContextPath() + "</h1>");
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
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("uName") == null) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You need to login to add to address!");
            return;
        }
        
        String uname = (String) session.getAttribute("uName");
        
        AccountDAO accountDAO = new AccountDAO();
        Account account = accountDAO.getAccountByEmail(uname);
        
        int acc_id = account.getId();
        String address = request.getParameter("address");
        String fullName = request.getParameter("name");
        String tel = request.getParameter("telephone");
        boolean isDefault = false;
        if (request.getParameter("isDefault") != null) {
            isDefault = Boolean.parseBoolean(request.getParameter("isDefault"));
        }
        
        AddressDAO addressDAO = new AddressDAO();
        Address addressModel = new Address(0, fullName, address, tel, null, isDefault);
        
        int addressID = addressDAO.addNewAddress(acc_id, addressModel);
        
        if (isDefault) {
            addressDAO.turnOffOtherAddress(acc_id, addressID);
        }
        
        MsgAddress msgAddress = new MsgAddress("Add new address success!", addressModel);
        Gson gson = new Gson();
        String msgAddressJson = gson.toJson(msgAddress);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(msgAddressJson);
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
