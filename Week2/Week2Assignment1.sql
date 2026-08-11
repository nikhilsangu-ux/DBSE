DROP DATABASE IF EXISTS skytrack_db;

CREATE DATABASE skytrack_db;

USE skytrack_db;

CREATE TABLE Flights (
    flight_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_number VARCHAR(20) NOT NULL UNIQUE,
    source VARCHAR(100) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    departure_date DATE NOT NULL,
    ticket_price DECIMAL(10,2) NOT NULL,

    CHECK (ticket_price > 0),
    CHECK (source <> destination)
);

CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT NOT NULL,
    flight_id INT NOT NULL,
    booking_date DATE NOT NULL,

    FOREIGN KEY (passenger_id)
        REFERENCES Passengers(passenger_id),

    FOREIGN KEY (flight_id)
        REFERENCES Flights(flight_id)
);

INSERT INTO Flights
(flight_number, source, destination, departure_date, ticket_price)
VALUES
('ST101', 'Hyderabad', 'Delhi', '2026-09-01', 5500.00),
('ST102', 'Mumbai', 'Bangalore', '2026-09-02', 4800.00),
('ST103', 'Chennai', 'Hyderabad', '2026-09-03', 4200.00),
('ST104', 'Delhi', 'Mumbai', '2026-09-04', 6000.00),
('ST105', 'Bangalore', 'Kolkata', '2026-09-05', 6500.00),
('ST106', 'Hyderabad', 'Mumbai', '2026-09-06', 5000.00),
('ST107', 'Chennai', 'Delhi', '2026-09-07', 5800.00),
('ST108', 'Kolkata', 'Bangalore', '2026-09-08', 6200.00),
('ST109', 'Mumbai', 'Delhi', '2026-09-09', 5700.00),
('ST110', 'Hyderabad', 'Kolkata', '2026-09-10', 6800.00);

INSERT INTO Passengers
(passenger_name, email)
VALUES
('Rahul Sharma', 'rahul@gmail.com'),
('Priya Singh', 'priya@gmail.com'),
('Amit Kumar', 'amit@gmail.com'),
('Sneha Reddy', 'sneha@gmail.com'),
('Arjun Patel', 'arjun@gmail.com'),
('Neha Verma', 'neha@gmail.com'),
('Kiran Rao', 'kiran@gmail.com'),
('Anjali Mehta', 'anjali@gmail.com'),
('Vikram Das', 'vikram@gmail.com'),
('Pooja Nair', 'pooja@gmail.com');

INSERT INTO Bookings
(passenger_id, flight_id, booking_date)
VALUES
(1, 1, '2026-08-20'),
(2, 2, '2026-08-20'),
(3, 3, '2026-08-21'),
(4, 4, '2026-08-21'),
(5, 5, '2026-08-22'),
(6, 6, '2026-08-22'),
(7, 7, '2026-08-23'),
(8, 8, '2026-08-23'),
(9, 9, '2026-08-24'),
(10, 10, '2026-08-24');

SELECT * FROM Flights;

SELECT * FROM Passengers;

SELECT * FROM Bookings;

SELECT
    p.passenger_name,
    f.flight_number,
    f.source,
    f.destination
FROM Bookings b
INNER JOIN Passengers p
    ON b.passenger_id = p.passenger_id
INNER JOIN Flights f
    ON b.flight_id = f.flight_id;

SELECT
    destination,
    COUNT(flight_id) AS total_flights
FROM Flights
GROUP BY destination
ORDER BY total_flights DESC;

CREATE TABLE Flight_History (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_id INT NOT NULL,
    flight_number VARCHAR(20) NOT NULL,
    action_type VARCHAR(50) NOT NULL,
    action_date DATE NOT NULL,

    FOREIGN KEY (flight_id)
        REFERENCES Flights(flight_id)
);

START TRANSACTION;

INSERT INTO Flights
(flight_number, source, destination, departure_date, ticket_price)
VALUES
('ST111', 'Hyderabad', 'Chennai', '2026-09-15', 4500.00);

SET @new_flight_id = LAST_INSERT_ID();

INSERT INTO Flight_History
(flight_id, flight_number, action_type, action_date)
VALUES
(@new_flight_id, 'ST111', 'NEW FLIGHT ADDED', CURRENT_DATE);

COMMIT;

SELECT * FROM Flights;

SELECT * FROM Flight_History;

CREATE INDEX idx_flight_number
ON Flights(flight_number);

SELECT *
FROM Flights
WHERE flight_number = 'ST101';

SELECT *
FROM Flights
WHERE destination = 'Delhi';

SHOW TABLES;