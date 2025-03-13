<%-- 
    Document   : report
    Created on : Mar 9, 2025, 9:58:11 PM
    Author     : 94775
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<%
    // Check if admin is logged in
    String adminUser = (String) session.getAttribute("adminUser");
    if (adminUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Database connection details
    String url = "jdbc:mysql://localhost:3306/vehicle_reservation_db";
    String user = "root";  
    String password = "";  

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Report</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .report-container {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            margin: 20px auto;
            width: 90%;
            max-width: 1200px;
        }

        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px auto;
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

        .filter-container {
            text-align: center;
            margin: 20px 0;
        }

        .filter-container select {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .print-btn {
            display: block;
            width: 200px;
            margin: 20px auto;
            padding: 10px;
            background-color: #0A6847;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-align: center;
        }

        .print-btn:hover {
            background-color: #085c3d;
        }
        @media print {
    body * {
        visibility: hidden;
    }
    
    .report-container, .report-container * {
        visibility: visible;
    }
    
    .report-container {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
    }

    .print-btn, .filter-container {
        display: none;
    }
}

    </style>
</head>
<body>
    <div class="dashboard">
        <!-- Sidebar -->
        <jsp:include page="sidebar.jsp" />
        
        <!-- Main Content -->
        <main class="content">
            <header class="header">
                <div class="profile">
                    <i class="fas fa-user-circle"></i>
                    <span class="username"><%= session.getAttribute("adminUser") %></span>
                </div>
            </header>

            <section class="manage-bookings">
                <div class="report-container">
                    
                    <!-- Status Filter Dropdown -->
                    <div class="filter-container">
                        <label for="statusFilter">Filter by Status: </label>
                        <select id="statusFilter" onchange="filterTable()">
                            <option value="All">All</option>
                            <option value="Approved">Approved</option>
                            <option value="Pending">Pending</option>
                            <option value="Cancelled">Cancelled</option>
                        </select>
                    </div>

                    <!-- Booking Table -->
                    <table class="table table-bordered" id="bookingTable">
                        <thead class="table-dark">
                            <tr>
                                <th>Booking ID</th>
                                <th>Customer</th>
                                <th>Vehicle</th>
                                <th>Driver</th>
                                <th>From</th>
                                <th>To</th>
                                <th>Date</th>
                                <th>Time</th>
                                <th>Amount</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    con = DriverManager.getConnection(url, user, password);

                                    String query = "SELECT b.booking_id, c.fname AS customer_name, v.model AS vehicle_model, " +
                                                   "COALESCE(d.driver_name, 'Not Assigned') AS driver_name, " +
                                                   "b.from_location, b.to_location, b.booking_date, b.booking_time, " +
                                                   "b.amount, b.status " +
                                                   "FROM bookings b " +
                                                   "JOIN customer c ON b.customer_id = c.customer_id " +
                                                   "LEFT JOIN vehicles v ON b.vehicle_id = v.vehicle_id " +
                                                   "LEFT JOIN drivers d ON b.driver_id = d.driver_id " +
                                                   "ORDER BY b.booking_date DESC";

                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();

                                    if (!rs.isBeforeFirst()) {
                                        out.println("<tr><td colspan='10' class='text-center text-danger'>No bookings found.</td></tr>");
                                    } else {
                                        while (rs.next()) {
                            %>
                            <tr class="booking-row" data-status="<%= rs.getString("status") %>">
                                <td><%= rs.getString("booking_id") %></td>
                                <td><%= rs.getString("customer_name") %></td>
                                <td><%= rs.getString("vehicle_model") %></td>
                                <td><%= rs.getString("driver_name") %></td>
                                <td><%= rs.getString("from_location") %></td>
                                <td><%= rs.getString("to_location") %></td>
                                <td><%= rs.getString("booking_date") %></td>
                                <td><%= rs.getString("booking_time") %></td>
                                <td>Rs. <%= rs.getString("amount") %></td>
                                <td>
                                    <span class="badge 
                                        <%= rs.getString("status").equalsIgnoreCase("Approved") ? "bg-success" : 
                                            rs.getString("status").equalsIgnoreCase("Cancelled") ? "bg-danger" : 
                                            "bg-warning text-dark" %>">
                                        <%= rs.getString("status") %>
                                    </span>
                                </td>
                            </tr>
                            <%
                                        }
                                    }
                                } catch (Exception e) {
                                    out.println("<tr><td colspan='10' class='text-center text-danger'>Error: " + e.getMessage() + "</td></tr>");
                                    e.printStackTrace();
                                } finally {
                                    if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                                    if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
                                    if (con != null) try { con.close(); } catch (SQLException ignored) {}
                                }
                            %>
                        </tbody>
                    </table>

                    <button onclick="window.print()" class="btn btn-primary print-btn">
                        <i class="fas fa-print"></i> Print Report
                    </button>
                </div>
            </section>
        </main>
    </div>

    <script>
        function filterTable() {
            var filter = document.getElementById("statusFilter").value.toLowerCase();
            var rows = document.querySelectorAll(".booking-row");

            rows.forEach(row => {
                var status = row.getAttribute("data-status").toLowerCase();
                if (filter === "all" || status === filter) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
        }
    </script>
</body>
</html>





