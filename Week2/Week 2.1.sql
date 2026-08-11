CREATE DATABASE IF NOT EXISTS LibraryDB;
USE LibraryDB;

CREATE TABLE IF NOT EXISTS Members ( 
	member_id INT PRIMARY KEY AUTO_INCREMENT, 
    member_name VARCHAR(100) NOT NULL 
);

CREATE TABLE IF NOT EXISTS Books ( 
	book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(200) NOT NULL, 
    author VARCHAR(100) NOT NULL, 
    isbn VARCHAR(20) NOT NULL, 
    published_year INT 
);

INSERT INTO Members (member_name) 
VALUES 
('John'), 
('Alice'), 
('Robert'), 
('Sophia');

INSERT INTO Books (title, author, isbn, published_year) 
VALUES 
('The Great Gatsby', 'F. Scott Fitzgerald', '9780743273565', 1925), 
('1984', 'George Orwell', '9780451524935', 1949), 
('To Kill a Mockingbird', 'Harper Lee', '9780061120084', 1960), 
('Harry Potter', 'J.K. Rowling', '9780590353427', 1997), 
('The Hobbit', 'J.R.R. Tolkien', '9780547928227', 1937);

CREATE TABLE IF NOT EXISTS Loans ( 
	loan_id INT PRIMARY KEY AUTO_INCREMENT, 
    member_id INT NOT NULL, 
    book_id INT NOT NULL, 
    loan_date DATE, 
    
    FOREIGN KEY (member_id) 
		REFERENCES Members(member_id), 
        
	FOREIGN KEY (book_id) 
		REFERENCES Books(book_id) 
);

INSERT INTO Loans (member_id, book_id, loan_date) 
VALUES 
(1, 2, '2026-08-01'), 
(2, 4, '2026-08-03'), 
(3, 1, '2026-08-05');

SELECT 
	m.member_name AS Member_Name, 
    b.title AS Book_Title 
FROM Loans l 
JOIN Members m 
	ON l.member_id = m.member_id 
JOIN Books b 
	ON l.book_id = b.book_id;
    
SELECT 
	published_year, 
    COUNT(book_id) AS total_books 
FROM Books 
GROUP BY published_year 
ORDER BY published_year;

CREATE TABLE IF NOT EXISTS Donation_History ( 
	donation_id INT PRIMARY KEY AUTO_INCREMENT, 
    book_id INT NOT NULL, 
    donation_date DATE, 
    donor_name VARCHAR(100), 
    
    FOREIGN KEY (book_id) 
		REFERENCES Books(book_id) 
);

START TRANSACTION; 

INSERT INTO Books 
	(title, author, isbn, published_year) 
VALUES 
	('The Digital Library', 'John Smith', '9781234567890', 2026); 
    
INSERT INTO Donation_History 
	(book_id, donation_date, donor_name) 
VALUES 
	(LAST_INSERT_ID(), CURRENT_DATE, 'ABC Foundation');
    
COMMIT;

SELECT * 
FROM Books 
WHERE isbn = '9781234567890';

SELECT * 
FROM Donation_History;

CREATE INDEX idx_books_isbn 
ON Books(isbn);

SELECT * 
FROM Books 
WHERE isbn = '9781234567890';