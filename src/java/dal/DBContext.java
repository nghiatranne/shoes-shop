/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author hoaht
 */
public class DBContext {
    protected Connection connection;
    
    public DBContext() {
        try {
            String url = "jdbc:sqlserver://" + serverName + ":" + portNumber + ";databaseName=" + dbName;
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, userId, psw);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
    
    private final String serverName = "localhost";
    private final String dbName = "ShoeShopDB";
    private final String portNumber = "1433";
    private final String userId = "sa";
    private final String psw = "123";
    
    public Connection getConnection() {
        return connection;
    }
    // Sua tren main
}
