package com.ZzzInn.ZzzInn;

import java.io.InputStream;

public class customer {
		private String firstName;
		private String lastName;
		private String email;
		private String phoneNumber;
		private	int numberOfGuests;
		private String roomType;
		private	int price;
		private	String checkInDate;
		private String checkOutDate;
		private String requests;
		private String imagePath;
		private String roomNumber;
		
		
		public customer(String firstName, String lastName, String email, String roomType, int price, String checkInDate, String checkOutDate, String phoneNumber, int numberOfGuests, String requests, String imagePath, String roomNumber) {
			super();
			this.firstName = firstName;
			this.lastName = lastName;
			this.email = email;
			this.roomType = roomType;
			this.price = price; 
			this.checkInDate = checkInDate;
			this.checkOutDate = checkOutDate;
			this.phoneNumber = phoneNumber;
			this.numberOfGuests = numberOfGuests;
			this.requests = requests;
			this.imagePath = imagePath;
			this.roomNumber = roomNumber;
		}

		public String getRoomNumber() {
			return roomNumber;
		}

		public void setRoomNumber(String roomNumber) {
			this.roomNumber = roomNumber;
		}

		public String getRequests() {
			return requests;
		}

		public void setRequests(String requests) {
			this.requests = requests;
		}

		public int getPrice() {
			return price;
		}

		public void setPrice(int price) {
			this.price = price;
		}

		public String getFirstName() {
			return firstName;
		}

		public void setFirstName(String firstName) {
			this.firstName = firstName;
		}

		public String getLastName() {
			return lastName;
		}

		public void setLastName(String lastName) {
			this.lastName = lastName;
		}

		public String getEmail() {
			return email;
		}

		public void setEmail(String email) {
			this.email = email;
		}

		public String getRoomType() {
			return roomType;
		}

		public void setRoomType(String roomType) {
			this.roomType = roomType;
		}

		public String getCheckInDate() {
			return checkInDate;
		}

		public void setCheckInDate(String checkInDate) {
			this.checkInDate = checkInDate;
		}

		public String getCheckOutDate() {
			return checkOutDate;
		}

		public void setCheckOutDate(String checkOutDate) {
			this.checkOutDate = checkOutDate;
		}

		public String getPhoneNumber() {
			return phoneNumber;
		}

		public void setPhoneNumber(String phoneNumber) {
			this.phoneNumber = phoneNumber;
		}

		public int getNumberOfGuests() {
			return numberOfGuests;
		}

		public void setNumberOfGuests(int numberOfGuests) {
			this.numberOfGuests = numberOfGuests;
		}
		
		public String getImageStream() {
		    return imagePath;
		}

		public void setImageStream(String imagePath) {
		    this.imagePath = imagePath;
		}

		//public boolean addCustomer(ZzzInn customer) {
			// TODO Auto-generated method stub
		//return false;
		//}
		
}