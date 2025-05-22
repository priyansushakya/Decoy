package com.ZzzInn.ZzzInn;

public class receptionist {
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String role;
    private int salary;
    private String joinedDate;
    private String imagePath;

    public receptionist(String firstName, String lastName, String email, String phone,
                        String role, int salary, String joinedDate, String imagePath) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phone = phone;
        this.role = role;
        this.salary = salary;
        this.joinedDate = joinedDate;
        this.imagePath = imagePath;
    }

    public String getFullName() {
        return firstName + " " + lastName;
    }

    public String getFirstName() { return firstName; }
    public String getLastName() { return lastName; }
    public String getEmail() { return email; }
    public String getPhone() { return phone; }
    public String getRole() { return role; }
    public int getSalary() { return salary; }
    public String getJoinedDate() { return joinedDate; }
    public String getImagePath() { return imagePath; }

    public void setRole(String role) { this.role = role; }
    public void setSalary(int salary) { this.salary = salary; }
    public void setJoinedDate(String joinedDate) { this.joinedDate = joinedDate; }
}