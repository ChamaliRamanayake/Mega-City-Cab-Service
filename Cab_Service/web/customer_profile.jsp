<%-- 
    Document   : customer_profile
    Created on : Feb 19, 2025, 4:35:48 AM
    Author     : 94775
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>

<%
    // Check if the user is logged in
    String customerUser = (String) session.getAttribute("customerUser");
    if (customerUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Variables for storing customer details
    String fullName = "", email = "", contact = "", address = "", username = "";

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
            fullName = rs.getString("fname") + " " + rs.getString("lname");
            email = rs.getString("email");
            contact = rs.getString("telephone");
            address = rs.getString("address");
            username = rs.getString("username");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception ignored) {}
        try { if (ps != null) ps.close(); } catch (Exception ignored) {}
        try { if (con != null) con.close(); } catch (Exception ignored) {}
    }
%>

<%
    // Handle AJAX request for updating customer details
    if (request.getParameter("updateField") != null && request.getParameter("newValue") != null) {
        String field = request.getParameter("updateField");
        String newValue = request.getParameter("newValue");

        if (field.equals("telephone") || field.equals("address")) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle_reservation_db", "root", "");

                ps = con.prepareStatement("UPDATE customer SET " + field + "=? WHERE username=?");
                ps.setString(1, newValue);
                ps.setString(2, customerUser);
                int updated = ps.executeUpdate();

                if (updated > 0) {
                    out.print("success");
                } else {
                    out.print("error");
                }
            } catch (Exception e) {
                out.print("error");
            } finally {
                try { if (ps != null) ps.close(); } catch (Exception ignored) {}
                try { if (con != null) con.close(); } catch (Exception ignored) {}
            }
        }
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        function updateField(field) {
            var inputField = document.getElementById(field + "Input");
            var newValue = inputField.value.trim();

            if (newValue === "") {
                alert("Please enter a new value.");
                return;
            }

            $.ajax({
                type: "POST",
                url: "customer_profile.jsp",
                data: { updateField: field, newValue: newValue },
                success: function(response) {
                    if (response.trim() === "success") {
                        document.getElementById(field).innerText = newValue; // Update displayed text
                        alert(field.charAt(0).toUpperCase() + field.slice(1) + " updated successfully!");
                        inputField.value = ""; // Clear input field after successful update
                    } else {
                        alert("Failed to update " + field);
                    }
                }
            });
        }
    </script>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">My Profile</h2>

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
                    <td>
                        <span id="telephone"><%= contact %></span>
                        <input type="text" id="telephoneInput" class="form-control d-inline-block w-50 mt-2" placeholder="Enter new contact">
                        <button class="btn btn-primary btn-sm mt-2" onclick="updateField('telephone')">Update</button>
                    </td>
                </tr>
                <tr>
                    <th>Address:</th>
                    <td>
                        <span id="address"><%= address %></span>
                        <input type="text" id="addressInput" class="form-control d-inline-block w-50 mt-2" placeholder="Enter new address">
                        <button class="btn btn-primary btn-sm mt-2" onclick="updateField('address')">Update</button>
                    </td>
                </tr>
                <tr>
                    <th>Username:</th>
                    <td><%= username %></td>
                </tr>
                <tr>
                    <th>Password:</th>
                    <td>
                        <button class="btn btn-danger btn-sm" onclick="window.location.href='reset_password.jsp'">Reset Password</button>
                    </td>
                </tr>
            </table>
                
        </div>

        <a href="customer_dashboard.jsp" class="btn btn-secondary mt-3">Back to Dashboard</a>
    </div>
</body>
</html>








