<%-- 
    Document   : view_bookings
    Created on : Feb 19, 2025, 4:35:05 AM
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
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">My Bookings</h2>
        <table class="table table-bordered mt-4">
            <thead class="table-dark">
                <tr>
                    <th>Booking ID</th>
                    <th>Customer ID</th>
                    <th>Vehicle</th>
                    <th>Destination</th>
                    <th>Date</th>
                    <th>Amount</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody id="view-booking-table">
                
            </tbody>
        </table>
        <a href="customer_dashboard.jsp" class="btn btn-secondary mt-3">Back to Dashboard</a>
    </div>
    <script src="js/view_booking.js"></script>
</body>
</html>

