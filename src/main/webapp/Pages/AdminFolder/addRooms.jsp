<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.ZzzInn.ZzzInnDAO.ZzzInnDAO" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add Room</title>
  <link rel="stylesheet" href="room_form.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
  <style>
  body {
  font-family: 'Cogui', sans-serif;
  background-image: url('../Images/addRoom.jpg');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  background-attachment: fixed;
  margin: 0;
  padding: 0;
}

.form-container {
  max-width: 600px;
  margin: 50px auto;
  background-color: #fff;
  padding: 30px;
  border-radius: 12px;
  box-shadow: 0 8px 20px rgba(0,0,0,0.1);
  position: relative;
}

.form-container h2 {
  text-align: center;
  color: #473c38;
  margin-bottom: 25px;
}

label {
  display: block;
  margin: 15px 0 5px;
  color: #473c38;
  font-weight: bold;
}

input[type="text"],
select,
textarea,
input[type="file"],
input[type="number"] {
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 6px;
  font-size: 16px;
  background-color: #fdfaf0;
}

textarea {
  resize: vertical;
}

.submit-btn {
  display: block;
  width: 100%;
  margin-top: 20px;
  padding: 12px;
  background-color: #473c38;
  color: #fdfaf0;
  border: none;
  border-radius: 25px;
  font-size: 18px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.submit-btn:hover {
  background-color: #64544e;
  transform: scale(1.03);
}

.back-button {
  display: inline-flex;
  align-items: center;
  margin-bottom: 20px;
  text-decoration: none;
  color: #473c38;
  font-size: 16px;
  font-weight: bold;
  transition: all 0.3s ease;
}

.back-button i {
  margin-right: 8px;
  font-size: 18px;
}

.back-button:hover {
  color: #a1866f;
  transform: translateX(-5px);
}
  
  </style>
  
  <script>
        function validateForm() {
			return confirm("Are you sure you want to add this room?");
        }
    </script>
</head>
<body>
  <div class="form-container">
    <a href="../AdminFolder/manageRooms.jsp" class="back-button">
      <i class="fas fa-arrow-left"></i> Back
    </a>
		<%
		String success = request.getParameter("success");
		String status = request.getParameter("status");
		String status1 = request.getParameter("status1");
		String status2 = request.getParameter("status2");
		%>

		<%
		if ("1".equals(success)) {
		%>
		<div
			style="padding: 10px; background-color: #d4edda; color: #155724; border-radius: 5px; margin-bottom: 15px;">
			✅ Room Added successfully!</div>
		<%
		} else if ("error1".equals(status)) {
		%>
		<div
			style="padding: 10px; background-color: #f8d7da; color: #721c24; border-radius: 5px; margin-bottom: 15px;">
			❌ An error occurred while adding the room.</div>
		<%
		} else if ("error3".equals(status1)) {
		%>
		<div
			style="padding: 10px; background-color: #f8d7da; color: #721c24; border-radius: 5px; margin-bottom: 15px;">
			❌ Pick another room number, Room number you're trying to add already exists.</div>
		<%
		} else if ("error2".equals(status2)) {
		%>
		<div
			style="padding: 10px; background-color: #f8d7da; color: #721c24; border-radius: 5px; margin-bottom: 15px;">
			❌ An error has occurred, Please check the system.</div>
		<%
		}
		%>

	<h2>Add Room</h2>

    <form action="${pageContext.request.contextPath}/addRoom" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
      <h2>Existing Room Numbers</h2>
      <label for="existingRoom">Existing Room Numbers</label>
      <select>
         <%
             ZzzInnDAO dao = new ZzzInnDAO();
             List<String> roomNumbers = dao.getBookedRoomNumbers();
             for(String roomNo : roomNumbers) {
         %>
             <option><%= roomNo %></option>
         <%
             }
         %>
      </select>
      
      
      <label for="roomName">Room Number</label>
      <input type="text" id="roomName" name="roomName" required>

      <label for="roomType">Room Type</label>
      <select id="roomType" name="roomType">
        <option value="Single">Single</option>
        <option value="Deluxe">Deluxe</option>
        <option value="Suite">Suite</option>
      </select>
      
      <label for="roomPrice">Room Price</label>
      <input type="number" id="roomPrice" name="roomPrice" required step="500" min="500" value="500">

      <label for="description">Description</label>
      <textarea id="description" name="description" rows="4"></textarea>

      <label for="image">Upload Image</label>
      <input type="file" id="image" name="image">

      <button type="submit" class="submit-btn">Save Room</button>
    </form>
  </div>
</body>
</html>