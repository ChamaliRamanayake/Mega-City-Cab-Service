/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

function fetchCustomerData() {
            fetch("http://localhost:8080/Cab_Service/api/customers/getAllCustomers")
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`HTTP error! Status: ${response.status}`);
                    }
                    return response.json();
                })
                .then(data => {
                    console.log("API Response:", data); // Debugging: Check API response format

                    let customers = Array.isArray(data) ? data : (data.customers || []);
                    if (!Array.isArray(customers)) {
                        throw new Error("Invalid API response format");
                    }

                    let tableBody = document.getElementById("customer-table-body");
                    let rows = "";
                    tableBody.innerHTML = ""; // Clear previous content

                    customers.forEach(customer => {
                        console.log("Customer Object:", customer); // Debugging each customer

                        let customer_id = customer.customer_id ? customer.customer_id : "N/A";
                        let Fname = customer.fname ? customer.fname : "N/A";
                        let lname = customer.lname ? customer.lname : "N/A";
                        let address = customer.address ? customer.address : "N/A";
                        let email = customer.email ? customer.email : "N/A";
                        let telephone = customer.telephone ? customer.telephone : "N/A";
                        let Username = customer.username ? customer.username : "N/A";

                        rows += "<tr>" +
                            "<td>" + customer_id + "</td>" +
                            "<td>" + Fname + " " +lname+"</td>" +
                            "<td>" + address + "</td>" +
                            "<td>" + email + "</td>" +
                            "<td>" + telephone + "</td>" +
                            "<td>" + Username + "</td>" +
                            "<td><button>Edit</button> <button>Delete</button></td>" +
                            "</tr>";
                    });

                    tableBody.innerHTML = rows;
                })
                .catch(error => console.error("Error fetching customer data:", error));
        }

        window.onload = fetchCustomerData;
