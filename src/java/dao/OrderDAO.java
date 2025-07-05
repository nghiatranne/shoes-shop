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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import model.Account;
import model.Address;
import model.Order;
import model.OrderDetail;
import model.OrderDetailRAW;
import model.OrderDetailUser;
import model.OrderRAW;
import model.OrderRAW2;
import model.OrderRAW3;
import model.OrderRevenue;
import model.PaymentMethod;

/**
 *
 * @author hoaht
 */
public class OrderDAO extends DBContext {
    
    public int getTotalOrderByStatus(OrderStatus orderStatus, Date from, Date to) {
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
        String sql;
        if (from != null && to != null) {
            sql = "select COUNT(*) from [Order] where Status = ? and CreateDate <= ? and CreateDate >= ?";
        } else {
            sql = "select COUNT(*) from [Order] where Status = ?";
        }
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            if (from != null && to != null) {
                ps.setInt(1, OrderStatus.statusToInt(orderStatus));
                ps.setString(2, sf.format(to));
                ps.setString(3, sf.format(from));
            } else {
                ps.setInt(1, OrderStatus.statusToInt(orderStatus));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public int getTotalOrder() {
        String sql = "select COUNT(*) from [Order]";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public List<OrderRevenue> listOrderRevenue(Date from, Date to, Integer sellerID, Integer status) {
        List<OrderRevenue> orderRevenues = new ArrayList<>();
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
        String sql = "DECLARE @StartDate DATE = ?; "
                + "DECLARE @EndDate DATE = ?; "
                + "WITH DateRange AS ( "
                + "    SELECT @StartDate AS DateValue "
                + "    UNION ALL\n"
                + "    SELECT DATEADD(DAY, 1, DateValue) "
                + "    FROM DateRange "
                + "    WHERE DATEADD(DAY, 1, DateValue) <= @EndDate "
                + ") "
                + "SELECT DateRange.DateValue as [Date], SUM(COALESCE(table1.TotalPrice, 0)) [TotalRevenue] "
                + "FROM DateRange "
                + "left join ( "
                + "	select o.ID, o.CreateDate, SUM(od.Quantity * od.Price) [TotalPrice] "
                + "	from [OrderDetail] od "
                + "	left join [Order] o on od.OrderID = o.ID "
                + "	left join [ManageOrder] mo on mo.OrderID = o.ID ";

        if (sellerID != null) {
            sql += "where mo.AccountID = ? ";
        } else if (status != null) {
            sql += "where o.Status = ? ";
        } else if (sellerID != null && status != null) {
            sql += "where o.Status = ? and mo.AccountID = ? ";
        }
        sql += "	group by o.ID, o.CreateDate "
                + ") as [table1] ON CAST(table1.CreateDate AS DATE) = DateRange.DateValue "
                + "GROUP BY DateRange.DateValue "
                + "OPTION (MAXRECURSION 1000);";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, sf.format(from));
            ps.setString(2, sf.format(to));

            if (sellerID != null) {
                ps.setInt(3, sellerID);
            } else if (status != null) {
                ps.setInt(3, status);
            } else if (sellerID != null && status != null) {
                ps.setInt(3, sellerID);
                ps.setInt(4, status);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                orderRevenues.add(new OrderRevenue(rs.getString("Date"), rs.getFloat("TotalRevenue")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderRevenues;
    }
    
    public Map<Order, Float> searchOrders(int accId, String query) {
        Map<Order, Float> orderMap = new HashMap<>();
        AccountDAO accountDAO = new AccountDAO();
        PaymentDAO paymentDAO = new PaymentDAO();
        String sql = "SELECT o.*, "
                + "SUM(od.Price * od.Quantity) AS [TotalAmount], "
                + "COUNT(od.ProductVariantSizeId) AS [TotalProduct] "
                + "FROM [Order] o "
                + "JOIN OrderDetail od ON o.ID = od.OrderID "
                + "LEFT JOIN ManageOrder mo ON mo.OrderID = o.ID "
                + "WHERE mo.AccountID = ? "
                + "AND (o.ID LIKE ? OR o.FullName LIKE ?) "
                + "GROUP BY o.ID, o.UpdateDate, o.CreateDate, o.Status, o.Note, o.FullName, o.Email, o.ReceiveAddress, o.Tel, o.AccountID, o.PaymentMethod, o.isPaid";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, accId);
            ps.setString(2, "%" + query + "%");
            ps.setString(3, "%" + query + "%");
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
                order.setAccount(accountDAO.getAccount(rs.getInt("AccountID")));
                order.setPaymentMethod(paymentDAO.getPaymentByPaymentMethod(rs.getString("PaymentMethod")));
                order.setPaid(rs.getBoolean("isPaid"));
                order.setOrderDetails(getListOrderDetail(rs.getString("ID")));

                orderMap.put(order, rs.getFloat("TotalAmount"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderMap;
    }
    
    public Set<OrderDetail> getListOrderDetail(String order_id) {
        Set<OrderDetail> orderDetails = new HashSet<>();
        String sql = "select * from OrderDetail where OrderID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, order_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setPrice(rs.getFloat("price"));
                orderDetail.setQuantity(rs.getInt("quantity"));
                orderDetails.add(orderDetail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetails;
    }
    
    public String getSaleNameByOrderID(String orderID) {
        String sql = "select a.FullName from ManageOrder mo left join Account a on mo.AccountID = a.ID where mo.OrderID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, orderID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getString(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "";
    }
    
    public Order getDetailOrderByOrderId(String order_id) {
        Order order = null;

        String sql = "SELECT o.*, od.Price AS odPrice, od.Quantity AS odQuantity, a.ID AS AccountID, a.Email AS AccountEmail, a.FullName AS AccountFullName, "
                + "pm.Method AS PaymentMethod "
                + "FROM [Order] o "
                + "JOIN OrderDetail od ON o.ID = od.OrderID "
                + "JOIN ProductVariantSize pvs ON od.ProductVariantSizeId = pvs.Id "
                + "JOIN Account a ON o.AccountID = a.ID "
                + "JOIN PaymentMethod pm ON o.PaymentMethod = pm.Method "
                + "WHERE o.ID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, order_id);
            ResultSet rs = ps.executeQuery();

            Set<OrderDetail> orderDetails = new HashSet<>();

            while (rs.next()) {
                if (order == null) {
                    order = new Order();
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

                    Account account = new Account();
                    account.setId(rs.getInt("AccountID"));
                    account.setEmail(rs.getString("AccountEmail"));
                    account.setFullname(rs.getString("AccountFullName"));
                    order.setAccount(account);

                    PaymentMethod paymentMethod = new PaymentMethod();
                    paymentMethod.setMethod(rs.getString("PaymentMethod"));
                    order.setPaymentMethod(paymentMethod);
                }

                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setOrder(order);
                orderDetail.setQuantity(rs.getInt("odQuantity"));
                orderDetail.setPrice(rs.getFloat("odPrice"));

                orderDetails.add(orderDetail);
            }

            if (order != null) {
                order.setOrderDetails(orderDetails);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }
    
    public void changeAccountManage(String orderId, int accountId) {
        String sql = "update ManageOrder set AccountID = ? where OrderID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accountId);
            ps.setString(2, orderId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public List<OrderDetailRAW> getListOrderDetailByOrderID(String orderId) {
        ProductVariantSizeDAO productVariantSizeDAO = new ProductVariantSizeDAO();
        List<OrderDetailRAW> orderDetailRAWs = new ArrayList<>();
        String sql = "select od.*, pvs.Id "
                + "from OrderDetail od "
                + "left join [Order] o on od.OrderID = o.ID "
                + "left join ProductVariantSize pvs on od.ProductVariantSizeId = pvs.Id "
                + "where od.OrderID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setQuantity(rs.getInt("quantity"));
                orderDetail.setPrice(rs.getFloat("price"));

                float total = rs.getFloat("Price") * rs.getInt("Quantity");

                OrderDetailRAW orderDetailRAW = new OrderDetailRAW();
                orderDetailRAW.setProductVariantSize(productVariantSizeDAO.getProductVariantSizeId(rs.getInt("Id")));
                orderDetailRAW.setOrderDetail(orderDetail);
                orderDetailRAW.setTotal(total);

                orderDetailRAWs.add(orderDetailRAW);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetailRAWs;
    }
    
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
    
    public List<OrderRAW2> listOrderByOrderName(int acc_id, String orderName) {
        List<OrderRAW2> orderRAW2s = new ArrayList<>();
        String sql = "SELECT o.*, SUM(od.Price * od.Quantity) as TotalAmount, COUNT(od.ProductVariantSizeId) as TotalProduct, "
                + "(select top 1 pv.Name from OrderDetail od  "
                + "left join ProductVariantSize pvs on od.ProductVariantSizeId = pvs.Id "
                + "left join ProductVariant pv on pv.Id = pvs.ProductVariantId "
                + "where od.OrderID = o.ID) as productName "
                + "FROM [Order] o LEFT JOIN OrderDetail od ON o.ID = od.OrderID "
                + "left join ManageOrder mo on mo.OrderID = o.ID "
                + "where mo.AccountID = ? and o.FullName + o.ID like '%" + orderName + "%' "
                + "GROUP BY o.ID, o.UpdateDate, o.CreateDate, o.Status, o.Note, o.FullName, o.Email, o.ReceiveAddress, o.Tel, o.AccountID, o.PaymentMethod, o.isPaid";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, acc_id);
            ps.setString(2, orderName);
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
//                order.setAccount(accountDAO.getAccount(rs.getInt("AccountID")));
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
    
    public List<OrderRAW2> listOrderByDate(int acc_id, String CreateDate, String CreateDate1) {
        List<OrderRAW2> orderRAW2s = new ArrayList<>();
        String sql = "SELECT o.*, SUM(od.Price * od.Quantity) as TotalAmount, COUNT(od.ProductVariantSizeId) as TotalProduct, "
                + "(select top 1 pv.Name from OrderDetail od "
                + "left join ProductVariantSize pvs on od.ProductVariantSizeId = pvs.Id "
                + "left join ProductVariant pv on pv.Id = pvs.ProductVariantID "
                + "where od.OrderID = o.ID) as productName "
                + "FROM [Order] o LEFT JOIN OrderDetail od ON o.ID = od.OrderID "
                + "left join ManageOrder mo on mo.OrderID = o.ID "
                + "where mo.AccountID = ? and o.CreateDate >= ? and o.CreateDate <= ? "
                + "GROUP BY o.ID, o.UpdateDate, o.CreateDate, o.Status, o.Note, o.FullName, o.Email, o.ReceiveAddress, o.Tel, o.AccountID, o.PaymentMethod, o.isPaid";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, acc_id);
            ps.setString(2, CreateDate);
            ps.setString(3, CreateDate1);
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
//                order.setAccount(accountDAO.getAccount(rs.getInt("AccountID")));
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
    
    public List<OrderRAW3> listOrderByOrderName(String orderName) {
        List<OrderRAW3> orderRAW3s = new ArrayList<>();
        String sql = "SELECT o.*, SUM(od.Price * od.Quantity) as TotalAmount, COUNT(od.ProductVariantSizeId) as TotalProduct, "
                + "(select top 1 pv.Name from OrderDetail od "
                + "left join ProductVariantSize pvs on od.ProductVariantSizeId = pvs.Id "
                + "left join ProductVariant pv on pvs.ProductVariantId = pv.Id "
                + "where od.OrderID = o.ID) as productName, a.FullName as [ManagerName] "
                + "FROM [Order] o LEFT JOIN OrderDetail od ON o.ID = od.OrderID "
                + "left join ManageOrder mo on mo.OrderID = o.ID "
                + "left join Account a on mo.AccountID = a.ID "
                + "where o.FullName + o.ID like '%" + orderName + "%' "
                + "GROUP BY o.ID, o.UpdateDate, o.CreateDate, o.Status, o.Note, o.FullName, o.Email, o.ReceiveAddress, o.Tel, o.AccountID, o.PaymentMethod, o.isPaid, mo.AccountID, a.FullName";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
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
//                order.setAccount(accountDAO.getAccount(rs.getInt("AccountID")));
                order.setPaid(rs.getBoolean("isPaid"));

                OrderRAW3 orderRAW3 = new OrderRAW3();
                orderRAW3.setOrder(order);
                orderRAW3.setTotalCost(rs.getFloat("TotalAmount"));
                orderRAW3.setTotalProduct(rs.getInt("TotalProduct"));
                orderRAW3.setProductName(cutStringTo20Chars(rs.getString("productName")) + "..., " + (rs.getInt("TotalProduct") - 1) + " more");
                orderRAW3.setManagerName(rs.getString("ManagerName"));
                orderRAW3s.add(orderRAW3);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderRAW3s;
    }
    
    public List<OrderRAW2> listOrderByStatus(int acc_id, int status) {
        List<OrderRAW2> orderRAW2s = new ArrayList<>();
        String sql = "SELECT o.*, SUM(od.Price * od.Quantity) as TotalAmount, COUNT(od.ProductVariantSizeId) as TotalProduct, "
                + "(select top 1 pv.Name from OrderDetail od left join ProductVariantSize pvs on od.ProductVariantSizeId = pvs.Id "
                + "left join ProductVariant pv on pv.Id = pvs.ProductVariantId "
                + "where od.OrderID = o.ID) as productName "
                + "FROM [Order] o LEFT JOIN OrderDetail od ON o.ID = od.OrderID "
                + "left join ManageOrder mo on mo.OrderID = o.ID "
                + "where mo.AccountID = ? and o.Status = ? "
                + "GROUP BY o.ID, o.UpdateDate, o.CreateDate, o.Status, o.Note, o.FullName, o.Email, o.ReceiveAddress, o.Tel, o.AccountID, o.PaymentMethod, o.isPaid";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, acc_id);
            ps.setInt(2, status);
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
//                order.setAccount(accountDAO.getAccount(rs.getInt("AccountID")));
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
    
    public List<OrderRAW3> listOrderByStatus(int status) {
        List<OrderRAW3> orderRAW3s = new ArrayList<>();
        String sql = "SELECT o.*, SUM(od.Price * od.Quantity) as TotalAmount, COUNT(od.ProductVariantSizeId) as TotalProduct, "
                + "(select top 1 pv.Name from OrderDetail od "
                + "left join ProductVariantSize pvs on od.ProductVariantSizeId = pvs.Id "
                + "left join ProductVariant pv on pv.Id = pvs.ProductVariantId "
                + "where od.OrderID = o.ID) as productName, a.FullName [ManagerName]"
                + "FROM [Order] o LEFT JOIN OrderDetail od ON o.ID = od.OrderID "
                + "left join ManageOrder mo on mo.OrderID = o.ID "
                + "left join Account a on mo.AccountID = a.ID "
                + "where o.Status = ? "
                + "GROUP BY o.ID, o.UpdateDate, o.CreateDate, o.Status, o.Note, o.FullName, o.Email, o.ReceiveAddress, o.Tel, o.AccountID, o.PaymentMethod, o.isPaid, a.FullName";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, status);
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
//                order.setAccount(accountDAO.getAccount(rs.getInt("AccountID")));
                order.setPaid(rs.getBoolean("isPaid"));

                OrderRAW3 orderRAW3 = new OrderRAW3();
                orderRAW3.setOrder(order);
                orderRAW3.setTotalCost(rs.getFloat("TotalAmount"));
                orderRAW3.setTotalProduct(rs.getInt("TotalProduct"));
                orderRAW3.setProductName(cutStringTo20Chars(rs.getString("productName")) + "..., " + (rs.getInt("TotalProduct") - 1) + " more");
                orderRAW3.setManagerName(rs.getString("ManagerName"));

                orderRAW3s.add(orderRAW3);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderRAW3s;
    }
    
    public List<OrderRAW3> listOrderByDate(String CreateDate, String CreateDate1) {
        List<OrderRAW3> orderRAW3s = new ArrayList<>();
        String sql = "SELECT o.*, SUM(od.Price * od.Quantity) as TotalAmount, COUNT(od.ProductVariantSizeId) as TotalProduct, "
                + "(select top 1 pv.Name from OrderDetail od "
                + "left join ProductVariantSize pvs on od.ProductVariantSizeId = pvs.Id "
                + "left join ProductVariant pv on pv.Id = pvs.ProductVariantId "
                + "where od.OrderID = o.ID) as productName, a.FullName [ManagerName] "
                + "FROM [Order] o LEFT JOIN OrderDetail od ON o.ID = od.OrderID "
                + "left join ManageOrder mo on mo.OrderID = o.ID "
                + "left join Account a on mo.AccountID = a.ID "
                + "where o.CreateDate >= ? and o.CreateDate <= ? "
                + "GROUP BY o.ID, o.UpdateDate, o.CreateDate, o.Status, o.Note, o.FullName, o.Email, o.ReceiveAddress, o.Tel, o.AccountID, o.PaymentMethod, o.isPaid, a.FullName";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, CreateDate);
            ps.setString(2, CreateDate1);
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
//                order.setAccount(accountDAO.getAccount(rs.getInt("AccountID")));
                order.setPaid(rs.getBoolean("isPaid"));

                OrderRAW3 orderRAW3 = new OrderRAW3();
                orderRAW3.setOrder(order);
                orderRAW3.setTotalCost(rs.getFloat("TotalAmount"));
                orderRAW3.setTotalProduct(rs.getInt("TotalProduct"));
                orderRAW3.setProductName(cutStringTo20Chars(rs.getString("productName")) + "..., " + (rs.getInt("TotalProduct") - 1) + " more");
                orderRAW3.setManagerName(rs.getString("ManagerName"));

                orderRAW3s.add(orderRAW3);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderRAW3s;
    }
    
    public List<Order> listAllOrderName() {
        List<Order> orders = new ArrayList<>();
        String sql = "select distinct FullName from [Order]";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();

                order.setFullName(rs.getString("FullName"));

                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
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
