<%-- 
    Document   : manage_booking
    Created on : Feb 13, 2025, 9:12:23 AM
    Author     : 94775
--%>

<%@page import="java.sql.*"%>
<%@page session="true" %>

<%
    // Check if admin is logged in
    String adminUser = (String) session.getAttribute("adminUser");
    if (adminUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Database connection details
    String url = "jdbc:mysql://localhost:3306/vehicle_reservation_db";
    String user = "root";  // Change to your DB user
    String password = "";   // Change to your DB password

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    double pricePerKm = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, user, password);

        // Check if form is submitted for price update
        String newPriceStr = request.getParameter("new_price");
        if (newPriceStr != null && !newPriceStr.isEmpty()) {
            double newPrice = Double.parseDouble(newPriceStr);
            String updateQuery = "UPDATE pricing SET price_per_km = ? WHERE id = 1";
            pst = con.prepareStatement(updateQuery);
            pst.setDouble(1, newPrice);
            int rowsUpdated = pst.executeUpdate();
            pst.close();
        }

        // Retrieve the latest price per km
        String priceQuery = "SELECT price_per_km FROM pricing LIMIT 1";
        pst = con.prepareStatement(priceQuery);
        rs = pst.executeQuery();
        
        if (rs.next()) {
            pricePerKm = rs.getDouble("price_per_km");
        }
        
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pst != null) try { pst.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Bookings</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <link rel="stylesheet" type="text/css" href="css/manage_booking_page.css">
        <style>
            .pricing-section {
    background: #f8f9fa;
    padding: 20px;
    margin: 20px 0;
    border-radius: 10px;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    text-align: center;
}

.pricing-section h2 {
    font-size: 22px;
    margin-bottom: 10px;
    color: #333;
}

.pricing-section p {
    font-size: 18px;
    color: #555;
    margin-bottom: 15px;
}

.pricing-section form {
    display: flex;
    justify-content: center;
    gap: 10px;
    align-items: center;
}

.pricing-section input {
    padding: 8px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 5px;
    width: 100px;
    text-align: center;
}

.pricing-section button {
    background: #007bff;
    color: white;
    border: none;
    padding: 8px 15px;
    font-size: 16px;
    border-radius: 5px;
    cursor: pointer;
    transition: background 0.3s ease;
}

.pricing-section button:hover {
    background: #0056b3;
}

        </style>
    </head>
    <body>
        <div class="dashboard">
            <jsp:include page="sidebar.jsp" />
            <main class="content">
                <header class="header">
                    <input type="text" placeholder="Search bookings...">
                    <div class="profile">
                        <i class="fas fa-user-circle"></i>
                        <span class="username"><%= session.getAttribute("adminUser") %></span>
                    </div>
                </header>
                
                <section class="pricing-section">
                    <h2>Pricing Information</h2>
                    <p>Current Price Per Km: Rs. <%= pricePerKm %></p>
                    <form action="manage_booking.jsp" method="POST">
                        <input type="number" name="new_price" step="0.01" min="0" required>
                        <button type="submit">Update Price</button>
                    </form>
                </section>
                
                <section class="manage-bookings">
                    <h2>Manage Bookings</h2>
                    <table>
                        <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>Customer Name</th>
                            <th>Vehicle</th>
                            <th>From</th>
                            <th>To</th>
                            <th>Distance</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Amount</th>
                            <th>Driver</th>
                            <th>Status</th>
                            <th>Select Status</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody id="booking-table-body">
                        <%
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                con = DriverManager.getConnection(url, user, password);

                                String query = "SELECT b.booking_id, c.fname AS customer_name, v.model, " +
                                               "b.from_location, b.to_location, b.booking_date, b.booking_time, b.distance," +
                                               "b.amount, b.status, d.driver_id, d.driver_name " +
                                               "FROM bookings b " +
                                               "JOIN customer c ON b.customer_id = c.customer_id " +
                                               "JOIN vehicles v ON b.vehicle_id = v.vehicle_id " +
                                               "LEFT JOIN drivers d ON b.driver_id = d.driver_id";

                                pst = con.prepareStatement(query);
                                rs = pst.executeQuery();

                                if (!rs.isBeforeFirst()) {
                                    out.println("<tr><td colspan='13' style='text-align:center;'>No bookings found.</td></tr>");
                                } else {
                                    while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getInt("booking_id") %></td>
                            <td><%= rs.getString("customer_name") %></td>
                            <td><%= rs.getString("model") %></td>
                            <td><%= rs.getString("from_location") %></td>
                            <td><%= rs.getString("to_location") %></td>
                            <td><%= rs.getString("distance") %> Km</td>
                            <td><%= rs.getString("booking_date") %></td>
                            <td><%= rs.getString("booking_time") %></td>
                            <td>Rs. <%= rs.getDouble("amount") %></td>
                            <td>
                                <form action="update_booking.jsp" method="POST">
                                    <input type="hidden" name="booking_id" value="<%= rs.getInt("booking_id") %>">
                                    <select name="driver_id" required>
                                        <option value="">Assign Driver</option>
                                        <%
                                            Connection driverCon = DriverManager.getConnection(url, user, password);
                                            PreparedStatement driverPst = driverCon.prepareStatement("SELECT driver_id, driver_name FROM drivers WHERE availability = 'Available'");
                                            ResultSet driverRs = driverPst.executeQuery();
                                            while (driverRs.next()) {
                                                int driverId = driverRs.getInt("driver_id");
                                                String driverName = driverRs.getString("driver_name");
                                                boolean selected = driverId == rs.getInt("driver_id");
                                        %>
                                        <option value="<%= driverId %>" <%= selected ? "selected" : "" %>><%= driverName %></option>
                                        <%
                                            }
                                            driverRs.close();
                                            driverPst.close();
                                            driverCon.close();
                                        %>
                                    </select>
                            </td>
                            <td><%= rs.getString("status") %></td>
                            <td>
                                <select name="status" required>
                                    <option value="Pending" <%= rs.getString("status").equals("Pending") ? "selected" : "" %>>Pending</option>
                                    <option value="Approved" <%= rs.getString("status").equals("Approved") ? "selected" : "" %>>Approved</option>
                                    <option value="Cancelled" <%= rs.getString("status").equals("Cancelled") ? "selected" : "" %>>Cancelled</option>
                                </select>
                            </td>
                            <td>
                                <button type="submit"><i class="fas fa-edit"></i></button>
                                </form>
                            </td>
                        </tr>
                        <%
                                    }
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                        </tbody>
                    </table>
                </section>
            </main>
        </div>
    </body>
</html>



