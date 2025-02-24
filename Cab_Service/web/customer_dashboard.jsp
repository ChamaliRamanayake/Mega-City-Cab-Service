<%-- 
    Document   : customer_dashboard
    Created on : Feb 14, 2025, 11:21:05 AM
    Author     : 94775
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%
    // Check if customer is logged in
    String customerUser = (String) session.getAttribute("customerUser");
    if (customerUser == null) {
        response.sendRedirect("customer_login.jsp"); // Redirect to login page if session is empty
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .dashboard-container {
            max-width: 900px;
            margin: auto;
            padding: 20px;
        }
        .card {
            transition: 0.3s;
        }
        .card:hover {
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">Mega City Cab</a>
            <a href="customer_logout.jsp" class="btn btn-danger">Logout</a>
        </div>
    </nav>

    <!-- Dashboard Content -->
    <div class="dashboard-container text-center mt-4">
        <h2>Welcome, <%= session.getAttribute("customerUser") %>!</h2>
        <p>Manage your bookings and profile easily from here.</p>

        <div class="row mt-4">
            <div class="col-md-4">
                <div class="card p-3 shadow">
                    <h5>Book a Ride</h5>
                    <p>Make a new reservation now.</p>
                    <a href="view_vehicle.jsp" class="btn btn-primary">Book Now</a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card p-3 shadow">
                    <h5>My Bookings</h5>
                    <p>View your past and upcoming rides.</p>
                    <a href="view_bookings.jsp" class="btn btn-info">View Bookings</a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card p-3 shadow">
                    <h5>Profile</h5>
                    <p>Update your personal details.</p>
                    <a href="customer_profile.jsp" class="btn btn-success">Edit Profile</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>




