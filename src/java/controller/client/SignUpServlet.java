/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import dao.AccountDAO;
import dao.AddressDAO;
import dao.RoleDAO;
import email_config.EmailUtility;
import jakarta.servlet.ServletContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import javax.mail.MessagingException;
import model.Account;
import model.Address;

/**
 *
 * @author hoaht
 */
@WebServlet(name = "SignUpServlet", urlPatterns = {"/sign-up"})
public class SignUpServlet extends HttpServlet {

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
            out.println("<title>Servlet SignUpServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignUpServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("/views/client/SignUpForm.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private String host;
    private String port;
    private String user;
    private String pass;

    public void init() {
        // reads SMTP server setting from web.xml file
        ServletContext context = getServletContext();
        host = context.getInitParameter("host");
        port = context.getInitParameter("port");
        user = context.getInitParameter("user");
        pass = context.getInitParameter("pass");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
            AccountDAO accountDAO = new AccountDAO();
            AddressDAO addressDAO = new AddressDAO();
            RoleDAO roleDAO = new RoleDAO();

            String fullName = request.getParameter("fullName");
            String telephone = request.getParameter("telephone");
            String email = request.getParameter("email");
            String gender = request.getParameter("gender");
            Date birthDate = null;
            if (request.getParameter("birthDate").length() != 0) {
                birthDate = sf.parse(request.getParameter("birthDate"));
            }
            String address = request.getParameter("address");
            String password = request.getParameter("password");
            String confirm_password = request.getParameter("confirm_password");
            Date createDate = new Date();
            boolean status = true;

            List<String> emails = accountDAO.listAllEmail();
            if (emails.contains(email)) {
                request.setAttribute("error_email", true);
                request.getRequestDispatcher("/views/client/SignUpForm.jsp").forward(request, response);
            } else {
                UUID uuid = UUID.randomUUID();
                String token = uuid.toString();
                Account account = new Account(0, null, fullName, email, password, gender, address, birthDate, telephone, null, createDate, null, null, null, null, null, null, null, null);
                int id = accountDAO.addAccount(account, token);
                
                addressDAO.addNewAddress(id, new Address(0, fullName, address, telephone, null, true));

                try {
                    EmailUtility.sendEmail(host, port, user, pass, email, "Verify Code", "This is your code: " + token);
                } catch (MessagingException ex) {
                    ex.printStackTrace();
                }

                response.sendRedirect(request.getContextPath() + "/login/verify?aId=" + id);
            }
        } catch (ServletException | IOException | ParseException e) {
            e.printStackTrace();
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
