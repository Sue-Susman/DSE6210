DROP TABLE IF EXISTS libraries.book;
DROP TABLE IF EXISTS libraries.book_authors;
DROP TABLE IF EXISTS libraries.book_copies;
DROP TABLE IF EXISTS libraries.book_loans;
DROP TABLE IF EXISTS libraries.borrower;
DROP TABLE IF EXISTS libraries.library_branch;
DROP TABLE IF EXISTS libraries.publisher;

DROP SCHEMA IF EXISTS libraries;

CREATE SCHEMA IF NOT EXISTS libraries;

--Create the book table
CREATE TABLE IF NOT EXISTS libraries.book (
	book_id SERIAL,
	title VARCHAR NOT NULL,
	publisher_id INT,
	PRIMARY KEY(book_id)
	);
	
--Create the publisher table
CREATE TABLE IF NOT EXISTS libraries.publisher (
	publisher_id SERIAL,
	publisher_name VARCHAR NOT NULL,
	publisher_address VARCHAR NOT NULL,
	publisher_phone VARCHAR NOT NULL,
	PRIMARY KEY(publisher_id)
);

--Create the book_authors table
CREATE TABLE IF NOT EXISTS libraries.book_authors (
	book_id INT,
	author_name VARCHAR NOT NULL,
	FOREIGN KEY(book_id)
	REFERENCES libraries.book(book_id)
);

--Create the library_branch table
CREATE TABLE IF NOT EXISTS libraries.library_branch (
	branch_id SERIAL,
	branch_name VARCHAR NOT NULL,
	branch_address VARCHAR NOT NULL,
	PRIMARY KEY (branch_id)
);

--Create the book_copies table
CREATE TABLE IF NOT EXISTS libraries.book_copies (
	book_id INT,
	branch_id INT,
	no_of_copies INT NOT NULL,
	PRIMARY KEY (book_id, branch_id),
    FOREIGN KEY (book_id) REFERENCES libraries.book(book_id),
    FOREIGN KEY (branch_id) REFERENCES libraries.library_branch(branch_id)
);

--Create the borrower table
CREATE TABLE IF NOT EXISTS libraries.borrower (
	card_no SERIAL,
	borrower_name VARCHAR NOT NULL,
	borrower_address VARCHAR NOT NULL,
	borrower_phone VARCHAR NOT NULL,
	PRIMARY KEY (card_no)
);

--Create the book_loans table
CREATE TABLE IF NOT EXISTS libraries.book_loans (
	loan_id SERIAL,
	book_id INT,
	branch_id INT,
	card_no INT,
	date_out DATE NOT NULL,
	due_date DATE NOT NULL,
	PRIMARY KEY (loan_id),
	FOREIGN KEY (book_id, branch_id) REFERENCES libraries.book_copies(book_id, branch_id),
    FOREIGN KEY (card_no) REFERENCES libraries.borrower(card_no)
);


-- Optional: Insert data into the publisher table
INSERT INTO libraries.publisher (publisher_name, publisher_address, publisher_phone)
VALUES
    ('Publisher A', 'Address A', '123-456-7890'),
    ('Publisher B', 'Address B', '987-654-3210');

-- Optional: Insert data into the library_branch table
INSERT INTO libraries.library_branch (branch_name, branch_address)
VALUES
    ('Branch 1', 'Branch Address 1'),
    ('Branch 2', 'Branch Address 2');

SELECT * from libraries.publisher