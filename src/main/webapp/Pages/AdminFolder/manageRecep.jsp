<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="../Nav/AdminNav.jsp" %>
<%@ page import="java.util.*, com.ZzzInn.ZzzInnDAO.ReceptionistDAO, com.ZzzInn.ZzzInn.receptionist" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Receptionists</title>
    <style>
        body {
            margin: 0;
            font-family: 'Cogui', sans-serif;
            background-image: url("../Images/PhotoJava2.jpg");
            background-size: cover;
        }
        .main-content {
            margin-left: 220px;
            padding: 40px;
        }
        h1 { color: white; }
        table {
            width: 100%;
            background: white;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            vertical-align: middle;
            text-align: center;
        }
        .profile-pic {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 50%;
        }
        .edit-input {
            display: none;
            width: 90%;
        }
        .save-btn {
            display: none;
            background: #473c38;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 3px;
            cursor: pointer;
        }
        .edit-icon {
            cursor: pointer;
            color: #473c38;
        }
        .btn-delete {
            background-color: #fa0c0c;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
    <script>
        function enableEdit(rowId) {
            const row = document.getElementById(rowId);
            row.querySelectorAll('.edit-input').forEach(i => i.style.display = 'inline-block');
            row.querySelectorAll('.text-label').forEach(l => l.style.display = 'none');
            row.querySelector('.save-btn').style.display = 'inline-block';
        }
    </script>
</head>
<body>
<div class="main-content">
    <h1>Manage Receptionists</h1>
    <a href="${pageContext.request.contextPath}/Pages/AdminFolder/RegisterEmployee.jsp" style="text-decoration: none;">
    <button style="background-color: #473c38; color: white; padding: 8px 16px; border: none; border-radius: 4px; margin-bottom: 20px; cursor: pointer;">
        ➕ Add Receptionist
    </button>
	</a>
    

    <%
        ReceptionistDAO dao = new ReceptionistDAO();
        List<receptionist> receptionists = dao.getAllReceptionists();
        int index = 0;
    %>

    <table>
        <tr>
            <th>Photo</th>
            <th>Full Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Role</th>
            <th>Salary</th>
            <th>Joined Date</th>
            <th>Actions</th>
        </tr>

        <% for (receptionist r : receptionists) {
               String rowId = "row" + index;
        %>
        <tr id="<%= rowId %>">
            <form method="post" action="${pageContext.request.contextPath}/UpdateReceptionist">
                <input type="hidden" name="_method" value="PUT">
                <input type="hidden" name="email" value="<%= r.getEmail() %>">

                <td>
                    <img src="${pageContext.request.contextPath}/<%= r.getImagePath() %>" class="profile-pic" alt="No Image">
                </td>
                <td><%= r.getFirstName() %> <%= r.getLastName() %></td>
                <td><%= r.getEmail() %></td>
                <td><%= r.getPhone() %></td>

                <td>
                    <span class="text-label"><%= r.getRole() %></span>
                    <input type="text" name="role" class="edit-input" value="<%= r.getRole() %>">
                </td>
                <td>
                    <span class="text-label"><%= r.getSalary() %></span>
                    <input type="number" name="salary" class="edit-input" value="<%= r.getSalary() %>">
                </td>
                <td>
                    <span class="text-label"><%= r.getJoinedDate() %></span>
                    <input type="date" name="joinedDate" class="edit-input" value="<%= r.getJoinedDate() %>">
                </td>
                <td>
                    <span class="edit-icon" onclick="enableEdit('<%= rowId %>')">✏️</span>
                    <button type="submit" class="save-btn">Save</button>
                </td>
            </form>

            <td>
                <form method="post" action="${pageContext.request.contextPath}/UpdateReceptionist" onsubmit="return confirm('Delete <%= r.getFullName() %>?')">
                    <input type="hidden" name="_method" value="DELETE">
                    <input type="hidden" name="email" value="<%= r.getEmail() %>">
                    <button type="submit" class="btn-delete">Delete</button>
                </form>
            </td>
        </tr>
        <% index++; } %>
    </table>
</div>
</body>
</html>