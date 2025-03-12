<%-- 
    Document   : delete_bookings
    Created on : Mar 12, 2025, 4:41:39 PM
    Author     : 94775
--%>

<%@page import="java.sql.*"%>
<%@page session="true" %>

<%
    // Check if the customer is logged in
    String customerUser = (String) session.getAttribute("customerUser");
    if (customerUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Database connection details
    String url = "jdbc:mysql://localhost:3306/vehicle_reservation_db";
    String user = "root";
    String password = "";

    // Get booking ID from request
    String bookingIdParam = request.getParameter("id");

    if (bookingIdParam == null || bookingIdParam.isEmpty()) {
        response.sendRedirect("view_bookings.jsp?error=Invalid booking ID");
        return;
    }

    int bookingId = Integer.parseInt(bookingIdParam);
    
    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, user, password);

        // Verify the booking belongs to the logged-in customer
        String checkQuery = "SELECT customer_id FROM bookings WHERE booking_id=?";
        pst = con.prepareStatement(checkQuery);
        pst.setInt(1, bookingId);
        rs = pst.executeQuery();

        if (!rs.next()) {
            response.sendRedirect("view_bookings.jsp?error=Booking not found");
            return;
        }

        String customerIdFromDB = rs.getString("customer_id");

        // Delete the booking
        String deleteQuery = "DELETE FROM bookings WHERE booking_id=?";
        pst = con.prepareStatement(deleteQuery);
        pst.setInt(1, bookingId);

        int rowsDeleted = pst.executeUpdate();

        if (rowsDeleted > 0) {
            response.sendRedirect("view_bookings.jsp?message=Booking deleted successfully");
        } else {
            response.sendRedirect("view_bookings.jsp?error=Failed to delete booking");
        }
    } catch (Exception e) {
        response.sendRedirect("view_bookings.jsp?error=Error: " + e.getMessage());
    } finally {
        if (pst != null) try { pst.close(); } catch (SQLException ignored) {}
        if (con != null) try { con.close(); } catch (SQLException ignored) {}
    }
%>

