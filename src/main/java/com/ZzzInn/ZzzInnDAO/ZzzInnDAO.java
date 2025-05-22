package com.ZzzInn.ZzzInnDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;


import com.ZzzInn.Database.DatabaseConnector;
import com.ZzzInn.ZzzInn.AddRoom;
import com.ZzzInn.ZzzInn.Employee;
import com.ZzzInn.ZzzInn.Room;
import com.ZzzInn.ZzzInn.customer;

public class ZzzInnDAO {
	private Connection conn;
	public ZzzInnDAO() throws ClassNotFoundException, SQLException {
		this.conn = DatabaseConnector.getConnection();
	}
	
	public int addCustomer(customer Customer) {
	    int generatedId = -1;
	    String query = "INSERT INTO customer(FirstName, LastName, Email, PhoneNumber, NumberOfGuests, Requests, ImageStream) VALUES (?,?,?,?,?,?,?)";

	    try {
	        PreparedStatement ps = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
	        ps.setString(1, Customer.getFirstName());
	        ps.setString(2, Customer.getLastName());
	        ps.setString(3, Customer.getEmail());
	        ps.setString(4, Customer.getPhoneNumber());
	        ps.setInt(5, Customer.getNumberOfGuests());
	        ps.setString(6, Customer.getRequests());
	        ps.setString(7, Customer.getImageStream());

	        int row = ps.executeUpdate();

	        if (row > 0) {
	            ResultSet rs = ps.getGeneratedKeys();
	            if (rs.next()) {
	                generatedId = rs.getInt(1);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return generatedId;
	}

	public boolean addCustomer_Room(int customerId, customer Customer) {
	    boolean isRowInserted = false;
	    String query = "INSERT INTO customer_room(CustomerID, RoomNumber, CheckInDate, CheckOutDate) VALUES (?,?,?,?)";

	    try {
	        PreparedStatement ps = conn.prepareStatement(query);
	        ps.setInt(1, customerId);
	        ps.setString(2, Customer.getRoomNumber());
	        ps.setString(3, Customer.getCheckInDate());
	        ps.setString(4, Customer.getCheckOutDate());

	        int row = ps.executeUpdate();
	        if (row > 0) {
	            isRowInserted = true;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return isRowInserted;
	}
	
	public boolean isRoomExists(String roomNumber) {
	    String query = "SELECT 1 FROM room WHERE RoomNumber = ?";
	    try (PreparedStatement ps = conn.prepareStatement(query)) {
	        ps.setString(1, roomNumber);
	        try (ResultSet rs = ps.executeQuery()) {
	            return rs.next();
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}
	
	public void updateRoomStatusToBooked(String roomNumber) {
	    String sql = "UPDATE room SET status = 'booked' WHERE roomNumber = ?";
	    
	    try (
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        
	        ps.setString(1, roomNumber);
	        ps.executeUpdate();
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	
	public boolean insertEmployee(Employee emp) {
		boolean isRowInserted = false;
        String query = "INSERT INTO employee (FirstName, LastName, Username, Email, EmpPhone, Password, Role, Salary, JoinedDate, Photo) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        if (conn != null) {

        	try{
        		PreparedStatement ps = conn.prepareStatement(query);

		            ps.setString(1, emp.getFirstName());
		            ps.setString(2, emp.getLastName());
		            ps.setString(3, emp.getUsername());
		            ps.setString(4, emp.getEmail());
		            ps.setString(5, emp.getPhone());
		            ps.setString(6, emp.getPassword());
		            ps.setString(7, emp.getRole());
		            ps.setInt(8, emp.getSalary());
		            ps.setString(9, emp.getJoinedDate());
		            ps.setString(10, emp.getImagePath());

                    int row = ps.executeUpdate();
                    
                    if(row > 0) {
    					isRowInserted = true;
    				}
	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false;
	        }
        }
        return isRowInserted;
    }
	
	public List<Room> getAllRooms() {
        List<Room> rooms = new ArrayList<>();
        // ← Make sure this matches your actual table name!
        String sql = "SELECT RoomNumber, Status, RoomType, Price FROM room";

        try (
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
            	String roomNumber = rs.getString("RoomNumber"); // instead of getInt
            	String status = rs.getString("Status");
            	String roomType = rs.getString("RoomType");
            	String price = rs.getString("Price");
            	rooms.add(new Room(roomNumber, status, roomType, price));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rooms;
	}

	
	public Employee getUserByEmail(String email) {
        Employee user = null;
        String sql = "SELECT * FROM employee WHERE Email = ?";

        try (Connection conn = DatabaseConnector.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new Employee(); 
                user.setFirstName(rs.getString("FirstName"));
                user.setLastName(rs.getString("LastName"));
                user.setUsername(rs.getString("Username"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("EmpPhone"));
                user.setPassword(rs.getString("Password")); // Encrypted
                user.setRole(rs.getString("Role"));
                user.setSalary(rs.getInt("Salary"));
                user.setJoinedDate(rs.getString("JoinedDate"));
                user.setImagePath(rs.getString("Photo"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
	
	public boolean updateEmployee(Employee emp) {
	    String sql = "UPDATE employee SET FirstName=?, LastName=?, Username=?, Email=?, EmpPhone=?, Photo=? WHERE Email=?";
	    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
	        stmt.setString(1, emp.getFirstName());
	        stmt.setString(2, emp.getLastName());
	        stmt.setString(3, emp.getUsername());
	        stmt.setString(4, emp.getEmail());
	        stmt.setString(5, emp.getPhone());
	        stmt.setString(6, emp.getImagePath());
	        stmt.setString(7, emp.getEmail());
	        return stmt.executeUpdate() > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	public boolean addRoom(AddRoom room) {
        String sql = "INSERT INTO room(RoomNumber, RoomType, Price, Description, Room_Image) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, room.getRoomNumber());
            stmt.setString(2, room.getRoomType());
            stmt.setInt(3, room.getRoomPrice());
            stmt.setString(4, room.getRoomDesc());
            stmt.setString(5, room.getImagePath());

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<AddRoom> getAllRooms1() {
        List<AddRoom> roomList = new ArrayList<>();
        String query = "SELECT * FROM room";

        try (PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                AddRoom room = new AddRoom();
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setRoomType(rs.getString("RoomType"));
                room.setRoomPrice(rs.getInt("Price"));
                room.setRoomDesc(rs.getString("Description"));
                room.setImagePath(rs.getString("Room_Image"));
                roomList.add(room);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return roomList;
    }
    
    public List<String> getBookedRoomNumbers() throws SQLException {
        List<String> bookedRooms = new ArrayList<>();

        String query = "SELECT RoomNumber FROM room";
        try (
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
        ) {
            while (rs.next()) {
                bookedRooms.add(rs.getString("RoomNumber"));
            }
        } catch (SQLException e) {
            e.printStackTrace();  // You can also log this
        }

        return bookedRooms;
    }

    public boolean deleteRoom(String roomNumber) {
        boolean rowDeleted = false;

        String deleteCustomerRoomSQL = "DELETE FROM customer_room WHERE RoomNumber = ?";
        String deleteRoomSQL = "DELETE FROM room WHERE RoomNumber = ?";

        try {
            // Disable auto-commit for transaction management
            conn.setAutoCommit(false);

            // First delete from customer_room
            try (PreparedStatement ps1 = conn.prepareStatement(deleteCustomerRoomSQL)) {
                ps1.setString(1, roomNumber);
                ps1.executeUpdate();
            }

            // Then delete from room
            try (PreparedStatement ps2 = conn.prepareStatement(deleteRoomSQL)) {
                ps2.setString(1, roomNumber);
                int rows = ps2.executeUpdate();
                if (rows > 0) {
                    rowDeleted = true;
                }
            }

            // Commit transaction
            conn.commit();

        } catch (Exception e) {
            e.printStackTrace();
            try {
                conn.rollback(); // Roll back in case of error
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
        } finally {
            try {
                conn.setAutoCommit(true); // Restore auto-commit
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return rowDeleted;
    }

	
    public void updateRoomStatus(String roomNumber, String newStatus) {
        String query = "UPDATE room SET Status = ? WHERE RoomNumber = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, newStatus);
            stmt.setString(2, roomNumber);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
}