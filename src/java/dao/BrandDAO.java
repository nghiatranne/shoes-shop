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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Brand;
import model.Category;
import model.Product;
import model.Product;

/**
 *
 * @author hoaht
 */
public class BrandDAO extends DBContext {
    public List<Brand> listAllBrand() {
        List<Brand> brands = new ArrayList<>();
        String sql = "select * from Brand";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                brands.add(new Brand(rs.getInt(1), rs.getString(4), rs.getDate(3), rs.getDate(2), null));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return brands;
    }
    
    public Map<Brand, Integer> searchBrandByName(String name) {
        Map<Brand, Integer> totalBookOfBrand = new HashMap<>();
        String sql = "SELECT b.ID, b.Name,b.CreateDate,b.UpdateDate, COUNT(p.Id) AS NumberOfBrand "
                + "   FROM Brand b LEFT JOIN Product p ON b.Id = p.BrandId "
                + "   WHERE b.Name LIKE  '%" + name + "%' " 
                + "   GROUP BY b.ID, b.Name,b.CreateDate,b.UpdateDate";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                String nameC = rs.getString("name");
                Date createDate = rs.getDate("createDate");
                Date updateDate = rs.getDate("updateDate");
                int numberOfBrands = rs.getInt("NumberOfBrand");

                Brand brand = new Brand(id, nameC, createDate, updateDate, null);
                totalBookOfBrand.put(brand, numberOfBrands);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalBookOfBrand;
    }
    
    public Map<Brand, Integer> getAllBrand() {
        Map<Brand, Integer> totalProductOfBrand = new HashMap<>();
        String sql = "SELECT b.ID, b.Name,b.CreateDate,b.UpdateDate, COUNT(p.Id) AS NumberOfBrand "
                + "FROM Brand b LEFT JOIN Product p ON b.Id = p.BrandId "
                + "GROUP BY b.ID, b.Name,b.CreateDate,b.UpdateDate";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                Date createDate = rs.getDate("createDate");
                Date updateDate = rs.getDate("updateDate");
                int numberOfBrand = rs.getInt("NumberOfBrand");

                Brand brand = new Brand(id, name, createDate, updateDate, null);
                totalProductOfBrand.put(brand, numberOfBrand);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalProductOfBrand;
    }

    public Brand getPublisherById(int id) {
        String sql = "SELECT * FROM publisher WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Brand p = new Brand();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                return p;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public List<Product> getProductsByPublisherId(int publisherId) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM product WHERE publisher_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, publisherId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setTitle(rs.getString("title"));
                p.setImage(rs.getString("image"));
                p.setDescription(rs.getString("description"));
                p.setCreateDate(rs.getDate("create_date"));
                p.setUpdateDate(rs.getDate("update_date"));
                p.setStatus(rs.getBoolean("status"));
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public void addBrand(Brand brand) {
        String sql = "INSERT INTO brand (name) VALUES (?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, brand.getName());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void updatePublisher(Brand publisher) {
        String sql = "UPDATE publisher SET name = ? WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, publisher.getName());
            st.setInt(3, publisher.getId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    

    public List<Brand> listAll() {
        List<Brand> publishers = new ArrayList<>();
        String sql = "SELECT * FROM Publisher";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                publishers.add(new Brand(rs.getInt("Id"), rs.getString("name"), rs.getDate("createdate"), rs.getDate("updatedate"), null));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return publishers;
    }
    
    public Brand getBrandById(int id) {
        try {
            String sql = "select * from Brand where id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String name = rs.getString(4);
                return new Brand(id, name, null, null, null);

            }
        } catch (Exception e) {
            System.out.println("getEventById" + e.getMessage());
        }
        return null;
    }
    
    public void editBrand(Brand b) {
        try {
            String sql = "update Brand set name=?, UpdateDate=GETDATE()   where id =?";
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, b.getName());

            ps.setInt(2, b.getId());
            ps.execute();

        } catch (Exception ex) {
            System.out.println("update:" + ex.getMessage());
        }
    }
    
    public void deleteBrand(String id) {
        try {
            String sql = "delete from Brand where id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, id);
            ps.execute();

        } catch (Exception e) {
            System.out.println("add:" + e.getMessage());
        }
    }
    
    public Brand getPublisherByBookID(int book_id) {
        String sql = "select p.* from Publisher p left join Book b on p.ID = b.PublisherID where b.ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, book_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Brand(rs.getInt("Id"), rs.getString("name"), rs.getDate("createdate"), rs.getDate("updatedate"), null);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Map<Brand, Integer> listAllPublisherAndTotalBook() {
        Map<Brand, Integer> publishers = new HashMap<>();
        String sql = "select p.*, count(b.ID) from Publisher p left join Book b on p.ID = b.PublisherID group by p.ID, p.Name, p.CreateDate, p.UpdateDate";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                publishers.put(new Brand(rs.getInt("Id"), rs.getString("name"), rs.getDate("createdate"), rs.getDate("updatedate"), null), rs.getInt(5));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return publishers;
    }
    
    public void addNewPublisher(Brand publisher) {
        String sql = "insert into Publisher(Name) values (?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, publisher.getName());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void deletePublisher(int id) {
        String sql = "delete from Publisher where ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public Brand getPublisher(int id) {
        String sql = "select * from Brand where ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Brand(rs.getInt("ID"), rs.getString("name"), rs.getDate("createDate"), rs.getDate("updateDate"), null);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public void update(Brand publisher, int id) {
        SimpleDateFormat sf = new SimpleDateFormat("yyyy/MM/dd");
        String sql = "UPDATE Publisher SET name = ?, updateDate = ? WHERE id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            
            ps.setString(1, publisher.getName());
            ps.setString(2, sf.format(publisher.getUpdateDate()));
            ps.setInt(3, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
