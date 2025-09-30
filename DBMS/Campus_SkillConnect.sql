-- Create database
CREATE DATABASE KUNAL;
USE KUNAL;

-- Students table
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    program VARCHAR(50),
    intake_year INT
);

-- Companies table
CREATE TABLE Companies (
    company_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    industry VARCHAR(100),
    headquarters_city VARCHAR(100)
);

-- Jobs table
CREATE TABLE Jobs (
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    company_id INT,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    openings INT DEFAULT 0,
    FOREIGN KEY (company_id) REFERENCES Companies(company_id)
        ON DELETE CASCADE
);

-- Applications table
CREATE TABLE Applications (
    application_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    job_id INT,
    status VARCHAR(50) DEFAULT 'APPLIED',
    applied_on DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
        ON DELETE CASCADE,
    FOREIGN KEY (job_id) REFERENCES Jobs(job_id)
        ON DELETE RESTRICT
);

-- Interviews table
CREATE TABLE Interviews (
    interview_id INT AUTO_INCREMENT PRIMARY KEY,
    application_id INT,
    interview_date DATE,
    round_number INT,
    feedback VARCHAR(255),
    FOREIGN KEY (application_id) REFERENCES Applications(application_id)
        ON DELETE CASCADE
);

-- Offers table
CREATE TABLE Offers (
    offer_id INT AUTO_INCREMENT PRIMARY KEY,
    application_id INT UNIQUE,
    status ENUM('PENDING', 'ACCEPTED', 'REJECTED') DEFAULT 'PENDING',
    offer_date DATE,
    FOREIGN KEY (application_id) REFERENCES Applications(application_id)
        ON DELETE CASCADE
);

-- Trigger: Ensure only one accepted offer per student
DELIMITER $$
CREATE TRIGGER one_offer_per_student
BEFORE UPDATE ON Offers
FOR EACH ROW
BEGIN
    IF NEW.status = 'ACCEPTED' THEN
        IF EXISTS (
            SELECT 1
            FROM Offers o
            JOIN Applications a ON o.application_id = a.application_id
            WHERE a.student_id = (
                SELECT student_id FROM Applications WHERE application_id = NEW.application_id
            )
            AND o.status = 'ACCEPTED'
            AND o.offer_id != NEW.offer_id
        ) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'A student can only have one accepted offer.';
        END IF;
    END IF;
END$$
DELIMITER ;

-- Students
INSERT INTO Students (name, email, program, intake_year) VALUES
('Amit Sharma', 'amit.sharma@example.com', 'MCA', 2023),
('Neha Verma', 'neha.verma@example.com', 'MCA', 2023),
('Rahul Mehta', 'rahul.mehta@example.com', 'MBA', 2022),
('Priya Singh', 'priya.singh@example.com', 'B.Tech', 2021),
('Kunal Patel', 'kunal.patel@example.com', 'MCA', 2022),
('Sonia Kapoor', 'sonia.kapoor@example.com', 'B.Sc', 2023),
('Arjun Nair', 'arjun.nair@example.com', 'M.Tech', 2021),
('Meera Joshi', 'meera.joshi@example.com', 'MCA', 2023);

-- Companies
INSERT INTO Companies (name, industry, headquarters_city) VALUES
('TechNova', 'Software', 'Bangalore'),
('FinEdge', 'Finance', 'Mumbai'),
('HealthPlus', 'Healthcare', 'Delhi');

-- Jobs
INSERT INTO Jobs (company_id, title, description, openings) VALUES
(1, 'Software Engineer', 'Backend development role', 3),
(1, 'Data Analyst', 'SQL and BI tools role', 2),
(2, 'Financial Analyst', 'Equity research role', 2),
(2, 'Risk Manager', 'Risk assessment role', 1),
(3, 'Healthcare Consultant', 'Advisory services', 2),
(3, 'ML Engineer', 'AI and ML based healthcare solutions', 0); -- job with 0 openings

-- Applications (20 total)
INSERT INTO Applications (student_id, job_id, status, applied_on) VALUES
(1, 1, 'APPLIED', '2025-09-01'),
(2, 1, 'INTERVIEWING', '2025-09-01'),
(3, 2, 'APPLIED', '2025-09-02'),
(4, 2, 'APPLIED', '2025-09-02'),
(5, 3, 'APPLIED', '2025-09-03'),
(6, 3, 'INTERVIEWING', '2025-09-03'),
(7, 4, 'APPLIED', '2025-09-04'),
(8, 4, 'APPLIED', '2025-09-04'),
(1, 5, 'APPLIED', '2025-09-05'),
(2, 5, 'APPLIED', '2025-09-05'),
(3, 5, 'APPLIED', '2025-09-05'),
(4, 5, 'APPLIED', '2025-09-05'),
(5, 6, 'APPLIED', '2025-09-06'),
(6, 6, 'APPLIED', '2025-09-06'),
(7, 1, 'APPLIED', '2025-09-07'),
(8, 1, 'APPLIED', '2025-09-07'),
(1, 2, 'APPLIED', '2025-09-08'),
(2, 3, 'APPLIED', '2025-09-08'),
(3, 4, 'APPLIED', '2025-09-09'),
(4, 6, 'APPLIED', '2025-09-09');

-- Interviews (10 total)
INSERT INTO Interviews (application_id, interview_date, round_number, feedback) VALUES
(2, '2025-09-10', 1, 'Good SQL knowledge'),
(3, '2025-09-11', 1, 'Average performance'),
(6, '2025-09-12', 1, 'Strong domain expertise'),
(7, '2025-09-13', 1, 'Good communication'),
(10, '2025-09-14', 1, 'Positive impression'),
(11, '2025-09-15', 1, 'Needs improvement'),
(12, '2025-09-16', 1, 'Well prepared'),
(15, '2025-09-17', 1, 'Strong technical skills'),
(16, '2025-09-18', 1, 'Weak fundamentals'),
(17, '2025-09-19', 1, 'Impressive answers');

-- Offers (3 total)
INSERT INTO Offers (application_id, status, offer_date) VALUES
(2, 'ACCEPTED', '2025-09-20'),
(6, 'PENDING', '2025-09-21'),
(10, 'REJECTED', '2025-09-22');

CREATE VIEW StudentPipeline AS
SELECT 
    s.student_id,
    s.name AS student_name,
    j.title AS job_title,
    c.name AS company_name,
    a.status AS application_status,
    MAX(i.interview_date) AS last_interview_date,
    o.status AS offer_status
FROM Students s
LEFT JOIN Applications a ON s.student_id = a.student_id
LEFT JOIN Jobs j ON a.job_id = j.job_id
LEFT JOIN Companies c ON j.company_id = c.company_id
LEFT JOIN Interviews i ON a.application_id = i.application_id
LEFT JOIN Offers o ON a.application_id = o.application_id
GROUP BY s.student_id, s.name, j.title, c.name, a.status, o.status;

SELECT * FROM StudentPipeline;