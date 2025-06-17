package dao;

import dal.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Size;

public class SizeDAO extends DBContext {
    
    public List<Size> listAllSize() {
        List<Size> sizes = new ArrayList<>();
        String sql = "select * from Size";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                sizes.add(new Size(rs.getInt(1), rs.getInt(2), rs.getBoolean(3), rs.getDate(4), rs.getDate(5)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sizes;
    }
    
    public Map<Size, Integer> getAllSize() {
        Map<Size, Integer> totalProductOfSize = new HashMap<>();
        String sql = "SELECT s.ID, s.Value, s.CreateDate, s.UpdateDate, COUNT(pvs.Id) AS NumberOfSize "
                + "FROM Size s LEFT JOIN ProductVariantSize pvs ON s.ID = pvs.SizeID "
                + "GROUP BY s.ID, s.Value, s.CreateDate, s.UpdateDate";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("ID");
                int value = rs.getInt("Value");
                Date createDate = rs.getDate("CreateDate");
                Date updateDate = rs.getDate("UpdateDate");
                int numberOfBooks = rs.getInt("NumberOfSize");

                Size size = new Size(id, value, true, createDate, updateDate);
                totalProductOfSize.put(size, numberOfBooks);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalProductOfSize;
    }
    
    public Map<Size, Integer> searchSizeByValue(String sVal) {
        Map<Size, Integer> totalProductOfCategory = new HashMap<>();
        String sql = "SELECT s.ID, s.Value, s.CreateDate, s.UpdateDate, COUNT(pvs.Id) AS NumberOfSize "
                + "FROM Size s LEFT JOIN ProductVariantSize pvs ON s.ID = pvs.SizeID "
                + "WHERE s.Value =  '" + sVal + "' " 
                + "GROUP BY s.ID, s.Value, s.CreateDate, s.UpdateDate";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("ID");
                int value = rs.getInt("Value");
                Date createDate = rs.getDate("CreateDate");
                Date updateDate = rs.getDate("UpdateDate");
                int numberOfProducts = rs.getInt("NumberOfSize");

                Size size = new Size(id, value, true, createDate, updateDate);
                totalProductOfCategory.put(size, numberOfProducts);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalProductOfCategory;
    }
    
    public void addSize(int value) {
        try {
            String sql = "INSERT INTO Size (value, status) VALUES (?, ?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, value);
            ps.setBoolean(2, true);
            ps.execute();

        } catch (Exception ex) {
            System.out.println("add:" + ex.getMessage());
        }
    }
    
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
        String sql = "UPDATE size SET value = ? WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, size.getValue());
            st.setInt(2, size.getId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void deleteSize(int id) {
        String sql = "delete from Size WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
} 