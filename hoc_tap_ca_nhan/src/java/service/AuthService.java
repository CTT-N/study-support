package service;

import dao.UserDAO;
import model.User;

public class AuthService {
    private UserDAO userDAO = new UserDAO();

    public User login(String username, String password) {
        User user = userDAO.findByUsername(username);

        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }

    public boolean register(User u1) {
        if (userDAO.isUsernameOrEmailExists(u1.getUsername(), u1.getEmail())) {
            return false; // trùng username hoac email
        }
        return userDAO.insert(u1);
    }
}