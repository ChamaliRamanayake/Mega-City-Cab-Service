<%-- 
    Document   : login
    Created on : Feb 13, 2025, 5:59:09 AM
    Author     : 94775
--%>


<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.security.MessageDigest" %> 
<%@ page session="true" %>

<%
    // Database connection parameters
    String dbURL = "jdbc:mysql://localhost:3306/vehicle_reservation_db";
    String dbUser = "root";
    String dbPass = "";

    String loginError = ""; // Initialize error message variable

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Hash the entered password using SHA-256
        String hashedPassword = "";
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes("UTF-8"));

            // Convert to hexadecimal format
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            hashedPassword = sb.toString();
        } catch (Exception e) {
            loginError = "Error hashing password: " + e.getMessage();
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish Connection
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            // Check if the user is a customer
            String sqlCustomer = "SELECT * FROM customer WHERE username = ? AND password = ?";
            stmt = conn.prepareStatement(sqlCustomer);
            stmt.setString(1, username);
            stmt.setString(2, hashedPassword);
            rs = stmt.executeQuery();

            if (rs.next()) {
                session.setAttribute("customerUser", username);
                response.sendRedirect("customer_dashboard.jsp");
            } else {
                // Check if the user is an admin
                String sqlAdmin = "SELECT * FROM admin WHERE username = ? AND password = ?";
                stmt = conn.prepareStatement(sqlAdmin);
                stmt.setString(1, username);
                stmt.setString(2, hashedPassword);
                rs = stmt.executeQuery();
                
                if (rs.next()) {
                    session.setAttribute("adminUser", username);
                    response.sendRedirect("admin_dashboard.jsp");
                } else {
                    loginError = "Invalid username or password!";
                }
            }
        } catch (Exception e) {
            loginError = "Database error: " + e.getMessage();
        } finally {
            // Close resources
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="css/customer_loginPage.css">
    <style>
        .error-message {
            color: red;
            text-align: center;
            margin-bottom: 10px;
            font-weight: bold;
        }
        
        .home-link {
        text-align: center;
        margin-top: 15px;
    }

    .home-link a {
        display: inline-block;
        color: #007bff;
        padding: 10px 20px;
        text-decoration: none;
        font-size: 16px;
        font-weight: bold;
        border-radius: 5px;
        transition: 0.3s;
    }

    </style>
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>

        <% if (!loginError.isEmpty()) { %>
            <div class="error-message">
                <%= loginError %>
            </div>
        <% } %>

        <form action="" method="post">
            <label for="username"><i class="fas fa-user"></i> Username</label>
            <input type="text" id="username" name="username" required>

            <label for="password"><i class="fas fa-lock"></i> Password</label>
            <input type="password" id="password" name="password" required>

            <button type="submit"><i class="fas fa-sign-in-alt"></i> Login</button>
        </form>

        <p>Don't have an account? <a href="customer_register.jsp">Register here</a></p>
        
        <p class="home-link">
            <a href="index.jsp"><i class="fas fa-home"></i>HOME PAGE</a>
        </p>
        
    </div>

</body>
</html>
