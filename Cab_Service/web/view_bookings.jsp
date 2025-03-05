<%-- 
    Document   : view_bookings
    Created on : Feb 19, 2025, 4:35:05 AM
    Author     : 94775
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>

<%
    // Check if the user is logged in
    String customerUser = (String) session.getAttribute("customerUser");
    if (customerUser == null) {
        response.sendRedirect("customer_login.jsp");
        return;
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
                    <th>Vehicle</th>
                    <th>Destination</th>
                    <th>Date</th>
                    <th>Amount</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection con = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    String customerID = "";

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle_reservation_db", "root", "");

                        // Get customer ID based on username
                        ps = con.prepareStatement("SELECT customer_id FROM customer WHERE username = ?");
                        ps.setString(1, customerUser);
                        rs = ps.executeQuery();
                        if (rs.next()) {
                            customerID = rs.getString("customer_id");
                        }
                        rs.close();
                        ps.close();

                        // Fetch bookings for this customer
                        ps = con.prepareStatement("SELECT * FROM bookings WHERE customer_id = ?");
                        ps.setString(1, customerID);
                        rs = ps.executeQuery();

                        while (rs.next()) {
                %>
                            <tr>
                                <td><%= rs.getString("booking_id") %></td>
                                <td><%= rs.getString("vehicle_id") %></td>
                                <td><%= rs.getString("destination") %></td>
                                <td><%= rs.getString("booking_date") %></td>
                                <td><%= rs.getString("amount") %></td>
                                <td><%= rs.getString("status") %></td>
                            </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='6' style='color: red;'>Error: " + e.getMessage() + "</td></tr>");
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                        if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
                        if (con != null) try { con.close(); } catch (SQLException ignored) {}
                    }
                %>
            </tbody>
        </table>

        <a href="customer_dashboard.jsp" class="btn btn-secondary mt-3">Back to Dashboard</a>
    </div>
</body>
</html>


