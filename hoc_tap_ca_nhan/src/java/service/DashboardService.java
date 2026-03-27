package service;

import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
                WHERE s.userId = ? AND a.status = 'pending'
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
                WHERE s.userId = ? 
                AND a.status = 'overdue'
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
}