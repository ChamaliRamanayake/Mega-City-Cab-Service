<%-- 
    Document   : admin_dashboard
    Created on : Feb 13, 2025, 6:49:47 AM
    Author     : 94775
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/admin_dashboard_page.css">
</head>
<body>
    <div class="dashboard">
     
        <jsp:include page="sidebar.jsp" />

        <!-- Main Content -->
        <main class="content">
            <!-- Header -->
            <header class="header">
                <input type="text" placeholder="Search here...">
                <div class="profile">
                    <i class="fas fa-user-circle"></i>
                    <span class="username"><%= session.getAttribute("username") %></span>
                </div>
            </header>
            
            <!-- Dashboard Content -->
            <section class="dashboard-content">
                
                <!-- Driver List -->
                <div class="driver-list">
                    <h2>All Drivers</h2>
                    <ul>
                        <li><img src="driver1.jpg" alt="Driver 1"> Alex Noman <span class="status available">Available</span></li>
                        <li><img src="driver2.jpg" alt="Driver 2"> Ethan Miller <span class="status unavailable">Unavailable</span></li>
                        <li><img src="driver3.jpg" alt="Driver 3"> Mason Wilson <span class="status available">Available</span></li>
                    </ul>
                </div>
                
                <!-- Driver Info -->
                <div class="driver-info">
                    <h2>Driver's Information</h2>
                    <div class="info">
                        <p>Driver: <b>Alex Noman</b></p>
                        <p>Car No: <b>6465</b></p>
                        <p>Status: <span class="status available">Available</span></p>
                        <p>Car Model: <b>Nissan Rogue</b></p>
                        <p>Trips Completed: <b>20</b></p>
                        <button class="assign-btn">Assign Trip</button>
                    </div>
                </div>
                
            </section>
        </main>
    </div>
</body>
</html>
