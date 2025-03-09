document.addEventListener("DOMContentLoaded", function () {
    fetchDriverData();
    document.querySelector(".add").addEventListener("click", handleDriverSubmit);
    document.querySelector(".update").addEventListener("click", updateDriver);
});

function fetchDriverData() {
    fetch("http://localhost:8080/Cab_Service/api/drivers/getAllDrivers")
        .then(response => response.json())
        .then(data => {
            console.log(data);
            let tableBody = document.getElementById("driver-table-body");
            tableBody.innerHTML = ""; // Clear previous data

            data.forEach(driver => {
                let row = document.createElement("tr");
                row.innerHTML = `
                    <td>${driver.driverID}</td>
                    <td>${driver.driver_name}</td>
                    <td>${driver.license_number}</td>
                    <td>${driver.contact_number}</td>
                    <td>${driver.availability}</td>
                    <td>
                        <button class="edit-btn" data-id="${driver.driverID}">Edit</button>
                        <button class="delete-btn" data-id="${driver.driverID}">Delete</button>
                    </td>
                `;

                row.querySelector(".edit-btn").addEventListener("click", function() {
                    loadDriverIntoForm(driver);
                });

                row.querySelector(".delete-btn").addEventListener("click", function() {
                    deleteDriver(driver.driverID);
                });

                tableBody.appendChild(row);
            });
        })
        .catch(error => console.error("Error fetching driver data:", error));
}

function handleDriverSubmit(event) {
    event.preventDefault();

    let driverId = document.querySelector("input[name='driverID']").value;

    if (driverId) {
        updateDriver();
    } else {
        addDriver();
    }
}

function addDriver() {
    if (!validateForm()) {
        return; // Stop execution if validation fails
    }

    let driverData = getDriverFormData();
    
    fetch("http://localhost:8080/Cab_Service/api/drivers/addDriver", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(driverData)
    })
    .then(response => {
        if (!response.ok) {
            return response.text().then(err => { throw new Error(err); });
        }
        return response.text();
    })
    .then(data => {
        console.log("Response:", data);
        alert("Driver added successfully!");
        document.getElementById("driver-form").reset();
        fetchDriverData();
    })
    .catch(error => console.error("Error adding driver:", error.message));
}


function updateDriver() {
    let driverData = getDriverFormData();

    fetch(`http://localhost:8080/Cab_Service/api/drivers/updateDriver`, {
        method: "PUT",
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
                document.getElementById("driver-form").reset();
                fetchDriverData();
            }
        })
    .catch(error => console.error("Error updating driver:", error));
}

function deleteDriver(id) {
    if (confirm("Are you sure you want to delete this driver?")) {
        fetch(`http://localhost:8080/Cab_Service/api/drivers/deleteDriver/${id}`, {
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
                fetchDriverData();
            }
        })
        .catch(error => console.error("Error deleting driver:", error));
    }
}

function loadDriverIntoForm(driver) {
    document.querySelector("input[name='driverID']").value = driver.driverID;
    document.querySelector("input[name='driver_name']").value = driver.driver_name;
    document.querySelector("input[name='license_number']").value = driver.license_number;
    document.querySelector("input[name='contact_number']").value = driver.contact_number;
    document.querySelector("select[name='availability']").value = driver.availability;
}

function getDriverFormData() {
    let driverID = document.querySelector("input[name='driverID']").value.trim();
    
    let driverData = {
        driver_name: document.querySelector("input[name='driver_name']").value.trim(),
        license_number: document.querySelector("input[name='license_number']").value.trim(),
        contact_number: document.querySelector("input[name='contact_number']").value.trim(),
        availability: document.querySelector("select[name='availability']").value
    };

    // Include driverID only if it's present (for updates)
    if (driverID) {
        driverData.driverID = driverID;
    }

    return driverData;
}


//FORM VALIDATION FUNCTION
function validateForm() {
    let driverName = document.querySelector("input[name='driver_name']").value.trim();
    let licenseNumber = document.querySelector("input[name='license_number']").value.trim();
    let contactNumber = document.querySelector("input[name='contact_number']").value.trim();
    
    let valid = true;

    document.querySelectorAll(".error-message").forEach(el => el.remove());

    if (driverName === "" || !/^[A-Za-z\s]+$/.test(driverName)) {
        showError(document.querySelector("input[name='driver_name']"), "Enter a valid name (letters only).");
        valid = false;
    }

    if (!/^[A-Z0-9]{8,12}$/.test(licenseNumber)) {
        showError(document.querySelector("input[name='license_number']"), "Enter a valid license number (8-12 alphanumeric characters).");
        valid = false;
    }

    if (!/^\d{10}$/.test(contactNumber)) {
        showError(document.querySelector("input[name='contact_number']"), "Enter a valid 10-digit contact number.");
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
