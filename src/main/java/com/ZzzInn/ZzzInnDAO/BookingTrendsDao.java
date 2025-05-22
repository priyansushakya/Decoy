package com.ZzzInn.ZzzInnDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.ZzzInn.ZzzInn.BookingTrends;


public class BookingTrendsDao {
    private Connection conn;

    public BookingTrendsDao(Connection conn) {
        this.conn = conn;
    }

    public List<BookingTrends> getBookingTrends() throws SQLException {
        List<BookingTrends> list = new ArrayList<>();
        String sql = """
            SELECT 
                DATE_FORMAT(CheckInDate, '%M') AS Month,
                COUNT(*) AS total_bookings
            FROM 
                customer_room
            GROUP BY 
                MONTH(CheckInDate)
            ORDER BY 
                MONTH(CheckInDate);
        """;

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new BookingTrends(
                    rs.getString("Month"),
                    rs.getInt("total_bookings")
                ));
            }
        }
        return list;
    }
}