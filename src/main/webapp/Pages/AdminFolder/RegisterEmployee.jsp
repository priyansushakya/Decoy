<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Register Receptionist</title>
    <link rel="stylesheet" type="text/css" href="../CSS/RegisterEmployee.css">
    <style>
        .form-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* Wrapper to hold the spinning border */
        .close-btn-wrapper {
		    position: relative;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    width: 40px;
		    height: 40px;
		}

        /* Close button styling */
        .close-btn {
            text-decoration: none;
            font-size: 35px;
            color: #555;
            font-weight: bold;
            cursor: pointer;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 2;
            line-height: 1;
        }

        .close-btn:hover {
            color: black;
        }

        /* Spinning border effect */
        .close-btn-wrapper::before {
		    content: '';
		    position: absolute;
		    width: 40px;
		    height: 40px;
		    border: 2px solid transparent;
		    border-radius: 50%;
		    z-index: 1;
		    transform: rotate(0deg);
		    transition: transform 0.6s ease;
		    opacity: 0; /* initially hidden */
		}
		
		.close-btn-wrapper:hover::before {
		    border-top: 2px solid black;
		    transform: rotate(360deg);
		    opacity: 1; /* becomes visible only on hover */
		}

    </style>
    <script>
        function validateForm() {
            const firstName = document.getElementById("firstName").value.trim();
            const lastName = document.getElementById("lastName").value.trim();
            const username = document.getElementById("username").value.trim();
            const email = document.getElementById("email").value.trim();
            const phone = document.getElementById("phone").value.trim();
            const password = document.getElementById("password").value;
            const profileImage = document.getElementById("profileImage").value;
            const role = document.getElementById("role").value.trim();
            const salary = document.getElementById("salary").value.trim();
            const joinedDate = document.getElementById("joinedDate").value.trim();

            if (!firstName) {
                alert("First Name is required.");
                return false;
            }
            if (!/^[a-zA-Z\s]+$/.test(firstName)) {
                alert("First Name can only contain letters.");
                return false;
            }

            if (!lastName) {
                alert("Last Name is required.");
                return false;
            }
            if (!/^[a-zA-Z\s]+$/.test(lastName)) {
                alert("Last Name can only contain letters.");
                return false;
            }

            if (!username) {
                alert("Username is required.");
                return false;
            }
            if (!/^[a-zA-Z0-9_]{4,}$/.test(username)) {
                alert("Username must be at least 4 characters and contain only letters, numbers, or underscores.");
                return false;
            }

            if (!email) {
                alert("Email is required.");
                return false;
            }
            const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-z]{2,4}$/;
            if (!emailPattern.test(email)) {
                alert("Please enter a valid email address.");
                return false;
            }

            if (!phone) {
                alert("Phone number is required.");
                return false;
            }
            const phonePattern = /^[0-9]{7,15}$/;
            if (!phonePattern.test(phone)) {
                alert("Phone number must be numeric and between 7 to 15 digits.");
                return false;
            }

            if (!password) {
                alert("Password is required.");
                return false;
            }
            if (password.length < 6) {
                alert("Password must be at least 6 characters long.");
                return false;
            }

            if (!role) {
                alert("Please select a role.");
                return false;
            }

            if (!salary) {
                alert("Salary is required.");
                return false;
            }
            const salaryValue = parseFloat(salary);
            if (isNaN(salaryValue) || salaryValue <= 0) {
                alert("Please enter a valid positive salary!");
                return false;
            }

            if (!joinedDate) {
                alert("Joined Date is required.");
                return false;
            }
            const today = new Date().toISOString().split("T")[0];
            if (joinedDate > today) {
                alert("Joined date cannot be in the future.");
                return false;
            }

            if (!profileImage) {
                alert("Profile image is required.");
                return false;
            }

            return confirm("Are you sure you want to register this receptionist?");
        }
    </script>
</head>
<body>

<div class="form-container">
    <div class="form-header">
        <h2>Employee Registration</h2>
        <div class="close-btn-wrapper">
            <a href="manageRecep.jsp" class="close-btn" title="Close">&times;</a>
        </div>
    </div>

    <form onsubmit="return validateForm()" action="../../RegisterEmployee" method="post" enctype="multipart/form-data">

        <div class="form-row">
            <div class="input-container">
                <label for="firstName">First Name:</label>
                <input type="text" name="firstName" id="firstName">
            </div>
            <div class="input-container">
                <label for="lastName">Last Name:</label>
                <input type="text" name="lastName" id="lastName">
            </div>
        </div>

        <div class="form-row">
            <div class="input-container">
                <label for="username">Username:</label>
                <input type="text" name="username" id="username">
            </div>
            <div class="input-container">
                <label for="email">Email:</label>
                <input type="email" name="email" id="email">
            </div>
        </div>

        <div class="form-row">
            <div class="input-container">
                <label for="phone">Phone:</label>
                <input type="text" name="phone" id="phone">
            </div>
            <div class="input-container">
                <label for="password">Password:</label>
                <input type="password" name="password" id="password">
            </div>
        </div>

        <div class="form-row">
            <div class="input-container">
                <label for="role">Role:</label>
                <select name="role" id="role">
                    <option value="">-- Select Role --</option>
                    <option value="intern">Intern</option>
                    <option value="receptionist">Receptionist</option>
                    <option value="admin">Admin</option>
                </select>
            </div>
            <div class="input-container">
                <label for="salary">Salary:</label>
                <input type="text" name="salary" id="salary">
            </div>
        </div>

        <div class="form-row">
            <div class="input-container">
                <label for="joinedDate">Joined Date:</label>
                <input type="date" name="joinedDate" id="joinedDate">
            </div>
            <div class="input-container">
                <label for="profileImage">Upload Image:</label>
                <input type="file" name="profileImage" id="profileImage" accept="image/*">
            </div>
        </div>

        <input type="submit" value="Register">
    </form>
</div>

</body>
</html>
