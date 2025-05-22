<%@ page import="java.sql.*, java.util.*, com.ZzzInn.Database.DatabaseConnector" %>
<%@ page import="com.ZzzInn.ZzzInnDAO.BookingTrendsDao" %>
<%@ page import="com.ZzzInn.ZzzInn.BookingTrends" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../Nav/AdminNav.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking Trends</title>
    <style>
        html, body {
		    height: 100%;
		    margin: 0;
		    font-family: 'Cogui', sans-serif;
		    background-image: url("../Images/back.jpg");
		    background-size: cover;
		    background-repeat: no-repeat;
		    background-position: center;
		}
		.main-content {
		    margin-left: 220px;
		    padding: 30px;
		    background-color: transparent; /* optional: to make content readable */
        }
        h1 { color: white; }
        h2 { color: #473c38; margin-bottom: 15px; }
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
    <h1>Booking Trends</h1>

    <%
        List<BookingTrends> trends = new ArrayList<>();
        try {
            Connection conn = DatabaseConnector.getConnection();
            BookingTrendsDao dao = new BookingTrendsDao(conn);
            trends = dao.getBookingTrends();
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error fetching booking trends: " + e.getMessage() + "</p>");
        }
    %>

    <div class="report-section">
        <h2>Monthly Booking Trends</h2>
        <table>
            <tr><th>Month</th><th>Total Bookings</th></tr>
            <%
                if (trends != null && !trends.isEmpty()) {
                    for (BookingTrends b : trends) {
            %>
                        <tr>
                            <td><%= b.getMonth() %></td>
                            <td><%= b.getTotalBookings() %></td>
                        </tr>
            <%
                    }
                } else {
            %>
                    <tr><td colspan="2">No booking trend data available.</td></tr>
            <%
                }
            %>
        </table>
    </div>
</div>
</body>
</html>