package com.ZzzInn.Controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;

import com.ZzzInn.Database.DatabaseConnector;
import com.ZzzInn.ZzzInn.customer;
import com.ZzzInn.ZzzInnDAO.ZzzInnDAO;

//import util.ValidationUtil;

import java.io.OutputStream;
/**
 * Servlet implementation class Controller
 */
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024,  // 1MB
	    maxFileSize = 1024 * 1024 * 5,    // 5MB
	    maxRequestSize = 1024 * 1024 * 10 // 10MB
	)
@WebServlet("/Controller")
public class CustomerInfoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CustomerInfoController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
 

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Something went wrong while retrieving room data.");
            request.getRequestDispatcher("/Pages/Error.jsp").forward(request, response);
        }
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html"); // Set content type for the response
	    PrintWriter out = response.getWriter();

	    String firstName = request.getParameter("firstName").trim();
	    String lastName = request.getParameter("lastName").trim();
	    String email = request.getParameter("email");
	    String phoneStr = request.getParameter("phone");
	    String guestsStr = request.getParameter("guests");
	    String roomType = request.getParameter("roomType");
	    String roomPriceStr = request.getParameter("roomPrice");
	    String checkInStr = request.getParameter("checkIn");
	    String checkOutStr = request.getParameter("checkOut");
	    String requests = request.getParameter("requests");
	    Part imagePart = request.getPart("photoUpload");
	    String fileName = imagePart.getSubmittedFileName();
	    String roomNumber = request.getParameter("roomNumber");
	    
	    //if (!ValidationUtil.isvalidImageExtension(fileName)) {
          //  response.getWriter().write("Invalid image format. Only jpg, jpeg, png, and gif are allowed.");
            //return;
        //}
        
        String appPath = request.getServletContext().getRealPath("");
        String uploadPath = appPath + File.separator + "images";

        
     // Create upload directory if not exists
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();
        
       // System.out.println("Upload directory path: " + uploadPath);

       // byte[] imageData = imagePart.getInputStream().readAllBytes();
        
     // Save image to folder
        String filePath = uploadPath + File.separator + fileName;
        imagePart.write(filePath);
        
     // Save path in DB (relative path for browser use)
        String imagePath = "images/" + fileName;
	    
	    java.sql.Date checkIn = null;
	    java.sql.Date checkOut = null;

	    try {
	        if (checkInStr != null && checkInStr.matches("\\d{4}-\\d{2}-\\d{2}")) {
	            checkIn = java.sql.Date.valueOf(checkInStr);
	        } else {
	            throw new IllegalArgumentException("Invalid or missing check-in date");
	        }

	        if (checkOutStr != null && checkOutStr.matches("\\d{4}-\\d{2}-\\d{2}")) {
	            checkOut = java.sql.Date.valueOf(checkOutStr);
	        } else {
	            throw new IllegalArgumentException("Invalid or missing check-out date");
	        }
	    } catch (IllegalArgumentException e) {
	        out.print("<p style='color:red;'>Invalid or missing Check-In/Check-Out date.</p>");
	    }
	    
	    
	    if(firstName == null || firstName.trim().isEmpty() || !firstName.matches("^[A-Za-z]+")) {
		    response.sendRedirect(request.getContextPath() + "/Pages/Receptionist/ConfirmRoom.jsp?error=firstname");
		    return;
		}
		
		if(lastName == null || lastName.trim().isEmpty() || !lastName.matches("^[A-Za-z]+")) {
		    response.sendRedirect(request.getContextPath() + "/Pages/Receptionist/ConfirmRoom.jsp?error0=lastname");
		    return;
		}
		
		//if (checkIn == null || checkIn.toLocalDate().isBefore(LocalDate.now())) {
        	//response.sendRedirect(request.getContextPath()+"/Pages/Receptionist/ConfirmRoom.jsp?error1=date");
            //return;
	   //}
		
		if(!phoneStr.matches("^\\+\\d{10,15}$")) {
		    response.sendRedirect(request.getContextPath() + "/Pages/Receptionist/ConfirmRoom.jsp?error2=phone");
		    return;
		}

	    int phone = 0;
	    int guests = 0;
	    int roomPrice = 0;
	    boolean parsingError = false;
	    String errorMessage = "";

	    try {
	       // phone = Integer.parseInt(phoneStr);
	        guests = Integer.parseInt(guestsStr);
	        roomPrice = Integer.parseInt(roomPriceStr);
	    } catch (NumberFormatException e) {
	        parsingError = true;
	        errorMessage = "<p style='color:red;'>Please enter valid numbers for Phone, Guests, and Room Price.</p>";
	    }

	    if (!parsingError) {
	    	customer Customer = new customer(firstName, lastName, email, roomType, roomPrice, checkInStr, checkOutStr, phoneStr, guests, requests, imagePath, roomNumber);
	        //Customer.setImageStream(imageStream);
	        boolean isCustomerAdded = false;
	        boolean isCustomerRoomAdded = false;
	        try {
	            /*ZzzInnDAO customerInfo = new ZzzInnDAO();
	            isCustomerAdded = customerInfo.addCustomer(Customer);
	            isCustomerRoomAdded = customerInfo.addCustomer_Room(Customer);
	            if (isCustomerAdded && isCustomerRoomAdded == true) {
	                out.println("<!DOCTYPE html>");
	                out.println("<html><head><title>Success</title></head><body>");
	                out.println("<p style='color:green;'>Customer added successfully!</p>");
	                out.println("</body></html>");
	            } else {
	                out.println("<!DOCTYPE html>");
	                out.println("<html><head><title>Failure</title></head><body>");
	                out.println("<p style='color:red;'>Failed to add customer.</p>");
	                out.println("</body></html>");
	            }*/
	        	ZzzInnDAO customerInfo = new ZzzInnDAO();
	        	int customerId = customerInfo.addCustomer(Customer);

	        	if (customerId != -1) {
	        	    // Check if the room exists before assigning it
	        	    if (customerInfo.isRoomExists(Customer.getRoomNumber())) {
	        	        boolean isCustomerRoomAdded1 = customerInfo.addCustomer_Room(customerId, Customer);
	        	        customerInfo.updateRoomStatusToBooked(roomNumber);
	        	        
	        	        if (isCustomerRoomAdded1) {
	        	        	request.setAttribute("successMessage", "Customer added successfully!");
	                        response.sendRedirect(request.getContextPath() + "/Pages/Receptionist/ConfirmRoom.jsp?success=1");
	        	            out.println("<p style='color:green;'>Customer added successfully!</p>");
	        	        } else {
	        	        	response.sendRedirect(request.getContextPath() + "/Pages/Receptionist/ConfirmRoom.jsp?status=2");
	        	            out.println("<p style='color:red;'>Customer added, but room booking failed.</p>");
	        	        }
	        	    } else {
	        	    	response.sendRedirect(request.getContextPath() + "/Pages/Receptionist/ConfirmRoom.jsp?status=3");
	        	        out.println("<p style='color:red;'>Customer added, but room number does not exist in the system.</p>");
	        	    }
	        	} else {
	        		response.sendRedirect(request.getContextPath() + "/Pages/Receptionist/ConfirmRoom.jsp?status=4");
	        	    out.println("<p style='color:red;'>Failed to add customer.</p>");
	        	}
	        	
	        } catch (Exception e) {
	            e.printStackTrace();
	            out.println("<!DOCTYPE html>");
	            out.println("<html><head><title>Error</title></head><body>");
	            out.println("<p style='color:red;'>An error occurred while adding the customer: " + e.getMessage() + "</p>");
	            out.println("</body></html>");
	        }
	    } else {
	        out.println("<!DOCTYPE html>");
	        out.println("<html><head><title>Input Error</title></head><body>");
	        out.println(errorMessage);
	        out.println("<p><a href='../../webapp/Pages/Receptionist/ConfirmRoom.jsp'>Go back to the form</a></p>"); // Provide a way to go back
	        out.println("</body></html>");
	    }
	    
	    
	}

}