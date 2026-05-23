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
        req.setAttribute("activePage", "password");
        req.setAttribute("pageTitle", "Đổi mật khẩu");
    //    req.setAttribute("pageCss", "changePassword.css");
        req.setAttribute("contentPage", "/views/auth/changePassword.jsp");

        req.getRequestDispatcher("/views/common/layout.jsp")
           .forward(req, resp);
    }
    
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws IOException, ServletException {
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("login");
            return;
        }

        User u1 = (User) session.getAttribute("user");

        String oldPass = req.getParameter("oldPass");
        String newPass = req.getParameter("newPass");
        String confirm = req.getParameter("confirm");

        String result = authService.changePassword(
                u1.getUsername(), oldPass, newPass, confirm);

        if ("Đổi mật khẩu thành công".equals(result)) {
            req.setAttribute("success", result);

            u1.setPassword(newPass);
            session.setAttribute("user", u1);
        } else {
            req.setAttribute("error", result);
        }

        req.setAttribute("activePage", "password");
        req.setAttribute("pageTitle", "Đổi mật khẩu");
    //    req.setAttribute("pageCss", "changePassword.css");
        req.setAttribute("contentPage", "/views/auth/changePassword.jsp");

        req.getRequestDispatcher("/views/common/layout.jsp").forward(req, resp);
    }
}
