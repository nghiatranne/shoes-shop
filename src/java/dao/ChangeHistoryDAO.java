/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import model.Account;
import model.ChangeHistory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class ChangeHistoryDAO extends DBContext {
    public void insert(ChangeHistory changeHistory) {
        String sql = "INSERT INTO ChangeHistory (ChangeDate, ChangedBy, Email, FullName, Gender, Mobile) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = connection; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, new java.sql.Date(changeHistory.getChangeDate().getTime()));
            ps.setInt(2, changeHistory.getChangedBy().getId());
            ps.setString(3, changeHistory.getEmail());
            ps.setString(4, changeHistory.getFullName());
            if (changeHistory.getGender() == null) {
                ps.setString(5, null);
            } else {
                ps.setBoolean(5, changeHistory.getGender());
            }
            ps.setString(6, changeHistory.getMobile());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<ChangeHistory> getChangeHistoriesByAccountId(int accountId, int changedBy) {
        List<ChangeHistory> changeHistories = new ArrayList<>();
        String sql = "SELECT c.*, a.ID as ChangedByID, a.FullName as ChangedByFullName, a.Email as ChangedByEmail, a.Tel as ChangedByTel "
                + "FROM ChangeHistory c "
                + "LEFT JOIN Account a ON c.ChangedBy = a.ID "
                + "WHERE c.Email = (SELECT Email FROM Account WHERE ID = ?) "
                + "AND c.ChangedBy = ?";
        try (Connection conn = connection; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            ps.setInt(2, changedBy);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ChangeHistory changeHistory = new ChangeHistory();
                    changeHistory.setId(rs.getInt("ID"));
                    changeHistory.setChangeDate(rs.getDate("ChangeDate"));

                    Account changedByAccount = new Account();
                    changedByAccount.setId(rs.getInt("ChangedByID"));
                    changedByAccount.setFullname(rs.getString("ChangedByFullName"));
                    changedByAccount.setEmail(rs.getString("ChangedByEmail"));
                    changedByAccount.setTelephone(rs.getString("ChangedByTel"));

                    changeHistory.setChangedBy(changedByAccount);
                    changeHistory.setEmail(rs.getString("Email"));
                    changeHistory.setFullName(rs.getString("FullName"));
                    if (rs.getString("gender") != null) {
                        changeHistory.setGender(rs.getBoolean("Gender"));
                    } else {
                        changeHistory.setGender(null);
                    }
                    changeHistory.setMobile(rs.getString("Mobile"));

                    changeHistories.add(changeHistory);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return changeHistories;
    }
}
