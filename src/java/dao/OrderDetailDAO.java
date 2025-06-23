/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author hoaht
 */
public class OrderDetailDAO extends DBContext {

    public boolean addNewOrderDetail(String order_id, int pvsId, int quantity, double price) {
        String sql = "insert into OrderDetail(Price, Quantity, OrderID, ProductVariantSizeID) values (?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setDouble(1, price);
            ps.setInt(2, quantity);
            ps.setString(3, order_id);
            ps.setInt(4, pvsId);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
}
