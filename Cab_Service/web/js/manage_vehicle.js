/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.addEventListener("DOMContentLoaded", function () {
    fetchVehicleData();
    document.querySelector(".add").addEventListener("click", handleVehicleSubmit);
    document.querySelector(".update").addEventListener("click", updateVehicle);
});

//    function fetchVehicleData() {
//    fetch("http://localhost:8080/Cab_Service/api/vehicles/getAllVehicles")
//        .then(response => {
//            if (!response.ok) {
//                throw new Error(`HTTP error! Status: ${response.status}`);
//            }
//            return response.json();
//        })
//        .then(data => {
//            console.log("API Response:", data); // Debugging: Check API response format
//
//            let vehicles = Array.isArray(data) ? data : (data.vehicles || []);
//
//            if (!Array.isArray(vehicles)) {
//                throw new Error("Invalid API response format");
//            }
//
//            let tableBody = document.getElementById("vehicle-table-body");
//            let rows = "";
//            tableBody.innerHTML = ""; // Clear previous content
//
//            vehicles.forEach(vehicle => {
//                console.log("Vehicle Object:", vehicle); // Debugging each vehicle                
//
//                // Ensure fields are not undefined
//                let vehicleModel = vehicle.vehicle_model ? vehicle.vehicle_model : "Unknown Model";
//                let vehicleType = vehicle.type_id ? vehicle.type_id : "Unknown Model";
//                let plateNumber = vehicle.plate_number ? vehicle.plate_number : "N/A";
//                let driverName = vehicle.driver_name ? vehicle.driver_name : "N/A";
//                let contactNumber = vehicle.contact_number ? vehicle.contact_number : "N/A";
//                let available = vehicle.available === "available" ? "Available" : "Not Available";
//                    
//                console.log("Vehicle Model:", vehicleModel); // Debugging each vehicle  
//                  
//                    rows += "<tr>" +
//                        "<td>" + vehicleModel + "</td>" +
//                        "<td>" + vehicleType + "</td>" +
//                        "<td>" + plateNumber + "</td>" +
//                        "<td>" + driverName + "</td>" +
//                        "<td>" + contactNumber + "</td>" +
//                        "<td>" + available + "</td>" +
//                        "<td><button>Edit</button> <button>Delete</button></td>" +
//                        "</tr>";
//                
//            });
//            
//            tableBody.innerHTML = rows;
//        })
//        .catch(error => console.error("Error fetching vehicle data:", error));
//}
//
//window.onload = fetchVehicleData;

function fetchVehicleData() {
    fetch("http://localhost:8080/Cab_Service/api/vehicles/getAllVehicles")
        .then(response => response.json())
        .then(data => {
            console.log(data);
            let tableBody = document.getElementById("vehicle-table-body");
            tableBody.innerHTML = ""; // Clear previous data

            data.forEach(vehicle => {
                let row = document.createElement("tr");
                row.innerHTML = `
                    
                    <td>${vehicle.vehicle_model}</td>
                    <td>${vehicle.type_id}</td>
                    <td>${vehicle.plate_number}</td>
                    <td>${vehicle.driver_name}</td>
                    <td>${vehicle.contact_number}</td>
                    <td>${vehicle.available}</td>
                    <td>
                        <button class="edit-btn" data-id="${vehicle.vehicle_id}">Edit</button>
                        <button class="delete-btn" data-id="${vehicle.vehicle_id}">Delete</button>
                    </td>
                `;

                row.querySelector(".edit-btn").addEventListener("click", function() {
                    loadVehicleIntoForm(vehicle);
                });

                row.querySelector(".delete-btn").addEventListener("click", function() {
                    deleteVehicle(vehicle.vehicle_id);
                });

                tableBody.appendChild(row);
            });
        })
        .catch(error => console.error("Error fetching vehicle data:", error));
}


function handleVehicleSubmit(event) {
    event.preventDefault();

    let vehicle_id = document.querySelector("input[name='vehicle_id']").value;

    if (vehicle_id) {
        updateVehicle();
    } else {
        addVehicle();
    }
}

function addVehicle() {
    let vehicleData = getVehicleFormData();

    fetch("http://localhost:8080/Cab_Service/api/vehicles/addVehicle", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(driverData)
    })
    .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.text(); // Read response as text
        })
        .then(data => {
            try {
                const jsonData = JSON.parse(data); // Try parsing as JSON
                console.log("JSON Response:", jsonData);
                
            } catch (e) {
                console.log("Text Response:", data); // Handle non-JSON response
                alert(data);
                document.getElementById("vehicle-form").reset();
                fetchDriverData();
            }
        })
    .catch(error => console.error("Error adding driver:", error));
}

function updateVehicle() {
    let vehicleData = getVehicleFormData();

    fetch(`http://localhost:8080/Cab_Service/api/vehicles/updateVehicle`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(vehicleData)
    })
    .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.text(); // Read response as text
        })
        .then(data => {
            try {
                const jsonData = JSON.parse(data); // Try parsing as JSON
                console.log("JSON Response:", jsonData);
                
            } catch (e) {
                console.log("Text Response:", data); // Handle non-JSON response
                alert(data);
                document.getElementById("vehicle-form").reset();
                fetchDriverData();
            }
        })
    .catch(error => console.error("Error updating vehicle:", error));
}

function loadVehicleIntoForm(vehicle) {
    document.querySelector("input[name='vehicle_id']").value = vehicle.vehicle_id;
    document.querySelector("input[name='model']").value = vehicle.vehicle_model;
//    document.querySelector("input[name='type']").value = vehicle.type_id;
    document.querySelector("input[name='plate_number']").value = vehicle.plate_number;
//    document.querySelector("input[name='driverName']").value = vehicle.driver_name;
    document.querySelector("input[name='contact_number']").value = vehicle.contact_number;
    document.querySelector("select[name='availability']").value = vehicle.available;
}

function getDriverFormData() {
    return {
        vehicle_id: document.querySelector("input[name='vehicle_id']").value,
        vehicle_model: document.querySelector("input[name='model']").value,
//        type_id: document.querySelector("input[name='type']").value,
        plate_number: document.querySelector("input[name='plate_number']").value,
//        driver_name: document.querySelector("input[name='driverName']").value,
        contact_number: document.querySelector("input[name='contact_number']").value,
        available: document.querySelector("select[name='availability']").value
    };
}