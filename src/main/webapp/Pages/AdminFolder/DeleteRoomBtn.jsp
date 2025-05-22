<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.ZzzInn.ZzzInn.AddRoom, com.ZzzInn.ZzzInnDAO.ZzzInnDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DeleteRoom</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #fdfaf0;
}

.container {
    max-width: 1000px;
    margin: auto;
    padding: 20px;
    margin-left: 260px; 
}

h1 {
    color: white;
    text-align: center;
    margin-bottom: 30px;
}

.room-card {
    background: #fff;
    padding: 20px;
    margin-bottom: 15px;
    border-radius: 10px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.room-info {
    display: flex;
    align-items: center;
    gap: 20px;
}

.room-info img {
    width: 120px;
    height: 80px;
    object-fit: cover;
    border-radius: 8px;
}

.room-info div {
    font-size: 18px;
}

form {
    margin: 0;
}

.btn-delete {
    background-color: #c0392b;
    color: white;
    border: none;
    padding: 10px 15px;
    border-radius: 5px;
    cursor: pointer;
}

.btn-delete:hover {
    background-color: #e74c3c;
}
</style>
</head>
<body>
<%@ include file="../Nav/AdminNav.jsp" %>

<div class="container">
  <h1>Delete Rooms</h1>

  <%
    String success = request.getParameter("success");
    String status = request.getParameter("status");
  %>

  <%
    if ("1".equals(success)) {
  %>
  <div
    style="padding: 10px; background-color: #d4edda; color: #155724; border-radius: 5px; margin-bottom: 15px;">
    ✅ Room Deleted successfully!</div>
  <%
    } else if ("error1".equals(status)) {
  %>
  <div
    style="padding: 10px; background-color: #f8d7da; color: #721c24; border-radius: 5px; margin-bottom: 15px;">
    ❌ An error occurred while removing the room.</div>
  <%
    } else if ("error2".equals(status)) {
  %>
  <div
    style="padding: 10px; background-color: #f8d7da; color: #721c24; border-radius: 5px; margin-bottom: 15px;">
    ❌ An error has occurred, Please check the system.</div>

  <%
    }
  %>

  <%
    ZzzInnDAO dao = new ZzzInnDAO();
    List<AddRoom> rooms = dao.getAllRooms1();
    for (AddRoom room : rooms) {
  %>
  <div class="room-card">
    <div class="room-info">
      <img
        src="<%=request.getContextPath() + "/" + room.getImagePath()%>"
        alt="<%=room.getRoomNumber()%>">
      <div>
        <strong><%=room.getRoomNumber()%></strong><br /> Type:
        <%=room.getRoomType()%>
      </div>
    </div>
    <form action="${pageContext.request.contextPath}/DeleteRoomServlet" method="post" onsubmit="return confirmDelete();">
      <input type="hidden" name="roomNumber" value="<%=room.getRoomNumber()%>" />
      <button type="submit" class="btn-delete">Delete</button>
    </form>
  </div>
  <%
    }
  %>
</div>

<script>
function confirmDelete() {
    return confirm("Are you sure you want to delete this room?");
}
</script>

</body>
</html>
