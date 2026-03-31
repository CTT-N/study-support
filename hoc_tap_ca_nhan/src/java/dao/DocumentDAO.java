package dao;

import model.Document;
import util.DBConnection;

import java.sql.*;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

public class DocumentDAO {

    public boolean insert(Document d) {
        String sql = "INSERT INTO documents(subjectId, documentName, filePath, fileType, fileSize) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, d.getSubjectId());
            ps.setString(2, d.getDocumentName());
            ps.setString(3, d.getFilePath());
            ps.setString(4, d.getFileType());
            ps.setLong(5, d.getFileSize());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<Document> findBySubject(int subjectId){
        List<Document> ds = new ArrayList<>();
        String sql = "select * from documents where subjectId = ?";
        
        try(Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setInt(1, subjectId);
            ResultSet rs = ps.executeQuery();
        // upload tai lieu len trong mon hoc    
            while(rs.next()){
                Document d = new Document();
                d.setId(rs.getInt("id"));
                d.setDocumentName(rs.getString("documentName"));
                d.setFilePath(rs.getString("filePath"));
                d.setFileSize(rs.getLong("fileSize"));
                d.setFileType(rs.getString("fileType"));
                ds.add(d);
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return ds;
    }
    
    public boolean delete(int id){
        String sql = "delete from documents where id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e){
            e.printStackTrace();
        }
        return false;
    }
}