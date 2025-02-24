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
        response.sendRedirect("customer_login.jsp"); // Redirect to login page if session is empty
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

    <script>
        function calculateFare() {
            let destination = document.getElementById("destination").value;
            let fareInput = document.getElementById("amount");
            let fare = 0;

            // Define fixed fare rates (Example: adjust based on real data)
            let fareRates = {
                "Colombo Fort": 1000,
                "Pettah": 1200,
                "Nugegoda": 1500,
                "Maharagama": 1800,
                "Kottawa": 2000
            };

            // Set the fare amount based on the selected destination
            if (fareRates[destination]) {
                fare = fareRates[destination];
            }

            // Update the fare input field
            fareInput.value = fare;
        }
    </script>
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
                    
                    String query = "SELECT model, plate_number FROM vehicles WHERE vehicle_id = ?";
                    PreparedStatement ps = con.prepareStatement(query);
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

            <label>Destination:</label>
            <select name="destination" id="destination" onchange="calculateFare()" required>
                <option value="">Select Destination</option>
                <option value="Colombo Fort">Colombo Fort</option>
                <option value="Pettah">Pettah</option>
                <option value="Nugegoda">Nugegoda</option>
                <option value="Maharagama">Maharagama</option>
                <option value="Kottawa">Kottawa</option>
            </select>

            <label>Amount (LKR):</label>
            <input type="number" name="amount" id="amount" required placeholder="Fare will be calculated" readonly>

            <input type="hidden" name="customer_id" value="1"> <%-- Replace with session-based customer_id --%>

            <button type="submit">Book Now</button>
        </form>
    </div>

</body>
</html>



