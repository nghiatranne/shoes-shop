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
import model.Role;

/**
 *
 * @author hoaht
 */
public class RoleDAO extends DBContext {

    public List<Role> listAll() {
        List<Role> roles = new ArrayList<>();
        String sql = "select * from Role";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                roles.add(new Role(rs.getInt(1), rs.getString(2), rs.getDate(3), rs.getDate(4)));
            }
            return roles;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roles;
    }

    public void insertRoleCustomer(int accountId) {
        String sql = "insert into RoleAccount(AccountID, RoleID) values (?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accountId);
            ps.setInt(2, 2);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Set<Role> listRoleByAccountId(int accId) {
        Set<Role> roles = new HashSet<>();
        String sql = "select r.* "
                +    "from RoleAccount ra left join [Role] r on ra.roleId = r.ID "
                +    "left join Account a on a.ID = ra.AccountID "
                +    "where a.ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                roles.add(new Role(rs.getInt(1), rs.getString(2), rs.getDate(3), rs.getDate(4)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roles;
    }

    public void assignRoleToAccount(int acc_id, int role_id) {
        String sql = "insert into RoleAccount(AccountID, RoleID) values (?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, acc_id);
            ps.setInt(2, role_id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void removeRoleFromAccount(int acc_id, int role_id) {
        String sql = "delete from RoleAccount where RoleID = ? and AccountID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, role_id);
            ps.setInt(2, acc_id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Map<Role, Integer> getListRoleAndTotalAccount() {
        Map<Role, Integer> rolesMap = new HashMap<>();
        String sql = "select r.*, count(a.ID) "
                + "from [Role] r left join RoleAccount ra on r.ID = ra.RoleID "
                + "left join Account a on ra.AccountID = a.ID "
                + "group by r.ID, r.RoleName, r.CreateDate, r.UpdateDate";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Role r = new Role(rs.getInt(1), rs.getString(2), rs.getDate(3), rs.getDate(4));
                rolesMap.put(r, rs.getInt(5));
            }
            
            return rolesMap;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public void insertNewRole(Role r) {
        String sql = "INSERT INTO Role (RoleName) VALUES (?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, r.getRole_name());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void deleteRole(int role_id) {
        String sql = "delete from [Role] where ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, role_id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public Role getRole(int role_id) {
        String sql = "select * from Role where id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, role_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Role(rs.getInt(1), rs.getString(2), rs.getDate(3), rs.getDate(4));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public void updateRole(int role_id, Role r) {
        String sql = "UPDATE Role SET RoleName = ?, UpdateDate = GETDATE() WHERE ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, r.getRole_name());
            ps.setInt(2, role_id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Set<Role> getListRoleByAccountId(int acc_id) {
        Set<Role> roles = new HashSet<>();
        String sql = "select r.* from Role r left join RoleAccount ra on r.ID = ra.RoleID left join Account a on ra.AccountID = a.ID where a.ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, acc_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int role_id = rs.getInt(1);
                String role_name = rs.getString(2);
                Date role_createDate = rs.getDate(3);
                Date role_updateDate = rs.getDate(4);
                
                Role role = new Role(role_id, role_name, role_createDate, role_updateDate);
                
                roles.add(role);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roles;
    }
}
