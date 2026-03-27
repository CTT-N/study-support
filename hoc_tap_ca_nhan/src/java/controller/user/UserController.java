package controller.user;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;

public class UserController extends HttpServlet {

    // XEM PROFILE
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("user");

        req.setAttribute("user", user);
        req.getRequestDispatcher("views/user/profile.jsp").forward(req, resp);
    }

    // UPDATE PROFILE
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        user.setFullName(req.getParameter("fullName"));
        user.setEmail(req.getParameter("email"));

        // ⚠️ hiện chưa update DB (bạn có thể thêm UserDAO.update)

        session.setAttribute("user", user);

        resp.sendRedirect("profile");
    }
}