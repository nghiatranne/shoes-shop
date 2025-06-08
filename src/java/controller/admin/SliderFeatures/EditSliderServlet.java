/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.SliderFeatures;

import com.oracle.wls.shaded.org.apache.bcel.generic.AALOAD;
import constants.FileLocation;
import dao.SliderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Slider;
import token.TokenGenerator;

/**
 *
 * @author USA
 */
@WebServlet(name = "EditSliderServlet", urlPatterns = {"/admin/sliders/edit"})
@MultipartConfig(
        location = FileLocation.SLIDE_IMAGE_LOCATION,
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 11
)
public class EditSliderServlet extends HttpServlet {

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
            out.println("<title>Servlet EditSliderServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditSliderServlet at " + request.getContextPath() + "</h1>");
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
        String id_raw = request.getParameter("id");
        SliderDAO sliderDao = new SliderDAO();
        try {
            int id = Integer.parseInt(id_raw);
            Slider slider = sliderDao.getSlider(id);
            request.setAttribute("slider", slider);
            request.getRequestDispatcher("/views/admin/EditSlider.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println(e.getMessage());
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
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String linkUrl = request.getParameter("linkUrl");

            String imageUrl_fileName = request.getParameter("old-imageUrl");
            Part part = request.getPart("imageUrl");
            if (part != null && part.getSize() > 0 && request.getParameter("notUpdateImageUrl") == null) {
                String token = TokenGeneratoror.generateToken();
                imageUrl_fileName = "img_" + token + ".jpg";
                part.write(imageUrl_fileName);
            }

            SliderDAO sliderDAO = new SliderDAO();
            Slider slider = new Slider(id, title, imageUrl_fileName, linkUrl, true, null, null, sf.parse(startDate), sf.parse(endDate));
            sliderDAO.updateSlider(slider);

            response.sendRedirect(request.getContextPath() + "/admin/sliders");
        } catch (ParseException ex) {
            Logger.getLogger(EditSliderServlet.class.getName()).log(Level.SEVERE, null, ex);
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
