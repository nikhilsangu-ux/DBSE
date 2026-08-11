DROP DATABASE IF EXISTS medicare_db;

CREATE DATABASE medicare_db;

USE medicare_db;

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    consultation_fee DECIMAL(10,2) NOT NULL,

    UNIQUE (doctor_name),

    CHECK (consultation_fee > 0)
);

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_id INT NOT NULL,
    patient_id INT NOT NULL,
    appointment_date DATE NOT NULL,

    FOREIGN KEY (doctor_id)
        REFERENCES Doctors(doctor_id),

    FOREIGN KEY (patient_id)
        REFERENCES Patients(patient_id)
);

INSERT INTO Doctors
(doctor_name, specialization, consultation_fee)
VALUES
('Dr. Rajesh Kumar', 'Cardiology', 1500.00),
('Dr. Priya Sharma', 'Neurology', 1800.00),
('Dr. Amit Verma', 'Orthopedics', 1200.00),
('Dr. Sneha Reddy', 'Dermatology', 1000.00),
('Dr. Arjun Patel', 'Pediatrics', 900.00),
('Dr. Neha Singh', 'Cardiology', 1600.00),
('Dr. Kiran Rao', 'Neurology', 1750.00),
('Dr. Anjali Mehta', 'Gynecology', 1400.00),
('Dr. Vikram Das', 'Orthopedics', 1300.00),
('Dr. Pooja Nair', 'Dermatology', 1100.00);

INSERT INTO Patients
(patient_name, email)
VALUES
('Rahul Sharma', 'rahul.patient@gmail.com'),
('Priya Singh', 'priya.patient@gmail.com'),
('Amit Kumar', 'amit.patient@gmail.com'),
('Sneha Reddy', 'sneha.patient@gmail.com'),
('Arjun Patel', 'arjun.patient@gmail.com'),
('Neha Verma', 'neha.patient@gmail.com'),
('Kiran Rao', 'kiran.patient@gmail.com'),
('Anjali Mehta', 'anjali.patient@gmail.com'),
('Vikram Das', 'vikram.patient@gmail.com'),
('Pooja Nair', 'pooja.patient@gmail.com');

INSERT INTO Appointments
(doctor_id, patient_id, appointment_date)
VALUES
(1, 1, '2026-09-01'),
(2, 2, '2026-09-02'),
(3, 3, '2026-09-03'),
(4, 4, '2026-09-04'),
(5, 5, '2026-09-05'),
(6, 6, '2026-09-06'),
(7, 7, '2026-09-07'),
(8, 8, '2026-09-08'),
(9, 9, '2026-09-09'),
(10, 10, '2026-09-10');

SELECT * FROM Doctors;

SELECT * FROM Patients;

SELECT * FROM Appointments;

SELECT
    p.patient_name,
    d.doctor_name,
    d.specialization,
    a.appointment_date
FROM Appointments a
INNER JOIN Patients p
    ON a.patient_id = p.patient_id
INNER JOIN Doctors d
    ON a.doctor_id = d.doctor_id;

SELECT
    specialization,
    COUNT(doctor_id) AS total_doctors
FROM Doctors
GROUP BY specialization
ORDER BY total_doctors DESC;

CREATE TABLE Doctor_History (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_id INT NOT NULL,
    doctor_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    action_type VARCHAR(50) NOT NULL,
    action_date DATE NOT NULL,

    FOREIGN KEY (doctor_id)
        REFERENCES Doctors(doctor_id)
);

START TRANSACTION;

INSERT INTO Doctors
(doctor_name, specialization, consultation_fee)
VALUES
('Dr. Rohan Gupta', 'ENT', 1250.00);

SET @new_doctor_id = LAST_INSERT_ID();

INSERT INTO Doctor_History
(doctor_id, doctor_name, specialization, action_type, action_date)
VALUES
(@new_doctor_id, 'Dr. Rohan Gupta', 'ENT',
 'NEW DOCTOR REGISTERED', CURRENT_DATE);

COMMIT;

SELECT * FROM Doctors;

SELECT * FROM Doctor_History;

CREATE INDEX idx_doctor_specialization
ON Doctors(specialization);

SELECT *
FROM Doctors
WHERE specialization = 'Cardiology';

SHOW TABLES;