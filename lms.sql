Creating Tables

a. Books Table

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100),
    genre VARCHAR(50),
    published_year INT
);

b. Members Table

CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    membership_date DATE
);

c. Loans Table

CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    book_id INT,
    member_id INT,
    loan_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

d.Categories table

CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

e.Publishers table

CREATE TABLE Publishers (
    publisher_id INT PRIMARY KEY,
    publisher_name VARCHAR(100),
    country VARCHAR(50)
);


f.Staff table

CREATE TABLE Staff (
    staff_id INT PRIMARY KEY,
    name VARCHAR(100),
    role VARCHAR(50),
    hire_date DATE
);


g.Fines table

CREATE TABLE Fines (
    fine_id INT PRIMARY KEY,
    loan_id INT,
    amount DECIMAL(6,2),
    paid BOOLEAN,
    FOREIGN KEY (loan_id) REFERENCES Loans(loan_id)
);



Insert Sample Data

a. Insert into Books

INSERT INTO Books VALUES
(1, 'To Kill a Mockingbird', 'Markandeya.H', 'Fiction', 1960),
(2, '1984', 'Nalini.L', 'basic', 1949),
(3, 'The Great Gatsby', 'Jayaram.K', 'Classic', 1925),
(4, 'Python Basics', 'Madhavi.S', 'Programming', 2021),
(5, 'java', 'Madhuri.P', 'Structure', 2018),
(6, 'physics', 'Mr.Mohan', 'Lecture', 2029);

b. Insert into Members

INSERT INTO Members VALUES
(1, 'Anvitha', 'anvita12@gmail.com', '2025-01-15'),
(2, 'Bhanu', 'bhanuraj5@gmail.com', '2025-03-20'),
(3, 'Chanikya', 'chani08@gamil.com', '2025-07-01');

c.Insert into Loans

INSERT INTO Loans VALUES
(1, 2, 2, '2025-07-01', '2025-08-10'),
(2, 4, 3, '2025-07-04', '2025-07-19'),
(3, 3, 1, '2025-08-05', NULL);

d. Insert into categories

INSERT INTO Categories VALUES
(1, 'chemistry'),
(2, 'data science'), 
(3, ' computer Science'), 
(4, 'Programming');

e. Insert into publishers

INSERT INTO Publishers VALUES
(1, 'gayatri', 'India'),
(2, 'ooha', 'USA'),
(3, 'prathyusha', 'UK');

f. Insert into staff

INSERT INTO Staff VALUES
(1, 'mahathi', 'Librarian', '2024-05-10'),
(2, 'rajyalakshmi', 'Assistant', '2025-01-20');

g. Insert into fines

INSERT INTO Fines VALUES
(1, 2, 16.00, FALSE);


>>Show all available books

SELECT * FROM Books;

>>List all members

SELECT * FROM Members;

>>Find all books currently on loan

SELECT b.title, m.name, l.loan_date
FROM Loans l
JOIN Books b ON l.book_id = b.book_id
JOIN Members m ON l.member_id = m.member_id
WHERE l.return_date IS NULL;

>>Count how many books each member has borrowed

SELECT m.name, COUNT(l.loan_id) AS total_loans
FROM Members m
JOIN Loans l ON m.member_id = l.member_id
GROUP BY m.name;

>>List books not currently loaned out

SELECT * FROM Books
WHERE book_id NOT IN (
    SELECT book_id FROM Loans WHERE return_date IS NULL
);

>>Show overdue books:

SELECT b.title, m.name, l.loan_date
FROM Loans l
JOIN Books b ON l.book_id = b.book_id
JOIN Members m ON l.member_id = m.member_id
WHERE l.return_date IS NULL AND l.loan_date < CURRENT_DATE;

>>Total fine amount owed by each member:

SELECT m.name, SUM(f.amount) AS total_fines
FROM Fines f
JOIN Loans l ON f.loan_id = l.loan_id
JOIN Members m ON l.member_id = m.member_id
WHERE f.paid = FALSE
GROUP BY m.name;

>>List Books by Publisher and Category

SELECT b.title, p.publisher_name, c.category_name
FROM Books b
LEFT JOIN Publishers p ON b.book_id % 3 + 1 = p.publisher_id  
LEFT JOIN Categories c ON b.book_id % 4 + 1 = c.category_id;  





