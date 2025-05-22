<%@ page import="java.sql.*, java.util.*, com.ZzzInn.Database.DatabaseConnector" %>
<%@ page import="com.ZzzInn.ZzzInnDAO.SalesReportDao" %>
<%@ page import="com.ZzzInn.ZzzInn.SalesReport" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../Nav/AdminNav.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sales Reports</title>
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
    <h1>Sales Report</h1>

    <%
        List<SalesReport> salesList = new ArrayList<>();
        try {
            Connection conn = DatabaseConnector.getConnection();
            SalesReportDao dao = new SalesReportDao(conn);
            salesList = dao.getSalesReport();
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error fetching sales report: " + e.getMessage() + "</p>");
        }
    %>

    <div class="report-section">
        <h2>Monthly Sales</h2>
        <table>
            <tr><th>Month</th><th>Total Sales</th></tr>
            <%
                if (salesList != null && !salesList.isEmpty()) {
                    for (SalesReport s : salesList) {
            %>
                        <tr>
                            <td><%= s.getMonth() %></td>
                            <td>Rs. <%= s.getTotalSales() %></td>
                        </tr>
            <%
                    }
                } else {
            %>
                    <tr><td colspan="2">No sales report data available.</td></tr>
            <%
                }
            %>
        </table>
    </div>
</div>
</body>
</html>