package controller.auth;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.User;
import service.AuthService;

import java.io.IOException;

public class RegisterController extends HttpServlet {
    private AuthService authService = new AuthService();

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User user = new User();
        user.setUsername(req.getParameter("username"));
        user.setPassword(req.getParameter("password"));
        user.setEmail(req.getParameter("email"));
        user.setFullName(req.getParameter("fullName"));

        boolean success = authService.register(user);

        if (success) {
            resp.sendRedirect("login");
        } else {
            req.setAttribute("error", "Username đã tồn tại");
            req.getRequestDispatcher("views/auth/register.jsp").forward(req, resp);
        }
    }
}