<%-- 
    Document   : manage_booking
    Created on : Feb 13, 2025, 9:12:23 AM
    Author     : 94775
--%>

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
                        <span class="username"><%= session.getAttribute("username") %></span>
                    </div>
                </header>
                <section class="manage-bookings">
                    <h2>Manage Bookings</h2>
                    <table>
                        <tr>
                            <th>Booking ID</th>
                            <th>Customer Name</th>
                            <th>Vehicle</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>

                        <tr>
                         
                        </tr>
                      
                    </table>
                </section>
            </main>
        </div>
    </body>
</html>
