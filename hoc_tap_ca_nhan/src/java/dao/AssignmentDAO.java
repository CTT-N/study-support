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
                a.setDescription(rs.getString("description")); // hiển thị thêm
                a.setType(rs.getString("type")); // thêm
                a.setStatus(rs.getString("status"));

                Timestamp createdTs = rs.getTimestamp("createdAt");
                if (createdTs != null) a.setCreatedAt(createdTs.toLocalDateTime());

                Timestamp dueTs = rs.getTimestamp("dueDate");
                if (dueTs != null) a.setDueDate(dueTs.toLocalDateTime());

                list.add(a);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public boolean insert(Assignment a) {
        String sql = "INSERT INTO assignments(subjectId, title, description, type, dueDate) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, a.getSubjectId());
            ps.setString(2, a.getTitle());
            ps.setString(3, a.getDescription());// ghi ca mo tả
            ps.setString(4, a.getType());

            if (a.getDueDate() != null) {
                ps.setTimestamp(5, Timestamp.valueOf(a.getDueDate()));
            } else {
                ps.setNull(5, Types.TIMESTAMP);
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
        String sql = "UPDATE assignments SET title=?, description=?, type=?, dueDate=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, a.getTitle());
            ps.setString(2, a.getDescription());
            ps.setString(3, a.getType());

            if (a.getDueDate() != null) {
                ps.setTimestamp(4, Timestamp.valueOf(a.getDueDate()));
            } else {
                ps.setNull(4, Types.TIMESTAMP);
            }

            ps.setInt(5, a.getId());

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
                a.setDescription(rs.getString("description"));
                a.setType(rs.getString("type"));

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

