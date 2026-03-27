package model;

import java.time.LocalDateTime;

public class Reminder {
    private int id;
    private int userId;
    private String type;
    private Integer assignmentId;
    private Integer examId;
    private LocalDateTime remindTime;
    private String message;
    private boolean isSent;
    private LocalDateTime createdAt;
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
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }
    public Integer getAssignmentId() {
        return assignmentId;
    }
    public void setAssignmentId(Integer assignmentId) {
        this.assignmentId = assignmentId;
    }
    public Integer getExamId() {
        return examId;
    }
    public void setExamId(Integer examId) {
        this.examId = examId;
    }
    public LocalDateTime getRemindTime() {
        return remindTime;
    }
    public void setRemindTime(LocalDateTime remindTime) {
        this.remindTime = remindTime;
    }
    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }
    public boolean isSent() {
        return isSent;
    }
    public void setSent(boolean isSent) {
        this.isSent = isSent;
    }
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

}