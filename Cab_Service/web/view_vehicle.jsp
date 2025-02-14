<%-- 
    Document   : view_vehicle
    Created on : Feb 13, 2025, 2:16:57 PM
    Author     : 94775
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Vehicles - Mega City Cab</title>
    <link rel="stylesheet" type="text/css" href="css/view_vehiclePage.css">
</head>
<body>

    <div class="container">
        <h2>View Vehicles 🚗</h2>

        <table>
            <tr>
                <th>Model</th>
                <th>Plate Number</th>
                <th>Type</th>
                <th>Status</th>
                <th>Booking</th>
            </tr>

            <%
            try {
                // Database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle_reservation_db", "root", "");

                String query = "SELECT v.vehicle_id, v.model, v.plate_number, vt.type_name, v.available FROM vehicles v JOIN vehicle_types vt ON v.type_id = vt.type_id WHERE v.available = 'AVAILABLE'";
                PreparedStatement ps = con.prepareStatement(query);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
            %>
                    <tr>
                        <td><%= rs.getString("model") %></td>
                        <td><%= rs.getString("plate_number") %></td>
                        <td><%= rs.getString("type_name") %></td>
                        <td><%= rs.getString("available") %></td>
                        <td>
                            <a href="customer_booking.jsp?vehicle_id=<%= rs.getInt("vehicle_id") %>&model=<%= rs.getString("model") %>&plate_number=<%= rs.getString("plate_number") %>" 
                               class="book-btn">Book Now</a>
                        </td>
                    </tr>
            <%
                }
                rs.close();
                ps.close();
                con.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='5' style='color:red;'>Error loading vehicles: " + e.getMessage() + "</td></tr>");
            }
            %>

        </table>

        <a href="index.jsp" class="back-btn">⬅ Back to Home</a>
    </div>

</body>
</html>

