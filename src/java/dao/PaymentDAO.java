package dao;

import dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.PaymentMethod;

public class PaymentDAO extends DBContext {

    public PaymentDAO() {
    }

    // Get all payment methods
    public List<PaymentMethod> listAll() {
        List<PaymentMethod> paymentMethods = new ArrayList<>();
        String sql = "SELECT * FROM PaymentMethod";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String method = rs.getString(1);
                String note = rs.getString(2);
                String imageLink = rs.getString(3);

                paymentMethods.add(new PaymentMethod(method, note, imageLink, null));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return paymentMethods;
    }

    public Map<PaymentMethod, Integer> listAllPaymentAndTotalOrder() {
        Map<PaymentMethod, Integer> paymentMethods = new HashMap<>();
        String sql = "select pm.*, count(o.ID) "
                + "from PaymentMethod pm left join [Order] o on pm.Method = o.PaymentMethod "
                + "group by pm.Method, pm.Note, pm.imageLink";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String method = rs.getString(1);
                String note = rs.getString(2);
                String imageLink = rs.getString(3);

                paymentMethods.put(new PaymentMethod(method, note, imageLink, null), rs.getInt(4));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return paymentMethods;
    }

    // Save a new payment method
    public void add(PaymentMethod paymentMethod) {
        String sql = "INSERT INTO PaymentMethod (method, note, imageLink) VALUES (?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, paymentMethod.getMethod());
            ps.setString(2, paymentMethod.getNote());
            ps.setString(3, paymentMethod.getImageLink());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Update an existing payment method
    public void update(PaymentMethod paymentMethod, String oldMethod) {
        String sql = "UPDATE PaymentMethod SET method = ?, note = ? WHERE Method = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, paymentMethod.getMethod());
            ps.setString(2, paymentMethod.getNote());
            ps.setString(3, oldMethod);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Delete a payment method
    public void delete(String method) {
        String sql = "DELETE FROM PaymentMethod WHERE Method = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, method);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Get a payment method by Method name
    public PaymentMethod getByMethod(String method) {
        PaymentMethod paymentMethod = null;
        String sql = "SELECT * FROM PaymentMethod WHERE method = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, method);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String fetchedMethod = rs.getString("method");
                String note = rs.getString("note");
                paymentMethod = new PaymentMethod(fetchedMethod, note, null, null);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return paymentMethod;
    }

    public List<PaymentMethod> searchByMethod(String keyword) {
        List<PaymentMethod> paymentMethods = new ArrayList<>();
        String sql = "SELECT method, note FROM PaymentMethod WHERE method LIKE ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String method = rs.getString("method");
                    String note = rs.getString("note");
                    paymentMethods.add(new PaymentMethod(method, note, null, null));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return paymentMethods;
    }

    public PaymentMethod getPaymentByPaymentMethod(String paymentMethod) {
        String sql = "select * from PaymentMethod where Method = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, paymentMethod);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String method = rs.getString(1);
                String note = rs.getString(2);
                
                PaymentMethod p = new PaymentMethod(method, note, null, null);
                return p;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
