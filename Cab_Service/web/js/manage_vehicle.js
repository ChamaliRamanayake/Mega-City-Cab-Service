document.addEventListener("DOMContentLoaded", function () {
    fetchVehicleData();
    document.querySelector(".add").addEventListener("click", handleVehicleSubmit);
    document.querySelector(".update").addEventListener("click", updateVehicle);
});

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
    if (!validateForm()) { // Use validateForm() instead of validateVehicleForm()
        return; // Stop execution if validation fails
    }

    let vehicleData = getVehicleFormData();

    fetch("http://localhost:8080/Cab_Service/api/vehicles/addVehicle", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(vehicleData)
    })
    .then(response => {
        if (!response.ok) {
            return response.text().then(err => { throw new Error(err); });
        }
        return response.text();
    })
    .then(data => {
        console.log("Response:", data);
        alert("Vehicle added successfully!");
        document.getElementById("vehicle-form").reset();
        fetchVehicleData();
    })
    .catch(error => console.error("Error adding vehicle:", error.message));
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
                fetchVehicleData();
            }
        })
    .catch(error => console.error("Error updating vehicle:", error));
}

function deleteVehicle(id) {
    if (confirm("Are you sure you want to delete this vehicle?")) {
        fetch(`http://localhost:8080/Cab_Service/api/vehicles/deleteVehicle/${id}`, {
            method: "DELETE",
            headers: { "Content-Type": "application/json" }
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
                fetchVehicleData();
            }
        })
        .catch(error => console.error("Error deleting vehicle:", error));
    }
}

function loadVehicleIntoForm(vehicle) {
    document.querySelector("input[name='vehicle_id']").value = vehicle.vehicle_id;
    document.querySelector("input[name='model']").value = vehicle.vehicle_model;
    document.querySelector("select[name='type']").value = vehicle.type_id;
    document.querySelector("input[name='plate_number']").value = vehicle.plate_number;
    document.querySelector("select[name='availability']").value = vehicle.available;
}

function getVehicleFormData() {
    let vehicle_id = document.querySelector("input[name='vehicle_id']").value.trim();

    let vehicleData = {
        vehicle_model: document.querySelector("input[name='model']").value.trim(),
        type_id: document.querySelector("select[name='type']").value.trim(),
        plate_number: document.querySelector("input[name='plate_number']").value.trim(),
        available: document.querySelector("select[name='availability']").value.trim()
    };

    // Include vehicle_id only if it's present (for updates)
    if (vehicle_id) {
        vehicleData.vehicle_id = vehicle_id;
    }

    return vehicleData;
}


// FORM VALIDATION FUNCTION
function validateForm() {
    let model = document.querySelector("input[name='model']").value.trim();
    let plateNumber = document.querySelector("input[name='plate_number']").value.trim();
    let type = document.querySelector("select[name='type']").value;
    let availability = document.querySelector("select[name='availability']").value;

    let valid = true;

    // Remove previous error messages
    document.querySelectorAll(".error-message").forEach(el => el.remove());

    // Validate Vehicle Model
    if (model === "" || !/^[A-Za-z0-9\s]+$/.test(model)) {
        showError(document.querySelector("input[name='model']"), "Enter a valid model (letters & numbers only).");
        valid = false;
    }

    // Validate Plate Number (Format: ABC-1234 or AB-1234)
    if (!/^[A-Z]{2,3}-\d{4}$/.test(plateNumber)) {
        showError(document.querySelector("input[name='plate_number']"), "Enter a valid plate number (e.g., ABC-1234).");
        valid = false;
    }

    // Validate Type Selection
    if (type === "") {
        showError(document.querySelector("select[name='type']"), "Please select a vehicle type.");
        valid = false;
    }

    // Validate Availability Selection
    if (availability === "") {
        showError(document.querySelector("select[name='availability']"), "Please select availability.");
        valid = false;
    }

    return valid;
}

function showError(input, message) {
    let error = document.createElement("small");
    error.className = "error-message";
    error.style.color = "red";
    error.innerText = message;
    input.parentNode.insertBefore(error, input.nextSibling);
}
