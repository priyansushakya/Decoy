<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="../Nav/ReceptionistNav.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ZzzInn.ZzzInn.Room, com.ZzzInn.ZzzInnDAO.ZzzInnDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Hotel Booking Form</title>
  <script src="../JS/Booking.js"></script>
  <style>
    * {
      box-sizing: border-box;
    }

    html, body {
      height: 100%;
      min-height: 100vh;
      margin: 0;
      padding: 0;
      font-family: 'Cogui', sans-serif;

    }

    body {
      background-image: url('../Images/PhotoJava1.jpg');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      background-attachment: fixed;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 2rem;
      margin-left: 220px;
      padding: 30px;
    }

    .form-container {
      background: #fdfaf0;
      padding: 2rem 2.5rem;
      width: 100%;
      max-width: 800px;
      border-radius: 20px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.2);
      animation: fadeIn 0.7s ease-in-out;
      margin-top: 500px;
    }
    
    .sides{
		display: flex;    
		gap: 2rem; /* adds spacing between Customer and Room sections */
  		flex-wrap: wrap;
  		margin-top:-20px;
    }
    
    .sides > .form-section {
  		flex: 1 1 45%; /* make each section take approximately half the width on larger screens */
	}

    .form-container h2 {
      text-align: center;
      font-size: 2rem;
      margin-bottom: 2rem;
      color: #333;
      text-transform: uppercase;
    }

    .form-section {
      margin-bottom: 2rem;
    }

    .form-section h3 {
      margin-bottom: 1rem;
      font-size: 1.3rem;
      color: #473c38;
      border-bottom: 2px solid #473c38;
      padding-bottom: 0.3rem;
      text-align: center;
    }

    .form-group {
      position: relative;
      margin-bottom: 1.5rem;
    }

    .form-group input,
    .form-group select,
    .form-group textarea {
      width: 100%;
      padding: 1rem 1rem 0.5rem;
      border: 1px solid #ccc;
      border-radius: 10px;
      font-size: 1rem;
      outline: none;
      background: transparent;
      transition: all 0.2s ease;
      resize: none;
  	  overflow: hidden;
    }

    .form-group label {
      position: absolute;
      top: 0.8rem;
      left: 1rem;
      color: #666;
      font-size: 0.95rem;
      transition: 0.2s ease all;
      pointer-events: none;
      background-color: #fdfaf0;
      padding: 0 0.3rem;
    }

    .form-group input:focus + label,
    .form-group input:not(:placeholder-shown) + label,
    .form-group select:focus + label,
    .form-group select:not([value=""]) + label,
    .form-group textarea:focus + label,
    .form-group textarea:not(:placeholder-shown) + label,
    .form-group input[type="file"] + label {
      top: -0.5rem;
      left: 0.8rem;
      font-size: 0.75rem;
      color: #473c38;
    }

    .form-group select {
      appearance: none;
      background-color: none;
    }
	
	.date{
		margin-top:-40px;	
	}
    .submit-btn {
      background: #473c38;
      color: white;
      padding: 1rem;
      font-size: 1.1rem;
      width: 100%;
      border: none;
      border-radius: 10px;
      cursor: pointer;
      transition: background 0.3s ease, transform 0.2s ease;
    }

    .submit-btn:hover {
      background: #64544e;
      transform: scale(1.02);
    }

    .error {
      font-size: 0.8rem;
      color: red;
      margin-top: 0.3rem;
      display: none;
    }

    .room-price {
      font-size: 1.1rem;
      font-weight: bold;
      color: #333;
      margin-top: 0.5rem;
    }
   
    .room-picker {
      padding: 20px;
      position: absolute;
      top: 100%;
      left: 0;
      width: 100%;
      background: white;
      border: 1px solid #ccc;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      z-index: 10;
      max-height: 200px;
      overflow-y: auto;
      display: none;
    }

    .room-picker ul {
      list-style-type: none;
      padding: 0;
      margin: 0;
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 10px;
    }

    .room-picker li {
      padding: 0.8rem;
      cursor: pointer;
      transition: background 0.3s;
      border-radius: 10px;
      text-align: center;
    }

    .notBooked {
            background-color:#9acd32; /* Light green */
            color: black;
        }
    .booked {
        background-color: #fe6f61; /* Light red */
        color: black;
    }

    .room-picker li.selected {
      background-color: #fed700;
      color: black;
    }

    .room-picker li:hover {
      background-color: #f1f1f1;
    }

    .room-picker li:active {
      background-color: #e0e0e0;
    }

    @media (max-width: 600px) {
      .form-container {
        padding: 1.5rem;
      }

      .form-section h3 {
        font-size: 1.1rem;
      }
      
      .sides {
   	 	flex-direction: column;
  	 }	

   	  .sides > .form-section {
  	  	width: 100%;
 	 }

    }
  </style>
</head>
<body>
<div class="main-content">
  <form class="form-container" onsubmit="return validateForm()" action="../../Controller" method="post" enctype="multipart/form-data">
    <h2>Hotel Room Booking</h2>
			<%
			String success = request.getParameter("success");
			String status = request.getParameter("status");
			%>

			<%
			if ("1".equals(success)) {
			%>
			<div
				style="padding: 10px; background-color: #d4edda; color: #155724; border-radius: 5px; margin-bottom: 15px;">
				✅ Room Booked successfully!</div>
			<%
			} else if ("2".equals(status)) {
			%>
			<div
				style="padding: 10px; background-color: #f8d7da; color: #721c24; border-radius: 5px; margin-bottom: 15px;">
				❌ An error occurred while booking the room.</div>
			<%
			} else if ("3".equals(status)) {
			%>
			<div
				style="padding: 10px; background-color: #f8d7da; color: #721c24; border-radius: 5px; margin-bottom: 15px;">
				❌ Customer added, but room number does not exist in the system.</div>
			<%
			} else if ("4".equals(status)) {
			%>
			<div
				style="padding: 10px; background-color: #f8d7da; color: #721c24; border-radius: 5px; margin-bottom: 15px;">
				❌ Failed to add customer.</div>
			<%
			}
			%>

			<div class="sides">
      <div class="form-section">
        <h3>Customer Details</h3>
        <div class="form-group">
	        <input type="text" id="firstName" name="firstName" placeholder=" " required />
	        <label for="firstName">First Name</label>
	        
	        <%
	    	String error = request.getParameter("error");
	  		if (error != null && error.equals("firstname")) {
	    	%>
	    	<p style="color:red; text-align:center;">Enter a valid last name! Please remove numbers and special characters!</p>
	    	<%
	    	}
	    	%>
	      </div>
	      <div class="form-group">
	        <input type="text" id="lastName" name="lastName" placeholder=" " required />
	        <label for="lastName">Last Name</label>
	        
	        <%
	    	String error0 = request.getParameter("error0");
	    	if (error0 != null && error0.equals("lastname")) {
	    	%>
	    	<p style="color:red; text-align:center;">Enter a valid last name! Please remove numbers and special characters!</p>
	    	<%
	    	}
	    	%>
	      </div>
	      <div class="form-group">
	        <input type="email" id="email" name="email" placeholder=" " required />
	        <label for="email">Email Address</label>
	      </div>
	
	      <div class="form-group">
	        <input type="tel" id="phone" name="phone" placeholder=" " required /> <!--pattern="[0-9]{10}"-->
	        <label for="phone">Phone Number</label>
	      </div>
	      
	      	<%
	    	String error2 = request.getParameter("error2");
	    	if (error2 != null && error2.equals("phone")) {
	    	%>
	    	<p style="color:red; text-align:center;">Please, enter a valid phone number! Start with '+'.</p>
			<%
	    	}
			%>
	
	      <div class="form-group">
	        <input type="file" id="photoUpload" name="photoUpload" accept="image/*" required />
	        <label for="photoUpload">Upload Photo ID</label>
	      </div>
	    </div>

      <div class="form-section">
        <h3>Room Details</h3>

        <div class="form-group" style="position: relative;">
          <input id="roomNumber" name="roomNumber" placeholder=" " readonly onclick="openRoomPicker()" required />
          <label for="roomNumber">Room Number</label>
          <div id="roomPicker" class="room-picker">
            <ul>
              <%
                ZzzInnDAO dao = new ZzzInnDAO();
                List<Room> rooms = dao.getAllRooms();
                for (Room r : rooms) {
                  String statusClass = r.getStatus().equalsIgnoreCase("booked") ? "booked" : "notBooked";
              %>
              <li class="<%= statusClass %>" 
                  <% if (!r.getStatus().equalsIgnoreCase("booked")) { %>
                    onclick="selectRoom('<%= r.getRoomNumber() %>', '<%= r.getRoomType() %>', <%= r.getPrice() %>)"
                  <% } %>
              >
                <%= r.getRoomNumber() %>
              </li>
              <% } %>
            </ul>
          </div>
        </div>

        <div class="form-group">
          <input type="number" id="guests" name="guests" placeholder=" " min="1" required />
          <label for="guests">Number of Guests</label>
        </div>

        <div class="form-group">
          <input type="text" id="roomType" name="roomType" placeholder=" " readonly required />
          <label for="roomType">Room Type</label>
        </div>

        <div class="form-group">
	  <input type="text" id="price" name="roomPrice" placeholder=" " readonly required />
	  <label for="price">Room Price (Rupees)</label>
	  <span id="priceDisplay" class="room-price"></span>
	</div>
	</div>
    </div>

    <div class="date">
	    <!-- Date & Requests -->
	    <div class="form-section">
	      <h3>Date & Special Requests</h3>
	
	      <div class="form-group">
	        <input type="date" id="checkin" name="checkIn" placeholder=" " required />
	        <label for="checkin">Check-in Date</label>
	      </div>
	      
	      	<%
	    	String error1 = request.getParameter("error1");
	    	if (error1 != null && error1.equals("date")) {
	    	 %>
	    	<p style="color:red; text-align:center;">Please, enter a proper date!</p>
	    	<%
	    	}
	    	%>
	      
	      <div class="form-group">
	        <input type="number" id="daysStay" name="daysStay" placeholder=" " min="1" required />
	        <label for="daysStay">Number of Days</label>
	      </div>
	      
	
	      <div class="form-group">
	        <input type="date" id="checkout" name="checkOut" placeholder=" " required/>
	        <label for="checkout">Check-out Date</label>
	      </div>
	
	      <div class="form-group">
	        <textarea id="requests" name="requests" placeholder=" " rows="3"></textarea>
	        <label for="requests">Special Requests</label>
	      </div>
	    </div>
	</div>
    <button class="submit-btn" type="submit">Confirm Booking</button>
  </form>
</div>

<script>

	function openRoomPicker() {
	    const picker = document.getElementById('roomPicker');
	    picker.style.display = picker.style.display === 'block' ? 'none' : 'block';
	  }
	
	function selectRoom(roomNumber, roomType, roomPrice) {
	    // Set values
	    document.getElementById('roomNumber').value = roomNumber;
	    document.getElementById('roomType').value = roomType;
	    document.getElementById('price').value = roomPrice;

	    // Remove 'selected' class from all room items
	    const allRooms = document.querySelectorAll('#roomPicker li');
	    allRooms.forEach(room => room.classList.remove('selected'));

	    // Add 'selected' class to the clicked room
	    const selectedRoom = Array.from(allRooms).find(room => room.textContent.trim() === roomNumber);
	    if (selectedRoom) {
	        selectedRoom.classList.add('selected');
	    }

	    // Hide the picker
	    document.getElementById('roomPicker').style.display = 'none';
	}




	function validateForm() {
	      const phone = document.getElementById('phone');
	      const phoneError = document.getElementById('phoneError');
	      roomPriceInput.value = ''; // Clear the hidden input value

	      if (!/^\d{10}$/.test(phone.value)) {
	        phoneError.style.display = 'block';
	        return false;
	      } else {
	        phoneError.style.display = 'none';
	      }
			
	      return confirm("Are you sure you want to add this room?");
	      return true;
	    }
	
	
    function validateForm() {
        return confirm("Are you sure you want to add this room?");
    }
</script>
</body>
</html>