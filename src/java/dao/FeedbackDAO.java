package dao;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Feedback;
import model.ProductVariantSize;
import model.Account;
import dao.ProductVariantSizeDAO;
import model.ProductVariant;
import model.FeedbackDto;

/**
 * Data Access Object for Feedback
 */
public class FeedbackDAO extends DBContext {
    
    public List<Feedback> getAllFeedBacks() {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = "SELECT f.*, pvs.ID as ProductVariantSizeID, pv.Name as ProductVariantName, a.FullName FROM Feedback f JOIN ProductVariantSize pvs ON f.ProductVariantSizeID = pvs.ID JOIN ProductVariant pv ON pvs.ProductVariantID = pv.ID JOIN Account a ON f.AccountID = a.ID";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductVariantSize pvs = new ProductVariantSize();
                pvs.setId(rs.getInt("ProductVariantSizeID"));
                ProductVariant pv = new ProductVariant();
                pv.setName(rs.getString("ProductVariantName"));
                pvs.setProductVariant(pv);

                Account account = new Account();
                account.setId(rs.getInt("AccountID"));
                account.setFullname(rs.getString("FullName"));

                Feedback feedback = new Feedback();
                feedback.setPvs(pvs);
                feedback.setAccount(account);
                feedback.setContent(rs.getString("content"));
                feedback.setRatedStar(rs.getInt("RatedStar"));  
                feedback.setStatus(rs.getBoolean("Status"));    
                feedback.setCreateDate(rs.getDate("CreateDate")); 
                feedback.setUpdateDate(rs.getDate("UpdateDate")); 
                feedback.setImage(rs.getString("Image")); 

                feedbacks.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbacks;
    }

    public void insertFeedback(Feedback feedback) {
        String sql = "INSERT INTO Feedback (AccountID, ProductVariantSizeID, content, RatedStar, Status, CreateDate, UpdateDate, Image) VALUES (?, ?, ?, ?, ?, GETDATE(), GETDATE(), ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, feedback.getAccount().getId());
            ps.setInt(2, feedback.getPvs().getId());
            ps.setString(3, feedback.getContent());
            ps.setInt(4, feedback.getRatedStar());
            ps.setBoolean(5, feedback.isStatus());
            ps.setString(6, feedback.getImage());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateFeedbackStatus(int accountID, int productVariantSizeID, boolean status) {
        String sql = "UPDATE Feedback SET Status = ?, UpdateDate = GETDATE() WHERE AccountID = ? AND ProductVariantSizeID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setBoolean(1, status);
            ps.setInt(2, accountID);
            ps.setInt(3, productVariantSizeID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Feedback getFeedBack(int accountID, int productVariantSizeID) {
        String sql = "SELECT f.*, pvs.ID as ProductVariantSizeID, pv.Name as ProductVariantName, a.FullName, a.Email, a.Tel FROM Feedback f JOIN ProductVariantSize pvs ON f.ProductVariantSizeID = pvs.ID JOIN ProductVariant pv ON pvs.ProductVariantID = pv.ID JOIN Account a ON f.AccountID = a.ID WHERE f.AccountID = ? AND f.ProductVariantSizeID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accountID);
            ps.setInt(2, productVariantSizeID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                ProductVariantSize pvs = new ProductVariantSize();
                pvs.setId(rs.getInt("ProductVariantSizeID"));
                ProductVariant pv = new ProductVariant();
                pv.setName(rs.getString("ProductVariantName"));
                pvs.setProductVariant(pv);

                Account account = new Account();
                account.setId(rs.getInt("AccountID"));
                account.setFullname(rs.getString("FullName"));
                account.setEmail(rs.getString("Email"));
                account.setTelephone(rs.getString("Tel"));

                Feedback feedback = new Feedback();
                feedback.setPvs(pvs);
                feedback.setAccount(account);
                feedback.setContent(rs.getString("content"));
                feedback.setRatedStar(rs.getInt("RatedStar"));
                feedback.setStatus(rs.getBoolean("Status"));
                feedback.setCreateDate(rs.getDate("CreateDate"));
                feedback.setUpdateDate(rs.getDate("UpdateDate"));
                feedback.setImage(rs.getString("Image")); 
                return feedback;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateStatus(int accountID, int productVariantSizeID, boolean status) {
        String sql = "UPDATE Feedback SET Status = ? WHERE AccountID = ? AND ProductVariantSizeID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setBoolean(1, status);
            ps.setInt(2, accountID);
            ps.setInt(3, productVariantSizeID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Feedback> getAllFeedBacks(String sort, String order) {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = "SELECT f.*, pvs.ID as ProductVariantSizeID, pv.Name as ProductVariantName, pv.Id as ProductVariantId, a.FullName FROM Feedback f JOIN ProductVariantSize pvs ON f.ProductVariantSizeID = pvs.ID JOIN ProductVariant pv ON pvs.ProductVariantID = pv.ID JOIN Account a ON f.AccountID = a.ID ORDER BY " + sort + " " + order;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductVariantSize pvs = new ProductVariantSize();
                pvs.setId(rs.getInt("ProductVariantSizeID"));
                ProductVariant pv = new ProductVariant();
                pv.setId(rs.getInt("ProductVariantId"));
                pv.setName(rs.getString("ProductVariantName"));
                pvs.setProductVariant(pv);

                Account account = new Account();
                account.setId(rs.getInt("AccountID"));
                account.setFullname(rs.getString("FullName"));

                Feedback feedback = new Feedback();
                feedback.setPvs(pvs);
                feedback.setAccount(account);
                feedback.setContent(rs.getString("content"));
                feedback.setRatedStar(rs.getInt("RatedStar"));
                feedback.setStatus(rs.getBoolean("Status"));
                feedback.setCreateDate(rs.getDate("CreateDate"));
                feedback.setUpdateDate(rs.getDate("UpdateDate"));
                feedback.setImage(rs.getString("Image")); 

                feedbacks.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbacks;
    }

    public List<Feedback> getFeedbacks(String search, String status, String product, String ratedStar, String sort, String order) {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = "SELECT f.*, pvs.ID as ProductVariantSizeID, pv.Name as ProductVariantName, pv.Id as ProductVariantId, a.FullName FROM Feedback f JOIN ProductVariantSize pvs ON f.ProductVariantSizeID = pvs.ID JOIN ProductVariant pv ON pvs.ProductVariantID = pv.ID JOIN Account a ON f.AccountID = a.ID WHERE "
                   + "a.FullName LIKE ? AND pv.ID LIKE ? AND f.RatedStar LIKE ? ";
        
        if (!status.isEmpty()) {
            sql += "AND f.Status = ? ";
        }
        
        sql += "ORDER BY " + sort + " " + order;
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + product + "%");
            ps.setString(3, "%" + ratedStar + "%");
            if (!status.isEmpty()) {
                ps.setBoolean(4, Boolean.parseBoolean(status));
            }
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductVariantSize pvs = new ProductVariantSize();
                pvs.setId(rs.getInt("ProductVariantSizeID"));
                ProductVariant pv = new ProductVariant();
                pv.setId(rs.getInt("ProductVariantId"));
                pv.setName(rs.getString("ProductVariantName"));
                pvs.setProductVariant(pv);

                Account account = new Account();
                account.setId(rs.getInt("AccountID"));
                account.setFullname(rs.getString("FullName"));

                Feedback feedback = new Feedback();
                feedback.setPvs(pvs);
                feedback.setAccount(account);
                feedback.setContent(rs.getString("content"));
                feedback.setRatedStar(rs.getInt("RatedStar"));
                feedback.setStatus(rs.getBoolean("Status"));
                feedback.setCreateDate(rs.getDate("CreateDate"));
                feedback.setUpdateDate(rs.getDate("UpdateDate"));
                feedback.setImage(rs.getString("Image")); 
                feedbacks.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbacks;
    }
    
    public int getTotalFeedback() {
        String sql = "select count(*) from Feedback";
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
    
    public int getTotalFeedbackToday() {
        String sql = "select count(*) from Feedback where CreateDate = CAST(GETDATE() AS DATE)";
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
      public List<FeedbackDto> getFeedbacksByProductVariantSize(int productVariantSizeID) {
        List<FeedbackDto> feedbacks = new ArrayList<>();
        String sql = "SELECT f.content, f.RatedStar, f.Status, f.CreateDate, f.UpdateDate, f.Image, pv.Name as ProductVariantName, a.FullName FROM Feedback f JOIN ProductVariantSize pvs ON f.ProductVariantSizeID = pvs.ID JOIN ProductVariant pv ON pvs.ProductVariantID = pv.ID JOIN Account a ON f.AccountID = a.ID WHERE f.ProductVariantSizeID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productVariantSizeID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                FeedbackDto dto = new FeedbackDto();
                dto.setContent(rs.getString("content"));
                dto.setRatedStar(rs.getInt("RatedStar"));
                dto.setStatus(rs.getBoolean("Status"));
                dto.setCreateDate(rs.getDate("CreateDate"));
                dto.setUpdateDate(rs.getDate("UpdateDate"));
                dto.setImage(rs.getString("Image"));
                dto.setProductVariantName(rs.getString("ProductVariantName"));
                dto.setAccountName(rs.getString("FullName"));
                feedbacks.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbacks;
    }
 public double getAverageRating(int productVariantSizeID) {
        String sql = "SELECT AVG(RatedStar) as averageRating FROM Feedback WHERE ProductVariantSizeID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productVariantSizeID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("averageRating");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public int getTotalReviews(int productVariantSizeID) {
        String sql = "SELECT COUNT(*) as totalReviews FROM Feedback WHERE ProductVariantSizeID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productVariantSizeID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("totalReviews");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

   public int getCountByStar(int productVariantSizeID, int star) {
        String sql = "SELECT COUNT(*) as starCount FROM Feedback WHERE ProductVariantSizeID = ? AND RatedStar = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productVariantSizeID);
            ps.setInt(2, star);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("starCount");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Lấy rating trung bình cho toàn bộ sản phẩm (theo ProductID)
    public double getAverageRatingByProduct(int productId) {
        String sql = "SELECT AVG(RatedStar) as averageRating FROM Feedback f " +
                     "JOIN ProductVariantSize pvs ON f.ProductVariantSizeID = pvs.ID " +
                     "JOIN ProductVariant pv ON pvs.ProductVariantID = pv.ID " +
                     "WHERE pv.ProductID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("averageRating");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    // Lấy tổng số review cho toàn bộ sản phẩm (theo ProductID)
    public int getTotalReviewsByProduct(int productId) {
        String sql = "SELECT COUNT(*) as totalReviews FROM Feedback f " +
                     "JOIN ProductVariantSize pvs ON f.ProductVariantSizeID = pvs.ID " +
                     "JOIN ProductVariant pv ON pvs.ProductVariantID = pv.ID " +
                     "WHERE pv.ProductID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("totalReviews");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

}
