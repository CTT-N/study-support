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

        //Check login
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("login");
            return;
        }
        User user = (User) session.getAttribute("user");
        int userId = user.getId();

        //Thống kê
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

        // FORWARD
        req.getRequestDispatcher("/views/dashboard/dashboard.jsp").forward(req, resp);
    }
}