package controller.dashboard;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.User;
import model.Assignment;
import service.DashboardService;

import java.io.IOException;
import java.util.List;

public class DashboardController extends HttpServlet {

    private DashboardService service = new DashboardService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("login");
            return;
        }
        User user = (User) session.getAttribute("user");
        int userId = user.getId();

        // Số liệu thống kê
        int totalSubjects = service.countSubjects(userId);
        int pendingAssignments = service.countPendingAssignments(userId);
        int overdueAssignments = service.countOverdueAssignments(userId);

        //Assignment sắp đến hạn
        List<Assignment> upcoming = service.getUpcomingAssignments(userId);

        // SET DATA
        req.setAttribute("totalSubjects", totalSubjects);
        req.setAttribute("pendingAssignments", pendingAssignments);
        req.setAttribute("overdueAssignments", overdueAssignments);
        req.setAttribute("upcoming", upcoming);

        req.setAttribute("activePage", "dashboard");
        req.setAttribute("pageTitle", "Trang chủ");
        req.setAttribute("pageCss", "dashboard.css");
        req.setAttribute("contentPage", "/views/dashboard/dashboard.jsp");

        req.getRequestDispatcher("/views/common/layout.jsp")
               .forward(req, resp);
    }
}