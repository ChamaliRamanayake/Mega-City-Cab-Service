document.addEventListener("DOMContentLoaded", function () {
    fetchDriverData();
    document.querySelector(".add").addEventListener("click", handleDriverSubmit);
    document.querySelector(".update").addEventListener("click", updateDriver);
});

function fetchDriverData() {
    fetch("http://localhost:8080/Cab_Service/api/drivers/getAllDrivers")
        .then(response => response.json())
        .then(data => {
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

    let driverId = document.querySelector("input[name='driver_id']").value;

    if (driverId) {
        updateDriver();
    } else {
        addDriver();
    }
}

function addDriver() {
    let driverData = getDriverFormData();

    fetch("http://localhost:8080/Cab_Service/api/drivers/addDriver", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(driverData)
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert("Driver added successfully!");
            document.getElementById("driver-form").reset();
            fetchDriverData();
        } else {
            alert("Error adding driver: " + data.message);
        }
    })
    .catch(error => console.error("Error adding driver:", error));
}

function updateDriver() {
    let driverData = getDriverFormData();

    fetch(`http://localhost:8080/Cab_Service/api/drivers/updateDriver/${driverData.driver_id}`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(driverData)
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert("Driver updated successfully!");
            document.getElementById("driver-form").reset();
            fetchDriverData();
        } else {
            alert("Error updating driver: " + data.message);
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
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert("Driver deleted successfully!");
                fetchDriverData();
            } else {
                alert("Error deleting driver: " + data.message);
            }
        })
        .catch(error => console.error("Error deleting driver:", error));
    }
}

function loadDriverIntoForm(driver) {
    document.querySelector("input[name='driver_id']").value = driver.driverID;
    document.querySelector("input[name='driver_name']").value = driver.driver_name;
    document.querySelector("input[name='license_number']").value = driver.license_number;
    document.querySelector("input[name='contact_number']").value = driver.contact_number;
    document.querySelector("select[name='availability']").value = driver.availability;
}

function getDriverFormData() {
    return {
        driver_id: document.querySelector("input[name='driver_id']").value,
        driver_name: document.querySelector("input[name='driver_name']").value,
        license_number: document.querySelector("input[name='license_number']").value,
        contact_number: document.querySelector("input[name='contact_number']").value,
        availability: document.querySelector("select[name='availability']").value
    };
}


