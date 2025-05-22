package com.ZzzInn.Controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ZzzInn.Database.DatabaseConnector;
import com.ZzzInn.ZzzInnDAO.GuestDAO;
import com.ZzzInn.ZzzInn.Guest;


/**
 * Servlet implementation class GuestSearchServlet
 */
@WebServlet("/GuestSearchAdmin")
public class GuestSearchAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GuestSearchAdmin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 String keyword = request.getParameter("keyword");
		 System.out.println("Keyword: " + keyword);
	     String showAll = request.getParameter("showAll");

	        try (Connection conn = DatabaseConnector.getConnection()) {
	            GuestDAO dao = new GuestDAO(conn);
	            List<Guest> results;

	            if (showAll != null) {
	                results = dao.getAllGuests(); // Fetch all customers
	            } else {
	                results = dao.searchGuests(keyword); // Search by keyword
	            }
	            System.out.println("Results Found: "+results.size());
	            request.setAttribute("results", results);
	        } catch (Exception e) {
	            e.printStackTrace();
	            request.setAttribute("error", "Failed to retrieve guest data.");
	        }

	        RequestDispatcher dispatcher = request.getRequestDispatcher("/Pages/AdminFolder/SearchGuestAdmin.jsp");
            dispatcher.forward(request, response);
	        //response.sendRedirect(request.getContextPath() + "/Pages/AdminFolder/SearchGuestAdmin.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}