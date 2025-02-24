<%-- 
    Document   : customer_profile
    Created on : Feb 19, 2025, 4:35:48 AM
    Author     : 94775
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%
    String customerUser = (String) session.getAttribute("customerUser");
    if (customerUser == null) {
        response.sendRedirect("customer_login.jsp");
    }

    String username = "";
    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); // Load Driver
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle_reservation_db", "root", "");
        PreparedStatement ps = con.prepareStatement("SELECT * FROM customer WHERE username=?");
        ps.setString(1, customerUser);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            username = rs.getString("username");
        }
        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
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
        <form action="update_profile.jsp" method="post" class="shadow p-4 rounded bg-light">
            <div class="mb-3">
                <label class="form-label">Username</label>
                <input type="text" class="form-control" name="name" value="<%= username %>" required>
            </div>
<!--            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" class="form-control" name="email" value="" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Phone</label>
                <input type="text" class="form-control" name="phone" value="" required>
            </div>-->
            <button type="submit" class="btn btn-success w-100">Update Profile</button>
        </form>
        <a href="customer_dashboard.jsp" class="btn btn-secondary mt-3">Back to Dashboard</a>
    </div>
</body>
</html>

