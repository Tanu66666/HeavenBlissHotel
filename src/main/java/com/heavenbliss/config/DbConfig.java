package com.heavenbliss.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Database Configuration Class
 * Handles MySQL database connection for Heaven Bliss Hotel
 * 
 * @author Tanisha Maharjan
 */
public class DbConfig {
    
    // Database credentials
    private static final String URL = "jdbc:mysql://localhost:3306/heavenbliss";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "";
    
    // MySQL Driver
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    
    /**
     * Establishes and returns connection to MySQL database
     * @return Connection object
     * @throws SQLException if connection fails
     * @throws ClassNotFoundException if driver not found
     */
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        // Load MySQL JDBC Driver
        Class.forName(DRIVER);
        
        // Create and return connection
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
    
    /**
     * Closes connection safely
     * @param conn Connection to close
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}