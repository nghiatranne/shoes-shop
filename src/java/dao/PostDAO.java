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
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import model.Account;
import model.Category;
import model.Post;

/**
 *
 * @author hoaht
 */
public class PostDAO extends DBContext {

    public void createNewPost(Post post, String[] list_category_choose) {
        String sql = "INSERT INTO Post (Title, Thumbnail, Content, Status, AccountID) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, post.getTitle());
            ps.setString(2, post.getThumbnail());
            ps.setString(3, post.getContent());
            ps.setBoolean(4, post.isStatus());
            ps.setInt(5, post.getAccount().getId());

            ResultSet rs = ps.executeQuery();
            int id = -1;
            while (rs.next()) {
                id = rs.getInt(1);
            }

            if (list_category_choose != null && list_category_choose.length != 0) {
                String sql2 = "insert into PostCategory(CategoryID, PostID) values (?, ?)";
                PreparedStatement ps2 = connection.prepareStatement(sql2);

                for (String cId : list_category_choose) {
                    ps2.setInt(1, Integer.parseInt(cId));
                    ps2.setInt(2, id);
                    ps2.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Post> listAllPosts() {
        AccountDAO accountDAO = new AccountDAO();

        List<Post> posts = new ArrayList<>();
        String sql = "SELECT * FROM Post";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Post post = new Post();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("Title"));
                post.setThumbnail(rs.getString("Thumbnail"));
                post.setContent(rs.getString("Content"));
                post.setStatus(rs.getBoolean("Status"));
                post.setCreateAt(rs.getDate("CreateAt"));
                post.setUpdateAt(rs.getDate("UpdateAt"));

                Account account = accountDAO.getAccount(rs.getInt("AccountID"));
                post.setAccount(account);

                Set<Category> categoryPost = getCategoryPost(rs.getInt("id"));
                System.out.println("----------q->" + categoryPost.size());
                post.setCategories(categoryPost);
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public List<Post> listAllPostsWithTitle(String title) {
        AccountDAO accountDAO = new AccountDAO();

        List<Post> posts = new ArrayList<>();
        String sql = "select * from Post where Title like '%" + title + "%'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Post post = new Post();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("Title"));
                post.setThumbnail(rs.getString("Thumbnail"));
                post.setContent(rs.getString("Content"));
                post.setStatus(rs.getBoolean("Status"));
                post.setCreateAt(rs.getDate("CreateAt"));
                post.setUpdateAt(rs.getDate("UpdateAt"));

                Account account = accountDAO.getAccount(rs.getInt("AccountID"));
                post.setAccount(account);

                Set<Category> categoryPost = getCategoryPost(rs.getInt("id"));
                post.setCategories(categoryPost);
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public List<Post> listAllPostsWithCId(int cId) {
        AccountDAO accountDAO = new AccountDAO();

        List<Post> posts = new ArrayList<>();
        String sql = "select p.* from Post p left join PostCategory pc on p.id = pc.PostID where pc.CategoryID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Post post = new Post();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("Title"));
                post.setThumbnail(rs.getString("Thumbnail"));
                post.setContent(rs.getString("Content"));
                post.setStatus(rs.getBoolean("Status"));
                post.setCreateAt(rs.getDate("CreateAt"));
                post.setUpdateAt(rs.getDate("UpdateAt"));

                Account account = accountDAO.getAccount(rs.getInt("AccountID"));
                post.setAccount(account);

                Set<Category> categoryPost = getCategoryPost(rs.getInt("id"));
                post.setCategories(categoryPost);
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }
    
    public List<Post> listAllPostsWithAId(int cId) {
        AccountDAO accountDAO = new AccountDAO();

        List<Post> posts = new ArrayList<>();
        String sql = "select * from Post where AccountID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Post post = new Post();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("Title"));
                post.setThumbnail(rs.getString("Thumbnail"));
                post.setContent(rs.getString("Content"));
                post.setStatus(rs.getBoolean("Status"));
                post.setCreateAt(rs.getDate("CreateAt"));
                post.setUpdateAt(rs.getDate("UpdateAt"));

                Account account = accountDAO.getAccount(rs.getInt("AccountID"));
                post.setAccount(account);

                Set<Category> categoryPost = getCategoryPost(rs.getInt("id"));
                post.setCategories(categoryPost);
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public Set<Category> getCategoryPost(int postId) {
        Set<Category> categorys = new HashSet<>();
        String sql = "select c.* from Category c left join PostCategory pc on c.ID = pc.CategoryID where pc.PostID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, postId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                categorys.add(new Category(rs.getInt(1), rs.getString(2), rs.getDate(3), rs.getDate(4), null, null));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categorys;
    }

    public void updateStatus(int postId, boolean status) {
        String sql = "UPDATE Post set Status = ? where id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setBoolean(1, status);
            ps.setInt(2, postId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Post getPost(int id) {
        AccountDAO accountDAO = new AccountDAO();

        String sql = "select * from Post where id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Post post = new Post();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("Title"));
                post.setThumbnail(rs.getString("Thumbnail"));
                post.setContent(rs.getString("Content"));
                post.setStatus(rs.getBoolean("Status"));
                post.setCreateAt(rs.getDate("CreateAt"));
                post.setUpdateAt(rs.getDate("UpdateAt"));

                Account account = accountDAO.getAccount(rs.getInt("AccountID"));
                post.setAccount(account);

                Set<Category> categoryPost = getCategoryPost(rs.getInt("id"));
                post.setCategories(categoryPost);

                return post;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void removeAllPostCategory(int postId) {
        String sql = "delete from PostCategory where PostID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, postId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updatePost(int postId, Post p, String[] list_category_choose) {
        String sql = "UPDATE Post set Title = ?, Thumbnail = ?, Content = ?, UpdateAt = GETDATE() where id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, p.getTitle());
            ps.setString(2, p.getThumbnail());
            ps.setString(3, p.getContent());
            ps.setInt(4, postId);
            ps.executeUpdate();

            if (list_category_choose != null && list_category_choose.length != 0) {
                String sql2 = "insert into PostCategory(CategoryID, PostID) values (?, ?)";
                PreparedStatement ps2 = connection.prepareStatement(sql2);

                for (String cId : list_category_choose) {
                    ps2.setInt(1, Integer.parseInt(cId));
                    ps2.setInt(2, postId);
                    ps2.executeUpdate();
                }
            }
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Post> listAllPostsSortedByUpdatedDate(int page, int recordsPerPage) throws SQLException {
        List<Post> posts = new ArrayList<>();
        int start = (page - 1) * recordsPerPage;
        // SQL Server pagination syntax
        String sql = "SELECT * FROM Post ORDER BY CreateAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, start);
            ps.setInt(2, recordsPerPage);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Post post = new Post();
                    post.setId(rs.getInt("id"));
                    post.setTitle(rs.getString("Title"));
                    post.setThumbnail(rs.getString("Thumbnail"));
                    post.setContent(rs.getString("Content"));
                    post.setStatus(rs.getBoolean("Status"));
                    post.setCreateAt(rs.getDate("CreateAt"));
                    post.setUpdateAt(rs.getDate("UpdateAt"));
                    post.setAccount(new AccountDAO().getAccount(rs.getInt("AccountID")));
                    post.setCategories(getCategoryPost(rs.getInt("id")));
                    posts.add(post);
                }
            }
        }
        return posts;
    }
    public List<Post> listLatestUpdatedPosts(int limit){
    List<Post> posts = new ArrayList<>();
    String sql = "SELECT Top(?)* FROM Post ORDER BY CreateAt DESC";

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, limit);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Post post = new Post();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("Title"));
                post.setThumbnail(rs.getString("Thumbnail"));
                post.setContent(rs.getString("Content"));
                post.setStatus(rs.getBoolean("Status"));
                post.setCreateAt(rs.getDate("CreateAt"));
                post.setUpdateAt(rs.getDate("UpdateAt"));
                post.setAccount(new AccountDAO().getAccount(rs.getInt("AccountID")));
                post.setCategories(getCategoryPost(rs.getInt("id")));
                posts.add(post);
            }
        }
    }catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
        }

    return posts;
}

    public int getNumberOfPosts() throws SQLException {
        String sql = "SELECT COUNT(*) FROM Post";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
            }
        }
        return 0;
    }

    public List<Post> listAllPostsWithTitle(String titleSearch, int page, int recordsPerPage) throws SQLException {
        List<Post> posts = new ArrayList<>();
        int start = (page - 1) * recordsPerPage;
        String sql = "SELECT * FROM Post WHERE Title LIKE ? ORDER BY CreateAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            // Set parameters before executing the query
            ps.setString(1, "%" + titleSearch + "%");
            ps.setInt(2, start);
            ps.setInt(3, recordsPerPage);

            try (ResultSet rs = ps.executeQuery()) {  // Execute the query after setting parameters
                while (rs.next()) {
                    Post post = new Post();
                    post.setId(rs.getInt("id"));
                    post.setTitle(rs.getString("Title"));
                    post.setThumbnail(rs.getString("Thumbnail"));
                    post.setContent(rs.getString("Content"));
                    post.setStatus(rs.getBoolean("Status"));
                    post.setCreateAt(rs.getDate("CreateAt"));
                    post.setUpdateAt(rs.getDate("UpdateAt"));

                    Account account = new AccountDAO().getAccount(rs.getInt("AccountID"));
                    post.setAccount(account);

                    Set<Category> categoryPost = getCategoryPost(rs.getInt("id"));
                    post.setCategories(categoryPost);
                    posts.add(post);
                }
            }
        }
        return posts;
    }

    public int getNumberOfPosts(String titleSearch) throws SQLException {
        int count = 0;
        String sql = "SELECT COUNT(*) AS total FROM Post WHERE Title LIKE ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + titleSearch + "%");

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt("total");
                }
            }
        }
        return count;
    }
    
    public int getTotalNewPostToday() {
        String sql = "select COUNT(*) from Post where CreateAt = CAST(GETDATE() AS DATE)";
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
    
    public int getTotalPost() {
        String sql = "select COUNT(*) from Post";
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
    
    public void deletePost(int postID) {
    String deletePostCategorySQL = "DELETE FROM PostCategory WHERE PostID = ?";
    String deletePostSQL = "DELETE FROM Post WHERE ID = ?";
    
    try {
        connection.setAutoCommit(false); // Bắt đầu transaction

        // Xóa các bản ghi liên quan trong PostCategory trước
        try (PreparedStatement ps1 = connection.prepareStatement(deletePostCategorySQL)) {
            ps1.setInt(1, postID);
            ps1.executeUpdate();
        }

        // Sau đó mới xóa post
        try (PreparedStatement ps2 = connection.prepareStatement(deletePostSQL)) {
            ps2.setInt(1, postID);
            ps2.executeUpdate();
        }

        connection.commit(); // Commit nếu mọi thứ thành công
    } catch (SQLException e) {
        try {
            connection.rollback(); // Rollback nếu có lỗi
        } catch (SQLException rollbackEx) {
            rollbackEx.printStackTrace();
        }
        e.printStackTrace();
    } finally {
        try {
            connection.setAutoCommit(true); // Trả lại trạng thái ban đầu
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
}
