/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import model.Brand;
import model.Category;
import model.Product;
import model.ProductVariant;
import model.ProductVariantSize;
import model.Publisher;
import model.Size;
import java.sql.Connection;
import java.sql.Timestamp;
import jakarta.servlet.http.Part;
import java.io.IOException;

/**
 *
 * @author admin
 */
public class ProductDAO extends DBContext{
    public List<Product> listAll() {
        BrandDAO brandDAO = new BrandDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Product";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("ID"));
                product.setTitle(rs.getString("Title"));
                product.setImage(rs.getString("Image"));
                product.setDescription(rs.getString("Description")); 
                product.setCreateDate(rs.getDate("CreateDate"));
                product.setUpdateDate(rs.getDate("UpdateDate"));
                product.setStatus(rs.getInt("Status") == 1);
                product.setBrand(brandDAO.getBrandById(rs.getInt("BrandID")));

                product.setCategories(categoryDAO.listAll(product.getId()));
                // Bạn có thể set thêm productvariants nếu có DAO tương ứng

                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public List<Product> listNewProducts() {
        BrandDAO brandDAO = new BrandDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        ProductVariantDAO productVariantDAO = new ProductVariantDAO();

        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Product ORDER BY CreateDate DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("ID"));
                product.setTitle(rs.getString("Title"));
                product.setImage(rs.getString("Image"));
                product.setDescription(rs.getString("Description")); // hoặc "DescDetail" nếu bạn muốn
                product.setCreateDate(rs.getDate("CreateDate"));
                product.setUpdateDate(rs.getDate("UpdateDate"));
                product.setStatus(rs.getInt("Status") == 1);
                product.setBrand(brandDAO.getBrandById(rs.getInt("BrandID")));

                product.setCategories(categoryDAO.listAll(product.getId()));
                // Nếu có DAO cho ProductVariant thì thêm ở đây:
                product.setProductvariants(productVariantDAO.getProductVariantsByProductId(product.getId()));

                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public List<Product> listBestSellers() {
        BrandDAO brandDAO = new BrandDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        ProductVariantDAO productVariantDAO = new ProductVariantDAO();
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, SUM(od.Quantity) AS TotalSold "
                   + "FROM Product p "
                   + "JOIN ProductVariant pv ON p.ID = pv.ProductID "
                   + "JOIN ProductVariantSize pvs ON pv.ID = pvs.ProductVariantID "
                   + "JOIN OrderDetail od ON pvs.ID = od.ProductVariantSizeID "
                   + "GROUP BY p.ID, p.Title, p.Image, p.Description, p.CreateDate, p.UpdateDate, p.Status, p.PublisherID "
                   + "HAVING SUM(od.Quantity) > 5 "
                   + "ORDER BY TotalSold DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("ID"));
                product.setTitle(rs.getString("Title"));
                product.setImage(rs.getString("Image"));
                product.setDescription(rs.getString("Description"));
                product.setCreateDate(rs.getDate("CreateDate"));
                product.setUpdateDate(rs.getDate("UpdateDate"));
                product.setStatus(rs.getBoolean("Status"));
                product.setBrand(brandDAO.getBrandById(rs.getInt("BrandID")));
                product.setCategories(categoryDAO.listAll(product.getId()));

                // Nếu cần, có thể load thêm productVariants ở đây
                product.setProductvariants(productVariantDAO.getProductVariantsByProductId(product.getId()));
                products.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }
    public List<Product> listRandomProducts() {
        BrandDAO brandDAO = new BrandDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Product> products = new ArrayList<>();
        ProductVariantDAO productVariantDAO = new ProductVariantDAO();

        String sql = "SELECT * FROM Product WHERE Status = 1 ORDER BY NEWID()";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("ID"));
                product.setTitle(rs.getString("Title"));
                product.setImage(rs.getString("Image"));
                product.setDescription(rs.getString("Description"));
                product.setCreateDate(rs.getDate("CreateDate"));
                product.setUpdateDate(rs.getDate("UpdateDate"));
                product.setStatus(rs.getBoolean("Status"));
                product.setBrand(brandDAO.getBrandById(rs.getInt("BrandID")));
                product.setCategories(categoryDAO.listAll(product.getId()));
                product.setProductvariants(productVariantDAO.getProductVariantsByProductId(product.getId()));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public Product getProductById(int id) {
        String sql = "SELECT * FROM Product WHERE ID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("ID"));
                p.setTitle(rs.getString("Title"));
                p.setImage(rs.getString("Image"));
                p.setDescription(rs.getString("Description"));
                p.setCreateDate(rs.getDate("CreateDate"));
                p.setUpdateDate(rs.getDate("UpdateDate"));
                p.setStatus(rs.getBoolean("Status"));
                
                BrandDAO brandDAO = new BrandDAO();
                Brand brand = brandDAO.getBrandById(rs.getInt("BrandID"));
                p.setBrand(brand);
                
                // Get categories
                CategoryDAO categoryDAO = new CategoryDAO();
                Set<Category> categories = categoryDAO.listAll(id);
                p.setCategories(categories);
                
                ProductVariantDAO productVariantDAO = new ProductVariantDAO();
                List<ProductVariant> variants = productVariantDAO.getProductVariantsByProductId(id);
                p.setProductvariants(variants);
                
                return p;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public Product getProductDetailById(int id) {
        String sql = "SELECT * FROM Product WHERE ID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("ID"));
                p.setTitle(rs.getString("Title"));
                p.setImage(rs.getString("Image"));
                p.setDescription(rs.getString("Description"));
                p.setCreateDate(rs.getDate("CreateDate"));
                p.setUpdateDate(rs.getDate("UpdateDate"));
                p.setStatus(rs.getBoolean("Status"));
                
                BrandDAO brandDAO = new BrandDAO();
                Brand brand = brandDAO.getBrandById(rs.getInt("BrandID"));
                p.setBrand(brand);
                
                // Get categories
                CategoryDAO categoryDAO = new CategoryDAO();
                Set<Category> categories = categoryDAO.listAll(id);
                p.setCategories(categories);
                
                ProductVariantDAO productVariantDAO = new ProductVariantDAO();
                List<ProductVariant> variants = productVariantDAO.getProductVariantsByProductId(id);
                p.setProductvariants(variants);
                
                return p;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public List<ProductVariant> getListProductVariantByProductId(int productId) {
        List<ProductVariant> list = new ArrayList<>();
        String sql = "select * from ProductVariant where ProductID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, productId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ProductVariant productVariant = new ProductVariant();
                productVariant.setId(rs.getInt("ID"));
                productVariant.setName(rs.getString("Name"));
                productVariant.setImportPrice(rs.getDouble("ImportPrice"));
                productVariant.setPrice(rs.getDouble("Price"));
                productVariant.setStatus(rs.getBoolean("Status"));
                productVariant.setCreateDate(rs.getDate("CreateDate"));
                productVariant.setUpdateDate(rs.getDate("UpdateDate"));
                productVariant.setImage(rs.getString("Image"));
                list.add(productVariant);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public List<ProductVariantSize> getListProductVariantSizeByProductId(int productVariantId) {
        List<ProductVariantSize> list = new ArrayList<>();
        String sql = "select * from ProductVariantSize pvs "
                + "left join Size s on pvs.SizeID = s.Id "
                + "where ProductVariantId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, productVariantId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ProductVariantSize productVariantSize = new ProductVariantSize();
                productVariantSize.setId(rs.getInt("ID"));
                productVariantSize.setQuantityHolding(rs.getInt("QuantityHolding"));
                productVariantSize.setQuantityInStock(rs.getInt("QuantityInStock"));
                Size s = new Size();
                s.setValue(rs.getInt("Value"));
                productVariantSize.setSize(s);
                list.add(productVariantSize);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> listAllActiveProducts() {
        BrandDAO brandDAO = new BrandDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        ProductVariantDAO productVariantDAO = new ProductVariantDAO();
        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM Product WHERE Status = 1";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("ID"));
                product.setTitle(rs.getString("Title"));
                product.setImage(rs.getString("Image"));
                product.setDescription(rs.getString("Description")); 
                product.setCreateDate(rs.getDate("CreateDate"));
                product.setUpdateDate(rs.getDate("UpdateDate"));
                product.setStatus(rs.getInt("Status") == 1);
                product.setBrand(brandDAO.getBrandById(rs.getInt("BrandID")));
                product.setCategories(categoryDAO.listAll(product.getId()));
                product.setProductvariants(productVariantDAO.getProductVariantsByProductId(product.getId()));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> searchProducts(String keyword) {
        BrandDAO brandDAO = new BrandDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        ProductVariantDAO productVariantDAO = new ProductVariantDAO();
        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM Product WHERE Status = 1 AND (Title LIKE ? OR Description LIKE ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("ID"));
                product.setTitle(rs.getString("Title"));
                product.setImage(rs.getString("Image"));
                product.setDescription(rs.getString("Description")); 
                product.setCreateDate(rs.getDate("CreateDate"));
                product.setUpdateDate(rs.getDate("UpdateDate"));
                product.setStatus(rs.getInt("Status") == 1);
                product.setBrand(brandDAO.getBrandById(rs.getInt("BrandID")));
                product.setCategories(categoryDAO.listAll(product.getId()));
                product.setProductvariants(productVariantDAO.getProductVariantsByProductId(product.getId()));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> listProductsByCategory(int categoryId) {
        BrandDAO brandDAO = new BrandDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        ProductVariantDAO productVariantDAO = new ProductVariantDAO();
        List<Product> products = new ArrayList<>();

        String sql = "SELECT DISTINCT p.* FROM Product p " +
                    "INNER JOIN ProductCategory pc ON p.ID = pc.ProductID " +
                    "WHERE p.Status = 1 AND pc.CategoryID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("ID"));
                product.setTitle(rs.getString("Title"));
                product.setImage(rs.getString("Image"));
                product.setDescription(rs.getString("Description")); 
                product.setCreateDate(rs.getDate("CreateDate"));
                product.setUpdateDate(rs.getDate("UpdateDate"));
                product.setStatus(rs.getInt("Status") == 1);
                product.setBrand(brandDAO.getBrandById(rs.getInt("BrandID")));
                product.setCategories(categoryDAO.listAll(product.getId()));
                product.setProductvariants(productVariantDAO.getProductVariantsByProductId(product.getId()));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public int addNewProduct(Product product) {
        String sql = "INSERT INTO Product (Title, Image, Description, CreateDate, UpdateDate, Status, BrandID) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, product.getTitle());
            ps.setString(2, product.getImage());
            ps.setString(3, product.getDescription());
            ps.setDate(4, new java.sql.Date(product.getCreateDate().getTime()));
            ps.setDate(5, new java.sql.Date(product.getUpdateDate().getTime()));
            ps.setBoolean(6, product.isStatus());
            ps.setInt(7, product.getBrand().getId());
            
            ps.executeUpdate();
            
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int productId = rs.getInt(1);
                
                // Add categories
                for (Category category : product.getCategories()) {
                    addProductCategory(productId, category.getId());
                }
                
                return productId;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    private void addProductCategory(int productId, int categoryId) throws SQLException {
        String sql = "INSERT INTO ProductCategory (ProductID, CategoryID) VALUES (?, ?)";
        DBContext db = new DBContext();
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setInt(2, categoryId);
            ps.executeUpdate();
        }
    }
    
    private void deleteProductCategories(int productId) throws SQLException {
        String sql = "DELETE FROM ProductCategory WHERE ProductID = ?";
        DBContext db = new DBContext();
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.executeUpdate();
        }
    }

    public void updateProductCategories(int productId, String[] categoryIds) throws SQLException {
        // First delete existing categories
        String deleteSql = "DELETE FROM ProductCategory WHERE ProductID = ?";
        
        try {
            PreparedStatement ps = connection.prepareStatement(deleteSql);
            ps.setInt(1, productId);
            ps.executeUpdate();
            
            String insertSql = "INSERT INTO ProductCategory (ProductID, CategoryID) VALUES (?, ?)";
            PreparedStatement ps2 = connection.prepareStatement(insertSql);
            for (String categoryId : categoryIds) {
                ps2.setInt(1, productId);
                ps2.setInt(2, Integer.parseInt(categoryId));
                ps2.addBatch();
            }
            ps2.executeBatch();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public int addProductVariant(ProductVariant variant) {
        String sql = "INSERT INTO ProductVariant (Name, ImportPrice, Price, ProductID, Status, CreateDate, UpdateDate, Image) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, variant.getName());
            ps.setDouble(2, variant.getImportPrice());
            ps.setDouble(3, variant.getPrice());
            ps.setInt(4, variant.getProduct().getId());
            ps.setBoolean(5, variant.isStatus());
            ps.setDate(6, new java.sql.Date(variant.getCreateDate().getTime()));
            ps.setDate(7, new java.sql.Date(variant.getUpdateDate().getTime()));
            ps.setString(8, variant.getImage());
            
            ps.executeUpdate();
            
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    public void addProductVariantSize(ProductVariantSize pvs) {
        String sql = "INSERT INTO ProductVariantSize (SizeID, ProductVariantID, QuantityInStock, QuantityHolding, Status, CreateDate, UpdateDate) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, pvs.getSize().getId());
            ps.setInt(2, pvs.getProductVariant().getId());
            ps.setInt(3, pvs.getQuantityInStock());
            ps.setInt(4, pvs.getQuantityHolding());
            ps.setBoolean(5, pvs.isStatus());
            ps.setDate(6, new java.sql.Date(pvs.getCreateDate().getTime()));
            ps.setDate(7, new java.sql.Date(pvs.getUpdateDate().getTime()));
            
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Product> listBookRelated(int bookID) {
        BrandDAO brandDAO = new BrandDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        ProductVariantDAO productVariantDAO = new ProductVariantDAO();

        List<Product> books = new ArrayList<>();

        String sql = "select * from Product where ID in ( "
                + "	select distinct b.ID from Product b left join ProductCategory bc on b.ID = bc.ProductID where bc.CategoryID in ( "
                + "		select c.ID from Category c left join ProductCategory bc on c.ID = bc.CategoryID where bc.ProductID = ? "
                + "	) and b.ID != ? "
                + ")";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, bookID);
            ps.setInt(2, bookID);
            ResultSet rs = ps.executeQuery();

            Map<Integer, Product> bookMap = new HashMap<>();

            while (rs.next()) {
                int bookId = rs.getInt("ID");
                Product book = bookMap.get(bookId);
                if (book == null) {
                    Product product = new Product();
                product.setId(rs.getInt("ID"));
                product.setTitle(rs.getString("Title"));
                product.setImage(rs.getString("Image"));
                product.setDescription(rs.getString("Description")); // hoặc "DescDetail" nếu bạn muốn
                product.setCreateDate(rs.getDate("CreateDate"));
                product.setUpdateDate(rs.getDate("UpdateDate"));
                product.setStatus(rs.getInt("Status") == 1);
                product.setBrand(brandDAO.getBrandById(rs.getInt("BrandID")));

                product.setCategories(categoryDAO.listAll(product.getId()));
                // Nếu có DAO cho ProductVariant thì thêm ở đây:
                product.setProductvariants(productVariantDAO.getProductVariantsByProductId(product.getId()));

                    bookMap.put(bookId, book);
                    books.add(book);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    public void updateProduct(Product product) {
        String sql = "UPDATE Product SET Title = ?, Image = ?, Description = ?, UpdateDate = ?, Status = ?, BrandID = ? WHERE ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, product.getTitle());
            ps.setString(2, product.getImage());
            ps.setString(3, product.getDescription());
            ps.setDate(4, new java.sql.Date(product.getUpdateDate().getTime()));
            ps.setBoolean(5, product.isStatus());
            ps.setInt(6, product.getBrand().getId());
            ps.setInt(7, product.getId());
            
            ps.executeUpdate();
            
            // Update categories
            updateProductCategories(product.getId(), product.getCategories().stream()
                    .map(category -> String.valueOf(category.getId()))
                    .toArray(String[]::new));
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void updateProductVariant(ProductVariant variant) {
        String sql = "UPDATE ProductVariant SET Name = ?, ImportPrice = ?, Price = ?, Status = ?, UpdateDate = ?, Image = ? WHERE ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, variant.getName());
            ps.setDouble(2, variant.getImportPrice());
            ps.setDouble(3, variant.getPrice());
            ps.setBoolean(4, variant.isStatus());
            ps.setDate(5, new java.sql.Date(variant.getUpdateDate().getTime()));
            ps.setString(6, variant.getImage());
            ps.setInt(7, variant.getId());
            
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void updateProductVariantSize(ProductVariantSize pvs) {
        String sql = "UPDATE ProductVariantSize SET SizeID = ?, QuantityInStock = ?, QuantityHolding = ?, Status = ?, UpdateDate = ? WHERE ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, pvs.getSize().getId());
            ps.setInt(2, pvs.getQuantityInStock());
            ps.setInt(3, pvs.getQuantityHolding());
            ps.setBoolean(4, pvs.isStatus());
            ps.setDate(5, new java.sql.Date(pvs.getUpdateDate().getTime()));
            ps.setInt(6, pvs.getId());
            
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Product> getFilterProduct(List<Integer> categoryIds, List<Integer> brandIds, Double minPrice, Double maxPrice, Integer rating, String key) {
        List<Product> products = new ArrayList<>();
        BrandDAO brandDAO = new BrandDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        ProductVariantDAO productVariantDAO = new ProductVariantDAO();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT DISTINCT p.* FROM Product p ");
        if (categoryIds != null && !categoryIds.isEmpty()) {
            sql.append("INNER JOIN ProductCategory pc ON p.ID = pc.ProductID ");
        }
        if (brandIds != null && !brandIds.isEmpty()) {
            // nothing to join, just filter
        }
        sql.append("LEFT JOIN ProductVariant pv ON p.ID = pv.ProductID ");
        if (rating != null && rating > 0) {
            sql.append("LEFT JOIN Feedback f ON p.ID = f.ProductID ");
        }
        sql.append("WHERE p.Status = 1 ");
        List<Object> params = new ArrayList<>();
        if (categoryIds != null && !categoryIds.isEmpty()) {
            sql.append("AND pc.CategoryID IN (");
            for (int i = 0; i < categoryIds.size(); i++) {
                sql.append("?");
                if (i < categoryIds.size() - 1) sql.append(",");
                params.add(categoryIds.get(i));
            }
            sql.append(") ");
        }
        if (brandIds != null && !brandIds.isEmpty()) {
            sql.append("AND p.BrandID IN (");
            for (int i = 0; i < brandIds.size(); i++) {
                sql.append("?");
                if (i < brandIds.size() - 1) sql.append(",");
                params.add(brandIds.get(i));
            }
            sql.append(") ");
        }
        if (minPrice != null) {
            sql.append("AND pv.Price >= ? ");
            params.add(minPrice);
        }
        if (maxPrice != null) {
            sql.append("AND pv.Price <= ? ");
            params.add(maxPrice);
        }
        if (key != null && !key.trim().isEmpty()) {
            sql.append("AND (p.Title LIKE ? OR p.Description LIKE ?) ");
            params.add("%" + key.trim() + "%");
            params.add("%" + key.trim() + "%");
        }
        if (rating != null && rating > 0) {
            sql.append("GROUP BY p.ID, p.Title, p.Image, p.Description, p.CreateDate, p.UpdateDate, p.Status, p.BrandID ");
            sql.append("HAVING AVG(f.Stars) >= ? ");
            params.add(rating.doubleValue());
        }
        sql.append("ORDER BY p.CreateDate DESC");
        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("ID"));
                product.setTitle(rs.getString("Title"));
                product.setImage(rs.getString("Image"));
                product.setDescription(rs.getString("Description"));
                product.setCreateDate(rs.getDate("CreateDate"));
                product.setUpdateDate(rs.getDate("UpdateDate"));
                product.setStatus(rs.getInt("Status") == 1);
                product.setBrand(brandDAO.getBrandById(rs.getInt("BrandID")));
                product.setCategories(categoryDAO.listAll(product.getId()));
                product.setProductvariants(productVariantDAO.getProductVariantsByProductId(product.getId()));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
}
