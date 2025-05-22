<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../Nav/ReceptionistNav.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking Records - ZzzInn</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-image: url("../Images/PhotoJava2.jpg");
            background-size: cover;
            background-repeat: no-repeat;
        }

        .main-content {
            margin-left: 220px;
            padding: 40px;
            margin-top: 0px;
        }

        h1 {
            color: #473c38;
            margin-bottom: 20px;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .add-btn {
            background-color: #473c38;
            color: white;
            padding: 10px 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            font-size: 14px;
            text-decoration: none;
        }

        .add-btn:hover {
            background-color: #5b4a42;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px 16px;
            border-bottom: 1px solid #ddd;
            text-align: left;
            color: #333;
        }

        th {
            background-color: #fcefcf;
            color: #473c38;
        }

        tr:hover {
            background-color: #f9f3e7;
        }
    </style>
</head>
<body>
<div class="main-content">
    <div class="top-bar">
        <h1>Booking Records</h1>
        <a href="booking_form.jsp" class="add-btn">+ Add Booking</a>
    </div>

    <table>
        <tr>
            <th>Guest Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Room No.</th>
            <th>Room Type</th>
            <th>Check-In</th>
            <th>Check-Out</th>
        </tr>
        <tr>
            <td>Sita Sharma</td>
            <td>sita@example.com</td>
            <td>9801234567</td>
            <td>102</td>
            <td>Deluxe</td>
            <td>2025-05-12</td>
            <td>2025-05-14</td>
        </tr>
        <tr>
            <td>Ramesh Thapa</td>
            <td>ramesh@gmail.com</td>
            <td>9800001122</td>
            <td>105</td>
            <td>Standard</td>
            <td>2025-05-11</td>
            <td>2025-05-13</td>
        </tr>
        <tr>
            <td>Priya Karki</td>
            <td>priya@zzz.com</td>
            <td>9801112233</td>
            <td>108</td>
            <td>Suite</td>
            <td>2025-05-10</td>
            <td>2025-05-15</td>
        </tr>
        <tr>
            <td>Manish Dahal</td>
            <td>manish@mail.com</td>
            <td>9812345678</td>
            <td>201</td>
            <td>Standard</td>
            <td>2025-05-09</td>
            <td>2025-05-12</td>
        </tr>
        <tr>
            <td>Rekha Gurung</td>
            <td>rekha@gurung.com</td>
            <td>9807654321</td>
            <td>204</td>
            <td>Deluxe</td>
            <td>2025-05-13</td>
            <td>2025-05-16</td>
        </tr>
    </table>
</div>
</body>
</html>