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

    public boolean register(User user) {
        if (userDAO.findByUsername(user.getUsername()) != null) {
            return false; // trùng username
        }
        return userDAO.insert(user);
    }
}