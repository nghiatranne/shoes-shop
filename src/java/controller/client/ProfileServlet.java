/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import constants.FileLocation;
import dao.AccountDAO;
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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import model.Account;

/**
 *
 * @author hoaht
 */
@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
@MultipartConfig(
        location = FileLocation.ACCOUNT_LOCATION,
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 11
)
public class ProfileServlet extends HttpServlet {

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
            out.println("<title>Servlet ProfileServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProfileServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession(false);
//        OrderDAO orderDAO = new OrderDAO();

        if (session != null && session.getAttribute("uName") != null) {
            String uName = (String) session.getAttribute("uName");

            AccountDAO accountDAO = new AccountDAO();
            Account account = accountDAO.getAccountByEmail(uName);

//            Map<Order, Float> orders_total = orderDAO.listAllOrderWithTotalPriceByAccount(account.getAcc_id());
//            List<Map.Entry<Order, Float>> orders_sorted = orders_total.entrySet()
//                    .stream()
//                    .sorted(Map.Entry.comparingByValue())
//                    .collect(Collectors.toList());
//            request.setAttribute("orders_sorted", orders_sorted);
            request.setAttribute("account", account);

            System.out.println(account.toString());

            request.getRequestDispatcher("/views/client/Profile.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/homepage");
        }
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
        try {
            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
            int acc_id_update = Integer.parseInt(request.getParameter("acc_id"));
            String fullName = request.getParameter("fullName");
            String gender = request.getParameter("gender");
            
            Part part = request.getPart("acc_img");
            String acc_img_fileName = "img_" + acc_id_update + ".jpg";
            part.write(acc_img_fileName);

            Date birthDate = null;
            if (request.getParameter("birthDate").length() != 0) {
                birthDate = sf.parse(request.getParameter("birthDate"));
            }
            String telephone = request.getParameter("telephone");
            String address = request.getParameter("address");
            HttpSession session = request.getSession();
            Account a = new Account(0, acc_img_fileName, fullName, (String) session.getAttribute("uName"), null, gender, address, birthDate, telephone, null, null, null, null, null, null, null, null, null, null);

            AccountDAO accountDAO = new AccountDAO();
            accountDAO.updateAccount(a, acc_id_update);

            response.sendRedirect(request.getContextPath() + "/profile");
        } catch (IOException | NumberFormatException | ParseException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/profile");
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
