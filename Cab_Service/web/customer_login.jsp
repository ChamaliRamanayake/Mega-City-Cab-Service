<%-- 
    Document   : customer_login
    Created on : Feb 14, 2025, 11:18:43 AM
    Author     : 94775
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="css/customer_loginPage.css">
    <script>
        function validateForm() {
            let username = document.getElementById("username").value;
            let password = document.getElementById("password").value;
            if (username.trim() === "" || password.trim() === "") {
                alert("Both fields are required!");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="login-container">
        <h2>Customer Login</h2>
        
        <%-- Check for login error --%>
        <% if (request.getParameter("error") != null) { %>
            <p style="color:red;">Invalid Username or Password!</p>
        <% } %>

        <form action="customer_login.jsp" method="post" onsubmit="return validateForm()">
            <label for="username"><i class="fas fa-user"></i> Username</label>
            <input type="text" id="username" name="username" required>

            <label for="password"><i class="fas fa-lock"></i> Password</label>
            <input type="password" id="password" name="password" required>

            <button type="submit"><i class="fas fa-sign-in-alt"></i> Login</button>
        </form>

        <p>Don't have an account? <a href="customer_register.jsp">Register here</a></p>
    </div>

    <%-- Handle login logic in JSP itself --%>
    <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username != null && password != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle_reservation_db", "root", "");

                String sql = "SELECT * FROM customer WHERE phone = ? AND password = ?";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, username);
                pst.setString(2, password);
                ResultSet rs = pst.executeQuery();

                if (rs.next()) {
                    session.setAttribute("customer_id", rs.getInt("customer_id"));
                    session.setAttribute("customer_name", rs.getString("name"));
                    response.sendRedirect("customer_dashboard.jsp");
                } else {
                    response.sendRedirect("customer_login.jsp?error=1");
                }

                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>


