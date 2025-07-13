/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import constants.FileLocation;
import dao.AccountDAO;
import dao.*;
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
import model.*;
import token.TokenGenerator;

/**
 *
 * @author USA
 */
@WebServlet(name = "FeedbackServlet", urlPatterns = {"/orders/order-detail/feedback"})
@MultipartConfig(
        location = FileLocation.FEEDBACK_LOCATION,
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 11
)
public class FeedbackServlet extends HttpServlet {

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
            out.println("<title>Servlet FeedbackServllet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FeedbackServllet at " + request.getContextPath() + "</h1>");
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
        String uEmail = (String) session.getAttribute("uName");
        int productVariantSizeId = Integer.parseInt(request.getParameter("id"));

        ProductVariantSizeDAO pvsDao = new ProductVariantSizeDAO();
        ProductVariantSize pvs = pvsDao.getProductVariantSizeById(productVariantSizeId);
        request.setAttribute("pvsDetail", pvs);

        AccountDAO accountDao = new AccountDAO();
        Account account = accountDao.getAccountByEmail(uEmail);
        request.setAttribute("acc", account);
        FeedbackDAO feedback = new FeedbackDAO();
        Feedback f = feedback.getFeedBack(account.getId(), productVariantSizeId);
        System.out.println(account.getId());
        System.out.println(productVariantSizeId);

        boolean active = f != null;
        if (active) {
            request.setAttribute("feedback", f);
            active = true;
        }

        request.setAttribute("active", active);

        request.getRequestDispatcher("/views/client/Feedback.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        String uEmail = (String) session.getAttribute("uName");
        int productVariantSizeId = Integer.parseInt(request.getParameter("id"));
        String orderId = request.getParameter("order_id");
        String content = request.getParameter("feedback");
        int ratedStar = Integer.parseInt(request.getParameter("rating"));
        boolean status = true;
        String imageUrl_fileName = request.getParameter("old-imageUrl");
        Part part = request.getPart("imageUrl");
        if (part != null && part.getSize() > 0 && request.getParameter("notUpdateImageUrl") == null) {
            String token = TokenGenerator.generateToken();
            imageUrl_fileName = "img_" + token + ".jpg";
            part.write(imageUrl_fileName);
        }

        FeedbackDAO feedbackDAO = new FeedbackDAO();
        AccountDAO accountDAO = new AccountDAO();
        ProductVariantSizeDAO pvsDAO = new ProductVariantSizeDAO();
        Account acc = accountDAO.getAccountByEmail(uEmail);
        ProductVariantSize pvs = pvsDAO.getProductVariantSizeById(productVariantSizeId);
        Feedback f = new Feedback(pvs, acc, content, ratedStar, status, imageUrl_fileName, null, null);
        feedbackDAO.insertFeedback(f);

        // Chuyển hướng về trang chi tiết sản phẩm
        response.sendRedirect(request.getContextPath() + "/products/product-detail?id=" + pvs.getProductVariant().getProduct().getId());
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
