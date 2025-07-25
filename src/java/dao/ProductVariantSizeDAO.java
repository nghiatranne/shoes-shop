package dao;

import dal.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import model.Product;
import model.ProductVariantSize;
import model.ProductVariant;
import model.Size;

public class ProductVariantSizeDAO extends DBContext {
    
    public void updateHold(int bookId, int quantity) {
        String sql = "update ProductVariantSize set ProductVariantSize = ? where ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, bookId);
            ps.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public List<ProductVariantSize> getAllProductVariantSizes() {
        List<ProductVariantSize> list = new ArrayList<>();
        String sql = "SELECT * FROM product_variant_size WHERE status = 1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ProductVariantSize pvs = new ProductVariantSize();
                pvs.setId(rs.getInt("id"));
                pvs.setQuantityInStock(rs.getInt("quantity_in_stock"));
                pvs.setQuantityHolding(rs.getInt("quantity_holding"));
                pvs.setStatus(rs.getBoolean("status"));
                
                // Get product variant
                ProductVariantDAO pvDAO = new ProductVariantDAO();
                ProductVariant pv = pvDAO.getProductVariantById(rs.getInt("product_variant_id"));
                pvs.setProductVariant(pv);
                
                // Get size
                SizeDAO sizeDAO = new SizeDAO();
                Size size = sizeDAO.getSizeById(rs.getInt("size_id"));
                pvs.setSize(size);
                
                list.add(pvs);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public ProductVariantSize getProductVariantSizeId(int id) {
        System.out.println("EXECUTE " + id);
        ProductDAO productDAO = new ProductDAO();
        String sql = "SELECT pvs.*, pv.*, s.* FROM ProductVariantSize pvs "
                + "left join ProductVariant pv on pv.Id = pvs.ProductVariantId "
                + "left join Size s on s.Id = pvs.SizeId "
                + "left join Product p on p.Id = pv.ProductId "
                + "WHERE pvs.id = ?";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                ProductVariantSize pvs = new ProductVariantSize();
                pvs.setId(rs.getInt("ID"));
               
                pvs.setQuantityInStock(rs.getInt("QuantityInStock"));
                pvs.setQuantityHolding(rs.getInt("QuantityHolding"));
                pvs.setStatus(rs.getBoolean("Status"));
                
//                // Get product variant
//                ProductVariantDAO pvDAO = new ProductVariantDAO();
//                ProductVariant pv = pvDAO.getProductVariantById(rs.getInt("ProductVariantID"));
//                pvs.setProductVariant(pv);

                ProductVariant pv = new ProductVariant();
                pv.setId(rs.getInt("ProductVariantId"));
                pv.setName(rs.getString("Name"));
                pv.setImportPrice(rs.getDouble("ImportPrice"));
                pv.setPrice(rs.getDouble("price"));
                pv.setImage(rs.getString("image"));
                pv.setProduct(productDAO.getProductById(rs.getInt("productId")));
                pvs.setProductVariant(pv);

                Size s = new Size();
                s.setId(rs.getInt("SizeId"));
                s.setValue(rs.getInt("value"));
                pvs.setSize(s);
                
                return pvs;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public List<ProductVariantSize> getProductVariantSizesByProductVariantId(int productVariantId) {
        List<ProductVariantSize> list = new ArrayList<>();
        String sql = "SELECT * FROM ProductVariantSize WHERE ProductVariantID = ? AND Status = 1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, productVariantId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ProductVariantSize pvs = new ProductVariantSize();
                pvs.setId(rs.getInt("ID"));
               
                pvs.setQuantityInStock(rs.getInt("QuantityInStock"));
                pvs.setQuantityHolding(rs.getInt("QuantityHolding"));
                pvs.setStatus(rs.getBoolean("Status"));
                
//                // Get product variant
//                ProductVariantDAO pvDAO = new ProductVariantDAO();
//                ProductVariant pv = pvDAO.getProductVariantById(rs.getInt("ProductVariantID"));
//                pvs.setProductVariant(pv);
                
                // Get size
                SizeDAO sizeDAO = new SizeDAO();
                Size size = sizeDAO.getSizeById(rs.getInt("SizeID"));
                pvs.setSize(size);
                
                list.add(pvs);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public ProductVariantSize getProductVariantSizesByProductVariantId(int productVariantId, int sizeId) {
        String sql = "SELECT * FROM ProductVariantSize WHERE ProductVariantID = ? AND SizeID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, productVariantId);
            st.setInt(2, sizeId);

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                ProductVariantSize pvs = new ProductVariantSize();
                pvs.setId(rs.getInt("ID"));
               
                pvs.setQuantityInStock(rs.getInt("QuantityInStock"));
                pvs.setQuantityHolding(rs.getInt("QuantityHolding"));
                pvs.setStatus(rs.getBoolean("Status"));
                
//                // Get product variant
//                ProductVariantDAO pvDAO = new ProductVariantDAO();
//                ProductVariant pv = pvDAO.getProductVariantById(rs.getInt("ProductVariantID"));
//                pvs.setProductVariant(pv);
                
                // Get size
                SizeDAO sizeDAO = new SizeDAO();
                Size size = sizeDAO.getSizeById(rs.getInt("SizeID"));
                pvs.setSize(size);
                
                return pvs;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public ProductVariantSize getProductVariantSizeById(int id) {
        ProductDAO productDAO = new ProductDAO();
        
        String sql = "SELECT * FROM ProductVariantSize pvs " +
                "left join ProductVariant pv on pvs.ProductVariantID = pv.ID " +
                "left join Size s on s.Id = pvs.SizeId " +
                "WHERE pvs.id = ? ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                ProductVariantSize pvs = new ProductVariantSize();
                pvs.setId(rs.getInt("id"));
                pvs.setQuantityInStock(rs.getInt("QuantityInStock"));
                pvs.setQuantityHolding(rs.getInt("QuantityHolding"));
                pvs.setStatus(rs.getBoolean("status"));
                ProductVariant pv = new ProductVariant();
                pv.setId(rs.getInt("ProductVariantID"));
                pv.setName(rs.getString("Name"));
                pv.setImportPrice(rs.getDouble("ImportPrice"));
                pv.setImage(rs.getString("image"));
                pv.setPrice(rs.getDouble("Price"));
                pv.setProduct(productDAO.getProductById(rs.getInt("ProductId")));
                pvs.setProductVariant(pv);
                Size s = new Size();
                s.setId(rs.getInt("SizeId"));
                s.setValue(rs.getInt("Value"));
                pvs.setSize(s);
                
                return pvs;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public void addProductVariantSize(ProductVariantSize pvs) {
        String sql = "INSERT INTO product_variant_size (product_variant_id, size_id, quantity_in_stock, quantity_holding, status) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, pvs.getProductVariant().getId());
            st.setInt(2, pvs.getSize().getId());
            st.setInt(3, pvs.getQuantityInStock());
            st.setInt(4, pvs.getQuantityHolding());
            st.setBoolean(5, pvs.isStatus());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void updateProductVariantSize(ProductVariantSize pvs) {
        String sql = "UPDATE product_variant_size SET product_variant_id = ?, size_id = ?, quantity_in_stock = ?, quantity_holding = ?, status = ? WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, pvs.getProductVariant().getId());
            st.setInt(2, pvs.getSize().getId());
            st.setInt(3, pvs.getQuantityInStock());
            st.setInt(4, pvs.getQuantityHolding());
            st.setBoolean(5, pvs.isStatus());
            st.setInt(6, pvs.getId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void deleteProductVariantSize(int id) {
        String sql = "UPDATE product_variant_size SET status = 0 WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void updateQuantity(int id, int quantity) {
        String sql = "UPDATE ProductVariantSize SET QuantityInStock = ? WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, quantity);
            st.setInt(2, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void updateHoldingQuantity(int id, int quantity) {
        String sql = "UPDATE ProductVariantSize SET QuantityHolding = ? WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, quantity);
            st.setInt(2, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
} 