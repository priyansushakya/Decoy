package com.ZzzInn.Controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.ZzzInn.ZzzInn.Employee;
import com.ZzzInn.ZzzInn.customer;
import com.ZzzInn.ZzzInnDAO.ZzzInnDAO;
import com.ZzzInn.utility.EncryptDecrypt;


/**
 * Servlet implementation class RegisterEmployee
 */
@WebServlet("/RegisterEmployee")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
					maxFileSize = 1024 * 1024 * 10,      // 10MB
					maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class RegisterEmployee extends HttpServlet {
	
	private static final String UPLOAD_DIR = "uploads";
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterEmployee() {
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
		doGet(request, response);
		
		PrintWriter out = response.getWriter();
		
		String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String salaryStr = request.getParameter("salary");
        String joinedDateStr = request.getParameter("joinedDate");
        
        String encryptPass = EncryptDecrypt.encrypt(password);
        
        java.sql.Date joinedDate = null;
        
        try {
	        if (joinedDateStr != null && joinedDateStr.matches("\\d{4}-\\d{2}-\\d{2}")) {
	            joinedDate = java.sql.Date.valueOf(joinedDateStr);
	        } else {
	            throw new IllegalArgumentException("Invalid or missing check-in date");
	        }
	    } catch (IllegalArgumentException e) {
	        out.print("<p style='color:red;'>Invalid or missing Check-In/Check-Out date.</p>");
	    }

        // Handle image upload
        Part imagePart = request.getPart("profileImage");
        String fileName = imagePart.getSubmittedFileName();
        //InputStream imagePath = imagePart.getInputStream();
        
        String appPath = request.getServletContext().getRealPath("");
        String uploadPath = appPath + File.separator + "images";
        
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();
        
        
        String filePath = uploadPath + File.separator + fileName;
        imagePart.write(filePath);
        
        String imagePath = "images/" + fileName;
        
        String imagesDirPath = getServletContext().getRealPath("/images");

        // Log to server console
        System.out.println("Images directory absolute path: " + imagesDirPath);
       
        int salary = 0;
        boolean parsingError = false;
	    String errorMessage = "";
	    
	    try {
	    	salary = Integer.parseInt(salaryStr);
	    }catch(NumberFormatException e) {
	    	parsingError = true;
	        errorMessage = "<p style='color:red;'>Please enter valid Salary Amount.</p>";
	    }
        
        
        if (!parsingError) {
        	Employee emp = new Employee(firstName, lastName, username, email, phone, encryptPass ,role, salary, joinedDateStr, imagePath);
        	emp.setImagePath(imagePath);
	        boolean isEmpAdded = false;
	        try {
	            ZzzInnDAO employeeDAO = new ZzzInnDAO();
	            isEmpAdded = employeeDAO.insertEmployee(emp);
	            if (isEmpAdded) {
	                // Optionally: store a message in session
	                request.getSession().setAttribute("message", "Employee added successfully!");
	                response.sendRedirect("Pages/AdminFolder/manageRecep.jsp");
	                
	            } else {
	                request.getSession().setAttribute("message", "Failed to add Employee.");
	                response.sendRedirect("Pages/AdminFolder/manageRecep.jsp");
	            }


	        } catch (Exception e) {
	            e.printStackTrace();
	            out.println("<!DOCTYPE html>");
	            out.println("<html><head><title>Error</title></head><body>");
	            out.println("<p style='color:red;'>An error occurred while adding the Employee: " + e.getMessage() + "</p>");
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