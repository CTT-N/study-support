package model;

import java.time.LocalDateTime;

public class Subject {
    private int id;
    private int userId;
    private String subjectName;
    private String description;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private int totalPending;
    private int totalOverdue;
    private int totalDocuments;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }
    public String getSubjectName() {
        return subjectName;
    }
    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
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
    public int getTotalPending() { return totalPending; }
    public void setTotalPending(int totalPending) { this.totalPending = totalPending; }

    public int getTotalOverdue() { return totalOverdue; }
    public void setTotalOverdue(int totalOverdue) { this.totalOverdue = totalOverdue; }
    
    public int getTotalDocuments() { return totalDocuments; }
    public void setTotalDocuments(int totalDocuments) { this.totalDocuments = totalDocuments; }
}