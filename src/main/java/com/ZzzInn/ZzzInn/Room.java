package com.ZzzInn.ZzzInn;

public class Room {
    private String roomNumber;
    private String status;
    private String roomType;
    private String price;
    
    public Room(String roomNumber, String status, String roomType, String price) {
        this.roomNumber = roomNumber;
        this.status = status;
        this.roomType = roomType;
        this.price = price;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public String getStatus() {
        return status;
    }
    public String getRoomType() {
        return roomType;
    }
    public String getPrice() {
        return price;
    }
}
