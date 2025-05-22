package com.ZzzInn.ZzzInn;

public class OccupancyReport {
    private String roomType;
    private int totalRooms;
    private int occupied;
    private int vacant;

    public OccupancyReport(String roomType, int totalRooms, int occupied, int vacant) {
        this.roomType = roomType;
        this.totalRooms = totalRooms;
        this.occupied = occupied;
        this.vacant = vacant;
    }

    public String getRoomType() {
        return roomType;
    }

    public int getTotalRooms() {
        return totalRooms;
    }

    public int getOccupied() {
        return occupied;
    }

    public int getVacant() {
        return vacant;
    }
}