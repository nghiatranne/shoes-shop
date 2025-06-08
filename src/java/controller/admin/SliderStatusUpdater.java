/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.SliderDAO;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.util.Timer;
import java.util.TimerTask;
import java.util.Date;
import java.util.logging.Logger;

/**
 *
 * @author hoaht
 */
@WebListener
public class SliderStatusUpdater implements ServletContextListener {

    private static final Logger LOGGER = Logger.getLogger(SliderStatusUpdater.class.getName());
    private Timer timer;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        timer = new Timer(true);
        timer.scheduleAtFixedRate(new UpdateTask(), 0, 86400000); // 86400000 ms = 24 hours
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        timer.cancel();
    }

    private class UpdateTask extends TimerTask {

        @Override
        public void run() {
            // Đây là nơi bạn sẽ thực hiện truy vấn để cập nhật trạng thái
            // Ví dụ: Gọi một phương thức để kiểm tra và cập nhật trạng thái slider
            LOGGER.info("Start Update");
            updateSliderStatus();
            LOGGER.info("End Update");
        }
    }

    private void updateSliderStatus() {
        // Giả sử bạn có phương thức để kết nối và cập nhật cơ sở dữ liệu
        // Cập nhật trạng thái dựa trên ngày hiện tại
        LOGGER.info("Updating...");
        SliderDAO sliderDAO = new SliderDAO();
        sliderDAO.updateSliderStatus();
        LOGGER.info("Updated...");
    }
}
