package controller.auth;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import service.AuthService;
import model.User;

import java.io.IOException;

public class LoginController extends HttpServlet {
    private AuthService authService = new AuthService();

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = authService.login(username, password);

        if (user != null) {
            req.getSession().setAttribute("user", user);
            resp.sendRedirect("dashboard");
        } else {
            req.setAttribute("error", "Sai tài khoản hoặc mật khẩu");
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
        }
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
    }
}