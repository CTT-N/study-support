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
    
    public String changePassword(String username, String oldPass, String newPass, String confirm){
        if (!newPass.equals(confirm)){
            return "Xác nhận mật khẩu không khớp";
        }
        
        // lấy user từ DB
        User u1 = userDAO.findByUsername(username);
        if(u1 == null){
            return "Người dùng không tồn tại";
        }
        if(!u1.getPassword().equals(oldPass)){
            return "Mật khẩu cũ không đúng";
        }
        
        // cap nhat mk
        boolean updated = userDAO.updatePasswordByUsername(username, newPass);
        if(updated){
            return "Đổi mật khẩu thành công";
        }
        return "Đổi mật khẩu thất bại";
    }
    
    // sua thong tin nguoi dung
    public String updateProfile(User user){

        // 1. validate email format
        String email = user.getEmail();
        // biểu thức chính quy (regex) dùng để kiểm tra email có đúng định dạng hay không
        String emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$";

        if (email == null || !email.matches(emailRegex)) {
            return "Email không hợp lệ";
        }

        // 2. check email trùng (trừ chính user)
        boolean exists = userDAO.isEmailExists(email, user.getId()); 

        if (exists) {
            return "Email đã tồn tại";
        }

        // 3. update DB
        boolean updated = userDAO.updateUser(user);

        if (updated) {
            return "SUCCESS";
        }

        return "Cập nhật thất bại";
    }
}