<%-- 
    Document   : customer_booking
    Created on : Feb 13, 2025, 1:51:42 PM
    Author     : 94775
--%>

<%@page import="java.sql.*"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>

<%
    // Check if customer is logged in
    String customerUser = (String) session.getAttribute("customerUser");

    if (customerUser == null) {
        response.sendRedirect("login.jsp"); // Redirect to login page if session is empty
        return;
    }

    // Initialize variables
    int customerId = -1;
    double pricePerKm = 0.0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle_reservation_db", "root", "");

        // Retrieve the customer ID based on the logged-in username
        String query = "SELECT customer_id FROM customer WHERE username = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, customerUser);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            customerId = rs.getInt("customer_id");
        } else {
            response.sendRedirect("login.jsp");
            return;
        }
        rs.close();
        ps.close();

        // Retrieve the latest price per km from the database
        String priceQuery = "SELECT price_per_km FROM pricing LIMIT 1";
        ps = con.prepareStatement(priceQuery);
        rs = ps.executeQuery();
        if (rs.next()) {
            pricePerKm = rs.getDouble("price_per_km");
        }

        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Book a Ride - Mega City Cab</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; text-align: center; }
        .container { width: 50%; margin: 50px auto; background: white; padding: 20px; border-radius: 10px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); }
        h2 { color: #333; }
        label { font-size: 18px; font-weight: bold; display: block; margin-top: 10px; }
        input, select { width: 100%; padding: 10px; margin-top: 5px; border-radius: 5px; border: 1px solid #ddd; }
        button { margin-top: 20px; padding: 10px 20px; background: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer; }
        button:hover { background: #0056b3; }
        .error { color: red; font-size: 16px; }
    </style>
</head>
<body>

    <div class="container">
        <h2>Book Your Ride 🚖</h2>

        <%
            String vehicleId = request.getParameter("vehicle_id");
            String model = "";
            String plateNumber = "";

            if (vehicleId != null && !vehicleId.isEmpty()) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle_reservation_db", "root", "");

                    String vehicleQuery = "SELECT model, plate_number FROM vehicles WHERE vehicle_id = ?";
                    PreparedStatement ps = con.prepareStatement(vehicleQuery);
                    ps.setInt(1, Integer.parseInt(vehicleId));
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        model = rs.getString("model");
                        plateNumber = rs.getString("plate_number");
                    }

                    rs.close();
                    ps.close();
                    con.close();
                } catch (Exception e) {
                    out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
                }
            }
        %>

        <form action="process_booking.jsp" method="post">
            <label>Selected Vehicle:</label>
            <input type="text" value="<%= model %> - <%= plateNumber %>" readonly>

            <input type="hidden" name="vehicle_id" value="<%= vehicleId %>">

            <label>From Location:</label>
            <input type="text" name="from_location" required>

            <label>To Location:</label>
            <input type="text" name="to_location" required>

            <label>Distance (km):</label>
            <input type="number" name="distance" id="distance" min="1" step="0.1" required oninput="calculatePrice()">

            <label>Price Per Km (LKR):</label>
            <input type="text" id="pricePerKm" value="<%= pricePerKm %>" readonly>

            <label>Total Amount (LKR):</label>
            <input type="text" name="amount" id="amount" readonly>

            <label>Booking Date:</label>
            <input type="date" name="booking_date" required>

            <label>Booking Time:</label>
            <input type="time" name="booking_time" required>

            <input type="hidden" name="customer_id" value="<%= customerId %>"> 

            <button type="submit">Book Now</button>
        </form>

    </div>

    <script>
        function calculatePrice() {
            var distance = document.getElementById("distance").value;
            var pricePerKm = document.getElementById("pricePerKm").value;
            var total = distance * pricePerKm;
            document.getElementById("amount").value = total.toFixed(2);
        }
    </script>

</body>
</html>






