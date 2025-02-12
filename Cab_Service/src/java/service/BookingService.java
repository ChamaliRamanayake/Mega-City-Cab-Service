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
import model.booking;
import model.vehicle;
import util.DBUtil;

/**
 *
 * @author 94775
 */
public class BookingService {
    
    DBUtil dbman = DBUtil.getInstance();
    Connection connection = dbman.getConnection();
    
        public List<booking> getAllBookings() {
        List<booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings";

        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                booking item = new booking();
                item.setBooking_id(rs.getInt("booking_id"));
                item.setCustomer_id(rs.getInt("customer_id"));
                item.setDriver_id(rs.getInt("driver_id"));
                item.setVehicle_id(rs.getInt("vehicle_id"));
                item.setDestination(rs.getString("destination"));
                item.setBookingDate(rs.getTimestamp("booking_date"));
                item.setAmount(rs.getBigDecimal("amount"));
                item.setStatus(rs.getString("status"));
                bookings.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
        }
        
        public booking getBookingByID(int id) {
        String query = "SELECT * FROM bookings WHERE booking_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    booking item = new booking();
                    item.setBooking_id(rs.getInt("booking_id"));
                    item.setCustomer_id(rs.getInt("customer_id"));
                    item.setDriver_id(rs.getInt("driver_id"));
                    item.setVehicle_id(rs.getInt("vehicle_id"));
                    item.setDestination(rs.getString("destination"));
                    item.setBookingDate(rs.getTimestamp("booking_date"));
                    item.setAmount(rs.getBigDecimal("amount"));
                    item.setStatus(rs.getString("status"));
                    return item;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
        
        public String addBooking(booking item) {
        String query = "INSERT INTO bookings (customer_id, driver_id, vehicle_id, destination, booking_date, amount, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, item.getCustomer_id());
            ps.setInt(2, item.getDriver_id());
            ps.setInt(3, item.getVehicle_id());
            ps.setString(4, item.getDestination());
            ps.setTimestamp(5, item.getBookingDate());
            ps.setBigDecimal(6, item.getAmount());
            ps.setString(7, item.getStatus());

            int result = ps.executeUpdate();
            if (result > 0) {
                return "Booking Info Added Successfully";
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return "Error Adding Booking Info";
        }
        return "Error Adding Booking Info";
    } 
        
        public String updateBooking(booking item) {
        String query = "UPDATE bookings SET customer_id = ?, driver_id = ?, vehicle_id = ?, destination = ?, booking_date = ?, amount = ?, status = ? WHERE booking_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, item.getCustomer_id());
            stmt.setInt(2, item.getDriver_id());
            stmt.setInt(3, item.getVehicle_id());
            stmt.setString(4, item.getDestination());
            stmt.setTimestamp(5, item.getBookingDate());
            stmt.setBigDecimal(6, item.getAmount());
            stmt.setString(7, item.getStatus());

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
        
        public String deleteBooking(int id) {
        String query = "DELETE FROM bookings WHERE booking_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            int result = stmt.executeUpdate();
            if (result > 0) {
                return "Booking Info Deleted Successfully";
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return "SQL Error: Unable to delete booking";
        }
        return "Error Deleting Booking Info";
    }
    
}
