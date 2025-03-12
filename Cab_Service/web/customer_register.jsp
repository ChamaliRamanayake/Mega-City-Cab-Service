<%-- 
    Document   : customer_register
    Created on : Feb 14, 2025, 11:39:28 AM
    Author     : 94775
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Registration</title>
    <link rel="stylesheet" type="text/css" href="css/customer_registerPage.css">
    <script>
async function hashPassword(password) {
    const encoder = new TextEncoder();
    const data = encoder.encode(password);
    const hashBuffer = await crypto.subtle.digest("SHA-256", data);
    const hashArray = Array.from(new Uint8Array(hashBuffer));
    return hashArray.map(byte => byte.toString(16).padStart(2, "0")).join("");
}

function validateForm() {
    let fname = document.querySelector("input[name='fname']").value.trim();
    let lname = document.querySelector("input[name='lname']").value.trim();
    let address = document.querySelector("input[name='address']").value.trim();
    let email = document.querySelector("input[name='email']").value.trim();
    let telephone = document.querySelector("input[name='telephone']").value.trim();
    let username = document.querySelector("input[name='username']").value.trim();
    let password = document.querySelector("input[name='password']").value;
    let confirmPassword = document.querySelector("input[name='confirm_password']").value;

    // Check for empty fields
    if (!fname || !lname || !address || !email || !telephone || !username || !password || !confirmPassword) {
        alert("All fields are required.");
        return false;
    }

    // Validate email format
    let emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(email)) {
        alert("Enter a valid email address.");
        return false;
    }

    // Validate telephone (must be exactly 10 digits)
    let phonePattern = /^\d{10}$/;
    if (!phonePattern.test(telephone)) {
        alert("Enter a valid 10-digit mobile number.");
        return false;
    }

    // Check if passwords match
    if (password !== confirmPassword) {
        alert("Passwords do not match!");
        return false;
    }

    return true;
}

async function registerCustomer(event) {
    event.preventDefault();  // Prevent default form submission

    if (!validateForm()) return;

    let password = document.querySelector("input[name='password']").value;
    let hashedPassword = await hashPassword(password); // Hash the password

    // Collect form data
    let customerData = {
        fname: document.querySelector("input[name='fname']").value.trim(),
        lname: document.querySelector("input[name='lname']").value.trim(),
        address: document.querySelector("input[name='address']").value.trim(),
        email: document.querySelector("input[name='email']").value.trim(),
        telephone: document.querySelector("input[name='telephone']").value.trim(),
        username: document.querySelector("input[name='username']").value.trim(),
        password: hashedPassword, // Store hashed password
    };

    fetch("http://localhost:8080/Cab_Service/api/customers/addCustomer", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(customerData)
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.text(); 
    })
    .then(data => {
        try {
            const jsonData = JSON.parse(data);
            console.log("JSON Response:", jsonData);
            alert("Registration successful!");
            window.location.href = "customer_login.jsp";
        } catch (e) {
            console.log("Text Response:", data);
            alert(data);
            document.getElementById("registerForm").reset();
        }
    })
    .catch(error => {
        console.error("Error registering customer:", error);
        alert("There was an error during registration.");
    });
}

    </script>
</head>
<body>
    <div class="register-container">
        <h2>Register</h2>
        
        <%-- Display error or success message --%>
        <% if (request.getParameter("error") != null) { %>
            <p style="color:red;">Registration failed. Please try again.</p>
        <% } %>

        <form id="registerForm" onsubmit="registerCustomer(event)">
            <div class="form-row">
                <div class="form-group">
                    <label>First Name</label>
                    <input type="text" name="fname" required>
                </div>
                <div class="form-group">
                    <label>Last Name</label>
                    <input type="text" name="lname" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Address</label>
                    <input type="text" name="address" required>
                </div>
                <div class="form-group">
                    <label>email</label>
                    <input type="email" name="email" required>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label>Mobile</label>
                    <input type="text" name="telephone" required>
                </div>
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" required>
                </div>
                <div class="form-group">
                    <label>Confirm Password</label>
                    <input type="password" name="confirm_password" required>
                </div>
            </div>

            <button type="submit">Register</button>
        </form>

        <p>Already have an account? <a href="login.jsp">Login here</a></p>
    </div>
</body>
</html>



