## SQL-Learning !
#This explains almost all the functions used in SQL for a simple database system.
# 🎓 University Database Management System

A foundational relational database project built using **Microsoft SQL Server (T-SQL)**. This repository contains the structural schema design, relational constraints, basic data population, and various data manipulation queries designed for a university management ecosystem.

## 🗂️ Database Architecture

The system uses a highly structured relational system consisting of 4 core tables linked via Primary and Foreign Keys:
*   **Departments:** Stores academic faculties (`DeptID`, `DeptName`, `Location`).
*   **Students:** Tracks student enrollment records and dynamically links them to departments.
*   **Courses:** Manages university course offerings, catalogs, and credit distributions.
*   **Enrollments:** A junction/associative table handling the many-to-many relationship mapping students to their respective courses per semester.
*   **Instructors:** they are assigned courses and are from specific departments.

## 🚀 Key SQL Concepts Implemented

This project acts as a practical script covering a wide range of SQL query standards:
*   **DDL (Data Definition Language):** Designing tables with `IDENTITY(1,1)` autoincrement keys and active relational constraints (`FOREIGN KEY REFERENCES`).
*   **DML (Data Manipulation Language):** Advanced filtering utilizing `SELECT`, `WHERE`, `UPDATE`, `DELETE`, and `TRUNCATE`.
*   **Logical & Search Operators:** String filtering and custom lookups using `IN`, `OR`, `NOT`, and `LIKE` pattern matching wildcards.
*   **Relational Joins:** Connecting multidimensional structures via `INNER JOIN` statements to generate comprehensive, human-readable student-course profiles.
*   **Built-in & User Functions:** String manipulation techniques (`UPPER`, `LOWER`, `LEN`), Date calculations (`DATEDIFF`, `GETDATE`), and Custom Scalar Functions.

## 💻 Environment & Tools Used
*   **Database Engine:** Microsoft SQL Server (v17.0)
*   **Management IDE:** SQL Server Management Studio (SSMS)
*   **Version Control:** GitHub Web Upload UI
