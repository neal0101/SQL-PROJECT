CREATE DATABASE EventManagement;
USE EventManagement;

CREATE TABLE Organizers (
    OrganizerID INT AUTO_INCREMENT PRIMARY KEY,
    OrganizerName VARCHAR(255) NOT NULL,
    ContactInfo VARCHAR(255)
);

CREATE TABLE Attendees (
    AttendeeID INT AUTO_INCREMENT PRIMARY KEY,
    AttendeeName VARCHAR(255) NOT NULL,
    Email VARCHAR(255),
    Phone VARCHAR(20)
);

CREATE TABLE Tickets (
    TicketID INT AUTO_INCREMENT PRIMARY KEY,
    EventID INT,
    AttendeeID INT,
    PurchaseDate DATE,
    TicketType VARCHAR(50),
    Price DECIMAL(10, 2),
    FOREIGN KEY (EventID) REFERENCES Events(EventID),
    FOREIGN KEY (AttendeeID) REFERENCES Attendees(AttendeeID)
);


CREATE TABLE Venues (
    VenueID INT AUTO_INCREMENT PRIMARY KEY,
    VenueName VARCHAR(255) NOT NULL,
    Location VARCHAR(255) NOT NULL,
    Capacity INT NOT NULL
);

CREATE TABLE Events (
    EventID INT AUTO_INCREMENT PRIMARY KEY,
    EventName VARCHAR(255) NOT NULL,
    EventDate DATE NOT NULL,
    VenueID INT,
    OrganizerID INT,
    FOREIGN KEY (VenueID) REFERENCES Venues(VenueID),
    FOREIGN KEY (OrganizerID) REFERENCES Organizers(OrganizerID)
);

INSERT INTO Venues (VenueName, Location, Capacity) VALUES
('Convention Center', '123 Main St', 1000),
('Grand Hall', '456 Broadway', 500),
('Outdoor Park', '789 Park Ave', 2000),
('Conference Hall', '101 River Rd', 800),
('Banquet Hall', '202 Ocean Ave', 300),
('Exhibition Center', '303 Hill St', 1500),
('Open Grounds', '404 Field Ln', 2500),
('Music Arena', '505 Melody Blvd', 1200),
('Sports Complex', '606 Stadium St', 5000),
('Community Center', '707 Village Rd', 600);

INSERT INTO Organizers (OrganizerName, ContactInfo) VALUES
('hemant sharma', 'hemant@example.com'),
('jiya Smith', 'jiya@example.com'),
('hellwya Davis', 'hellwya@example.com'),
('Michael Johnson', 'michael@example.com'),
('Sarag gi', 'sarag@example.com'),
('hitesh Brown', 'hitesh@example.com'),
('nilesh Wilson', 'nilesh@example.com'),
('viney Martin', 'viney@example.com'),
('saurab Thompson', 'saurab@example.com'),
('sooraj White', 'sooraj@example.com');

INSERT INTO Events (EventName, EventDate, VenueID, OrganizerID) VALUES
('Tech Conference', '2024-08-01', 1, 1),
('Music Festival', '2024-09-15', 3, 2),
('Art Expo', '2024-07-20', 2, 1),
('Business Summit', '2024-10-05', 4, 3),
('Food Carnival', '2024-11-25', 5, 4),
('Health Expo', '2024-12-10', 6, 5),
('Literature Fair', '2024-08-20', 7, 6),
('Science Exhibition', '2024-09-10', 8, 7),
('Sports Gala', '2024-07-30', 9, 8),
('Community Meetup', '2024-08-15', 10, 9);
		
INSERT INTO Attendees (AttendeeName, Email, Phone) VALUES
('ambani Johnson', 'ambani@example.com', '555-1234'),
('Narendra Modi ', 'Narendra@example.com', '555-5678'),
('Charlie Davis', 'charlie@example.com', '555-8765'),
('Diana mishra', 'diana@example.com', '555-2345'),
('Evan dubay', 'evan@example.com', '555-3456'),
('siri  saha', 'fiona@example.com', '555-4567'),
('doni King', 'george@example.com', '555-5679'),
('rohit sharma', 'hannah@example.com', '555-6789'),
('virat koholi', 'ivy@example.com', '555-7890'),
('Jack Nelson', 'jack@example.com', '555-8901');

INSERT INTO Tickets (EventID, AttendeeID, PurchaseDate, TicketType, Price) VALUES
(1, 1, '2024-07-01', 'Regular', 100.00),
(1, 2, '2024-07-02', 'VIP', 200.00),
(2, 3, '2024-08-01', 'Regular', 150.00),
(3, 4, '2024-06-20', 'Regular', 50.00),
(4, 5, '2024-09-25', 'VIP', 300.00),
(5, 6, '2024-10-05', 'Regular', 80.00),
(6, 7, '2024-11-15', 'VIP', 120.00),
(7, 8, '2024-07-10', 'Regular', 60.00),
(8, 9, '2024-08-05', 'VIP', 140.00),
(9, 10, '2024-06-25', 'Regular', 90.00),
(10, 1, '2024-07-01', 'VIP', 130.00),
(1, 3, '2024-07-04', 'Regular', 100.00),
(2, 4, '2024-08-02', 'VIP', 150.00),
(3, 5, '2024-06-21', 'Regular', 50.00),
(4, 6, '2024-09-26', 'VIP', 300.00),
(5, 7, '2024-10-06', 'Regular', 80.00),
(6, 8, '2024-11-16', 'VIP', 120.00),
(7, 9, '2024-07-11', 'Regular', 60.00),
(8, 10, '2024-08-06', 'VIP', 140.00),
(9, 1, '2024-06-26', 'Regular', 90.00);

-- List all upcoming events
SELECT EventName, EventDate, VenueName
FROM Events
JOIN Venues ON Events.VenueID = Venues.VenueID
WHERE EventDate > CURDATE()
ORDER BY EventDate;

-- Get the details of a specific event
SELECT EventName, EventDate, VenueName, OrganizerName
FROM Events
JOIN Venues ON Events.VenueID = Venues.VenueID
JOIN Organizers ON Events.OrganizerID = Organizers.OrganizerID
WHERE EventID = 1;

-- List all attendees for a specific event
SELECT AttendeeName, Email, Phone
FROM Attendees
JOIN Tickets ON Attendees.AttendeeID = Tickets.AttendeeID
WHERE EventID = 1;

-- Calculate total revenue for a specific event
SELECT EventName, SUM(Price) AS TotalRevenue
FROM Tickets
JOIN Events ON Tickets.EventID = Events.EventID
WHERE Tickets.EventID = 1
GROUP BY EventName;

-- Get the number of tickets sold by ticket type for a specific event
SELECT TicketType, COUNT(*) AS TicketsSold
FROM Tickets
WHERE EventID = 1
GROUP BY TicketType;

-- Find events organized by a specific organizer
SELECT EventName, EventDate, VenueName
FROM Events
JOIN Venues ON Events.VenueID = Venues.VenueID
WHERE OrganizerID = 1;

