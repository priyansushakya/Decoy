<%@ page import="java.util.*, com.ZzzInn.ZzzInnDAO.ReceptionistDashboardDAO" %>
<%@ include file="../Nav/ReceptionistNav.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ZzzInn - Receptionist Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: 'Cogui', sans-serif;
            background-image: url("../Images/PhotoJava2.jpg");
            background-size: cover;
            background-repeat: no-repeat;
        }
        .main-content {
            margin-left: 220px;
            padding: 30px;
        }
        h1 {
            color: white;
            font-weight: bold;
        }
        .dashboard-cards {
            display: flex;
            gap: 20px;
            margin-top: 50px;
            flex-wrap: wrap;
        }
        .card {
            flex: 1;
            min-width: 250px;
            background-color: #fdfaf0;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        .card h3 {
            color: #473c38;
            margin-bottom: 10px;
        }
        .value {
            font-size: 28px;
            font-weight: bold;
            color: #473c38;
        }
        .activities-section {
            margin-top: 40px;
        }
        .card table {
            width: 100%;
            margin-top: 10px;
            border-collapse: collapse;
        }
        .card table th, .card table td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ccc;
        }
        footer {
            text-align: center;
            margin-top: 40px;
            font-size: 14px;
            color: #999;
        }
    </style>
</head>
<body>
<div class="main-content">
    <h1>Welcome to Receptionist Dashboard</h1>

    <%
        ReceptionistDashboardDAO dao = new ReceptionistDashboardDAO();
        int totalBookings = dao.getTotalBookings();
        int availableRooms = dao.getAvailableRooms();
        int guestsCheckedIn = dao.getGuestsCheckedIn();
        List<String[]> activities = dao.getRecentActivities();
    %>

    <div class="dashboard-cards">
        <div class="card">
            <h3>Total Bookings</h3>
            <div class="value"><%= totalBookings %></div>
        </div>
        <div class="card">
            <h3>Available Rooms</h3>
            <div class="value"><%= availableRooms %></div>
        </div>
        <div class="card">
            <h3>Guests Checked-in</h3>
            <div class="value"><%= guestsCheckedIn %></div>
        </div>
    </div>

    <div class="activities-section card">
        <h3>Recent Activities</h3>
        <table>
            <tr><th>Activity</th><th>Time</th></tr>
            <%
                if (activities != null && !activities.isEmpty()) {
                    for (String[] row : activities) {
            %>
            <tr>
                <td><%= row[0] %></td>
                <td><%= row[1] %></td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr><td colspan="2">No recent activity available</td></tr>
            <%
                }
            %>
        </table>
    </div>

    <footer>
        &copy; 2025 ZzzInn Hotel. All rights reserved.
    </footer>
</div>
</body>
</html>