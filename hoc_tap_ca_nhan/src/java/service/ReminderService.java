package service;

import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/*
     Ý tưởng:
    - Mỗi 1 phút chạy 1 lần
    - Lấy reminder chưa gửi (isSent = false)
    - Nếu đến thời gian → xử lý (in log / sau này gửi email)
    - Update isSent = true
*/

public class ReminderService {

    private ScheduledExecutorService scheduler = Executors.newSingleThreadScheduledExecutor();

    public void start() {

        scheduler.scheduleAtFixedRate(() -> {

            try (Connection conn = DBConnection.getConnection()) {

                String sql = "SELECT * FROM reminders WHERE isSent = false AND remindTime <= NOW()";

                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {

                    int id = rs.getInt("id");
                    String message = rs.getString("message");

                    // Hiện tại chỉ in ra console
                    System.out.println("REMINDER: " + message);

                    // Đánh dấu đã gửi
                    PreparedStatement update = conn.prepareStatement(
                            "UPDATE reminders SET isSent = true WHERE id = ?"
                    );
                    update.setInt(1, id);
                    update.executeUpdate();
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

        }, 0, 1, TimeUnit.MINUTES); // chạy mỗi 1 phút
    }
}