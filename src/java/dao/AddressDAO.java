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
import java.util.List;
import model.Address;

/**
 *
 * @author hoaht
 */
public class AddressDAO extends DBContext{
    public int addNewAddress(int accId, Address address) {
        String sql = "Insert into [Address]([Address], Fullname, Tel, AccountID, isDefault) values (?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, address.getAddress());
            ps.setString(2, address.getFullName());
            ps.setString(3, address.getTel());
            ps.setInt(4, accId);
            ps.setBoolean(5, address.isChoosen());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    public List<Address> listAllAddressByAccount(int accID) {
        List<Address> addresses = new ArrayList<>();
        String sql = "select * from [Address] where AccountID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                addresses.add(new Address(rs.getInt("ID"),  rs.getString("fullName"), rs.getString("Address"), rs.getString("Tel"), null, rs.getBoolean("isDefault")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return addresses;
    }
    
    public void turnOffOtherAddress(int acc_id, int addressID) {
        String sql = "update [Address] set isDefault = 0 where id != ? and AccountID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, addressID);
            ps.setInt(2, acc_id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public Address getAddressChoosenByAccID(int accID) {
        String sql = "select * from [Address] where AccountID = ? and isDefault = 1";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Address(rs.getInt("ID"),  rs.getString("fullName"), rs.getString("Address"), rs.getString("Tel"), null, rs.getBoolean("isDefault"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public void updateAddressDefault(int accID, int addressID) {
        String sql1 = "UPDATE Address set isDefault = 1 where id = ? and AccountID = ?";
        String sql2 = "UPDATE Address set isDefault = 0 where id != ? and AccountID = ?";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql1);
            ps.setInt(1, addressID);
            ps.setInt(2, accID);
            ps.executeUpdate();
            
            PreparedStatement ps2 = connection.prepareStatement(sql2);
            ps2.setInt(1, addressID);
            ps2.setInt(2, accID);
            ps2.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public Address getAddressByAddressID(int addressID) {
        String sql = "select * from [Address] where id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, addressID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                return new Address(rs.getInt("ID"),  rs.getString("fullName"), rs.getString("Address"), rs.getString("Tel"), null, rs.getBoolean("isDefault"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
