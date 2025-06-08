/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.OrderStatistics;
import model.OrderTrend;

/**
 *
 * @author USA
 */
public class StatisticsDAO extends DBContext {

    public OrderStatistics getOrderStatistics(Date startDate, Date endDate) {
        OrderStatistics stats = new OrderStatistics();
        String sql = "SELECT "
                + "SUM(CASE WHEN Status = 5 THEN 1 ELSE 0 END) AS successOrders, "
                + "SUM(CASE WHEN Status = -1 THEN 1 ELSE 0 END) AS cancelledOrders, "
                + "SUM(CASE WHEN Status = 0 THEN 1 ELSE 0 END) AS submittedOrders "
                + "FROM [Order] "
                + "WHERE CreateDate >= ? AND CreateDate <= ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                stats.setSuccessOrders(rs.getInt("successOrders"));
                stats.setCancelledOrders(rs.getInt("cancelledOrders"));
                stats.setSubmittedOrders(rs.getInt("submittedOrders"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }

    public double getTotalRevenue(Date startDate, Date endDate) {
        double totalRevenue = 0;
        String sql = "SELECT SUM(od.Price * od.Quantity) as totalRevenue "
                + "FROM [Order] o "
                + "JOIN OrderDetail od ON o.ID = od.OrderID "
                + "WHERE o.CreateDate >= ? AND o.CreateDate <= ? AND o.Status = 5";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalRevenue = rs.getDouble("totalRevenue");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalRevenue;
    }

    public Map<String, Double> getRevenueByCategory(Date startDate, Date endDate) {
        Map<String, Double> revenueByCategory = new HashMap<>();
        String sql = "SELECT c.Name as categoryName, SUM(od.Price * od.Quantity) as revenue "
                + "FROM [Order] o "
                + "JOIN OrderDetail od ON o.ID = od.OrderID "
                + "JOIN Book b ON od.ISBN = b.ISBN "
                + "JOIN BookCategory bc ON b.ID = bc.BookID "
                + "JOIN Category c ON bc.CategoryID = c.ID "
                + "WHERE o.CreateDate >= ? AND o.CreateDate <= ? AND o.Status = 5 "
                + "GROUP BY c.Name";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                revenueByCategory.put(rs.getString("categoryName"), rs.getDouble("revenue"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return revenueByCategory;
    }

    public int getNewRegisteredCustomers(Date startDate, Date endDate) {
        int newRegisteredCustomers = 0;
        String sql = "SELECT COUNT(*) as newRegisteredCustomers "
                + "FROM Account "
                + "WHERE CreateDate >= ? AND CreateDate <= ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                newRegisteredCustomers = rs.getInt("newRegisteredCustomers");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return newRegisteredCustomers;
    }

    public int getNewBoughtCustomers(Date startDate, Date endDate) {
        int newBoughtCustomers = 0;
        String sql = "SELECT COUNT(DISTINCT AccountID) as newBoughtCustomers "
                + "FROM [Order] "
                + "WHERE CreateDate >= ? AND CreateDate <= ? AND Status = 5";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                newBoughtCustomers = rs.getInt("newBoughtCustomers");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return newBoughtCustomers;
    }


  public double getAverageRating(Date startDate, Date endDate) {
        List<Double> ratings = new ArrayList<>();
        String sql = "SELECT f.RatedStar "
                + "FROM Feedback f "
                + "JOIN Book b ON f.ISBN = b.ISBN "
                + "JOIN OrderDetail od ON od.ISBN = b.ISBN "
                + "JOIN [Order] o ON o.ID = od.OrderID "
                + "WHERE o.CreateDate >= ? AND o.CreateDate <= ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ratings.add(rs.getDouble("RatedStar"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        double sum = 0;
        for (double rating : ratings) {
            sum += rating;
        }

        double average = ratings.isEmpty() ? 0 : sum / ratings.size();

        // Format the average to 2 decimal places
        DecimalFormat df = new DecimalFormat("#.##");
        return Double.parseDouble(df.format(average));
    }
  
    public Map<String, Double> getAverageRatingByCategory(Date startDate, Date endDate) {
        Map<String, Double> averageRatingByCategory = new HashMap<>();
        String sql = "SELECT c.Name as categoryName, AVG(f.RatedStar) as averageRating "
                + "FROM Feedback f "
                + "JOIN Book b ON f.ISBN = b.ISBN "
                + "JOIN OrderDetail od ON od.ISBN = b.ISBN "
                + "JOIN [Order] o ON o.ID = od.OrderID "
                + "JOIN BookCategory bc ON b.ID = bc.BookID "
                + "JOIN Category c ON bc.CategoryID = c.ID "
                + "WHERE o.CreateDate >= ? AND o.CreateDate <= ? "
                + "GROUP BY c.Name";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                averageRatingByCategory.put(rs.getString("categoryName"), rs.getDouble("averageRating"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return averageRatingByCategory;
    }

    public List<OrderTrend> getOrderTrend(Date startDate, Date endDate) {
        List<OrderTrend> orderTrends = new ArrayList<>();
        String sql = "SELECT o.CreateDate, "
                + "COUNT(*) as allOrders, "
                + "SUM(CASE WHEN o.Status = 5 THEN 1 ELSE 0 END) as successOrders "
                + "FROM [Order] o "
                + "WHERE o.CreateDate >= ? AND o.CreateDate <= ? "
                + "GROUP BY o.CreateDate "
                + "ORDER BY o.CreateDate";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderTrend orderTrend = new OrderTrend();
                orderTrend.setDate(rs.getDate("CreateDate"));
                orderTrend.setAllOrders(rs.getInt("allOrders"));
                orderTrend.setSuccessOrders(rs.getInt("successOrders"));
                orderTrends.add(orderTrend);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderTrends;
    }

}
