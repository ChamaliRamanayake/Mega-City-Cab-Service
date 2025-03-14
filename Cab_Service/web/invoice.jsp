<%-- 
    Document   : invoice
    Created on : Mar 12, 2025, 9:42:58 PM
    Author     : 94775
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    String bookingID = request.getParameter("id");
    String customerUser = (String) session.getAttribute("customerUser");

    if (customerUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String customerName = "", fromLocation = "", toLocation = "", distance = "", bookingDate = "", bookingTime = "";
    String vehicleModel = "", driverName = "Not Assigned", contactNumber = "Not Assigned", amount = "", status = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle_reservation_db", "root", "");

        String query = "SELECT c.fname, c.lname, b.booking_id, b.from_location, b.to_location, b.distance, " +
                       "b.booking_date, b.booking_time, v.model AS vehicle_model, " +
                       "COALESCE(d.driver_name, 'Not Assigned') AS driver_name, " +
                       "COALESCE(d.contact_number, 'Not Assigned') AS contact_number, " +
                       "b.amount, b.status " +
                       "FROM bookings b " +
                       "JOIN customer c ON b.customer_id = c.customer_id " +
                       "LEFT JOIN vehicles v ON b.vehicle_id = v.vehicle_id " +
                       "LEFT JOIN drivers d ON b.driver_id = d.driver_id " +
                       "WHERE b.booking_id = ?";

        ps = con.prepareStatement(query);
        ps.setString(1, bookingID);
        rs = ps.executeQuery();

        if (rs.next()) {
            customerName = rs.getString("fname") + " " + rs.getString("lname");
            fromLocation = rs.getString("from_location");
            toLocation = rs.getString("to_location");
            distance = rs.getString("distance");
            bookingDate = rs.getString("booking_date");
            bookingTime = rs.getString("booking_time");
            vehicleModel = rs.getString("vehicle_model");
            driverName = rs.getString("driver_name");
            contactNumber = rs.getString("contact_number");
            amount = rs.getString("amount");
            status = rs.getString("status");
        }
    } catch (Exception e) {
        out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
        if (con != null) try { con.close(); } catch (SQLException ignored) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .invoice-box {
            max-width: 800px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ddd;
            background: #fff;
            font-family: Arial, sans-serif;
        }
        .header {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
        }
        .details {
            margin-top: 20px;
            font-size: 16px;
        }
        .table th, .table td {
            text-align: center;
        }
        .total-section {
            text-align: right;
            font-size: 18px;
            font-weight: bold;
        }
        @media print {
    .no-print {
        display: none;
        }
    }
    </style>
</head>
<body>
    <div class="invoice-box">
        <div class="header">Mega City Cab - Invoice</div>
        <hr>
        <div class="details">
            <p><strong>Customer:</strong> <%= customerName %></p>
            <p><strong>Booking ID:</strong> <%= bookingID %></p>
            <p><strong>Order Date:</strong> <%= bookingDate %> <%= bookingTime %></p>
            <p><strong>Status:</strong> <span style="color: green;"> <%= status %> </span></p>
        </div>
        
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>From</th>
                    <th>To</th>
                    <th>Distance</th>
                    <th>Vehicle</th>
                    <th>Driver</th>
                    <th>Contact</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><%= fromLocation %></td>
                    <td><%= toLocation %></td>
                     <td><%= distance %> Km</td>
                    <td><%= vehicleModel %></td>
                    <td><%= driverName %></td>
                    <td><%= contactNumber %></td>
                    <td>Rs. <%= amount %></td>
                </tr>
            </tbody>
        </table>

        <div class="total-section">
            <p>Grand Total: Rs. <%= amount %></p>
        </div>
        <button onclick="window.print()" class="btn btn-primary no-print">Print Invoice</button>
        <a href="view_bookings.jsp" class="btn btn-secondary no-print">Back</a>
    </div>
</body>
</html>


