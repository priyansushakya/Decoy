<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.ZzzInn.ZzzInnDAO.ZzzInnDAO, com.ZzzInn.ZzzInn.AddRoom, com.ZzzInn.ZzzInn.Room" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Room Availability</title>
  <style>
  /* your CSS from static file remains unchanged */
  * { box-sizing: border-box; }
  body {
    font-family: 'Cogui', sans-serif;
    background-color: #fdfaf0;
    margin: 0;
    padding: 0;
  }
  .container {
      max-width: 1400px;
      margin: auto;
      padding: 20px;
      margin-left: 265px;
    }
    h1 {
      text-align: center;
      font-size: 30px;
      margin-bottom: 40px;
      color: white;
    }
    .category {
      margin-bottom: 50px;
    }
    .category h2 {
      font-size: 28px;
      color: white;
      margin-bottom: 25px;
    }
    hr {
      border: none;
      height: 2px;
      background-color: white;
      margin: 30px 0;
      width: 100%;
    }
    .room-flex {
      display: flex;
      flex-wrap: wrap;
      justify-content: flex-start; /* Align items to the left */
      gap: 15px;
    }
    .room-card {
      width: 32%;
      height: 475px;
      background-color: #fff;
      border-radius: 10px;
      padding: 15px;
      margin-bottom: 30px;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
    .room-card img {
      width: 100%;
      height: 300px;
      object-fit: cover;
      border-radius: 8px;
      margin-bottom: 15px;
    }
    .room-card h3 {
      margin: 5px 0;
      font-size: 20px;
    }
    .room-card p {
      color: #777;
      margin-bottom: 15px;
    }
    .room-card button {
      background-color: #473c38;
      color: #fdfaf0;
      border: none;
      padding: 10px 20px;
      border-radius: 25px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }
    .moreBtn{
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
    }
    .room-card button:hover {
      background-color: #64544e;
    }
    .top-buttons {
      display: flex;
      justify-content: flex-start;
      gap: 15px;
      margin-bottom: 30px;
    }
    .room-info {
	  display: flex;
	  justify-content: space-between;
	  align-items: center;
	  margin-bottom: 15px;
	}
	.room-info p {
	  margin: 0;
	  color: #777;
	  font-size: 16px;
	}
    .status-badge {
	  display: inline-block;
	  max-width: fit-content; /* shrink-wrap width */
	  padding: 6px 12px;
	  font-weight: bold;
	  border-radius: 12px;
	  font-size: 0.9rem;
	  margin-right: 20px;
	}
	.status-badge.booked {
	  background-color: #e74c3c; /* red */
	  color: white;
	}
	.status-badge.available {
	  background-color: #27ae60; /* green */
	  color: white;
	}
    .btn {
      padding: 10px 20px;
      border: none;
      border-radius: 25px;
      background-color: red;
      color: #fdfaf0;
      cursor: pointer;
      font-size: 16px;
      transition: all 0.3s ease;
      box-shadow: 0 2px 5px rgba(0,0,0,0.2);
      text-decoration: none;
    }
    .btn:hover {
      transform: scale(1.08);
    }
    .status-controls {
	  display: flex;
	  align-items: center;
	  gap: 10px;
	}
	
	.status-controls form {
	  margin: 0;
	}

.status-controls select {
  padding: 6px 10px;
  font-size: 14px;
  border-radius: 6px;
  border: 1px solid #ccc;
}
    
    
    @media (max-width: 992px) {
      .room-card { width: 48%; }
    }
    @media (max-width: 600px) {
      .room-card { width: 100%; }
    }
  </style>
</head>
<body>

<%@ include file="../Nav/ReceptionistNav.jsp" %>

<%
    ZzzInnDAO dao = new ZzzInnDAO();
    List<AddRoom> rooms = dao.getAllRooms1();
    String[] categories = { "Single", "Double", "Suite" };
%>

<div class="container">
  <h1>Manage Rooms</h1> 

   <!-- SINGLE ROOMS -->
<div class="category">
    <h2>Single Rooms</h2>
    <hr>
    <div class="room-flex">
        <%  
            for (AddRoom singleRoom : rooms) {
                if (singleRoom.getRoomType().equalsIgnoreCase("Single")) {
                    String roomNumber = singleRoom.getRoomNumber();
                    String status = "Available";
                    List<Room> roomList = dao.getAllRooms();
                    for (Room r : roomList) {
                        if (r.getRoomNumber().equals(roomNumber)) {
                            status = r.getStatus();
                            break;
                        }
                    }
                    boolean booked = "booked".equalsIgnoreCase(status);
        %>
        <div class="room-card">
            <img
                src="<%= request.getContextPath() + "/" + singleRoom.getImagePath() %>"
                alt="<%= singleRoom.getRoomNumber() %>">
            <h3><%= singleRoom.getRoomNumber() %></h3>
            <div class="room-info">
			  <p><%= singleRoom.getRoomType() %></p>
			  <div class="status-controls">
			    <div class="status-badge <%= booked ? "booked" : "available" %>">
			      <%= booked ? "Booked" : "Available" %>
			    </div>
			    <form action="${pageContext.request.contextPath}/RoomController" method="post">
			      <input type="hidden" name="action" value="updateStatus" />
			      <input type="hidden" name="roomNumber" value="<%= singleRoom.getRoomNumber() %>" />
			      <select name="newStatus" onchange="this.form.submit()">
			        <option value="notBooked" <%= !booked ? "selected" : "" %>>Available</option>
			        <option value="booked" <%= booked ? "selected" : "" %>>Booked</option>
			      </select>
			    </form>
			  </div>
			</div>

            <div class="moreBtn">
                <a href="ConfirmRoom.jsp?roomId=<%= singleRoom.getRoomNumber() %>">
                    <button <%= booked ? "disabled" : "" %>>
                        <%= booked ? "Booked" : "Book Now" %>
                    </button>
                </a>
            </div>
        </div>
        <%
                }
            }
        %>
    </div>
</div>

		<!-- Deluxe ROOMS -->
<div class="category">
    <h2>Deluxe Rooms</h2>
    <hr>
    <div class="room-flex">
        <%  
            for (AddRoom deluxeRoom : rooms) {
                if (deluxeRoom.getRoomType().equalsIgnoreCase("Deluxe")) {
                    String roomNumber = deluxeRoom.getRoomNumber();
                    String status = "Available";
                    List<Room> roomList = dao.getAllRooms();
                    for (Room r : roomList) {
                        if (r.getRoomNumber().equals(roomNumber)) {
                            status = r.getStatus();
                            break;
                        }
                    }
                    boolean booked = "booked".equalsIgnoreCase(status);
        %>
        <div class="room-card">
            <img
                src="<%= request.getContextPath() + "/" + deluxeRoom.getImagePath() %>"
                alt="<%= deluxeRoom.getRoomNumber() %>">
            <h3><%= deluxeRoom.getRoomNumber() %></h3>
            <div class="room-info">
			  <p><%= deluxeRoom.getRoomType() %></p>
			  <div class="status-controls">
			    <div class="status-badge <%= booked ? "booked" : "available" %>">
			      <%= booked ? "Booked" : "Available" %>
			    </div>
			    <form action="${pageContext.request.contextPath}/RoomController" method="post">
			      <input type="hidden" name="action" value="updateStatus" />
			      <input type="hidden" name="roomNumber" value="<%= deluxeRoom.getRoomNumber() %>" />
			      <select name="newStatus" onchange="this.form.submit()">
			        <option value="notBooked" <%= !booked ? "selected" : "" %>>Available</option>
			        <option value="booked" <%= booked ? "selected" : "" %>>Booked</option>
			      </select>
			    </form>
			  </div>
			</div>
            <div class="moreBtn">
                <a href="ConfirmRoom.jsp?roomId=<%= deluxeRoom.getRoomNumber() %>">
                    <button <%= booked ? "disabled" : "" %>>
                        <%= booked ? "Booked" : "Book Now" %>
                    </button>
                </a>
            </div>
        </div>
        <%
                }
            }
        %>
    </div>
</div>

		<!-- SUITE ROOMS -->
<div class="category">
    <h2>Suite</h2>
    <hr>
    <div class="room-flex">
        <%  
            for (AddRoom Suite : rooms) {
                if (Suite.getRoomType().equalsIgnoreCase("Suite")) {
                    String roomNumber = Suite.getRoomNumber();
                    String status = "Available";
                    List<Room> roomList = dao.getAllRooms();
                    for (Room r : roomList) {
                        if (r.getRoomNumber().equals(roomNumber)) {
                            status = r.getStatus();
                            break;
                        }
                    }
                    boolean booked = "booked".equalsIgnoreCase(status);
        %>
        <div class="room-card">
            <img
                src="<%= request.getContextPath() + "/" + Suite.getImagePath() %>"
                alt="<%= Suite.getRoomNumber() %>">
            <h3><%= Suite.getRoomNumber() %></h3>
            <div class="room-info">
			  <p><%= Suite.getRoomType() %></p>
			  <div class="status-controls">
			    <div class="status-badge <%= booked ? "booked" : "available" %>">
			      <%= booked ? "Booked" : "Available" %>
			    </div>
			    <form action="${pageContext.request.contextPath}/RoomController" method="post">
			      <input type="hidden" name="action" value="updateStatus" />
			      <input type="hidden" name="roomNumber" value="<%= Suite.getRoomNumber() %>" />
			      <select name="newStatus" onchange="this.form.submit()">
			        <option value="notBooked" <%= !booked ? "selected" : "" %>>Available</option>
			        <option value="booked" <%= booked ? "selected" : "" %>>Booked</option>
			      </select>
			    </form>
			  </div>
			</div>
            <div class="moreBtn">
                <a href="ConfirmRoom.jsp?roomId=<%= Suite.getRoomNumber() %>">
                    <button <%= booked ? "disabled" : "" %>>
                        <%= booked ? "Booked" : "Book Now" %>
                    </button>
                </a>
            </div>
        </div>
        <%
                }
            }
        %>
    </div>
</div>
</div>
</body>
<script>
function toggleDropdown(roomId) {
  const form = document.getElementById("form-" + roomId);
  form.style.display = (form.style.display === "block") ? "none" : "block";
}

// Optional: click outside to hide any open dropdown
document.addEventListener("click", function(event) {
  if (!event.target.closest(".status-action")) {
    document.querySelectorAll(".status-form").forEach(form => form.style.display = "none");
  }
});
</script>

</html>