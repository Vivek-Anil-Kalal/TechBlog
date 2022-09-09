package com.tech.blog.helper;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ConnectionProvider {

    private static Connection con = null ;

    public static Connection getDbConnection() {

        try {
            if ( con == null ) {
                // Load Driver
                Class.forName("com.mysql.jdbc.Driver");

                // Create Connection ...
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/techblog", "root", "admin");
                
                System.out.println("Connection Established");
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ConnectionProvider.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ConnectionProvider.class.getName()).log(Level.SEVERE, null, ex);
        }
        return con;
    }
}
