package dao;

import model.Subject;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SubjectDAO {

    public List<Subject> findByUser(int userId) {
        List<Subject> list = new ArrayList<>();
        String sql = """
            select s.*,
              count(distinct case when a.status = 'pending' then a.id end) as totalPending,
              count(distinct case when a.status = 'pending' and a.duedate < now() then a.id end) as totalOverdue,
              count(distinct d.id) as totalDocuments
            from subjects s
            left join assignments a on s.id=a.subjectId
            left join documents d on s.id= d.subjectId
            where s.userId = ?
            group by s.id
                     """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Subject s = new Subject();
                s.setId(rs.getInt("id"));
                s.setSubjectName(rs.getString("subjectName"));
                s.setDescription(rs.getString("description"));
                s.setTotalPending(rs.getInt("totalPending"));
                s.setTotalOverdue(rs.getInt("totalOverdue"));
                s.setTotalDocuments(rs.getInt("totalDocuments"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insert(Subject s) {
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
        String sql = """
            select s.*,
              count(distinct case when a.status = 'pending' then a.id end) as totalPending,
              count(distinct case when a.status = 'pending' and a.duedate < now() then a.id end) as totalOverdue,
              count(distinct d.id) as totalDocuments
            from subjects s
            left join assignments a on s.id=a.subjectId
            left join documents d on s.id= d.subjectId
            where s.userId = ? and lower(s.subjectname) like lower(?)
            group by s.id
                     """;
        
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
                s.setTotalPending(rs.getInt("totalPending"));
                s.setTotalOverdue(rs.getInt("totalOverdue"));
                s.setTotalDocuments(rs.getInt("totalDocuments"));
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