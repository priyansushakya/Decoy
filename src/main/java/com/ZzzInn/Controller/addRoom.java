package com.ZzzInn.Controller;

import java.io.IOException;
import java.io.File;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.ZzzInn.ZzzInn.AddRoom;
import com.ZzzInn.ZzzInnDAO.ZzzInnDAO;

/**
 * Servlet implementation class addRoom
 */
@WebServlet("/addRoom")
@MultipartConfig(
		fileSizeThreshold = 1024 * 1024,  // 1MB
		maxFileSize = 1024 * 1024 * 5,    // 5MB
		maxRequestSize = 1024 * 1024 * 10 // 10MB
		)
public class addRoom extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addRoom() {
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
	    String roomNumber = request.getParameter("roomName");
	    String roomType = request.getParameter("roomType");
	    String roomPriceStr = request.getParameter("roomPrice");
	    String roomDesc = request.getParameter("description");
	    Part imagePart = request.getPart("image");
	    String fileName = imagePart.getSubmittedFileName();

	    if (!ValidationUtil.isValidImageExtension(fileName)) {
	        request.setAttribute("errorMessage", "Invalid image format. Only jpg, jpeg, png, and gif are allowed.");
	        request.getRequestDispatcher("/Pages/Admin/AddRoom.jsp").forward(request, response);
	        return;
	    }

	    String appPath = request.getServletContext().getRealPath("");
	    String uploadPath = appPath + File.separator + "images";

	    File uploadDir = new File(uploadPath);
	    if (!uploadDir.exists()) uploadDir.mkdir();

	    String filePath = uploadPath + File.separator + fileName;
	    imagePart.write(filePath);

	    String imagePath = "images/" + fileName;

	    int roomPrice = 0;
	    boolean parsingError = false;
	    String errorMessage = "";

	    try {
	        roomPrice = Integer.parseInt(roomPriceStr);
	    } catch (NumberFormatException e) {
	        parsingError = true;
	        errorMessage = "Please enter valid numbers for Room Price.";
	    }

	    if (parsingError) {
	        request.setAttribute("errorMessage", errorMessage);
	        request.getRequestDispatcher(request.getContextPath() + "/Pages/AdminFolder/addRooms.jsp").forward(request, response);
	        return;
	    }

	    try {
	        ZzzInnDAO dao = new ZzzInnDAO();
	        boolean exists = dao.isRoomExists(roomNumber);

	        if (exists) {
	        	request.setAttribute("errorMessage", "Failed to add room. Please try again.");
	            response.sendRedirect(request.getContextPath() +"/Pages/AdminFolder/addRooms.jsp?status1=error3");
	            return;
	        }

	        AddRoom addRoom = new AddRoom(roomNumber, roomType, roomPrice, roomDesc, imagePath);
	        boolean success = dao.addRoom(addRoom);

	        if (success) {
	        	//HttpSession session = request.getSession();
	        	//session.setAttribute("successMessage", "Room added successfully!");
	            request.setAttribute("successMessage", "Room added successfully!");
	            response.sendRedirect(request.getContextPath() + "/Pages/AdminFolder/addRooms.jsp?success=1");
	          
	        } else {
	            request.setAttribute("errorMessage", "Failed to add room. Please try again.");
	            response.sendRedirect(request.getContextPath() +"/Pages/AdminFolder/addRooms.jsp?status=error1");
	        }

	        //request.getRequestDispatcher("/Pages/Admin/AddRoom.jsp").forward(request, response);
	    } catch (Exception e) {
	        e.printStackTrace();
	        request.setAttribute("errorMessage", "An error occurred while adding the room: " + e.getMessage());
	        response.sendRedirect(request.getContextPath() + "/Pages/AdminFolder/addRooms.jsp?status2=error2");
	    }
	    
	}
	
	public class ValidationUtil {
	    public static boolean isValidImageExtension(String fileName) {
	        if (fileName == null || fileName.isEmpty()) return false;
	        String lower = fileName.toLowerCase();
	        return lower.endsWith(".jpg") || lower.endsWith(".jpeg") || lower.endsWith(".png") || lower.endsWith(".gif");
	    }
	}


}
