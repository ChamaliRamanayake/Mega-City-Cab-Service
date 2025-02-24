<%-- 
    Document   : manage_customer
    Created on : Feb 15, 2025, 1:35:39 PM
    Author     : 94775
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page session="true" %>
<%
    // Check if admin is logged in
    String adminUser = (String) session.getAttribute("adminUser");
    if (adminUser == null) {
        response.sendRedirect("login.jsp"); // Redirect to login page if session is empty
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Customers</title>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
            <link rel="stylesheet" type="text/css" href="css/style.css">
        <style>
            table {
                width: 80%;
                border-collapse: collapse;
                margin: 20px auto;
                font-family: Arial, sans-serif;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }
            th {
                background-color: #0A6847;
                color: white;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
        </style>
    </head>
    <body>
        <div class="dashboard">
        <jsp:include page="sidebar.jsp" />
        <main class="content">
            <header class="header">
                    <input type="text" placeholder="Search customers...">
                    <div class="profile">
                        <i class="fas fa-user-circle"></i>
                        <span class="username"><%= session.getAttribute("adminUser") %></span>
                    </div>
                </header>
            <section class="manage-customer">
                    <h2>Manage Customer</h2>
                    <table>
                        <table border="1">
                        <thead>
                        <tr>
                            <th>Customer ID</th>
                            <th>Customer Name</th>
                            <th>Address</th>
                            <th>Email</th>
                            <th>Telephone</th>
                            <th>Username</th>
                            <th>Action</th>
                        </tr>
                        <thead>
                        <tbody id="customer-table-body">
                           
                        </tbody>

                    </table>
                        
                        
        <script src="js/manage_customer.js"></script>
    </body>
</html>

