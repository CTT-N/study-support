DROP DATABASE IF EXISTS study_support;
CREATE DATABASE study_support;
USE study_support;

/*
select * from users
select * from documents
select * from assignments
select * from subjects
*/

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    fullName VARCHAR(100),

    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE subjects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    subjectName VARCHAR(100) NOT NULL,
    description TEXT,

    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX idx_subject_user ON subjects(userId);

-- ASSIGNMENTS (TASK + EXAM)
CREATE TABLE assignments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subjectId INT NOT NULL,

    title VARCHAR(200) NOT NULL,
    description TEXT,

    -- Gộp type
    type ENUM('TASK', 'EXAM') DEFAULT 'TASK',

    dueDate DATETIME,

    -- Chỉ giữ trạng thái thật, nếu quá hạn làm mà vẫn pending thì hệ thống sẽ tự cập nhật
    status ENUM('PENDING', 'DONE') DEFAULT 'PENDING',

    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (subjectId) REFERENCES subjects(id) ON DELETE CASCADE
);

-- Index tối ưu query
CREATE INDEX idx_assignment_subject ON assignments(subjectId);
CREATE INDEX idx_assignment_due ON assignments(dueDate);
CREATE INDEX idx_assignment_status ON assignments(status);
CREATE INDEX idx_assignment_type ON assignments(type);

CREATE TABLE documents (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subjectId INT NOT NULL,

    documentName VARCHAR(255),
    filePath VARCHAR(255),
    fileType VARCHAR(20),
    fileSize BIGINT,

    uploadDate DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (subjectId) REFERENCES subjects(id) ON DELETE CASCADE
);

CREATE INDEX idx_doc_subject ON documents(subjectId);