package dao;

import model.Document;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

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
}