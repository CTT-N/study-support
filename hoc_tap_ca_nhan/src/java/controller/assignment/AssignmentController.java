package controller.assignment;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import dao.AssignmentDAO;
import model.Assignment;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public class AssignmentController extends HttpServlet {

    private AssignmentDAO dao = new AssignmentDAO();

    // LẤY DANH SÁCH
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("edit".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));

            Assignment a = dao.findById(id);

            req.setAttribute("assignment", a);
            req.getRequestDispatcher("/views/assignment/assignment-edit.jsp")
               .forward(req, resp);
            return; // rất quan trọng
        }

        // mặc định: hiển thị list
        int subjectId = Integer.parseInt(req.getParameter("subjectId"));
        List<Assignment> list = dao.findBySubject(subjectId);

        req.setAttribute("assignments", list);
        req.getRequestDispatcher("/views/assignment/assignment-list.jsp")
           .forward(req, resp);
    }

    // Create + update status + delete
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String action = req.getParameter("action");

        if ("create".equals(action)) {

            int subjectId = Integer.parseInt(req.getParameter("subjectId"));
            String title = req.getParameter("title");
            String due = req.getParameter("dueDate");

            Assignment a = new Assignment();
            a.setSubjectId(subjectId);
            a.setTitle(title);

            if (due != null && !due.isEmpty()) {

                LocalDate dueLocalDate = LocalDate.parse(due);
                LocalDate today = LocalDate.now();

                // validate
                if (dueLocalDate.isBefore(today)) {
                    req.setAttribute("error", "Hạn làm việc không hợp lý, mời chọn lại");
                    req.setAttribute("assignments", dao.findBySubject(subjectId));

                    req.getRequestDispatcher("/views/assignment/list.jsp").forward(req, resp);
                    return;
                }

                // convert đúng
                a.setDueDate(dueLocalDate.atStartOfDay());
            }

            dao.insert(a);

            resp.sendRedirect("assignments?subjectId=" + subjectId);
            return;
        
        } else if ("updateStatus".equals(action)) {

            int id = Integer.parseInt(req.getParameter("id"));
            String status = req.getParameter("status");

            dao.updateStatus(id, status);
            
            resp.sendRedirect("assignments?subjectId=" + req.getParameter("subjectId"));
            return;
            
        } else if ("delete".equals(action)) {

            int id = Integer.parseInt(req.getParameter("id"));
            dao.delete(id);
            
            resp.sendRedirect("assignments?subjectId=" + req.getParameter("subjectId"));
            return;
            
        } else if ("update".equals(action)) {

            int id = Integer.parseInt(req.getParameter("id"));
            int subjectId = Integer.parseInt(req.getParameter("subjectId"));
            String title = req.getParameter("title");
            String due = req.getParameter("dueDate");

            Assignment a = new Assignment();
            a.setId(id);
            a.setSubjectId(subjectId);
            a.setTitle(title);

            if (due != null && !due.isEmpty()) {

                LocalDate dueLocalDate = LocalDate.parse(due);
                LocalDate today = LocalDate.now();

                // validate
                if (dueLocalDate.isBefore(today)) {
                    req.setAttribute("error", "Hạn làm việc không hợp lý");

                    Assignment old = dao.findById(id);
                    req.setAttribute("assignment", old);

                    req.getRequestDispatcher("/views/assignment/edit.jsp")
                       .forward(req, resp);
                    return;
                }

                a.setDueDate(dueLocalDate.atStartOfDay());
            }

            dao.update(a);

            resp.sendRedirect("assignments?subjectId=" + subjectId);
            return;
        }
    }
}