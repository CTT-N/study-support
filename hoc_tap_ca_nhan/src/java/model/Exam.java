package model;

import java.time.LocalDateTime;

public class Exam {
    private int id;
    private int subjectId;
    private String examTitle;
    private LocalDateTime examDate;
    private String location;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public int getSubjectId() {
        return subjectId;
    }
    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }
    public String getExamTitle() {
        return examTitle;
    }
    public void setExamTitle(String examTitle) {
        this.examTitle = examTitle;
    }
    public LocalDateTime getExamDate() {
        return examDate;
    }
    public void setExamDate(LocalDateTime examDate) {
        this.examDate = examDate;
    }
    public String getLocation() {
        return location;
    }
    public void setLocation(String location) {
        this.location = location;
    }
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

}