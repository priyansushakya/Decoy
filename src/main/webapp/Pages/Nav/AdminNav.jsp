<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Header/NavBar-Admin</title>
    <style>
        body {
            margin: 0;
            font-family: 'Cogui', sans-serif;
            background-color: #473c38;
        }

        .header {
            width: 220px;
            background-color: #fdfaf0;
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            padding-top: 20px;
        }

        .header h2 {
            color: #473c38;
            text-align: center;
            margin-bottom: 20px;
        }

        .header a {
            display: block;
            padding: 12px 20px;
            color: #473c38;
            text-decoration: none;
            transition: background 0.3s;
        }

        .header a:hover {
            background-color: #FCF4D7;
        }

        .header a.active {
            font-weight: bold;
            border-bottom: 3px solid #473c38;
            background-color: #FCF4D7;
        }

        .top-right-header {
            position: absolute;
            top: 10px;
            right: 20px;
            z-index: 1000;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 12px;
            color: white;
        }

        .welcome-text {
            font-weight: bold;
        }

        .profile-pic {
            height: 40px;
            width: 40px;
            border-radius: 50%;
            object-fit: cover;
        }

        .logo {
            width: 90px;
            height: auto;
        }

        .dropdown {
            position: relative;
        }

        .dropdown-btn::after {
            font-size: 12px;
        }

        .dropdown-content {
            display: none;
            flex-direction: column;
            background-color: #fdfaf0;
            position: relative;
            padding-left: 20px;
            z-index: 10;
        }

        .dropdown-content.show {
            display: flex;
        }
    </style>

    <script>
        function confirmLogout() {
            if (confirm("Do you want to logout?")) {
                window.location.href = '<%= request.getContextPath() %>/LogOutServlet';
            }
        }

        document.addEventListener('DOMContentLoaded', function () {
            const dropdownBtn = document.querySelector('.dropdown-btn');
            const dropdownContent = document.querySelector('.dropdown-content');

            if (dropdownBtn) {
                dropdownBtn.addEventListener('click', function (e) {
                    e.preventDefault();
                    dropdownContent.classList.toggle('show');
                });

                document.addEventListener('click', function (e) {
                    if (!dropdownBtn.contains(e.target) && !dropdownContent.contains(e.target)) {
                        dropdownContent.classList.remove('show');
                    }
                });
            }
        });
    </script>
</head>
<body>
<%
    String uri = request.getRequestURI();
    boolean isReportPage = uri.contains("SalesReport.jsp") || uri.contains("OccupancyReport.jsp") || uri.contains("BookingTrends.jsp");
%>

<div class="top-right-header">
    <div class="user-info">
        <span class="welcome-text">
            Welcome, <c:out value="${sessionScope.loggedInUser.firstName}"/> <c:out value="${sessionScope.loggedInUser.lastName}"/>
        </span>
        <img src="${pageContext.request.contextPath}/${sessionScope.loggedInUser.imagePath}" alt="Profile" class="profile-pic" />
        <img src="../Images/LOGO.png" alt="ZzzInn Logo" class="logo" />
    </div>
</div>

<div class="header">
    <h2>Admin Panel</h2>
    <a href="<%= request.getContextPath() %>/Pages/AdminFolder/AdminDashBoard.jsp" class="<%= uri.contains("AdminDashBoard.jsp") ? "active" : "" %>">Dashboard</a>
    <a href="<%= request.getContextPath() %>/Pages/AdminFolder/manageRecep.jsp" class="<%= uri.contains("manageRecep.jsp") ? "active" : "" %>">Manage Receptionist</a>
    <a href="<%= request.getContextPath() %>/Pages/AdminFolder/manageRooms.jsp" class="<%= uri.contains("manageRooms.jsp") ? "active" : "" %>">Manage Rooms</a>
    <a href="<%= request.getContextPath() %>/Pages/AdminFolder/SearchGuestAdmin.jsp" class="<%= uri.contains("SearchGuestAdmin.jsp") ? "active" : "" %>">Bookings Records</a>

    <div class="dropdown">
        <a href="#" class="dropdown-btn">Reports</a>
        <div class="dropdown-content <%= isReportPage ? "show" : "" %>">
            <a href="<%= request.getContextPath() %>/Pages/AdminFolder/SalesReport.jsp" class="<%= uri.contains("SalesReport.jsp") ? "active" : "" %>">Sales Report</a>
            <a href="<%= request.getContextPath() %>/Pages/AdminFolder/OccupancyReport.jsp" class="<%= uri.contains("OccupancyReport.jsp") ? "active" : "" %>">Occupancy Report</a>
            <a href="<%= request.getContextPath() %>/Pages/AdminFolder/BookingTrends.jsp" class="<%= uri.contains("BookingTrends.jsp") ? "active" : "" %>">Booking Trends</a>
        </div>
    </div>

    <a href="<%= request.getContextPath() %>/Pages/AdminFolder/AdminProfile.jsp" class="<%= uri.contains("AdminProfile.jsp") ? "active" : "" %>">Admin Profile</a>
    <a href="#" onclick="confirmLogout()">Logout</a>
</div>

</body>
</html>
