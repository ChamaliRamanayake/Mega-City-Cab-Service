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
import model.customer;
import model.driver;
import util.DBUtil;

/**
 *
 * @author 94775
 */
public class CustomerService {

    DBUtil dbman = DBUtil.getInstance();
    Connection connection = dbman.getConnection();
    
        public List<customer> getAllCustomers() {
        List<customer> customers = new ArrayList<>();
        String query = "SELECT * FROM customer";

        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                customer item = new customer();
                item.setCustomer_id(rs.getInt("customer_id"));
                item.setFname(rs.getString("fname"));
                item.setLname(rs.getString("lname"));
                item.setAddress(rs.getString("address"));
                item.setTelephone(rs.getInt("telephone"));
                item.setUsername(rs.getString("username"));
                item.setPassword(rs.getString("password"));
                item.setRole(rs.getString("role"));
                customers.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
        }
        
        public customer getCustomerByID(int id) {
        String query = "SELECT * FROM customer WHERE id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    customer item = new customer();
                    item.setCustomer_id(rs.getInt("customer_id"));
                    item.setFname(rs.getString("fname"));
                    item.setLname(rs.getString("lname"));
                    item.setAddress(rs.getString("address"));
                    item.setTelephone(rs.getInt("telephone"));
                    item.setUsername(rs.getString("username"));
                    item.setPassword(rs.getString("password"));
                    item.setRole(rs.getString("role"));
                    return item;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
        
        public String addCustomer(customer item) {
        String query = "INSERT INTO customer (fname, lname, address, telephone, username, password, role) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, item.getFname());
            ps.setString(2, item.getLname());
            ps.setString(3, item.getAddress());
            ps.setInt(4, item.getTelephone());
            ps.setString(5, item.getUsername());
            ps.setString(6, item.getPassword());
            ps.setString(7, item.getRole());

            int result = ps.executeUpdate();
            if (result > 0) {
                return "Customer Info Added Successfully";
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return "Error Adding Customer Info";
        }
        return "Error Adding Customer Info";
    }    
       
    public String updateCustomer(customer item) {
        String query = "UPDATE customer SET fname = ?, lname = ?, address = ?, telephone = ?, username = ?, password = ?, role = ? WHERE customer_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, item.getFname());
            stmt.setString(2, item.getLname());
            stmt.setString(3, item.getAddress());
            stmt.setInt(4, item.getTelephone());
            stmt.setString(5, item.getUsername());
            stmt.setString(6, item.getPassword());
            stmt.setString(7, item.getRole());

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
    
        public String deleteCustomer(int id) {
        String query = "DELETE FROM customer WHERE customer_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            int result = stmt.executeUpdate();
            if (result > 0) {
                return "Customer Info Deleted Successfully";
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return "SQL Error: Unable to delete customer";
        }
        return "Error Deleting Customer Info";
    }
        
}
