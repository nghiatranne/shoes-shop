/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import constants.OrderStatus;
import dao.AccountDAO;
import dao.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import model.OrderRevenue;
import model.SaleRAW;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hoaht
 */
@WebServlet(name = "SaleDashboardServlet", urlPatterns = {"/admin/sale-dashboard"})
public class SaleDashboardServlet extends HttpServlet {

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
            out.println("<title>Servlet SaleDashboardServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SaleDashboardServlet at " + request.getContextPath() + "</h1>");
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
        try {
            SimpleDateFormat sf = new SimpleDateFormat("dd/MM/yyyy");
            OrderDAO orderDAO = new OrderDAO();
            AccountDAO accountDAO = new AccountDAO();

            List<SaleRAW> listAccountRoleSale = accountDAO.getListAccountRoleSale();
            request.setAttribute("listAccountRoleSale", listAccountRoleSale);

            OrderStatus[] orderStatusesValue = OrderStatus.values();
            request.setAttribute("orderStatusesValue", orderStatusesValue);

            Date dateFrom = null;
            Date dateTo = null;
            if (request.getParameter("dateFrom") != null && request.getParameter("dateTo") != null && !request.getParameter("dateFrom").isBlank() && !request.getParameter("dateTo").isBlank()) {
                dateFrom = sf.parse(request.getParameter("dateFrom"));
                dateTo = sf.parse(request.getParameter("dateTo"));
                
                if (!checkDates(dateFrom, dateTo)) {
                    request.setAttribute("error_month", true);
                } else {
                    dateFrom = null;
                    dateTo = null;
                }

                request.setAttribute("dateFrom", request.getParameter("dateFrom"));
                request.setAttribute("dateTo", request.getParameter("dateTo"));
            }

            int totalOrderByStatusSUBMITTED = orderDAO.getTotalOrderByStatus(OrderStatus.SUBMITTED, dateFrom, dateTo);
            int totalOrderByStatusCONFIRMED = orderDAO.getTotalOrderByStatus(OrderStatus.CONFIRMED, dateFrom, dateTo);
            int totalOrderByStatusPACKAGING = orderDAO.getTotalOrderByStatus(OrderStatus.PACKAGING, dateFrom, dateTo);
            int totalOrderByStatusSHIPPING = orderDAO.getTotalOrderByStatus(OrderStatus.SHIPPING, dateFrom, dateTo);
            int totalOrderByStatusSHIPPED = orderDAO.getTotalOrderByStatus(OrderStatus.SHIPPED, dateFrom, dateTo);
            int totalOrderByStatusCOMPLETED = orderDAO.getTotalOrderByStatus(OrderStatus.COMPLETED, dateFrom, dateTo);
            int totalOrderByStatusCANCELED = orderDAO.getTotalOrderByStatus(OrderStatus.CANCELED, dateFrom, dateTo);
            int totalOrderByStatusREJECTED = orderDAO.getTotalOrderByStatus(OrderStatus.REJECTED, dateFrom, dateTo);
            int totalOrder = orderDAO.getTotalOrder();

            request.setAttribute("totalOrderByStatusSUBMITTED", totalOrderByStatusSUBMITTED);
            request.setAttribute("totalOrderByStatusCONFIRMED", totalOrderByStatusCONFIRMED);
            request.setAttribute("totalOrderByStatusPACKAGING", totalOrderByStatusPACKAGING);
            request.setAttribute("totalOrderByStatusSHIPPING", totalOrderByStatusSHIPPING);
            request.setAttribute("totalOrderByStatusSHIPPED", totalOrderByStatusSHIPPED);
            request.setAttribute("totalOrderByStatusCOMPLETED", totalOrderByStatusCOMPLETED);
            request.setAttribute("totalOrderByStatusCANCELED", totalOrderByStatusCANCELED);
            request.setAttribute("totalOrderByStatusREJECTED", totalOrderByStatusREJECTED);
            request.setAttribute("totalOrder", totalOrder);

            Date dateFromO;
            Date dateToO;
            if (request.getParameter("dateFromO") != null && request.getParameter("dateToO") != null && !request.getParameter("dateFromO").isBlank() && !request.getParameter("dateToO").isBlank()) {
                dateFromO = sf.parse(request.getParameter("dateFromO"));
                dateToO = sf.parse(request.getParameter("dateToO"));

                if (!checkDates(dateFromO, dateToO)) {
                    request.setAttribute("error_month", true);

                    Date currentDate = new Date();
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTime(currentDate);
                    calendar.add(Calendar.DAY_OF_MONTH, -6);
                    Date sevenDaysAgo = calendar.getTime();
                    List<OrderRevenue> orderRevenues = orderDAO.listOrderRevenue(sevenDaysAgo, currentDate, null, null);
                    request.setAttribute("orderRevenues", orderRevenues);
                    
                    request.getRequestDispatcher("/views/admin/SaleDashboard.jsp").forward(request, response);
                    return;
                }

                Integer sellerID = (request.getParameter("seller") != null && !request.getParameter("seller").isBlank()) ? Integer.valueOf(request.getParameter("seller")) : null;
                Integer status = (request.getParameter("status") != null && !request.getParameter("status").isBlank()) ? OrderStatus.statusToInt(OrderStatus.valueOf(request.getParameter("status"))) : null;

                request.setAttribute("sellerKey", request.getParameter("seller"));
                request.setAttribute("statusKey", (request.getParameter("status") != null && !request.getParameter("status").isBlank()) ? OrderStatus.valueOf(request.getParameter("status")) : null);
                request.setAttribute("dateFromO", request.getParameter("dateFromO"));
                request.setAttribute("dateToO", request.getParameter("dateToO"));

                List<OrderRevenue> orderRevenues = orderDAO.listOrderRevenue(dateFromO, dateToO, sellerID, status);
                request.setAttribute("orderRevenues", orderRevenues);
            } else {
                Date currentDate = new Date();
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(currentDate);
                calendar.add(Calendar.DAY_OF_MONTH, -6);
                Date sevenDaysAgo = calendar.getTime();
                List<OrderRevenue> orderRevenues = orderDAO.listOrderRevenue(sevenDaysAgo, currentDate, null, null);
                request.setAttribute("orderRevenues", orderRevenues);
            }

            request.getRequestDispatcher("/views/admin/SaleDashboard.jsp").forward(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(SaleDashboardServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static boolean checkDates(Date dateFrom, Date dateTo) {
        Calendar calFrom = Calendar.getInstance();
        Calendar calTo = Calendar.getInstance();
        calFrom.setTime(dateFrom);
        calTo.setTime(dateTo);

        // Kiểm tra dateTo có sau dateFrom không
        if (calTo.before(calFrom)) {
            System.out.println("dateTo không thể trước dateFrom.");
            return false;
        }

        // Thêm 3 tháng vào calFrom
        calFrom.add(Calendar.MONTH, 3);

        // Kiểm tra xem dateTo có trong khoảng 3 tháng kể từ dateFrom không
        if (calTo.after(calFrom)) {
            System.out.println("Khoảng thời gian giữa dateFrom và dateTo vượt quá 3 tháng.");
            return false;
        }

        // Nếu không có lỗi, trả về true
        System.out.println("Các ngày hợp lệ và nằm trong khoảng 3 tháng.");
        return true;
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
        processRequest(request, response);
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
