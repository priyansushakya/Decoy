package com.ZzzInn.ZzzInn;

public class BookingTrends {
    private String month;
    private int totalBookings;

    public BookingTrends(String month, int totalBookings) {
        this.month = month;
        this.totalBookings = totalBookings;
    }

    public String getMonth() {
        return month;
    }

    public int getTotalBookings() {
        return totalBookings;
    }
}