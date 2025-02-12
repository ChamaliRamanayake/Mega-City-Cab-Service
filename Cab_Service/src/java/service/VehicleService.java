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
import model.vehicle;
import util.DBUtil;

/**
 *
 * @author 94775
 */
public class VehicleService {
    
    DBUtil dbman = DBUtil.getInstance();
    Connection connection = dbman.getConnection();
    
        public List<vehicle> getAllVehicles() {
        List<vehicle> vehicles = new ArrayList<>();
        String query = "SELECT * FROM vehicles";

        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                vehicle item = new vehicle();
                item.setVehicle_id(rs.getInt("vehicle_id"));
                item.setVehicle_model(rs.getString("model"));
                item.setPlate_number(rs.getString("plate_number"));
                item.setAvailable(rs.getString("available"));
                item.setType_id(rs.getInt("type_id"));
                vehicles.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vehicles;
        }
        
        public vehicle getVehicleByID(int id) {
        String query = "SELECT * FROM vehicles WHERE vehicle_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    vehicle item = new vehicle();
                    item.setVehicle_id(rs.getInt("vehicle_id"));
                    item.setVehicle_model(rs.getString("model"));
                    item.setPlate_number(rs.getString("plate_number"));
                    item.setAvailable(rs.getString("available"));
                    item.setType_id(rs.getInt("type_id"));
                    return item;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
        
        public String addVehicle(vehicle item) {
        String query = "INSERT INTO vehicles (model, plate_number, available, type_id) VALUES (?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, item.getVehicle_model());
            ps.setString(2, item.getPlate_number());
            ps.setString(3, item.getAvailable());
            ps.setInt(4, item.getType_id());

            int result = ps.executeUpdate();
            if (result > 0) {
                return "Vehicle Info Added Successfully";
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return "Error Adding Vehicle Info";
        }
        return "Error Adding Vehicle Info";
    } 
        
        public String updateVehicle(vehicle item) {
        String query = "UPDATE vehicles SET model = ?, plate_number = ?, available = ?, type_id = ? WHERE vehicle_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, item.getVehicle_model());
            stmt.setString(2, item.getPlate_number());
            stmt.setString(3, item.getAvailable());
            stmt.setInt(4, item.getType_id());
            stmt.setInt(5, item.getVehicle_id());

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
        
        public String deleteVehicle(int id) {
        String query = "DELETE FROM vehicles WHERE vehicle_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            int result = stmt.executeUpdate();
            if (result > 0) {
                return "Vehicle Info Deleted Successfully";
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return "SQL Error: Unable to delete vehicle";
        }
        return "Error Deleting Vehicle Info";
    }
    
}
