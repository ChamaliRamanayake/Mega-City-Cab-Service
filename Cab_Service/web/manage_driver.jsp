<%-- 
    Document   : manage_driver
    Created on : Feb 13, 2025, 9:09:11 AM
    Author     : 94775
--%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Drivers</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <link rel="stylesheet" type="text/css" href="css/manage_driver_page.css">
</head>
<body>
    <div class="dashboard">
        <jsp:include page="sidebar.jsp" />
        <main class="content">
            <header class="header">
                <input type="text" placeholder="Search here...">
                <div class="profile">
                    <i class="fas fa-user-circle"></i>
                    <span class="username"><%= session.getAttribute("username") %></span>
                </div>
            </header>
             
            <section class="dashboard-content">

                <div class="driver-form">
                    <h2>Add New Driver</h2>
                    <form action="AddDriverServlet" method="post">
                        <label>Driver Name:</label>
                        <input type="text" name="driver_name" required>

                        <label>License Number:</label>
                        <input type="text" name="license_number" required>

                        <label>Contact Number:</label>
                        <input type="text" name="contact_number" required>

                        <label>Availability:</label>
                        <select name="availability">
                            <option value="Available">Available</option>
                            <option value="Not Available">Not Available</option>
                        </select>

                        <button type="submit" class="update" title="Edit Info">
                            <i class="fas fa-edit"></i>
                        </button>

                        <button type="submit" class="add" title="Insert Info">
                            <i class="fas fa-plus-circle"></i>
                        </button>

                        <button type="reset" class="cancel" title="Cancel Info">
                            <i class="fas fa-times-circle"></i>
                        </button>
                    </form>
                </div>
                
                <div class="driver-info">
                    <h2>Driver Information</h2>
                    <table border="1">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>License Number</th>
                                <th>Contact</th>
                                <th>Availability</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody id="driver-table-body">
                           
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </div>
</body>
