function fetchBookingData() {
            fetch("http://localhost:8080/Cab_Service/api/bookings/getAllBookings")
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`HTTP error! Status: ${response.status}`);
                    }
                    return response.json();
                })
                .then(data => {
                    console.log("API Response:", data); // Debugging: Check API response format

                    let bookings = Array.isArray(data) ? data : (data.bookings || []);
                    if (!Array.isArray(bookings)) {
                        throw new Error("Invalid API response format");
                    }

                    let tableBody = document.getElementById("view-booking-table");
                    let rows = "";
                    tableBody.innerHTML = ""; // Clear previous content

                    bookings.forEach(booking => {
                        console.log("booking Object:", booking); 

                        let booking_id = booking.booking_id ? booking.booking_id : "N/A";
                        let customer_id = booking.customer_id ? booking.customer_id : "N/A";
                        let vehicle_id = booking.vehicle_id ? booking.vehicle_id : "N/A";
                        let destination = booking.destination ? booking.destination : "N/A";
                        let bookingDate = booking.bookingDate ? booking.bookingDate : "N/A";
                        let amount = booking.amount ? booking.amount : "N/A";
                        let status = booking.status ? booking.status : "N/A";


                        rows += "<tr>" +
                            "<td>" +booking_id + "</td>" +
                            "<td>" + customer_id +"</td>" +
                            "<td>" + vehicle_id +"</td>" +
                            "<td>" + destination +"</td>" +
                            "<td>" + bookingDate +"</td>" +
                            "<td>" + amount +"</td>" +
                            "<td>" + status +"</td>" +
                            "<td><button>Delete</button></td>" +
                            "</tr>";
                    });

                    tableBody.innerHTML = rows;
                })
                .catch(error => console.error("Error fetching booking data:", error));
        }

        window.onload = fetchBookingData;

