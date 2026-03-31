package controller.auth;
import service.AuthService;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;


public class ChangePasswordController extends HttpServlet {
    private AuthService authService = new AuthService();
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {
        req.getRequestDispatcher("/views/auth/changePassword.jsp").forward(req, resp);
    }
    
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {
        HttpSession session = req.getSession(false);
        
        // kiem tra dang nhap?
        if(session == null || session.getAttribute("user")==null){
            resp.sendRedirect("index.jsp");
            return;
        }
        
        // lấy user từ session
        User u1 = (User) session.getAttribute("user");
        
        String oldPass = req.getParameter("oldPass");
        String newPass = req.getParameter("newPass");
        String confirm = req.getParameter("confirm");
        
        // gọi service
        String result = authService.changePassword(
                u1.getUsername(), oldPass, newPass, confirm);
        
        if ("SUCCESS".equals(result)){
            req.setAttribute("success", "Đổi mật khẩu thành công!");
        } else {
            req.setAttribute("error", result);
        }
        
        req.getRequestDispatcher("/views/auth/changePassword.jsp").forward(req, resp);
    }
}
