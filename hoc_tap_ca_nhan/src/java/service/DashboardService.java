package service;

import model.Assignment;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DashboardService {

    public int countSubjects(int userId) {
        String sql = "SELECT COUNT(*) FROM subjects WHERE userId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int countPendingAssignments(int userId) {
        String sql = """
                SELECT COUNT(*) 
                FROM assignments a
                JOIN subjects s ON a.subjectId = s.id
                WHERE s.userId = ? AND a.status = 'PENDING'
                """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int countOverdueAssignments(int userId) {
        String sql = """
                SELECT COUNT(*) 
                FROM assignments a
                JOIN subjects s ON a.subjectId = s.id
                WHERE s.userId = ? AND a.status = 'OVERDUE'
                """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Assignment> getUpcomingAssignments(int userId) {
        List<Assignment> list = new ArrayList<>();

        String sql = """
                SELECT a.*
                FROM assignments a
                JOIN subjects s ON a.subjectId = s.id
                WHERE s.userId = ?
                AND a.status = 'PENDING'
                AND a.dueDate IS NOT NULL
                ORDER BY a.dueDate ASC
                LIMIT 5
                """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Assignment a = new Assignment();

                a.setId(rs.getInt("id"));
                a.setSubjectId(rs.getInt("subjectId"));
                a.setTitle(rs.getString("title"));
                a.setStatus(rs.getString("status"));

                Timestamp ts = rs.getTimestamp("dueDate");
                if (ts != null) {
                    a.setDueDate(ts.toLocalDateTime());
                }

                list.add(a);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}