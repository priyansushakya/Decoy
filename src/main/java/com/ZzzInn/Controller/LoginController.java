package com.ZzzInn.Controller;

import java.io.IOException;
//import java.io.PrintWriter;
//import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ZzzInn.ZzzInn.Employee;
import com.ZzzInn.ZzzInnDAO.ZzzInnDAO;
import com.ZzzInn.utility.EncryptDecrypt;

/**
 * Servlet implementation class LoginController
 */
@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
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
		String inputEmail = request.getParameter("email");
        String inputPassword = request.getParameter("password");

        try {
            ZzzInnDAO dao = new ZzzInnDAO();
            Employee user = dao.getUserByEmail(inputEmail);

            if (user != null) {
                String decryptedPassword = EncryptDecrypt.decrypt(user.getPassword());

                if (inputPassword.equals(decryptedPassword)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("loggedInUser", user);
                    session.setAttribute("role", user.getRole()); 

                    // Redirect based on role
                    String role = user.getRole().toLowerCase();
                    if (role.equals("admin")) {
                        response.sendRedirect("Pages/AdminFolder/AdminDashBoard.jsp");
                    } else if (role.equals("receptionist")) {
                        response.sendRedirect("Pages/Receptionist/ReceptionistDashBoard.jsp");
                    } else {
                        request.setAttribute("error", "Unauthorized role.");
                        response.sendRedirect(request.getContextPath() + "/Pages/Login/Login.jsp?success=1");
                    }
                } else {
                    request.setAttribute("error", "Invalid password, Please Try again.");
                    response.sendRedirect(request.getContextPath() + "/Pages/Login/Login.jsp?success=2");
                }
            } else {
                request.setAttribute("error", "Invalid email, Try again.");
                response.sendRedirect(request.getContextPath() + "/Pages/Login/Login.jsp?success=3");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An system error occurred: ");
            response.sendRedirect(request.getContextPath() + "/Pages/Login/Login.jsp?success=4");
        }
	}
  }
