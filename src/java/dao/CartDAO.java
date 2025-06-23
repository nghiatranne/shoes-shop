/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.CartRAW;

/**
 *
 * @author hoaht
 */
public class CartDAO extends DBContext {

    public void addToCart(int book_id, int acc_id, int quantity) {
        try {
            String sql = "";
            boolean exsitedCart = isExsitedCart(book_id, acc_id);

            if (exsitedCart) {
                // update
                sql = "update Cart "
                        + "set Quantity = (select Quantity from Cart c where c.AccountID = ? and c.ProductVariantSizeID = ?) + ? "
                        + "where AccountID = ? and ProductVariantSizeID = ?";
                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setInt(1, acc_id);
                ps.setInt(2, book_id);
                ps.setInt(3, quantity);
                ps.setInt(4, acc_id);
                ps.setInt(5, book_id);

                ps.executeUpdate();
            } else {
                // insert
                sql = "insert into Cart(AccountID, ProductVariantSizeID, Quantity) values (?, ?, ?)";
                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setInt(1, acc_id);
                ps.setInt(2, book_id);
                                ps.setInt(3, quantity);

                ps.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean isExsitedCart(int book_id, int acc_id) {
        String sql = "select COUNT(*) from Cart where ProductVariantSizeID = ? and AccountID = ? and status != 1";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, book_id);
            ps.setInt(2, acc_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1) == 1;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<CartRAW> listAll(int acc_id) {
        List<CartRAW> cartRAWs = new ArrayList<>();
        String sql = "SELECT pvs.ID, c.Quantity, pv.Image as productVariantImage, s.Value as sizeValue, p.Title as productName, pv.Price as price, pv.Name as productVariantName " +
                     "FROM Cart c " +
                     "LEFT JOIN ProductVariantSize pvs ON c.ProductVariantSizeID = pvs.ID " +
                     "LEFT JOIN ProductVariant pv ON pvs.ProductVariantID = pv.ID " +
                     "LEFT JOIN Product p ON pv.ProductID = p.ID " +
                     "LEFT JOIN Size s ON pvs.SizeID = s.ID " +
                     "WHERE c.AccountID = ? AND c.Status = 0";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, acc_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                cartRAWs.add(new CartRAW(
                    rs.getInt("ID"),
                                            rs.getString("productVariantName"),

                    rs.getInt("Quantity"),
                    rs.getString("productVariantImage"),
                    rs.getInt("sizeValue"),
                    rs.getString("productName"),
                    rs.getDouble("price")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartRAWs;
    }
    
    public void deleteCart(int book_id, int acc_id) {
        String sql = "delete from Cart where AccountID = ? and ProductVariantSizeID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, acc_id);
            ps.setInt(2, book_id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void updateQuantity(int pvsId, int acc_id, int quantity) {
        String sql = "update Cart set Quantity = ? where AccountID = ? and ProductVariantSizeID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, acc_id);
            ps.setInt(3, pvsId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void updateStatus(int pvsId, int accountId) {
        String sql = "update Cart set status = 1 where ProductVariantSizeID = ? and AccountID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, pvsId);
            ps.setInt(2, accountId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
