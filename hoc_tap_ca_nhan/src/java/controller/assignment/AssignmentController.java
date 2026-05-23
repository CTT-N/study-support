package controller.assignment;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import dao.AssignmentDAO;
import dao.SubjectDAO;
import model.Assignment;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import model.Subject;

public class AssignmentController extends HttpServlet {

    private AssignmentDAO dao = new AssignmentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("edit".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));

            Assignment a = dao.findById(id);

            req.setAttribute("assignment", a);
            req.setAttribute("contentPage", "/views/assignment/assignment-edit.jsp");
            req.getRequestDispatcher("/views/common/layout.jsp")
                .forward(req, resp);
            return;
        }

        // mặc định: hiển thị list
        int subjectId = Integer.parseInt(req.getParameter("subjectId"));
        List<Assignment> list = dao.findBySubject(subjectId);
        SubjectDAO subjectDAO = new SubjectDAO();
        Subject subject = subjectDAO.findById(subjectId);
        
        //set data
        req.setAttribute("subject", subject);
        req.setAttribute("assignments", list);
        // set layout
        req.setAttribute("activePage", "subjects");
        req.setAttribute("pageTitle", "Nhiệm vụ");
        req.setAttribute("pageCss", "assignment.css");
        req.setAttribute("contentPage", "/views/assignment/assignment-list.jsp");
        
        req.getRequestDispatcher("/views/common/layout.jsp")
            .forward(req, resp);
    }

    // Create + update status + delete
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String action = req.getParameter("action");

        if ("create".equals(action)) {
            int subjectId = Integer.parseInt(req.getParameter("subjectId"));
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            String type = req.getParameter("type");
            String due = req.getParameter("dueDate");

            Assignment a = new Assignment();
            a.setSubjectId(subjectId);
            a.setTitle(title);
            a.setDescription(description);

            // type mặc định
            if (type == null || type.isEmpty()) {
                type = "TASK";
            }
            a.setType(type);

            LocalDateTime dueDate;
            if (due != null && !due.isEmpty()) {
                LocalDate dueLocalDate = LocalDate.parse(due);
                LocalDate today = LocalDate.now();

                if (dueLocalDate.isBefore(today)) {
                    req.setAttribute("error", "Hạn làm việc không hợp lý");
                    req.setAttribute("assignments", dao.findBySubject(subjectId));

                    SubjectDAO subjectDAO = new SubjectDAO();
                    req.setAttribute("subject", subjectDAO.findById(subjectId));
                    req.setAttribute("activePage", "subjects");
                    req.setAttribute("pageTitle", "Chỉnh sửa nhiệm vụ");
                    req.setAttribute("contentPage", "/views/assignment/assignment-edit.jsp");

                    req.getRequestDispatcher("/views/common/layout.jsp").forward(req, resp);
                    return;
                }
                dueDate = dueLocalDate.atStartOfDay();
            } 
            else {
                // nếu người dùng ko nhập thì mặc định là thời điểm hiện tại
                dueDate = LocalDateTime.now();
            }

            a.setDueDate(dueDate);

            dao.insert(a);

            resp.sendRedirect("assignments?subjectId=" + subjectId);
            return;
        } 
        else if ("updateStatus".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            String status = req.getParameter("status");

            dao.updateStatus(id, status);
            
            resp.sendRedirect("assignments?subjectId=" + req.getParameter("subjectId"));
            return;
            
        } 
        else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.delete(id);
            
            resp.sendRedirect("assignments?subjectId=" + req.getParameter("subjectId"));
            return;
            
        }
        else if ("update".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            int subjectId = Integer.parseInt(req.getParameter("subjectId"));
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            String type = req.getParameter("type");
            String due = req.getParameter("dueDate");

            Assignment a = new Assignment();
            a.setId(id);
            a.setSubjectId(subjectId);
            a.setTitle(title);
            a.setDescription(description);

            // type mặc định 
            if (type == null || type.isEmpty()) {
                type = "TASK";
            }
            a.setType(type);

            // xử lý dueDate
            Assignment old = dao.findById(id);
            LocalDateTime dueDate;

            if (due != null && !due.isEmpty()) {
                LocalDate dueLocalDate = LocalDate.parse(due);
                LocalDate today = LocalDate.now();

                if (dueLocalDate.isBefore(today)) {
                    req.setAttribute("error", "Hạn làm việc không hợp lý");
                    req.setAttribute("assignment", old);

                    SubjectDAO subjectDAO = new SubjectDAO();
                    req.setAttribute("subject", subjectDAO.findById(subjectId));
                    req.setAttribute("activePage", "subjects");
                    req.setAttribute("pageTitle", "Chỉnh sửa nhiệm vụ");
                    req.setAttribute("contentPage", "/views/assignment/assignment-edit.jsp");

                    req.getRequestDispatcher("/views/common/layout.jsp").forward(req, resp);
                    return;
                }
                dueDate = dueLocalDate.atStartOfDay();

            } 
            else {
                // giữ nguyên nếu không nhập
                dueDate = old.getDueDate();
            }

            a.setDueDate(dueDate);

            dao.update(a);

            resp.sendRedirect("assignments?subjectId=" + subjectId);
            return;
        }
    }
}