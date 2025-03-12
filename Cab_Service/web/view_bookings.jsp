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

        <%-- Success or Error Message --%>
        <%
            String message = request.getParameter("message");
            String error = request.getParameter("error");

            if (message != null) { %>
                <div class="alert alert-success"><%= message %></div>
        <%  } else if (error != null) { %>
                <div class="alert alert-danger"><%= error %></div>
        <%  } 
        %>

        <table class="table table-bordered mt-4">
            <thead class="table-dark">
                <tr>
                    <th>Booking ID</th>
                    <th>Vehicle Model</th>
                    <th>Driver Name</th>
                    <th>Driver Contact</th>
                    <th>From Location</th>
                    <th>To Location</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Amount</th>
                    <th>Status</th>
                    <th>Action</th> <%-- New Column for Delete Button --%>
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

                        // Fetch all bookings including pending ones with left joins
                        String query = "SELECT b.booking_id, v.model AS vehicle_model, b.from_location, b.to_location, " +
                                       "b.booking_date, b.booking_time, b.amount, b.status, " +
                                       "COALESCE(d.driver_name, 'Not Assigned') AS driver_name, " +
                                       "COALESCE(d.contact_number, 'Not Assigned') AS contact_number " +
                                       "FROM bookings b " +
                                       "LEFT JOIN vehicles v ON b.vehicle_id = v.vehicle_id " +
                                       "LEFT JOIN drivers d ON b.driver_id = d.driver_id " +
                                       "WHERE b.customer_id = ?";

                        ps = con.prepareStatement(query);
                        ps.setString(1, customerID);
                        rs = ps.executeQuery();

                        while (rs.next()) {
                            String bookingStatus = rs.getString("status");
                %>
                            <tr>
                                <td><%= rs.getString("booking_id") %></td>
                                <td><%= rs.getString("vehicle_model") %></td>
                                <td><%= rs.getString("driver_name") %></td>
                                <td><%= rs.getString("contact_number") %></td>
                                <td><%= rs.getString("from_location") %></td>
                                <td><%= rs.getString("to_location") %></td>
                                <td><%= rs.getString("booking_date") %></td>
                                <td><%= rs.getString("booking_time") %></td>
                                <td><%= rs.getString("amount") %></td>
                                <td>
                                    <span class="badge 
                                        <%= bookingStatus.equalsIgnoreCase("Approved") ? "bg-success" : 
                                            bookingStatus.equalsIgnoreCase("Cancelled") ? "bg-danger" : 
                                            "bg-warning text-dark" %>">
                                        <%= bookingStatus %>
                                    </span>
                                </td>
                                <td>
                                    <% if ("Pending".equalsIgnoreCase(bookingStatus)) { %>
                                        <a href="delete_bookings.jsp?id=<%= rs.getString("booking_id") %>" 
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('Are you sure you want to delete this booking?');">
                                            Delete
                                        </a>
                                    <% } else { %>
                                        <button class="btn btn-secondary btn-sm" disabled>Cannot Delete</button>
                                    <% } %>
                                </td>
                            </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='11' style='color: red;'>Error: " + e.getMessage() + "</td></tr>");
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












