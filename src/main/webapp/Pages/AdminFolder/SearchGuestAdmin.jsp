<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.ZzzInn.ZzzInn.Booking" %>
<%@ page import="com.ZzzInn.Database.DatabaseConnector" %>
<%@ include file="../Nav/AdminNav.jsp" %>
<%@ page import="com.ZzzInn.ZzzInnDAO.BookingDAO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ZzzInn.ZzzInn.Guest" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Guest Search</title>
    <style>
        .container {
            margin-left: 250px; 
		    padding: 40px;
		    font-family: 'Cogui', sans-serif;
		    background-image: url('<%= request.getContextPath() %>/Pages/Images/back.jpg');
		    background-size: cover;
		    background-repeat: no-repeat;
		    background-position: center center;
		    height: 100vh;
        }

        h2 {
	        margin-bottom: 20px;
	    	color: #fdfaf0;
       
        }

        form {
            margin-bottom: 30px;
        }

        input[type="text"] {
            padding: 10px;
            width: 300px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .btn {
            padding: 10px 20px;
            background-color: #473c38;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 10px;
        }

        .btn:hover {
            background-color: #5b4a42;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fdfaf0;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ccc;
        }

        th {
            background-color: #eee;
        }
        .table th, .table td {
            vertical-align: middle;
        }
      
    </style>
</head>
<body>
<div class="container">
    <h2>Search Guest</h2>

    <form method="get" action="${pageContext.request.contextPath}/GuestSearchAdmin">
        <input type="text" name="keyword" placeholder="Enter guest name or email..." />
        <input type="submit" class="btn" value="Search" />
        <input type="submit" class="btn" name="showAll" value="Show All Guests" />
    </form>
   
   
    <%
    @SuppressWarnings("unchecked")
        List<Guest> results = (List<Guest>) request.getAttribute("results");
        if (results != null) {
            if (results.isEmpty()) {
    %>
                <p>No results found.</p>
    <%
            } else {
    %>
                <table>
                    <tr>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Room</th>
                        <th>Check-In</th>
                        <th>Check-Out</th>
                    </tr>
    <%
                for (Guest guest : results) {
    %>
                    <tr>
                        <td><%= guest.getFirstName() + " " + guest.getLastName() %></td>
                        <td><%= guest.getEmail() %></td>
                        <td><%= guest.getPhoneNumber() %></td>
                        <td><%= guest.getRoomNumber() %></td>
                        <td><%= guest.getCheckInDate() %></td>
                        <td><%= guest.getCheckOutDate() %></td>
                    </tr>
    <%
                }
    %>
                </table>
    <%
            }
        }
    %>

	<h2>Booking Records</h2>
	<%
	    List<Booking> bookingList = new ArrayList<>();
	    try {
	        Connection conn = DatabaseConnector.getConnection(); 
	        BookingDAO bookingDao = new BookingDAO(conn);
	        bookingList = bookingDao.getAllBookings();
	        request.setAttribute("bookingList", bookingList);
	    } catch (Exception e) {
	        e.printStackTrace(); 
	    }
	%>
	<table class="table table-bordered table-hover mt-3">
    <thead class="thead-light">
        <tr>
            <th>CustomerID</th>
            <th>Name</th>
            <th>CheckInDate</th>
            <th>Phone</th>
            <th>Room (Booked)</th>
            <th>Deposit</th>
            <th>Special Request</th>
            <th>Status</th>
        </tr>
    </thead>
    <%
	    List<Booking> list = (List<Booking>) request.getAttribute("bookingList");
	    if (list != null && !list.isEmpty()) {
	        for (Booking b : list) {
	%>
	    <tr>
	        <td><%= b.getCustomerID() %></td>
	        <td><%= b.getName() %></td>
	        <td><%= b.getCheckInDate() %></td>
	        <td><%= b.getPhone() %></td>
	        <td><%= b.getBookedRoom() %></td>
	        <td><%= b.getDeposit() %></td>
	        <td><%= b.getSpecialRequest() %></td>
	        <td><%= b.getStatus() %></td>
	    </tr>
	<%
	        }
	    } else {
	%>
	    <tr><td colspan="8">No booking records found.</td></tr>
	<%
	    }
	%>
</table>
</div>
</body>
</html>
