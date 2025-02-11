/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author 94775
 */
public class DBUtil {
    
    private static DBUtil instance;
    private static Connection connection;
    
    private static final String URL = "jdbc:mysql://localhost:3306/vehicle_reservation_db";    
    private static final String USERNAME = "root";    
    private static final String PASSWORD = ""; 
    
    private DBUtil(){
            try{
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(URL,USERNAME,PASSWORD);
            }
            catch(Exception e){
            }
        }
    
        public static DBUtil getInstance(){
    
        if(instance == null){
            synchronized (DBUtil.class) {
                if(instance == null){
                    instance = new DBUtil();
                }
            }
            }
    return instance;
    }
    
    
    public Connection getConnection(){
        return connection;
    }
    
    public void closeConnection(){
    
        try {
            if(connection != null){
           connection.close();
           
       }
        } catch (SQLException e) {
        }
 
    }
}
