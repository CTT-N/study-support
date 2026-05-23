package controller.auth;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.User;
import service.AuthService;

import java.io.IOException;

public class RegisterController extends HttpServlet {
    private AuthService authService = new AuthService();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 1. Lấy dữ liệu đã nhập
        String fullName = req.getParameter("fullName"); // Đảm bảo đã đồng bộ name="fullName" từ form
        String email = req.getParameter("email");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirmP = req.getParameter("confirmPassword");

        // 2. Validate cơ bản: Bắt buộc điền đủ thông tin
        if (email == null || username == null || password == null || confirmP == null
                || email.trim().isEmpty() || username.trim().isEmpty() || password.isEmpty()) {

            req.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
            return;
        }

        // 3. Validate mật khẩu xác nhận
        if (!password.equals(confirmP)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
            return;
        }

        // 4. Nếu vượt qua tất cả kiểm tra, mới tiến hành lưu Database
        User u1 = new User();
        u1.setFullName(fullName);
        u1.setEmail(email);
        u1.setUsername(username);
        u1.setPassword(password);

        boolean success = authService.register(u1);

        if (success) {
            resp.sendRedirect("login");
        } else {
            req.setAttribute("error", "Username hoặc email đã tồn tại");
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
        }
    }
}