CREATE TABLE zzzinn.room (
    RoomNumber VARCHAR(100) NOT NULL PRIMARY KEY,
    RoomType VARCHAR(100),
    Price INT(255),
    Description TEXT,
    Room_Image VARCHAR(255),
    status VARCHAR(20) NOT NULL DEFAULT 'available'
);


CREATE TABLE zzzinn.customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(20),
    NumberOfGuests INT,
    Requests VARCHAR(1500),
    ImageStream VARCHAR(100)
);

CREATE TABLE zzzinn.employee (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Username VARCHAR(100),
    Email VARCHAR(100),
    EmpPhone VARCHAR(100),
    Password VARCHAR(100),
    Role VARCHAR(100),
    Salary INT,
    JoinedDate DATE,
    Photo VARCHAR(100)
);

CREATE TABLE zzzinn.customer_room (
    CustomerID INT,
    RoomNumber VARCHAR(100),
    CheckInDate DATE,
    CheckOutDate DATE,
    PRIMARY KEY (CustomerID, RoomNumber),
    FOREIGN KEY (CustomerID) REFERENCES zzzinn.customer(CustomerID),
    FOREIGN KEY (RoomNumber) REFERENCES zzzinn.room(RoomNumber)
);

CREATE TABLE zzzinn.employee_customer (
    EmployeeID INT,
    CustomerID INT,
    RoomNumber VARCHAR(100),
    PRIMARY KEY (EmployeeID, CustomerID, RoomNumber),
    FOREIGN KEY (EmployeeID) REFERENCES zzzinn.employee(EmployeeID),
    FOREIGN KEY (CustomerID) REFERENCES zzzinn.customer(CustomerID),
    FOREIGN KEY (RoomNumber) REFERENCES zzzinn.room(RoomNumber)
);
