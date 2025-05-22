<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../Nav/AdminNav.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reports</title>
    <style>
        .main-content {
            margin-left: 220px;
            padding: 30px;
            font-family: 'Segoe UI', sans-serif;
            background-image: url("../Images/PhotoJava2.jpg");
            background-size: cover;
            background-repeat: no-repeat;
        }
        
        h1{
			color: white;        
        }
        h2 {
            color: #473c38;
            margin-bottom: 15px;
        }
        .report-section {
            background-color: #fdfaf0;
            padding: 20px;
            margin-bottom: 30px;
            border-radius: 8px;
            box-shadow: 0 1px 5px rgba(0,0,0,0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px;
        }
        th {
            background-color: #eee;
        }
    </style>
</head>
<body>
<div class="main-content">
    <h1>Reports</h1>

    <div class="report-section">
        <h2>Sales Report</h2>
        <table>
            <tr><th>Date</th><th>Total Sales</th><th>Profit</th></tr>
            <tr><td>2025-05-01</td><td>Rs. 25,000</td><td>Rs. 5,000</td></tr>
            <tr><td>2025-05-02</td><td>Rs. 30,000</td><td>Rs. 6,200</td></tr>
        </table>
    </div>

    <div class="report-section">
        <h2>Occupancy Report</h2>
        <table>
            <tr><th>Room Type</th><th>Total Rooms</th><th>Occupied</th><th>Vacant</th></tr>
            <tr><td>Deluxe</td><td>10</td><td>8</td><td>2</td></tr>
            <tr><td>Standard</td><td>15</td><td>12</td><td>3</td></tr>
        </table>
    </div>

    <div class="report-section">
        <h2>Booking Trends</h2>
        <table>
            <tr><th>Month</th><th>Total Bookings</th></tr>
            <tr><td>April</td><td>240</td></tr>
            <tr><td>May</td><td>310</td></tr>
        </table>
    </div>
</div>
</body>
</html>