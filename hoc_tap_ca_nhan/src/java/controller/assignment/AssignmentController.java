package controller.assignment;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import dao.AssignmentDAO;
import model.Assignment;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

public class AssignmentController extends HttpServlet {

    private AssignmentDAO dao = new AssignmentDAO();

    // LẤY DANH SÁCH
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int subjectId = Integer.parseInt(req.getParameter("subjectId"));

        List<Assignment> list = dao.findBySubject(subjectId);

        req.setAttribute("assignments", list);
        req.getRequestDispatcher("views/assignment/list.jsp").forward(req, resp);
    }

    // CREATE + UPDATE STATUS
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String action = req.getParameter("action");

        if ("create".equals(action)) {

            Assignment a = new Assignment();
            a.setSubjectId(Integer.parseInt(req.getParameter("subjectId")));
            a.setTitle(req.getParameter("title"));

            String due = req.getParameter("dueDate");
            if (due != null && !due.isEmpty()) {
                a.setDueDate(LocalDateTime.parse(due));
            }

            dao.insert(a);

        } else if ("updateStatus".equals(action)) {

            int id = Integer.parseInt(req.getParameter("id"));
            String status = req.getParameter("status");

            dao.updateStatus(id, status);
        }

        resp.sendRedirect("assignments?subjectId=" + req.getParameter("subjectId"));
    }
}