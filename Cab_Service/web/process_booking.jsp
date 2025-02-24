<%-- 
    Document   : process_booking
    Created on : Feb 13, 2025, 1:54:40 PM
    Author     : 94775
--%>

<%@page import="java.sql.*"%>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Booking Confirmation</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; text-align: center; }
        .container { width: 50%; margin: 50px auto; background: white; padding: 20px; border-radius: 10px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); }
        h2 { color: #333; }
        .success { color: green; font-size: 18px; }
        .error { color: red; font-size: 18px; }
        a { display: inline-block; margin-top: 20px; padding: 10px 20px; background: #007bff; color: white; text-decoration: none; border-radius: 5px; }
        a:hover { background: #0056b3; }
    </style>
</head>
<body>

    <div class="container">
        <h2>Booking Status</h2>

        <%
            String vehicle_id = request.getParameter("vehicle_id");
            String destination = request.getParameter("destination");
            String amount = request.getParameter("amount");
            String customer_id = request.getParameter("customer_id"); // Get from session in real case

            Connection con = null;
            PreparedStatement ps = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle_reservation_db", "root", "");

                String query = "INSERT INTO bookings (customer_id, vehicle_id, destination, amount, status) VALUES (?, ?, ?, ?, 'PENDING')";
                ps = con.prepareStatement(query);
                ps.setInt(1, Integer.parseInt(customer_id));
                ps.setInt(2, Integer.parseInt(vehicle_id));
                ps.setString(3, destination);
                ps.setBigDecimal(4, new java.math.BigDecimal(amount));

                int rowsInserted = ps.executeUpdate();
                if (rowsInserted > 0) {
                    out.println("<p class='success'>Booking Successful! Your ride is pending approval. ✅</p>");
                } else {
                    out.println("<p class='error'>Failed to book. Try again later. ❌</p>");
                }

            } catch (Exception e) {
                out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (ps != null) ps.close();
                if (con != null) con.close();
            }
        %>

        <a href="customer_booking.jsp">Book Another Ride</a>
    </div>

</body>
</html>

