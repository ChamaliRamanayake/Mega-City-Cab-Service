<%-- 
    Document   : manage_vehicle
    Created on : Feb 12, 2025, 9:28:22 AM
    Author     : 94775
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Vehicles</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/manage_vehicle_page.css">

 <script>
        function fetchVehicleData() {
    fetch("http://localhost:8080/Cab_Service/api/vehicles/getAllVehicles")
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! Status: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {
            console.log("API Response:", data); // Debugging: Check API response format

            let vehicles = Array.isArray(data) ? data : (data.vehicles || []);

            if (!Array.isArray(vehicles)) {
                throw new Error("Invalid API response format");
            }

            let tableBody = document.getElementById("vehicle-table-body");
            tableBody.innerHTML = ""; // Clear previous content

            vehicles.forEach(vehicle => {
                console.log("Vehicle Object:", vehicle); // Debugging each vehicle

                let available = (vehicle.available === true || vehicle.available === "true" || vehicle.available == 1) 
                    ? "Available" 
                    : "Not Available";

                let row = `<tr>
                    <td>${vehicle.model || "N/A"}</td>
                    <td>${vehicle.plate_number || "N/A"}</td>
                    <td>${available}</td>
                    <td><button>Edit</button> <button>Delete</button></td>
                </tr>`;

                tableBody.innerHTML += row;
            });
        })
        .catch(error => console.error("Error fetching vehicle data:", error));
}

window.onload = fetchVehicleData;


    </script>

</head>
<body>
    <div class="dashboard">
        
        <!-- Sidebar -->
        <jsp:include page="sidebar.jsp" />

        <!-- Main Content -->
        <main class="content">
            <!-- Header -->
            <header class="header">
                <input type="text" placeholder="Search here...">
                <div class="profile">
                    <i class="fas fa-user-circle"></i>
                    <span class="username"></span>
                </div>
            </header>
            
            <!-- Dashboard Content -->
            <section class="dashboard-content">
                
                <!-- Vehicle Form -->
                <div class="vehicle-form">
                    <h2>Add New Vehicle</h2>
                    <form action="AddVehicleServlet" method="post">

                        <label>Model:</label>
                        <input type="text" name="model" required>
                        
                        <label>Type:</label>
                        <select name="type">
                            <option value="">Select Type</option>
                            <%
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver"); // Ensure MySQL Driver is loaded
                                    java.sql.Connection con = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle_reservation_db", "root", "");
                                    java.sql.PreparedStatement pst = con.prepareStatement("SELECT type_id, type_name FROM vehicle_types");
                                    java.sql.ResultSet rs = pst.executeQuery();

                                    if (!rs.isBeforeFirst()) { // Check if the result set is empty
                            %>
                                        <option value="">No Types Found</option>
                            <%
                                    } else {
                                        while (rs.next()) {
                            %>
                                            <option value="<%= rs.getInt("type_id") %>"><%= rs.getString("type_name") %></option>
                            <%
                                        }
                                    }
                                    rs.close();
                                    pst.close();
                                    con.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                            %>
                                    <option value="">Error Loading Types</option>
                            <%
                                }
                            %>
                        </select>
                        
                        <label>Plate Number:</label>
                        <input type="text" name="plate_number" required>
                        
                        <label>Availability:</label>
                        <select name="availability">
                            <option value="available">Available</option>
                            <option value="not available">Not Available</option>
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
                
                <!-- Vehicle Info -->
                <div class="vehicle-info">
                    <h2>Vehicle Information</h2>
                    <table border="1">
                        <thead>
                            <tr>
                                <th>Model</th>
                                <!--<th>Type</th>-->
                                <th>Plate Number</th>
                                <th>Availability</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody id="vehicle-table-body">
                            
                        </tbody>
                    </table>
                </div>
                
            </section>
        </main>
    </div>

</body>
</html>




