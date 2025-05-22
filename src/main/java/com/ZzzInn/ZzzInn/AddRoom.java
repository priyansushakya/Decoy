package com.ZzzInn.ZzzInn;

public class AddRoom 
{
    private String roomNumber;
    private String roomType;
    private int roomPrice;
    private String roomDesc;
    private String imagePath;


    public AddRoom()
    {

    }


    public AddRoom(String roomNumber, String roomType, int roomPrice, String roomDesc, String imagePath)
    {
        this.roomNumber = roomNumber;
        this.roomType = roomType;
        this.roomPrice = roomPrice;
        this.roomDesc = roomDesc;
        this.imagePath = imagePath;
    }


    public String getRoomNumber() {
        return roomNumber;
    }


    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }


    public String getRoomType() {
        return roomType;
    }


    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }


    public int getRoomPrice() {
        return roomPrice;
    }


    public void setRoomPrice(int roomPrice) {
        this.roomPrice = roomPrice;
    }


    public String getRoomDesc() {
        return roomDesc;
    }


    public void setRoomDesc(String roomDesc) {
        this.roomDesc = roomDesc;
    }


    public String getImagePath() {
        return imagePath;
    }


    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

}