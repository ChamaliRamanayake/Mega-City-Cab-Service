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
            String from_location = request.getParameter("from_location");
            String to_location = request.getParameter("to_location");
            String bookingDateStr = request.getParameter("booking_date");
            String bookingTimeStr = request.getParameter("booking_time");
            String customer_id = request.getParameter("customer_id");
            String distanceStr = request.getParameter("distance");
            String amountStr = request.getParameter("amount");

            Connection con = null;
            PreparedStatement ps = null;
            double distance = Double.parseDouble(distanceStr);
            double total_amount = Double.parseDouble(amountStr);

            try {
                // Convert date and time properly
                java.sql.Date booking_date = java.sql.Date.valueOf(bookingDateStr);
                java.sql.Time booking_time = java.sql.Time.valueOf(bookingTimeStr + ":00");

                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle_reservation_db", "root", "");

                // Insert booking into database
                String query = "INSERT INTO bookings (customer_id, vehicle_id, from_location, to_location, distance, booking_date, booking_time, amount, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'PENDING')";
                ps = con.prepareStatement(query);
                ps.setInt(1, Integer.parseInt(customer_id));
                ps.setInt(2, Integer.parseInt(vehicle_id));
                ps.setString(3, from_location);
                ps.setString(4, to_location);
                ps.setDouble(5, distance);
                ps.setDate(6, booking_date);
                ps.setTime(7, booking_time);
                ps.setDouble(8, total_amount);

                int rowsInserted = ps.executeUpdate();
                if (rowsInserted > 0) {
                    out.println("<p class='success'>Booking Successful! Your ride is pending approval. ✅</p>");
                    out.println("<p>Total Distance: " + distance + " km</p>");
                    out.println("<p>Total Fare: " + total_amount + " LKR</p>");
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
        <a href="view_bookings.jsp">View Booking</a>
    </div>

</body>
</html>






