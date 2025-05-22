package com.ZzzInn.Database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnector {
    private final static String databaseName ="zzzinn";
    private final static String username ="root";
    private final static String password = "";
    private final static String jdbcurl = "jdbc:mysql://localhost:3306/" + databaseName;

    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Connection conn = null;
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcurl, username, password);
        return conn;
    }

    public static void main(String[]arg) {
        try {
            Connection conn = DatabaseConnector.getConnection();
            if (conn != null ) {
                System.out.println("Connected!!");
            }
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }
}