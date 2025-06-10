/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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
import model.ProductVariant;
import model.Product;

public class ProductVariantDAO extends DBContext {
    
    public List<ProductVariant> getAllProductVariants() {
        List<ProductVariant> list = new ArrayList<>();
        String sql = "SELECT * FROM product_variant WHERE status = 1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ProductVariant pv = new ProductVariant();
                pv.setId(rs.getInt("id"));
                pv.setName(rs.getString("name"));
                pv.setImportPrice(rs.getDouble("import_price"));
                pv.setPrice(rs.getDouble("price"));
                pv.setStatus(rs.getBoolean("status"));
                pv.setImage(rs.getString("image"));
                
                // Get product
                ProductDAO productDAO = new ProductDAO();
                Product product = productDAO.getProductById(rs.getInt("product_id"));
                pv.setProduct(product);
                
                list.add(pv);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public Set<ProductVariant> getProductVariantsByProductId(int productId) {
        Set<ProductVariant> list = new HashSet<>();
        String sql = "SELECT * FROM ProductVariant WHERE ProductID = ? AND Status = 1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, productId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ProductVariant pv = new ProductVariant();
                pv.setId(rs.getInt("ID"));
                pv.setName(rs.getString("Name"));
                pv.setImportPrice(rs.getDouble("ImportPrice"));
                pv.setPrice(rs.getDouble("Price"));
                pv.setStatus(rs.getBoolean("Status"));
                pv.setImage(rs.getString("Image"));
                
                // Get product
                ProductDAO productDAO = new ProductDAO();
                Product product = productDAO.getProductById(rs.getInt("ProductID"));
                pv.setProduct(product);
                
                ProductVariantSizeDAO productVariantSizeDAO = new ProductVariantSizeDAO();
                pv.setProductvariantsizes(productVariantSizeDAO.getProductVariantSizesByProductVariantId(rs.getInt("ID")));
                
                list.add(pv);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public ProductVariant getProductVariantById(int id) {
        String sql = "SELECT * FROM product_variant WHERE id = ? AND status = 1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                ProductVariant pv = new ProductVariant();
                pv.setId(rs.getInt("id"));
                pv.setName(rs.getString("name"));
                pv.setImportPrice(rs.getDouble("import_price"));
                pv.setPrice(rs.getDouble("price"));
                pv.setStatus(rs.getBoolean("status"));
                pv.setImage(rs.getString("image"));
                
                // Get product
                ProductDAO productDAO = new ProductDAO();
                Product product = productDAO.getProductById(rs.getInt("product_id"));
                pv.setProduct(product);
                
                return pv;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public void addProductVariant(ProductVariant pv) {
        String sql = "INSERT INTO product_variant (name, import_price, price, product_id, status, image) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, pv.getName());
            st.setDouble(2, pv.getImportPrice());
            st.setDouble(3, pv.getPrice());
            st.setInt(4, pv.getProduct().getId());
            st.setBoolean(5, pv.isStatus());
            st.setString(6, pv.getImage());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void updateProductVariant(ProductVariant pv) {
        String sql = "UPDATE product_variant SET name = ?, import_price = ?, price = ?, product_id = ?, status = ?, image = ? WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, pv.getName());
            st.setDouble(2, pv.getImportPrice());
            st.setDouble(3, pv.getPrice());
            st.setInt(4, pv.getProduct().getId());
            st.setBoolean(5, pv.isStatus());
            st.setString(6, pv.getImage());
            st.setInt(7, pv.getId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void deleteProductVariant(int id) {
        String sql = "UPDATE product_variant SET status = 0 WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
