package controller.auth;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.User;
import service.AuthService;

import java.io.IOException;

public class RegisterController extends HttpServlet {
    private AuthService authService = new AuthService();
    
    // hien thi trang register
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
    }
    // xu ly dang ky tai khoan nguoi dung
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        // lay du lieu da nhap
        String email = req.getParameter("email");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirmP = req.getParameter("confirmPassword");
        
        // validate co ban
        if(email == null || username==null || password==null || confirmP==null
                || email.isEmpty() || username.isEmpty() || password.isEmpty() ){
            req.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
        }
        
        // kiem tra lai phan mat khau
        if(!password.equals(confirmP)){
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
            return;
        }
        // tao user
        User u1 = new User();
        u1.setEmail(email);
        u1.setUsername(username);
        u1.setPassword(password);
        
        // goi service
        boolean success = authService.register(u1);

        if (success) {
            resp.sendRedirect("login");
        } else {
            req.setAttribute("error", "Username hoặc đã tồn tại");
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
        }
    }
}