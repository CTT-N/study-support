package controller.dashboard;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.User;
import service.DashboardService;

import java.io.IOException;

public class DashboardController extends HttpServlet {

    private DashboardService service = new DashboardService();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("user");

        int userId = user.getId();

        // LẤY DATA
        int totalSubjects = service.countSubjects(userId);
        int pendingAssignments = service.countPendingAssignments(userId);
        int overdueAssignments = service.countOverdueAssignments(userId);

        // SET JSP
        req.setAttribute("totalSubjects", totalSubjects);
        req.setAttribute("pendingAssignments", pendingAssignments);
        req.setAttribute("overdueAssignments", overdueAssignments);

        req.getRequestDispatcher("views/dashboard/dashboard.jsp").forward(req, resp);
    }
}