package com.ZzzInn.ZzzInnDAO;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.ZzzInn.ZzzInn.Guest;

public class GuestDAO {
    private Connection conn;

    public GuestDAO(Connection conn) {
        this.conn = conn;
    }

    public List<Guest> searchGuests(String keyword) {
        List<Guest> guests = new ArrayList<>();
        String sql = "SELECT c.FirstName, c.LastName, c.Email, c.PhoneNumber, " +
                "r.RoomNumber, r.RoomType, r.Price, " +
                "cr.CheckInDate, cr.CheckOutDate " +
                "FROM customer c " +
                "JOIN customer_room cr ON c.CustomerID = cr.CustomerID " +
                "JOIN room r ON cr.RoomNumber = r.RoomNumber " +
                "WHERE c.FirstName LIKE ? OR c.LastName LIKE ? OR c.Email LIKE ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            String pattern = "%" + keyword + "%";
            ps.setString(1, pattern);
            ps.setString(2, pattern);
            ps.setString(3, pattern);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Guest guest = new Guest();
                guest.setFirstName(rs.getString("FirstName"));
                guest.setLastName(rs.getString("LastName"));
                guest.setEmail(rs.getString("Email"));
                guest.setPhoneNumber(rs.getString("PhoneNumber"));
                guest.setRoomNumber(rs.getString("RoomNumber"));
                guest.setRoomType(rs.getString("RoomType"));
                guest.setCheckInDate(rs.getString("CheckInDate"));
                guest.setCheckOutDate(rs.getString("CheckOutDate"));
                guests.add(guest);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return guests;
    }

    public List<Guest> getAllGuests() {
        List<Guest> guests = new ArrayList<>();
        String sql = "SELECT c.FirstName, c.LastName, c.Email, c.PhoneNumber, " +
                "r.RoomNumber, r.RoomType, r.Price, " +
                "cr.CheckInDate, cr.CheckOutDate " +
                "FROM customer c " +
                "JOIN customer_room cr ON c.CustomerID = cr.CustomerID " +
                "JOIN room r ON cr.RoomNumber = r.RoomNumber";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Guest guest = new Guest();
                guest.setFirstName(rs.getString("FirstName"));
                guest.setLastName(rs.getString("LastName"));
                guest.setEmail(rs.getString("Email"));
                guest.setPhoneNumber(rs.getString("PhoneNumber"));
                guest.setRoomNumber(rs.getString("RoomNumber"));
                guest.setRoomType(rs.getString("RoomType"));
                guest.setCheckInDate(rs.getString("CheckInDate"));
                guest.setCheckOutDate(rs.getString("CheckOutDate"));
                guests.add(guest);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return guests;
    }

}
