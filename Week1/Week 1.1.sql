DROP TABLE IF EXISTS customer_transactions;
DROP TABLE IF EXISTS bank_transactions;

CREATE TABLE bank_transactions (
    txn_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    branch_name VARCHAR(50),
    transaction_type VARCHAR(20),
    amount DECIMAL(10,2),
    transaction_date DATE
);

ALTER TABLE bank_transactions
ADD account_no VARCHAR(20);

ALTER TABLE bank_transactions
MODIFY COLUMN customer_name VARCHAR(100);

RENAME TABLE bank_transactions
TO customer_transactions;

TRUNCATE TABLE customer_transactions;

INSERT INTO customer_transactions
    (txn_id, customer_name, branch_name, transaction_type,
     amount, transaction_date, account_no)
VALUES
    (101, 'Ravi', 'Hyderabad', 'Deposit',
     5000.00, '2024-01-05', 'ACC1001'),

    (102, 'Sita', 'Hyderabad', 'Withdrawal',
     2000.00, '2024-01-06', 'ACC1002'),

    (103, 'Kiran', 'Vijayawada', 'Deposit',
     12000.00, '2024-01-08', 'ACC1003'),

    (104, 'Anil', 'Vizag', 'Deposit',
     8000.00, '2024-01-10', 'ACC1004'),

    (105, 'Priya', 'Hyderabad', 'Withdrawal',
     3500.00, '2024-01-11', 'ACC1005'),

    (106, 'Ramesh', 'Vizag', 'Deposit',
     15000.00, '2024-01-12', 'ACC1006'),

    (107, 'Keerthi', 'Vijayawada', 'Withdrawal',
     1000.00, '2024-01-13', 'ACC1007'),

    (108, 'Rahul', 'Hyderabad', 'Deposit',
     9000.00, '2024-01-14', 'ACC1008'),

    (109, 'Sneha', 'Vizag', 'Withdrawal',
     4000.00, '2024-01-15', 'ACC1009'),

    (110, 'Madhu', 'Vijayawada', 'Deposit',
     11000.00, '2024-01-16', 'ACC1010');

INSERT INTO customer_transactions
    (txn_id, customer_name, branch_name, transaction_type,
     amount, transaction_date, account_no)
VALUES
    (111, 'Venu', 'Vizag', 'Deposit',
     7000.00, '2024-01-18', 'ACC1011');

UPDATE customer_transactions
SET amount = 5000.00
WHERE txn_id = 105;

DELETE FROM customer_transactions
WHERE txn_id = 111;

SELECT *
FROM customer_transactions;

SELECT *
FROM customer_transactions
WHERE transaction_type = 'Deposit';

SELECT *
FROM customer_transactions
ORDER BY amount DESC;

DROP USER IF EXISTS 'Auditor1'@'localhost';

CREATE USER 'Auditor1'@'localhost'
IDENTIFIED BY 'Auditor@123';

GRANT SELECT
ON customer_transactions
TO 'Auditor1'@'localhost';

SHOW GRANTS FOR 'Auditor1'@'localhost';

DROP USER IF EXISTS 'BranchManager'@'localhost';

CREATE USER 'BranchManager'@'localhost'
IDENTIFIED BY 'Manager@123';

GRANT ALL PRIVILEGES
ON customer_transactions
TO 'BranchManager'@'localhost';

SHOW GRANTS FOR 'BranchManager'@'localhost';

REVOKE SELECT
ON customer_transactions
FROM 'Auditor1'@'localhost';

REVOKE ALL PRIVILEGES
ON customer_transactions
FROM 'BranchManager'@'localhost';

START TRANSACTION;

UPDATE customer_transactions
SET amount = 6000.00
WHERE txn_id = 101;

COMMIT;

START TRANSACTION;

SAVEPOINT Before_Update;

UPDATE customer_transactions
SET amount = 99999.00
WHERE txn_id = 102;

ROLLBACK TO SAVEPOINT Before_Update;

COMMIT;

START TRANSACTION;

UPDATE customer_transactions
SET amount = 7000.00
WHERE txn_id = 101;

SAVEPOINT SP1;

UPDATE customer_transactions
SET amount = 9000.00
WHERE txn_id = 102;

ROLLBACK TO SAVEPOINT SP1;

COMMIT;

SELECT *
FROM customer_transactions
ORDER BY txn_id;

SHOW TABLES;