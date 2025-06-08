/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import model.Category;

/**
 *
 * @author HP
 */
public class CategoryDAO extends DBContext {

    public List<Category> listAllCategory() {
        List<Category> categories = new ArrayList<>();
        String sql = "select * from Category";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                categories.add(new Category(rs.getString(1), rs.getString(2), rs.getDate(3), rs.getDate(4), null, null));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }
    
    public Set<Category> listAll(int book_id) {
        Set<Category> categories = new HashSet<>();
        String sql = "select * from Category c left join BookCategory bc on c.ID = bc.CategoryID where bc.BookID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, book_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                categories.add(new Category(rs.getString(1), rs.getString(2), rs.getDate(3), rs.getDate(4), null, null));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    public Map<Category, Integer> getAllCategory() {
        Map<Category, Integer> totalBookOfCategory = new HashMap<>();
        String sql = "SELECT a.ID, a.Name,a.CreateDate,a.UpdateDate,"
                + "COUNT(bc.BookID) AS NumberOfcategoty "
                + " FROM Category a LEFT JOIN BookCategory bc ON a.ID = bc.CategoryID"
                + " GROUP BY a.ID, a.Name,a.CreateDate,a.UpdateDate";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String id = rs.getString("id");
                String name = rs.getString("name");
                Date createDate = rs.getDate("createDate");
                Date updateDate = rs.getDate("updateDate");
                int numberOfBooks = rs.getInt("NumberOfcategoty");

                Category cate = new Category(id, name, createDate, updateDate, null, null);
                totalBookOfCategory.put(cate, numberOfBooks);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalBookOfCategory;
    }

    public void deleteCategory(String id) {
        try {
            String sql = "delete from Category where id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, id);
            ps.execute();

        } catch (Exception e) {
            System.out.println("add:" + e.getMessage());
        }
    }

    public Category getCategoryById(String id) {
        try {
            String sql = "select * from Category where id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                String name = rs.getString(2);
                return new Category(id, name, null, null, null, null);

            }
        } catch (Exception e) {
            System.out.println("getEventById" + e.getMessage());
        }
        return null;
    }

    public void addCategory(Category c) {
        try {
            String sql = "INSERT INTO Category (Name) VALUES (?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, c.getName());
            ps.execute();

        } catch (Exception ex) {
            System.out.println("add:" + ex.getMessage());
        }
    }

    public void editCategory(Category c) {
        try {
            String sql = "update Category set name=?, UpdateDate=GETDATE()   where id =?";
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, c.getName());

            ps.setString(2, c.getId());
            ps.execute();

        } catch (Exception ex) {
            System.out.println("update:" + ex.getMessage());
        }
    }

    public Map<Category, Integer> searchCAtegoryByName(String name) {
        Map<Category, Integer> totalBookOfCategory = new HashMap<>();
        String sql = "SELECT a.ID, a.Name, a.CreateDate, a.UpdateDate, COUNT(bc.BookID) AS NumberOfcategoty"
                + "   FROM Category a LEFT JOIN BookCategory bc ON a.ID = bc.CategoryID "
                + "   WHERE a.Name LIKE  '%" + name + "%' " 
                + "   GROUP BY a.ID, a.Name, a.CreateDate, a.UpdateDate";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String id = rs.getString("id");
                String nameC = rs.getString("name");
                Date createDate = rs.getDate("createDate");
                Date updateDate = rs.getDate("updateDate");
                int numberOfBooks = rs.getInt("NumberOfcategoty");

                Category cate = new Category(id, nameC, createDate, updateDate, null, null);
                totalBookOfCategory.put(cate, numberOfBooks);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalBookOfCategory;
    }



        public static void main(String[] args) {
            // Initialize the DAO
            CategoryDAO categoryDAO = new CategoryDAO();

            // Search for categories by name
            String searchName = "Pub"; // Example search term
            Map<Category, Integer> categories = categoryDAO.searchCAtegoryByName(searchName);

            // Print out the search results
            for (Map.Entry<Category, Integer> entry : categories.entrySet()) {
                Category category = entry.getKey();
                Integer bookCount = entry.getValue();
                System.out.println("Category ID: " + category.getId());
                System.out.println("Category Name: " + category.getName());
                System.out.println("Create Date: " + category.getCreateDate());
                System.out.println("Update Date: " + category.getUpdateDate());
                System.out.println("Number of Books: " + bookCount);
                System.out.println("---------------------------");
            }
        }
    }

