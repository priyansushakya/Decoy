package com.ZzzInn.ZzzInnDAO;

import com.ZzzInn.ZzzInn.Booking;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
    private Connection conn;

    public BookingDAO(Connection conn) {
        this.conn = conn;
    }

    public List<Booking> getAllBookings() throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = """
            SELECT 
                c.CustomerID,
                CONCAT(c.FirstName, ' ', c.LastName) AS Name,
                cr.CheckInDate,
                c.PhoneNumber AS Phone,
                r.RoomNumber AS BookedRoom,
                r.Price AS Deposit,
                c.Requests AS SpecialRequest,
                r.Status AS Status
            FROM 
                customer_room cr
            JOIN 
                customer c ON cr.CustomerID = c.CustomerID
            JOIN 
                room r ON cr.RoomNumber = r.RoomNumber;
        """;

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setCustomerID(rs.getInt("CustomerID"));
                booking.setName(rs.getString("Name"));
                booking.setCheckInDate(rs.getDate("CheckInDate"));
                booking.setPhone(rs.getString("Phone"));
                booking.setBookedRoom(rs.getString("BookedRoom"));
                booking.setDeposit(rs.getDouble("Deposit"));
                booking.setSpecialRequest(rs.getString("SpecialRequest"));
                booking.setStatus(rs.getString("Status"));

                list.add(booking);
            }
        }

        return list;
    }
}