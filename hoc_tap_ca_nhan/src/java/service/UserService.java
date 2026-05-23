package service;

import dao.UserDAO;
import model.User;

public class UserService {
    private final UserDAO userDAO = new UserDAO();

    public String updateProfile(User user) {
        String emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$";
        if (user.getEmail() == null || !user.getEmail().matches(emailRegex)) {
            return "Email không hợp lệ";
        }

        if (userDAO.isEmailExists(user.getEmail(), user.getId())) {
            return "Email đã tồn tại";
        }

        return userDAO.updateUser(user) ? "SUCCESS" : "Cập nhật thất bại";
    }

    // thêm các hàm khác như:
    // public User getUserById(int id) { ... }
}