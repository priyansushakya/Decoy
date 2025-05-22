<%@ page import="java.sql.*, java.util.*, com.ZzzInn.Database.DatabaseConnector" %>
<%@ page import="com.ZzzInn.ZzzInnDAO.OccupancyReportDao" %>
<%@ page import="com.ZzzInn.ZzzInn.OccupancyReport" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../Nav/AdminNav.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Occupancy Report</title>
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
    <h1>Occupancy Report</h1>

    <%
        List<OccupancyReport> reportList = new ArrayList<>();
        try {
            Connection conn = DatabaseConnector.getConnection();
            OccupancyReportDao dao = new OccupancyReportDao(conn);
            reportList = dao.getOccupancyReport();
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error fetching occupancy report: " + e.getMessage() + "</p>");
        }
    %>

    <div class="report-section">
        <h2>Room Occupancy</h2>
        <table>
            <tr><th>Room Type</th><th>Total Rooms</th><th>Occupied</th><th>Vacant</th></tr>
            <%
                if (reportList != null && !reportList.isEmpty()) {
                    for (OccupancyReport o : reportList) {
            %>
                        <tr>
                            <td><%= o.getRoomType() %></td>
                            <td><%= o.getTotalRooms() %></td>
                            <td><%= o.getOccupied() %></td>
                            <td><%= o.getVacant() %></td>
                        </tr>
            <%
                    }
                } else {
            %>
                    <tr><td colspan="4">No occupancy data available.</td></tr>
            <%
                }
            %>
        </table>
    </div>
</div>
</body>
</html>