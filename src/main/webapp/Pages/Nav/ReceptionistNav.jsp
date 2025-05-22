<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Header/NavBar-Receptionist</title>
    <style>
        body {
            margin: 0;
            font-family: 'Cogui', sans-serif;
            background-color: #473c38;
        }

        .header {
            width: 240px;
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
            background-color: #f0e6d2;
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
    </style>
    
    <script>
    function confirmLogout() {
        if (confirm("Do you want to logout?")) {
            window.location.href = '<%= request.getContextPath() %>/LogOutServlet';
        }
    }
    </script>
</head>
<body>
<%
    String uri = request.getRequestURI();
%>

<div class="top-right-header">
    <div class="user-info">
        <span class="welcome-text">
            Welcome, <c:out value="${sessionScope.loggedInUser.firstName}"/> <c:out value="${sessionScope.loggedInUser.lastName}"/>
        </span>
        <img src="${pageContext.request.contextPath}/${sessionScope.loggedInUser.imagePath}" alt="Profile" class="profile-pic" />
        <img src="<%= request.getContextPath() %>/Pages/Images/LOGO.png" alt="Logo" class="logo" />
    </div>
</div>

<div class="header">
    <h2>Receptionist Panel</h2>
    <a href="<%= request.getContextPath() %>/Pages/Receptionist/ReceptionistDashBoard.jsp" class="<%= uri.contains("ReceptionistDashBoard.jsp") ? "active" : "" %>">Dashboard</a>
    <a href="<%= request.getContextPath() %>/Pages/Receptionist/viewRoom.jsp" class="<%= uri.contains("viewRoom.jsp") ? "active" : "" %>">View Room</a>
    <a href="<%= request.getContextPath() %>/Pages/Receptionist/ConfirmRoom.jsp" class="<%= uri.contains("ConfirmRoom.jsp") ? "active" : "" %>">Make New Booking</a>
    <a href="<%= request.getContextPath() %>/Pages/Receptionist/SearchGuest.jsp" class="<%= uri.contains("SearchGuest.jsp") ? "active" : "" %>">Search Guest</a>
    <a href="<%= request.getContextPath() %>/Pages/Receptionist/ReceptionistProfile.jsp" class="<%= uri.contains("ReceptionistProfile.jsp") ? "active" : "" %>">Receptionist Profile</a>
    <a href="#" onclick="confirmLogout()">Logout</a>
</div>

</body>
</html>