/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.driver;
import util.DBUtil;

/**
 *
 * @author 94775
 */
public class DriverService {
    
    DBUtil dbman = DBUtil.getInstance();
    Connection connection = dbman.getConnection();
    
        public List<driver> getAllDrivers() {
        List<driver> drivers = new ArrayList<>();
        String query = "SELECT * FROM drivers";

        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                driver item = new driver();
                item.setDriverID(rs.getInt("id"));
                item.setDriver_name(rs.getString("driver_name"));
                item.setLicense_number(rs.getString("license_number"));
                item.setContact_number(rs.getInt("contact_number"));
                item.setAvailability(rs.getString("availability"));
                drivers.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return drivers;
        }
        
        public driver getDriverByID(int id) {
        String query = "SELECT * FROM drivers WHERE id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    driver item = new driver();
                    item.setDriverID(rs.getInt("id"));
                    item.setDriver_name(rs.getString("driver_name"));
                    item.setLicense_number(rs.getString("license_number"));
                    item.setContact_number(rs.getInt("contact_number"));
                    item.setAvailability(rs.getString("availability"));
                    return item;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
        
        public String addDriver(driver item) {
        String query = "INSERT INTO drivers (driver_name, license_number, contact_number, availability) VALUES (?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, item.getDriver_name());
            ps.setString(2, item.getLicense_number());
            ps.setInt(3, item.getContact_number());
            ps.setString(4, item.getAvailability());

            int result = ps.executeUpdate();
            if (result > 0) {
                return "Driver Info Added Successfully";
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return "Error Adding Driver Info";
        }
        return "Error Adding Driver Info";
    }    
        
        public String updateDriver(driver item) {
        String query = "UPDATE drivers SET driver_name = ?, license_number = ?, contact_number = ?, availability = ? WHERE id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, item.getDriver_name());
            stmt.setString(2, item.getLicense_number());
            stmt.setInt(3, item.getContact_number());
            stmt.setString(4, item.getAvailability());
            stmt.setInt(5, item.getDriverID());

            int result = stmt.executeUpdate();
            if (result > 0) {
                return "Updated Successfully";
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return "SQL Error: Unable to update";
        }
        return "Update Failure";
    }
    
        public String deleteDriver(int id) {
        String query = "DELETE FROM drivers WHERE id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            int result = stmt.executeUpdate();
            if (result > 0) {
                return "Driver Info Deleted Successfully";
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return "SQL Error: Unable to delete driver";
        }
        return "Error Deleting Driver Info";
    }
        
}
