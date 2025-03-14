<%-- 
    Document   : manage_booking
    Created on : Feb 13, 2025, 9:12:23 AM
    Author     : 94775
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page session="true" %>
<%
    // Check if admin is logged in
    String adminUser = (String) session.getAttribute("adminUser");
    if (adminUser == null) {
        response.sendRedirect("login.jsp"); // Redirect to login page if session is empty
        return;
    }

    // Database connection details
    String url = "jdbc:mysql://localhost:3306/vehicle_reservation_db";
    String user = "root";  // Replace with your DB username
    String password = "";   // Replace with your DB password

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
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
                                // Load MySQL driver and establish connection
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                con = DriverManager.getConnection(url, user, password);

                                // SQL Query to fetch booking details with driver information
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
                                    // Display message if no records are found
                                    out.println("<tr><td colspan='11' style='text-align:center;'>No bookings found.</td></tr>");
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
                                <!-- Driver Selection Form -->
                                <form action="update_booking.jsp" method="POST">
                                    <input type="hidden" name="booking_id" value="<%= rs.getInt("booking_id") %>">
                                    <select name="driver_id" required>
                                        <option value="">Assign Driver</option>
                                        <%
                                            Connection driverCon = null;
                                            PreparedStatement driverPst = null;
                                            ResultSet driverRs = null;

                                            try {
                                                driverCon = DriverManager.getConnection(url, user, password);
                                                String driverQuery = "SELECT driver_id, driver_name FROM drivers WHERE availability = 'Available'";
                                                driverPst = driverCon.prepareStatement(driverQuery);
                                                driverRs = driverPst.executeQuery();

                                                while (driverRs.next()) {
                                                    int driverId = driverRs.getInt("driver_id");
                                                    String driverName = driverRs.getString("driver_name");
                                                    boolean selected = driverId == rs.getInt("driver_id");
                                        %>
                                        <option value="<%= driverId %>" <%= selected ? "selected" : "" %>><%= driverName %></option>
                                        <%
                                                }
                                            } catch (SQLException e) {
                                                e.printStackTrace();
                                            } finally {
                                                if (driverRs != null) try { driverRs.close(); } catch (SQLException e) { e.printStackTrace(); }
                                                if (driverPst != null) try { driverPst.close(); } catch (SQLException e) { e.printStackTrace(); }
                                                if (driverCon != null) try { driverCon.close(); } catch (SQLException e) { e.printStackTrace(); }
                                            }
                                        %>
                                    </select>
                            </td>
                            <td><%= rs.getString("status") %></td>
                            <td>
                                <!-- Status Selection -->
                                <select name="status" required>
                                    <option value="Pending" <%= rs.getString("status").equals("Pending") ? "selected" : "" %>>Pending</option>
                                    <option value="Approved" <%= rs.getString("status").equals("Approved") ? "selected" : "" %>>Approved</option>
                                    <option value="Cancelled" <%= rs.getString("status").equals("Cancelled") ? "selected" : "" %>>Cancelled</option>
                                </select>
                            </td>
                            <td>
                                <button type="submit" title="Update Info"><i class="fas fa-edit"></i></button>
                                </form>
                                <a href="delete_booking.jsp?id=<%= rs.getInt("booking_id") %>" class="delete-btn" title="Delete Info" onclick="return confirm('Are you sure you want to delete this booking?')"><i class="fas fa-trash"></i></a>
                            </td>
                        </tr>
                        <%
                                    }
                                }
                            } catch (Exception e) {
                                out.println("<tr><td colspan='11' style='text-align:center; color:red;'>Error: " + e.getMessage() + "</td></tr>");
                                e.printStackTrace();
                            } finally {
                                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                                if (pst != null) try { pst.close(); } catch (SQLException e) { e.printStackTrace(); }
                                if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
                            }
                        %>
                        </tbody>
                    </table>
                </section>
            </main>
        </div>
    </body>
</html>



