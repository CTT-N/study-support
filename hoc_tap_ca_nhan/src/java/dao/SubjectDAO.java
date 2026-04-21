package dao;

import model.Subject;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SubjectDAO {

    public List<Subject> findByUser(int userId) {
        List<Subject> list = new ArrayList<>();

        // tìm môn học theo mã nguoi dung
        String sql = "SELECT * FROM subjects WHERE userId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Subject s = new Subject();
                s.setId(rs.getInt("id"));
                s.setSubjectName(rs.getString("subjectName"));
                s.setDescription(rs.getString("description"));
                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insert(Subject s) {
        // thêm môn học mới
        String sql = "INSERT INTO subjects(userId, subjectName, description) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, s.getUserId());
            ps.setString(2, s.getSubjectName());
            ps.setString(3, s.getDescription());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean delete(int id) {
        // khi xóa thư mục môn học
        String sql = "DELETE FROM subjects WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public List<Subject> findByName(int userId, String key){
        List<Subject> ds = new ArrayList<>();
        String sql = "SELECT * FROM subjects WHERE userId = ? AND LOWER(subjectName) LIKE LOWER(?)";

        try(Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setString(2, "%" + key + "%");

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                Subject s = new Subject();
                s.setId(rs.getInt("id"));
                s.setSubjectName(rs.getString("subjectName"));
                s.setDescription(rs.getString("description"));
                ds.add(s);
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        return ds;
    }
        public Subject findById(int id) {
        String sql = "SELECT * FROM subjects WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Subject s = new Subject();
                s.setId(rs.getInt("id"));
                s.setSubjectName(rs.getString("subjectName"));
                s.setDescription(rs.getString("description"));
                return s;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}