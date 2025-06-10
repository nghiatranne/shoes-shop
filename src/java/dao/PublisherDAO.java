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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Publisher;
import model.Product;

/**
 *
 * @author hoaht
 */
public class PublisherDAO extends DBContext {

    public Publisher getPublisherById(int id) {
        String sql = "SELECT * FROM publisher WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Publisher p = new Publisher();
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
    
    public void addPublisher(Publisher publisher) {
        String sql = "INSERT INTO publisher (name) VALUES (?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, publisher.getName());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void updatePublisher(Publisher publisher) {
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
    

    public List<Publisher> listAll() {
        List<Publisher> publishers = new ArrayList<>();
        String sql = "SELECT * FROM Publisher";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                publishers.add(new Publisher(rs.getInt("Id"), rs.getString("name"), rs.getDate("createdate"), rs.getDate("updatedate"), null));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return publishers;
    }
    
    public Publisher getPublisherByBookID(int book_id) {
        String sql = "select p.* from Publisher p left join Book b on p.ID = b.PublisherID where b.ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, book_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Publisher(rs.getInt("Id"), rs.getString("name"), rs.getDate("createdate"), rs.getDate("updatedate"), null);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Map<Publisher, Integer> listAllPublisherAndTotalBook() {
        Map<Publisher, Integer> publishers = new HashMap<>();
        String sql = "select p.*, count(b.ID) from Publisher p left join Book b on p.ID = b.PublisherID group by p.ID, p.Name, p.CreateDate, p.UpdateDate";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                publishers.put(new Publisher(rs.getInt("Id"), rs.getString("name"), rs.getDate("createdate"), rs.getDate("updatedate"), null), rs.getInt(5));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return publishers;
    }
    
    public void addNewPublisher(Publisher publisher) {
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
    
    public Publisher getPublisher(int id) {
        String sql = "select * from Publisher where ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Publisher(rs.getInt("ID"), rs.getString("name"), rs.getDate("createDate"), rs.getDate("updateDate"), null);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public void update(Publisher publisher, int id) {
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
