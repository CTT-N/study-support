package controller.user;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.User;
import service.AuthService;

import java.io.IOException;

public class UserController extends HttpServlet {

    private AuthService authService = new AuthService();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // check login
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        String action = req.getParameter("action");

        // vào trang edit profile
        if ("editProfile".equals(action)) {
            req.setAttribute("activePage", "profile");
            req.setAttribute("pageTitle", "Sửa thông tin");
            req.setAttribute("pageCss", "edit-profile.css");
            req.setAttribute("contentPage", "/views/user/editProfile.jsp");
            // forward
            req.getRequestDispatcher("/views/common/layout.jsp")
               .forward(req, resp);
            return;
        }

        // mặc định: profile
        User user = (User) session.getAttribute("user");
        //set data
        req.setAttribute("user", user);
        //set layout
        req.setAttribute("activePage", "profile");
        req.setAttribute("pageTitle", "Thông tin người dùng");
        req.setAttribute("pageCss", "profile.css");
        req.setAttribute("contentPage", "/views/user/profile.jsp");
        // forward
        req.getRequestDispatcher("/views/common/layout.jsp")
           .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        String action = req.getParameter("action");

        if ("editProfile".equals(action)) {

            User user = (User) session.getAttribute("user");

            String fullName = req.getParameter("fullName");
            String email = req.getParameter("email");

            user.setFullName(fullName);
            user.setEmail(email);

            String result = authService.updateProfile(user);

            if ("SUCCESS".equals(result)) {

                session.setAttribute("user", user);

                // redirect + message qua param
                resp.sendRedirect(req.getContextPath() + "/user?msg=updated");
                return;

            } else {
                // forward lại layout (KHÔNG forward jsp trực tiếp)
                req.setAttribute("error", result);

                req.setAttribute("activePage", "profile");
                req.setAttribute("pageTitle", "Sửa thông tin");
                req.setAttribute("pageCss", "edit-profile.css");
                req.setAttribute("contentPage", "/views/user/editProfile.jsp");

                req.getRequestDispatcher("/views/common/layout.jsp")
                   .forward(req, resp);
            }
        }
    }
}