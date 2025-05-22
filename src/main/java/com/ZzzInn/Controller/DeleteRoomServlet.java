package com.ZzzInn.Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ZzzInn.ZzzInnDAO.ZzzInnDAO;

/**
 * Servlet implementation class DeleteRoomServlet
 */
@WebServlet("/DeleteRoomServlet")
public class DeleteRoomServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteRoomServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		 String roomNumber = request.getParameter("roomNumber");

	        try {
	        	ZzzInnDAO dao = new ZzzInnDAO();
		        boolean success = dao.deleteRoom(roomNumber);

		        if (success) {
		        	request.setAttribute("successMessage", "Room Deleted successfully!");
		            response.sendRedirect(request.getContextPath() + "/Pages/AdminFolder/DeleteRoomBtn.jsp?success=1");
		        } else {
		        	request.setAttribute("FailMessage", "Room could not be Removed!");
		            response.sendRedirect(request.getContextPath() +"/Pages/AdminFolder/DeleteRoomBtn.jsp?status=error1");
		        }
	        	
	        }catch(Exception e) {
	        	e.printStackTrace();
		        request.setAttribute("errorMessage", "An error occurred while adding the room: " + e.getMessage());
		        response.sendRedirect(request.getContextPath() + "/Pages/AdminFolder/DeleteRoomBtn.jsp?status=error2");
	        }
	}

}
