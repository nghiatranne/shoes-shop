/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import constants.OrderStatus;
import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import model.Address;
import model.Order;
import model.OrderDetail;
import model.OrderDetailUser;
import model.OrderRAW;
import model.OrderRAW2;

/**
 *
 * @author hoaht
 */
public class OrderDAO extends DBContext {
    public OrderRAW getOrder(String order_id) {
        String sql = "select o.*, SUM(od.Price * od.Quantity) as [Total] "
                + "from [Order] o left join OrderDetail od on o.ID = od.OrderID where o.ID = ? "
                + "group by o.ID, o.UpdateDate, o.CreateDate, "
                + "o.Status, o.Note, o.FullName, o.Email, o.ReceiveAddress, "
                + "o.Tel, o.AccountID, o.PaymentMethod, o.isPaid";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, order_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrder_id(rs.getString("ID"));
                order.setUpdateDate(rs.getDate("UpdateDate"));
                order.setCreateDate(rs.getDate("CreateDate"));
                order.setStatus(OrderStatus.intToStatus(rs.getInt("Status")));
                order.setNote(rs.getString("Note"));
                order.setFullName(rs.getString("FullName"));
                order.setEmail(rs.getString("Email"));
                order.setReceiveAddress(rs.getString("ReceiveAddress"));
                order.setTel(rs.getString("Tel"));
                order.setPaid(rs.getBoolean("isPaid"));
                Set<OrderDetail> orderDetails = getOrderDetailProductVariantSizeByOrderID(rs.getString("ID"));
                order.setOrderDetails(orderDetails);

                OrderRAW orderRAW = new OrderRAW();
                orderRAW.setOrder(order);
                orderRAW.setTotalCost(rs.getFloat("total"));

                String productName = "";
                for (OrderDetail od : orderDetails) {
                    productName = cutStringTo20Chars(od.getProductVariantSize().getProductVariant().getName()) + "...";
                    break;
                }

                if (orderDetails.size() >= 2) {
                    productName = productName + ", " + (order.getOrderDetails().size() - 1) + " more";
                }
                orderRAW.setProductName(productName);

                return orderRAW;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public void updateOrderAddress(String orderId, Address address) {
        String sql = "update [Order] set FullName = ?, ReceiveAddress = ?, Tel = ? where ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, address.getFullName());
            ps.setString(2, address.getAddress());
            ps.setString(3, address.getTel());
            ps.setString(4, orderId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public static String cutStringTo20Chars(String inputString) {
        if (inputString.length() > 20) {
            return inputString.substring(0, 20);
        } else {
            return inputString;
        }
    }
    
    public Set<OrderDetail> getOrderDetailProductVariantSizeByOrderID(String order_id) {
        ProductVariantSizeDAO productVariantSizeDAO = new ProductVariantSizeDAO();
        Set<OrderDetail> orderDetails = new HashSet<>();
        String sql = "select * from OrderDetail where OrderID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, order_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setProductVariantSize(productVariantSizeDAO.getProductVariantSizeById(rs.getInt("ProductVariantSizeID")));
                orderDetail.setPrice(rs.getFloat("Price"));
                orderDetail.setQuantity(rs.getInt("Quantity"));
                orderDetails.add(orderDetail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetails;
    }
    
    public List<OrderRAW2> listAllOrderWithTotalCost(int accId) {
        List<OrderRAW2> orderRAW2s = new ArrayList<>();
        String sql = "SELECT o.*, SUM(od.Price * od.Quantity) as TotalAmount, COUNT(od.ProductVariantSizeID) as TotalProduct, "
                + "(select top 1 pv.Name from OrderDetail od left join ProductVariantSize pvs on od.ProductVariantSizeID = pvs.Id left join ProductVariant pv on pvs.ProductVariantId = pv.Id where od.OrderID = o.ID) as productName "
                + "FROM [Order] o LEFT JOIN OrderDetail od ON o.ID = od.OrderID "
                + "where o.AccountID = ? "
                + "GROUP BY o.ID, o.UpdateDate, o.CreateDate, o.Status, o.Note, o.FullName, o.Email, o.ReceiveAddress, o.Tel, o.AccountID, o.PaymentMethod, o.isPaid";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrder_id(rs.getString("ID"));
                order.setUpdateDate(rs.getDate("UpdateDate"));
                order.setCreateDate(rs.getDate("CreateDate"));
                order.setStatus(OrderStatus.intToStatus(rs.getInt("Status")));
                order.setNote(rs.getString("Note"));
                order.setFullName(rs.getString("FullName"));
                order.setEmail(rs.getString("Email"));
                order.setReceiveAddress(rs.getString("ReceiveAddress"));
                order.setTel(rs.getString("Tel"));
                order.setPaid(rs.getBoolean("isPaid"));

                OrderRAW2 orderRAW2 = new OrderRAW2();
                orderRAW2.setOrder(order);
                orderRAW2.setTotalCost(rs.getFloat("TotalAmount"));
                orderRAW2.setTotalProduct(rs.getInt("TotalProduct"));
                orderRAW2.setProductName(cutStringTo20Chars(rs.getString("productName")) + "..., " + (rs.getInt("TotalProduct") - 1) + " more");
                orderRAW2s.add(orderRAW2);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderRAW2s;
    }
    
    public Order getOrderByOrderID(String orderID) {
        String sql = "select * from [Order] where ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, orderID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();

                order.setOrder_id(rs.getString("ID"));
                order.setUpdateDate(rs.getDate("UpdateDate"));
                order.setCreateDate(rs.getDate("CreateDate"));
                order.setStatus(OrderStatus.intToStatus(rs.getInt("Status")));
                order.setNote(rs.getString("Note"));
                order.setFullName(rs.getString("FullName"));
                order.setEmail(rs.getString("Email"));
                order.setReceiveAddress(rs.getString("ReceiveAddress"));
                order.setTel(rs.getString("Tel"));
                order.setPaid(rs.getBoolean("isPaid"));

                return order;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public Set<OrderDetailUser> getOrderDetailProductVariantSizeByOrderIDWithFeedbackStatus(String order_id, int acc_id) {
        ProductVariantSizeDAO productVariantSizeDAO = new ProductVariantSizeDAO();
        Set<OrderDetailUser> orderDetailUsers = new HashSet<>();
        String sql = "select od.*, "
                + "		CASE "
                + "           WHEN f.ProductVariantSizeID IS NULL THEN 0 "
                + "           ELSE 1 "
                + "		END AS isFeedback "
                + "from OrderDetail od "
                + "Left JOIN Feedback f ON od.ProductVariantSizeID = f.ProductVariantSizeID "
                + "Left join [Order] o on o.ID = od.OrderID "
                + "where OrderID = ? AND o.AccountID = ?;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, order_id);
            ps.setInt(2, acc_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetailUser orderDetailUser = new OrderDetailUser();

                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setProductVariantSize(productVariantSizeDAO.getProductVariantSizeById(rs.getInt("ProductVariantSizeId")));
                orderDetail.setPrice(rs.getFloat("Price"));
                orderDetail.setQuantity(rs.getInt("Quantity"));

                orderDetailUser.setOrderDetail(orderDetail);
                orderDetailUser.setFeedback(rs.getBoolean("isFeedback"));

                orderDetailUsers.add(orderDetailUser);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetailUsers;
    }
    
    public boolean updateStatusOrder(OrderStatus orderStatus, String order_id) {
        String sql = "update [Order] set Status = ? where ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, OrderStatus.statusToInt(orderStatus));
            ps.setString(2, order_id);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public void removeOrder(String orderID) {
        String sql = "delete from [Order] where ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, orderID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void updateOrderPaidStatus(String orderId) {
        String sql = "update [Order] set isPaid = 1 where ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, orderId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public boolean addNewOrder(Order order) {
        String sql = "Insert into [Order](ID, Status, Note, FullName, Email, ReceiveAddress, Tel, AccountID, PaymentMethod) "
                + "values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, order.getOrder_id());
            ps.setInt(2, OrderStatus.statusToInt(order.getStatus()));
            ps.setString(3, order.getNote());
            ps.setString(4, order.getFullName());
            ps.setString(5, order.getEmail());
            ps.setString(6, order.getReceiveAddress());
            ps.setString(7, order.getTel());
            ps.setInt(8, order.getAccount().getId());
            ps.setString(9, order.getPaymentMethod().getMethod());

            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public void assignOrderToMarketer(String orderId) {
        String sql = "insert into ManageOrder (AccountID, OrderID) "
                + "select top 1 a.ID, (select ID from [Order] where ID = ?) "
                + "from Account a left join [ManageOrder] mo on a.ID = mo.AccountID "
                + "left join RoleAccount ra on a.ID = ra.AccountID "
                + "left join [Role] r on r.ID = ra.RoleID "
                + "where r.RoleName = 'SALE' "
                + "group by a.ID "
                + "order by COUNT(mo.OrderID) asc";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, orderId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public boolean isHasOrderId(String order_id) {
        String sql = "select count(*) from [Order] where ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, order_id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                return rs.getInt(1) >= 1;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
