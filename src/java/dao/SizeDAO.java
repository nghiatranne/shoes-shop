package dao;

import dal.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Size;

public class SizeDAO extends DBContext {
    
    public List<Size> getAllSizes() {
        List<Size> list = new ArrayList<>();
        String sql = "SELECT * FROM size WHERE status = 1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Size size = new Size();
                size.setId(rs.getInt("id"));
                 size.setValue(rs.getInt("value"));
                size.setStatus(rs.getBoolean("status"));
                list.add(size);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public Size getSizeById(int id) {
        String sql = "SELECT * FROM Size WHERE ID = ? AND Status = 1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Size size = new Size();
                size.setId(rs.getInt("ID"));
                size.setValue(rs.getInt("Value"));
                size.setStatus(rs.getBoolean("Status"));
                return size;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public void addSize(Size size) {
        String sql = "INSERT INTO Size (value, status) VALUES (?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, size.getValue());
            st.setBoolean(2, size.isStatus());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void updateSize(Size size) {
        String sql = "UPDATE size SET name = ?, status = ? WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, size.getValue());
            st.setBoolean(2, size.isStatus());
            st.setInt(3, size.getId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void deleteSize(int id) {
        String sql = "UPDATE size SET status = 0 WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
} 