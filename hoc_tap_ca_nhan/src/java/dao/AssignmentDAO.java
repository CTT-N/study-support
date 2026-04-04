package dao;

import model.Assignment;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AssignmentDAO {

    public List<Assignment> findBySubject(int subjectId) {
        List<Assignment> list = new ArrayList<>();

        String sql = "SELECT * FROM assignments WHERE subjectId = ? " +
                     "ORDER BY " +
                     "CASE " +
                     "WHEN status = 'overdue' THEN 1 " +
                     "WHEN status = 'pending' THEN 2 " +
                     "WHEN status = 'done' THEN 3 " +
                     "END, dueDate ASC";

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

                // createdAt
                Timestamp createdTs = rs.getTimestamp("createdAt");
                if (createdTs != null) {
                    a.setCreatedAt(createdTs.toLocalDateTime());
                }

                // dueDate
                Timestamp dueTs = rs.getTimestamp("dueDate");
                if (dueTs != null) {
                    a.setDueDate(dueTs.toLocalDateTime());
                }

                // tự động đánh dấu quá hạn
                if (a.getDueDate() != null
                        && a.getDueDate().isBefore(java.time.LocalDateTime.now())
                        && !"done".equalsIgnoreCase(a.getStatus())) {

                    a.setStatus("overdue");
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

    // cap nhat trang thai
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
    
    // thay doi thong tin ve nhiem vu
    public boolean update(Assignment a) {
        String sql = "UPDATE assignments SET title = ?, dueDate = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, a.getTitle());

            if (a.getDueDate() != null) {
                ps.setTimestamp(2, Timestamp.valueOf(a.getDueDate()));
            } else {
                ps.setNull(2, Types.TIMESTAMP);
            }

            ps.setInt(3, a.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Assignment findById(int id) {
        String sql = "SELECT * FROM assignments WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Assignment a = new Assignment();

                a.setId(rs.getInt("id"));
                a.setSubjectId(rs.getInt("subjectId"));
                a.setTitle(rs.getString("title"));
                a.setStatus(rs.getString("status"));

                Timestamp createdTs = rs.getTimestamp("createdAt");
                if (createdTs != null) {
                    a.setCreatedAt(createdTs.toLocalDateTime());
                }

                Timestamp dueTs = rs.getTimestamp("dueDate");
                if (dueTs != null) {
                    a.setDueDate(dueTs.toLocalDateTime());
                }

                return a;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}

