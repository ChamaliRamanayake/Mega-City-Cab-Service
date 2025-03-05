<%-- 
    Document   : customer_profile
    Created on : Feb 19, 2025, 4:35:48 AM
    Author     : 94775
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>

<%
    // Check if the user is logged in
    String customerUser = (String) session.getAttribute("customerUser");
    if (customerUser == null) {
        response.sendRedirect("customer_login.jsp");
        return;
    }

    // Variables for storing customer details
    String fullName = "", email = "", contact = "", address = "", username = "";
    String message = "";

    // Database connection setup
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle_reservation_db", "root", "");

        // Fetch customer details
        ps = con.prepareStatement("SELECT * FROM customer WHERE username=?");
        ps.setString(1, customerUser);
        rs = ps.executeQuery();

        if (rs.next()) {
            String firstName = rs.getString("fname");
            String lastName = rs.getString("lname");
            fullName = firstName + " " + lastName;
            email = rs.getString("email");
            contact = rs.getString("telephone");
            address = rs.getString("address");
            username = rs.getString("username");
        }

        // Handle password update request
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String newPassword = request.getParameter("new_password");
            String confirmPassword = request.getParameter("confirm_password");

            // Check if new password and confirm password match
            if (!newPassword.equals(confirmPassword)) {
                message = "<div class='alert alert-danger'>New password and confirm password do not match!</div>";
            } else {
                // Hash the new password using SHA-1
                MessageDigest md = MessageDigest.getInstance("SHA-1");
                byte[] hashedBytes = md.digest(newPassword.getBytes());
                StringBuilder sb = new StringBuilder();
                for (byte b : hashedBytes) {
                    sb.append(String.format("%02x", b));
                }
                String hashedPassword = sb.toString();

                // Update password in database
                ps = con.prepareStatement("UPDATE customer SET password=? WHERE username=?");
                ps.setString(1, hashedPassword);
                ps.setString(2, customerUser);
                int updated = ps.executeUpdate();

                if (updated > 0) {
                    message = "<div class='alert alert-success'>Password updated successfully!</div>";
                } else {
                    message = "<div class='alert alert-danger'>Failed to update password. Try again!</div>";
                }
            }
        }
    } catch (NoSuchAlgorithmException e) {
        message = "<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>";
    } catch (Exception e) {
        message = "<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>";
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception ignored) {}
        try { if (ps != null) ps.close(); } catch (Exception ignored) {}
        try { if (con != null) con.close(); } catch (Exception ignored) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">My Profile</h2>
        
        <%= message %> <!-- Display success/error messages -->

        <div class="card shadow p-4 rounded bg-light">
            <h4 class="mb-3">Customer Details</h4>
            <table class="table">
                <tr>
                    <th>Full Name:</th>
                    <td><%= fullName %></td>
                </tr>
                <tr>
                    <th>Email:</th>
                    <td><%= email %></td>
                </tr>
                <tr>
                    <th>Contact:</th>
                    <td><%= contact %></td>
                </tr>
                <tr>
                    <th>Address:</th>
                    <td><%= address %></td>
                </tr>
                <tr>
                    <th>Username:</th>
                    <td><%= username %></td>
                </tr>
            </table>
        </div>

        <h4 class="mt-4">Update Password</h4>
        <form action="customer_profile.jsp" method="post" class="shadow p-4 rounded bg-light">
            <div class="mb-3">
                <label class="form-label">New Password</label>
                <input type="password" class="form-control" name="new_password" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Confirm New Password</label>
                <input type="password" class="form-control" name="confirm_password" required>
            </div>
            <button type="submit" class="btn btn-success w-100">Update Password</button>
        </form>

        <a href="customer_dashboard.jsp" class="btn btn-secondary mt-3">Back to Dashboard</a>
    </div>
</body>
</html>




