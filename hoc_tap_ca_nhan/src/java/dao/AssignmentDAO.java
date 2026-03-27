package dao;

import model.Assignment;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AssignmentDAO {

    public List<Assignment> findBySubject(int subjectId) {
        List<Assignment> list = new ArrayList<>();
        String sql = "SELECT * FROM assignments WHERE subjectId = ? ORDER BY dueDate ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, subjectId);
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

    public boolean insert(Assignment a) {
        String sql = "INSERT INTO assignments(subjectId, title, dueDate) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, a.getSubjectId());
            ps.setString(2, a.getTitle());

            if (a.getDueDate() != null) {
                ps.setTimestamp(3, Timestamp.valueOf(a.getDueDate()));
            } else {
                ps.setNull(3, Types.TIMESTAMP);
            }

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean delete(int id) {
        String sql = "DELETE FROM assignments WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateStatus(int id, String status) {
        String sql = "UPDATE assignments SET status = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}