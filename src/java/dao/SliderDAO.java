package dao;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Slider;

/**
 *
 * @author USA
 */
public class SliderDAO extends DBContext {

    public List<Slider> getAllSliders() {
        List<Slider> sliders = new ArrayList<>();
        String sql = "SELECT * FROM Slider";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Slider slider = new Slider();
                slider.setId(rs.getInt("id"));
                slider.setTitle(rs.getString("title"));
                slider.setImageUrl(rs.getString("image_url"));
                slider.setLinkUrl(rs.getString("link_url"));
                slider.setStatus(rs.getBoolean("Status"));
                slider.setCreateAt(rs.getDate("CreateAt"));
                slider.setUpdateAt(rs.getDate("UpdateAt"));
                slider.setStartDate(rs.getDate("StartDate"));
                slider.setEndDate(rs.getDate("EndDate"));
                sliders.add(slider);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sliders;
    }

    public void insertSlider(Slider slider) {
        String sql = "INSERT INTO Slider (title, image_url, link_url, Status, CreateAt, UpdateAt, StartDate, EndDate) VALUES (?, ?, ?, ?, GETDATE(), ?, ?, ?)";
        try {
            Date startDate = slider.getStartDate();
            Date endDate = slider.getEndDate();
            Date curDate = new Date();

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, slider.getTitle());
            ps.setString(2, slider.getImageUrl());
            ps.setString(3, slider.getLinkUrl());

            if (curDate.before(endDate) && curDate.after(endDate)) {
                ps.setBoolean(4, true);
            } else {
                ps.setBoolean(4, false);
            }

            ps.setDate(5, slider.getUpdateAt() != null ? new java.sql.Date(slider.getUpdateAt().getTime()) : null);
            ps.setDate(6, slider.getStartDate() != null ? new java.sql.Date(slider.getStartDate().getTime()) : null);
            ps.setDate(7, slider.getEndDate() != null ? new java.sql.Date(slider.getEndDate().getTime()) : null);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateSlider(Slider slider) {
        String sql = "UPDATE Slider SET title = ?, image_url = ?, link_url = ?, Status = ?, UpdateAt = GETDATE(), StartDate = ?, EndDate = ? WHERE id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, slider.getTitle());
            ps.setString(2, slider.getImageUrl());
            ps.setString(3, slider.getLinkUrl());
            ps.setBoolean(4, slider.isStatus());
            ps.setDate(5, slider.getStartDate() != null ? new java.sql.Date(slider.getStartDate().getTime()) : null);
            ps.setDate(6, slider.getEndDate() != null ? new java.sql.Date(slider.getEndDate().getTime()) : null);
            ps.setInt(7, slider.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteSlider(int id) {
        String sql = "DELETE FROM Slider WHERE id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Slider getSlider(int id) {
        String sql = "SELECT * FROM Slider WHERE id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Slider slider = new Slider();
                slider.setId(rs.getInt("id"));
                slider.setTitle(rs.getString("title"));
                slider.setImageUrl(rs.getString("image_url"));
                slider.setLinkUrl(rs.getString("link_url"));
                slider.setStatus(rs.getBoolean("Status"));
                slider.setCreateAt(rs.getDate("CreateAt"));
                slider.setUpdateAt(rs.getDate("UpdateAt"));
                slider.setStartDate(rs.getDate("StartDate"));
                slider.setEndDate(rs.getDate("EndDate"));
                return slider;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Slider> searchSlidersByTitle(String title) {
        List<Slider> sliders = new ArrayList<>();
        String sql = "SELECT * FROM Slider WHERE title LIKE ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + title + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Slider slider = new Slider();
                slider.setId(rs.getInt("id"));
                slider.setTitle(rs.getString("title"));
                slider.setImageUrl(rs.getString("image_url"));
                slider.setLinkUrl(rs.getString("link_url"));
                slider.setStatus(rs.getBoolean("Status"));
                slider.setCreateAt(rs.getDate("CreateAt"));
                slider.setUpdateAt(rs.getDate("UpdateAt"));
                slider.setStartDate(rs.getDate("StartDate"));
                slider.setEndDate(rs.getDate("EndDate"));
                sliders.add(slider);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sliders;
    }

    public void updateStatus(int id, boolean status) {
        String sql = "UPDATE Slider SET Status = ? WHERE id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setBoolean(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateSliderStatus() {
        String sql = "UPDATE Slider "
                + "SET [Status] = CASE "
                + "                WHEN GETDATE() >= DATEADD(day, 1, startDate) AND GETDATE() <= DATEADD(day, 1, endDate) THEN 1 "
                + "                ELSE 0 "
                + "             END, "
                + "UpdateAt = GETDATE() "
                + "WHERE startDate IS NOT NULL AND endDate IS NOT NULL;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
