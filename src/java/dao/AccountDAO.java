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
import java.util.Date;
import java.util.List;
import java.util.Set;
import model.Account;
import model.Role;
import model.SaleRAW;
//import model.SaleRAW;

/**
 *
 * @author hoaht
 */
public class AccountDAO extends DBContext {

    public List<SaleRAW> getListAccountRoleSale() {
        List<SaleRAW> sales = new ArrayList<>();
        String sql = "select a.ID, a.FullName, COUNT(CASE WHEN o.Status = 0 THEN mo.OrderID ELSE NULL END) [total] "
                + "from Account a left join RoleAccount ra on a.ID = ra.AccountID "
                + "left join [Role] r on r.ID = ra.RoleID "
                + "left join ManageOrder mo on a.ID = mo.AccountID "
                + "left join [Order] o on mo.OrderID = o.ID "
                + "where r.RoleName = 'SALE' "
                + "group by a.ID, a.FullName";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int acc_id = rs.getInt("id");
                String acc_fullname = rs.getString("fullname");
                int totalOrder = rs.getInt("total");

                Account account = new Account(acc_id, null, acc_fullname, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

                SaleRAW saleRAW = new SaleRAW(account, totalOrder);

                sales.add(saleRAW);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sales;
    }
    
    public List<String> listAllEmail() {
        List<String> emails = new ArrayList<>();
        String sql = "select email from Account";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                emails.add(rs.getString(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return emails;
    }

    public List<Account> listAllEmailPass() {
        RoleDAO roleDAO = new RoleDAO();
        List<Account> accounts = new ArrayList<>();
        String sql = "select ID, Email, Password, Status from Account";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Set<Role> roles = roleDAO.listRoleByAccountId(rs.getInt(1));
                accounts.add(new Account(rs.getInt(1), null, null, rs.getString(2), rs.getString(3), null, null, null, null, rs.getBoolean(4), null, null, null, roles, null, null, null, null, null));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return accounts;
    }

    public int addAccount(Account account, String token) {
        SimpleDateFormat sf = new SimpleDateFormat("MM/dd/yyyy");
        RoleDAO roleDAO = new RoleDAO();

        String sql = "INSERT INTO Account (FullName, Password, Email, Gender, Address, Birthdate, Tel, Token, Status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 0)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, account.getFullname());
            ps.setString(2, account.getPassword());
            ps.setString(3, account.getEmail());
            if (account.getGender() == null) {
                ps.setString(4, null);
            } else {
                ps.setBoolean(4, account.getGender().equalsIgnoreCase("true"));
            }
            ps.setString(5, account.getAddress());
            if (account.getBirthdate() == null) {
                ps.setString(6, null);
            } else {
                ps.setString(6, sf.format(account.getBirthdate()));
            }
            ps.setString(7, account.getTelephone());

            ps.setString(8, token);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int accId = rs.getInt(1);
                roleDAO.insertRoleCustomer(accId);
                return accId;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public List<Account> listAll() {
        List<Account> accounts = new ArrayList<>();
        RoleDAO roleDAO = new RoleDAO();
        String sql = "select * from Account";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Set<Role> roles = roleDAO.listRoleByAccountId(rs.getInt(1));
                Account a = new Account(rs.getInt("id"), rs.getString("image"), rs.getString("fullname"), rs.getString("email"), rs.getString("password"), rs.getBoolean("gender") ? "Male" : "Female", rs.getString("address"), rs.getDate("birthdate"), rs.getString("tel"), rs.getBoolean("status"), rs.getDate("createDate"), rs.getDate("updateDate"), null, roles, null, null, null, null, null);
                accounts.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return accounts;
    }

    public List<Account> listAllSorted(String sortBy) {
        List<Account> accounts = new ArrayList<>();
        RoleDAO roleDAO = new RoleDAO();
        String sql = "SELECT * FROM Account";

        // Thêm điều kiện sắp xếp vào câu lệnh SQL dựa trên tham số sortBy
        switch (sortBy) {
            case "0": // Male
                sql += " WHERE Gender = '1'"; // Giả định 1 là Male, 0 là Female
                break;
            case "1": // Female
                sql += " WHERE Gender = '0'"; // Giả định 0 là Female, 1 là Male
                break;
            case "2": // Role admin
                sql = "SELECT * FROM Account a JOIN RoleAccount r ON a.ID = r.AccountID WHERE r.RoleID = 1";
                break;
            case "3": // Role customer
                sql = "SELECT * FROM Account a JOIN RoleAccount r ON a.ID = r.AccountID WHERE r.RoleID = 2";
                break;
            case "4": // Role maketer
                sql = "SELECT * FROM Account a JOIN RoleAccount r ON a.ID = r.AccountID WHERE r.RoleID = 4";
                break;
            case "5": // Role sale
                sql = "SELECT * FROM Account a JOIN RoleAccount r ON a.ID = r.AccountID WHERE r.RoleID = 3";
                break;
            case "6": // Not available
                sql += " WHERE Status = 0";
                break;
            case "7": // Available
                sql += " WHERE Status = 1";
                break;
            case "8": // All
                // Không thay đổi SQL, lấy tất cả
                break;
            case "9": // Sort by full name
                sql += " ORDER BY FullName";
                break;
            case "10": // Sort by email
                sql += " ORDER BY Email";
                break;
            case "11": // Sort by telephone
                sql += " ORDER BY Tel";
                break;
            default:
                break;
        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Set<Role> roles = roleDAO.listRoleByAccountId(rs.getInt("id"));
                Account a = new Account(rs.getInt("id"), rs.getString("image"), rs.getString("fullname"), rs.getString("email"), rs.getString("password"), rs.getBoolean("gender") ? "Male" : "Female", rs.getString("address"), rs.getDate("birthdate"), rs.getString("tel"), rs.getBoolean("status"), rs.getDate("createDate"), rs.getDate("updateDate"), null, roles, null, null, null, null, null);
                accounts.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return accounts;
    }

    public boolean checkOldPassword(String email, String oldPassword) {
        String sql = "SELECT * FROM Account WHERE Email = ? AND Password = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, oldPassword);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePassword(String email, String newPassword) {
        String sql = "UPDATE Account SET Password = ? WHERE Email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setString(2, email);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean changeStatusToAccount(int acc_id, int status) {
        String sql = "UPDATE Account SET Status = ? WHERE ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, status);
            ps.setInt(2, acc_id);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Account getAccount(int id) {
        RoleDAO roleDAO = new RoleDAO();
        String sql = "select * from Account where ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int acc_id = rs.getInt("id");
                String acc_image = rs.getString("image");
                String acc_fullname = rs.getString("fullname");
                String acc_email = rs.getString("email");
                String acc_gender_string = rs.getString("gender");
                String acc_address = rs.getString("address");
                Date acc_birthdate = rs.getDate("birthdate");
                String acc_telephone = rs.getString("tel");
                Date acc_createDate = rs.getDate("createDate");
                Date acc_updateDate = rs.getDate("updateDate");
                String acc_token = rs.getString("token");
                Boolean acc_status = rs.getBoolean("status");

                Set<Role> roles = roleDAO.getListRoleByAccountId(acc_id);

                Account account = new Account(acc_id, acc_image, acc_fullname, acc_email, null, acc_gender_string, acc_address, acc_birthdate, acc_telephone, acc_status, acc_createDate, acc_updateDate, acc_token, roles, null, null, null, null, null);

                return account;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Account getAccountByEmail(String uEmail) {
        RoleDAO roleDAO = new RoleDAO();
        String sql = "select * from Account where Email = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, uEmail);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int acc_id = rs.getInt("id");
                String acc_image = rs.getString("image");
                String acc_fullname = rs.getString("fullname");
                String acc_email = rs.getString("email");
                String acc_gender_string = rs.getString("gender");
                String acc_address = rs.getString("address");
                Date acc_birthdate = rs.getDate("birthdate");
                String acc_telephone = rs.getString("tel");
                Date acc_createDate = rs.getDate("createDate");
                Date acc_updateDate = rs.getDate("updateDate");
                String acc_token = rs.getString("token");
                Boolean acc_status = rs.getBoolean("status");

                Set<Role> roles = roleDAO.getListRoleByAccountId(acc_id);

                Account account = new Account(acc_id, acc_image, acc_fullname, acc_email, null, acc_gender_string, acc_address, acc_birthdate, acc_telephone, acc_status, acc_createDate, acc_updateDate, acc_token, roles, null, null, null, null, null);

                return account;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateStatus(boolean status, int accId) {
        String sql = "update Account set Status = ? where ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setBoolean(1, status);
            ps.setInt(2, accId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean verifyAccount(int accId, String token) {
        String sql = "select id from Account where ID = ? and token = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accId);
            ps.setString(2, token);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                if (rs.getString(1) != null) {
                    updateStatus(true, accId);
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void storeResetToken(String email, String token) {
        String sql = "INSERT INTO password_reset_tokens (email, token) VALUES (?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, token);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean isValidToken(String token) {
        String sql = "SELECT * FROM password_reset_tokens WHERE token = ? AND expiration >= GETDATE()";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void resetPass(String email, String newPass, String token) {
        String sql = "update Account set Password = ? where Email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, newPass);
            ps.setString(2, email);
            ps.executeUpdate();

            sql = "delete from password_reset_tokens where token = ?";
            PreparedStatement ps2 = connection.prepareStatement(sql);
            ps2.setString(1, token);
            ps2.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateAccount(Account account, int acc_id_update) {
        SimpleDateFormat sf = new SimpleDateFormat("MM/dd/yyyy");
        String sql = "UPDATE Account SET FullName = ?, Email = ?, Gender = ?, Address = ?, Birthdate = ?, Tel = ?, UpdateDate = GETDATE(), Image = ? WHERE ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, account.getFullname());
            ps.setString(2, account.getEmail());

            // Handle gender
            if (account.getGender() == null) {
                ps.setString(3, null);
            } else {
                ps.setBoolean(3, account.getGender().equalsIgnoreCase("1"));
            }

            ps.setString(4, account.getAddress());

            // Handle birthdate
            if (account.getBirthdate() == null) {
                ps.setString(5, null);
            } else {
                ps.setString(5, sf.format(account.getBirthdate()));
            }

            ps.setString(6, account.getTelephone());
            ps.setString(7, account.getImage());
            ps.setInt(8, acc_id_update);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void updateAccountCustomer(Account account, int accID) {
        SimpleDateFormat sf = new SimpleDateFormat("MM/dd/yyyy");
        String sql = "UPDATE Account SET FullName = ?, Email = ?, Gender = ?, Tel = ?, UpdateDate = GETDATE() WHERE ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, account.getFullname());
            ps.setString(2, account.getEmail());

            // Handle gender
            if (account.getGender() == null) {
                ps.setString(3, null);
            } else {
                ps.setBoolean(3, account.getGender().equalsIgnoreCase("Male"));
            }

            ps.setString(4, account.getTelephone());

            ps.setInt(5, accID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Account> searchCustomerByFullname(String keyword) {
        List<Account> accounts = new ArrayList<>();
        RoleDAO roleDAO = new RoleDAO();
        String sql = "SELECT * FROM Account WHERE FullName LIKE ? ";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword.trim() + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Set<Role> roles = roleDAO.listRoleByAccountId(rs.getInt("id"));
                    Account a = new Account(
                            rs.getInt("id"), rs.getString("image"), rs.getString("fullname"), rs.getString("email"),
                            rs.getString("password"), rs.getBoolean("gender") ? "Male" : "Female",
                            rs.getString("address"), rs.getDate("birthdate"), rs.getString("tel"),
                            rs.getBoolean("status"), rs.getDate("createDate"), rs.getDate("updateDate"),
                            null, roles, null, null, null, null, null
                    );
                    accounts.add(a);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return accounts;
    }

    public List<Account> getListAccountByRole(String roleName) {
        List<Account> accounts = new ArrayList<>();
        RoleDAO roleDAO = new RoleDAO();
        String sql = "select * "
                + "from Account a left join RoleAccount ra on a.ID = ra.AccountID "
                + "left join [Role] r on r.ID = ra.RoleID "
                + "where r.RoleName = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, roleName);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int acc_id = rs.getInt("id");
                String acc_image = rs.getString("image");
                String acc_fullname = rs.getString("fullname");
                String acc_email = rs.getString("email");
                String acc_gender_string = rs.getString("gender");
                String acc_address = rs.getString("address");
                Date acc_birthdate = rs.getDate("birthdate");
                String acc_telephone = rs.getString("tel");
                Date acc_createDate = rs.getDate("createDate");
                Date acc_updateDate = rs.getDate("updateDate");
                String acc_token = rs.getString("token");
                Boolean acc_status = rs.getBoolean("status");

                Set<Role> roles = roleDAO.getListRoleByAccountId(acc_id);

                Account account = new Account(acc_id, acc_image, acc_fullname, acc_email, null, acc_gender_string, acc_address, acc_birthdate, acc_telephone, acc_status, acc_createDate, acc_updateDate, acc_token, roles, null, null, null, null, null);

                accounts.add(account);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return accounts;
    }

//    public List<SaleRAW> getListAccountRoleSale() {
//        List<SaleRAW> sales = new ArrayList<>();
//        String sql = "select a.ID, a.FullName, COUNT(CASE WHEN o.Status = 0 THEN mo.OrderID ELSE NULL END) [total] "
//                + "from Account a left join RoleAccount ra on a.ID = ra.AccountID "
//                + "left join [Role] r on r.ID = ra.RoleID "
//                + "left join ManageOrder mo on a.ID = mo.AccountID "
//                + "left join [Order] o on mo.OrderID = o.ID "
//                + "where r.RoleName = 'SALE' "
//                + "group by a.ID, a.FullName";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                int acc_id = rs.getInt("id");
//                String acc_fullname = rs.getString("fullname");
//                int totalOrder = rs.getInt("total");
//
//                Account account = new Account(acc_id, null, acc_fullname, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
//
//                SaleRAW saleRAW = new SaleRAW(account, totalOrder);
//
//                sales.add(saleRAW);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return sales;
//    }

    public List<String> getUserRoles(String acc_email) {
        String sql = "select r.RoleName from Account a left join RoleAccount ar on a.ID = ar.AccountID\n"
                + "left join [Role] r on r.ID = ar.RoleID\n"
                + "where a.Email = ?";
        List<String> roles = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, acc_email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                roles.add(rs.getString("RoleName"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roles;
    }

    public int getTotalCustomerToday() {
        String sql = "select COUNT(*) from Account a left join RoleAccount ra on a.ID = ra.AccountID "
                + "where ra.RoleID = 2 and CreateDate = CAST(GETDATE() AS DATE)";
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

    public int getTotalCustomer() {
        String sql = "select COUNT(*) from Account a left join RoleAccount ra on a.ID = ra.AccountID "
                + "where ra.RoleID = 2";
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

    public List<Account> listAllCustomer() {
        List<Account> accounts = new ArrayList<>();
        String sql = "select *, r.RoleName "
                + "from Account a left join RoleAccount ra on a.ID = ra.AccountID "
                + "left join [Role] r on ra.RoleID = r.ID "
                + "where ra.RoleID not in (select ID from [Role] where ID != 2)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String image = rs.getString("image");
                String fullName = rs.getString("fullname");
                String email = rs.getString("email");
                String gender = null;
                if (rs.getString("gender") != null) {
                    gender = rs.getBoolean("gender") ? "Male" : "Female";
                }
                Date birthdate = rs.getDate("birthdate");
                String tel = rs.getString("tel");
                Boolean status = rs.getBoolean("status");
                
                Account account = new Account(id, image, fullName, email, null, gender, null, birthdate, tel, status, null, null, null, null, null, null, null, null, null);
                accounts.add(account);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return accounts;
    }
    
    public List<Account> listAllCustomer(String key) {
        List<Account> accounts = new ArrayList<>();
        String sql = "select *, r.RoleName "
                + "from Account a left join RoleAccount ra on a.ID = ra.AccountID "
                + "left join [Role] r on ra.RoleID = r.ID "
                + "where ra.RoleID not in (select ID from [Role] where ID != 2) and a.FullName like '%" + key + "%'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String image = rs.getString("image");
                String fullName = rs.getString("fullname");
                String email = rs.getString("email");
                String gender = null;
                if (rs.getString("gender") != null) {
                    gender = rs.getBoolean("gender") ? "Male" : "Female";
                }
                Date birthdate = rs.getDate("birthdate");
                String tel = rs.getString("tel");
                Boolean status = rs.getBoolean("status");
                
                Account account = new Account(id, image, fullName, email, null, gender, null, birthdate, tel, status, null, null, null, null, null, null, null, null, null);
                accounts.add(account);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return accounts;
    }
}
