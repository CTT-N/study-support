package dao;

import model.User;
import util.DBConnection;

import java.sql.*;

public class UserDAO {
    
    // dung cho viec dang nhap
    public User findByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setEmail(rs.getString("email"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                return u;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // kiem tra khi co yeu cau tao tai khoan nguoi dung
    public boolean isUsernameOrEmailExists(String username, String email) {
    String sql = "SELECT 1 FROM users WHERE username = ? OR email = ?";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, username);
        ps.setString(2, email);

        ResultSet rs = ps.executeQuery();
        return rs.next(); // có dữ liệu => tồn tại

    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}

    // them tai khoan vao co so du lieu
    public boolean insert(User user) {
        String sql = "INSERT INTO users(username, email, password, fullName) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getFullName());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}