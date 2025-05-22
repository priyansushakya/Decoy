<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../Nav/ReceptionistNav.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Receptionist Profile</title>
    <style>
        body {
            margin: 0;
            font-family: 'Cogui', sans-serif;
            background-image: url("../Images/PhotoJava2.jpg");
            background-size: cover;
            background-attachment: fixed;
        }

        .profile-container {
            margin-left: 250px;
            padding: 80px 30px;
        }

        .card {
            width: 600px;
            margin: auto;
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 10px;
            padding: 40px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
        }

        #profile-wrapper .card {
            display: none;
        }

        #profile-wrapper .card.active {
            display: block;
        }

        .profile-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .profile-header img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #ccc;
            margin-bottom: 15px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            text-align: left;
            width: 35%;
            padding: 10px;
            background-color: #f3f3f3;
            font-weight: 600;
        }

        td {
            padding: 10px;
            color: #333;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .btn {
            margin-top: 20px;
            padding: 10px 25px;
            background-color: #473c38;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #5b4a42;
        }

        .btns {
            text-align: center;
            margin-top: 25px;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5);
        }

        .modal-content {
            background-color: #fff;
            margin: 10% auto;
            padding: 30px;
            border-radius: 10px;
            width: 400px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        }

        .close {
            float: right;
            font-size: 24px;
            font-weight: bold;
            cursor: pointer;
        }

        .error-msg {
            color: red;
            text-align: center;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .success-msg {
            color: green;
            text-align: center;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .toggle-password {
            cursor: pointer;
            font-size: 14px;
            margin-top: 5px;
            display: block;
        }

        #phone-error {
            color: red;
            font-size: 13px;
            display: block;
        }
    </style>

    <script>
        function toggleEdit() {
            document.getElementById("profile-display").classList.remove("active");
            document.getElementById("profile-edit").classList.add("active");
        }

        function cancelEdit() {
            document.getElementById("profile-edit").classList.remove("active");
            document.getElementById("profile-display").classList.add("active");
        }

        function previewImage(input) {
            const preview = document.getElementById("recep-img");
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

        function openModal() {
            document.getElementById("passwordModal").style.display = "block";
        }

        function closeModal() {
            document.getElementById("passwordModal").style.display = "none";
        }

        function toggleVisibility(id) {
            const field = document.getElementById(id);
            field.type = field.type === "password" ? "text" : "password";
        }

        function validatePhone() {
            const phoneInput = document.getElementById("phone");
            const phoneError = document.getElementById("phone-error");
            const phoneRegex = /^\d{10,15}$/;
            if (!phoneRegex.test(phoneInput.value)) {
                phoneError.textContent = "Phone number must be 10 to 15 digits.";
                return false;
            } else {
                phoneError.textContent = "";
                return true;
            }
        }

        window.onload = function() {
            const phoneInput = document.getElementById("phone");
            phoneInput.addEventListener("input", validatePhone);
        };
    </script>
</head>
<body>
<div class="profile-container">
    <div id="profile-wrapper">
        <!-- Display Mode -->
        <div class="card active" id="profile-display">
            <c:if test="${not empty errorMsg}">
                <div class="error-msg">${errorMsg}</div>
            </c:if>
            <c:if test="${not empty successMsg}">
                <div class="success-msg">${successMsg}</div>
                <c:remove var="successMsg" scope="session" />
            </c:if>

            <div class="profile-header">
                <img src="${pageContext.request.contextPath}/${sessionScope.loggedInUser.imagePath}" id="recep-img" alt="Profile Picture">
                <h2>Receptionist Profile</h2>
            </div>
            <table>
                <tr><th>Full Name</th><td>${sessionScope.loggedInUser.firstName} ${sessionScope.loggedInUser.lastName}</td></tr>
                <tr><th>Username</th><td>${sessionScope.loggedInUser.username}</td></tr>
                <tr><th>Email</th><td>${sessionScope.loggedInUser.email}</td></tr>
                <tr><th>Phone Number</th><td>${sessionScope.loggedInUser.phone}</td></tr>
                <tr><th>Role</th><td>${sessionScope.loggedInUser.role}</td></tr>
                <tr><th>Joined Date</th><td>${sessionScope.loggedInUser.joinedDate}</td></tr>
            </table>
            <div class="btns">
                <button class="btn" onclick="toggleEdit()">Edit</button>
                <button class="btn" onclick="openModal()">Change Password</button>
            </div>
        </div>

        <!-- Edit Mode -->
        <div class="card" id="profile-edit">
            <form action="${pageContext.request.contextPath}/ReceptionistProfileUpdate" method="post" enctype="multipart/form-data" onsubmit="return validatePhone()">
                <div class="profile-header">
                    <img src="${pageContext.request.contextPath}/${sessionScope.loggedInUser.imagePath}" id="recep-img" alt="Profile Picture">
                    <input type="file" name="profileImage" onchange="previewImage(this)">
                    <h2>Edit Profile</h2>
                </div>
                <table>
                    <tr><th>First Name</th><td><input type="text" name="firstName" value="${sessionScope.loggedInUser.firstName}" required></td></tr>
                    <tr><th>Last Name</th><td><input type="text" name="lastName" value="${sessionScope.loggedInUser.lastName}" required></td></tr>
                    <tr><th>Username</th><td><input type="text" name="username" value="${sessionScope.loggedInUser.username}" required></td></tr>
                    <tr><th>Email</th><td><input type="email" name="email" value="${sessionScope.loggedInUser.email}" required></td></tr>
                    <tr>
                        <th>Phone</th>
                        <td>
                            <input type="text" id="phone" name="phone" value="${sessionScope.loggedInUser.phone}" required
                                   pattern="^\d{10,15}$" title="Phone number must be 10 to 15 digits.">
                            <span id="phone-error"></span>
                        </td>
                    </tr>
                    <tr><th>Joined Date</th><td><input type="text" value="${sessionScope.loggedInUser.joinedDate}" readonly></td></tr>
                </table>
                <div class="btns">
                    <button type="submit" class="btn">Save</button>
                    <button type="button" class="btn" onclick="cancelEdit()">Back</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Password Change Modal -->
<div id="passwordModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h2 style="text-align:center;">Change Password</h2>
        <form action="${pageContext.request.contextPath}/ReceptionistProfileUpdate" method="post">
            <input type="hidden" name="email" value="${sessionScope.loggedInUser.email}">
            <label>Current Password</label>
            <input type="password" name="currentPassword" id="currentPassword" required>
            <span class="toggle-password" onclick="toggleVisibility('currentPassword')">👁 Show</span>

            <label>New Password</label>
            <input type="password" name="newPassword" id="newPassword" required>
            <span class="toggle-password" onclick="toggleVisibility('newPassword')">👁 Show</span>

            <label>Confirm Password</label>
            <input type="password" name="confirmPassword" id="confirmPassword" required>
            <span class="toggle-password" onclick="toggleVisibility('confirmPassword')">👁 Show</span>

            <div class="btns">
                <button type="submit" class="btn">Save Password</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
