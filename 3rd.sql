
DROP TABLE IF EXISTS StudentEnrollments;

CREATE TABLE StudentEnrollments (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    course_id VARCHAR(10) NOT NULL,
    enrollment_date DATE NOT NULL
) ENGINE=InnoDB;

INSERT INTO StudentEnrollments VALUES 
(1, 'Ashish', 'CSE101', '2024-06-01'),
(2, 'Smaran', 'CSE102', '2024-06-01'),
(3, 'Vaibhav', 'CSE103', '2024-06-01');

SELECT 'Initial Table State' AS Step;
SELECT * FROM StudentEnrollments;

START TRANSACTION;

UPDATE StudentEnrollments 
SET enrollment_date='2024-06-10'
WHERE student_id=1;

DO SLEEP(1); 
UPDATE StudentEnrollments 
SET enrollment_date='2024-06-15'
WHERE student_id=2;
UPDATE StudentEnrollments 
SET enrollment_date='2024-06-20'
WHERE student_id=1;

COMMIT;

SELECT 'After Deadlock Simulation' AS Step;
SELECT * FROM StudentEnrollments;
START TRANSACTION;

SELECT * FROM StudentEnrollments WHERE student_id=1; 
UPDATE StudentEnrollments 
SET enrollment_date='2024-07-10'
WHERE student_id=1;
COMMIT;
SELECT * FROM StudentEnrollments WHERE student_id=1;
COMMIT;
SELECT * FROM StudentEnrollments WHERE student_id=1;
START TRANSACTION;

SELECT * FROM StudentEnrollments WHERE student_id=2 FOR UPDATE;
UPDATE StudentEnrollments SET enrollment_date='2024-08-01' WHERE student_id=2;

DO SLEEP(2);
COMMIT;
START TRANSACTION;
SELECT * FROM StudentEnrollments WHERE student_id=2; 
COMMIT;
SELECT 'Final Table State' AS Step;
SELECT * FROM StudentEnrollments;
