<%-- 
    Document   : customer_register
    Created on : Feb 14, 2025, 11:39:28 AM
    Author     : 94775
--%>

<%-- 
    Document   : customer_register
    Created on : Feb 14, 2025, 11:39:28 AM
    Author     : 94775
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Registration</title>
    <link rel="stylesheet" type="text/css" href="css/customer_registerPage.css">
</head>
<body>
    <div class="register-container">
        <h2>Register</h2>
        
        <%-- Display error or success message --%>
        <% if (request.getParameter("error") != null) { %>
            <p style="color:red;">Registration failed. Please try again.</p>
        <% } %>

        <form action="register_customer.jsp" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label>First Name</label>
                    <input type="text" name="fname" required>
                </div>
                <div class="form-group">
                    <label>Last Name</label>
                    <input type="text" name="lname" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Address</label>
                    <input type="text" name="address" required>
                </div>
                <div class="form-group">
                    <label>Mobile</label>
                    <input type="text" name="telephone" required>
                </div>
            </div>
            
            <div class="form-row full-width">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" required>
                </div>
                <div class="form-group">
                    <label>Confirm Password</label>
                    <input type="password" name="confirm_password" required>
                </div>
            </div>

            <button type="submit">Register</button>
        </form>

        <p>Already have an account? <a href="customer_login.jsp">Login here</a></p>
    </div>
</body>
</html>



