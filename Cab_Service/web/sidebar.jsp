<%-- 
    Document   : sidebar
    Created on : Feb 12, 2025, 8:46:30 PM
    Author     : 94775
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
       <aside class="sidebar">
            <div class="logo">Mega City Cab</div>
<!--            <div class="profile-account">
                <img src="images/profile.jpg" alt="Profile Image" class="profile-img">
            </div>-->
            <ul class="menu">
                <li class=""><a href="admin_dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                <li><a href="manage_driver.jsp"><i class="fas fa-user"></i> Drivers</a></li>
                <li><a href="manage_vehicle.jsp"><i class="fas fa-car"></i> Vehicles</a></li>
                <li><a href="manage_customer.jsp"><i class="fas fa-user"></i> Customer</a></li>
                <li><a href="manage_booking.jsp"><i class="fas fa-calendar-alt"></i> Bookings</a></li>
                <li><a href="report.jsp"><i class="fas fa-file-alt"></i> Report</a></li>
                <li><a href="settings.jsp"><i class="fas fa-cog"></i> Settings</a></li>
            </ul>
            <a href="logout.jsp" class="logout">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </aside>

    </body>
</html>

