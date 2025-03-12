<%-- 
    Document   : delete_booking
    Created on : Mar 10, 2025, 8:59:05 PM
    Author     : 94775
--%>

<%@page import="java.sql.*"%>
<%@page session="true" %>

<%
    String adminUser = (String) session.getAttribute("adminUser");
    if (adminUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String url = "jdbc:mysql://localhost:3306/vehicle_reservation_db";
    String user = "root";
    String password = "";

    int bookingId = Integer.parseInt(request.getParameter("id"));

    Connection con = null;
    PreparedStatement pst = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, user, password);

        String query = "DELETE FROM bookings WHERE booking_id=?";
        pst = con.prepareStatement(query);
        pst.setInt(1, bookingId);

        int rowsDeleted = pst.executeUpdate();

        if (rowsDeleted > 0) {
            response.sendRedirect("manage_booking.jsp?message=Booking deleted successfully");
        } else {
            response.sendRedirect("manage_booking.jsp?error=Failed to delete booking");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pst != null) try { pst.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

