package controller.subject;

import model.Subject;
import model.User;
import dao.SubjectDAO;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

public class SubjectController extends HttpServlet {

    private SubjectDAO dao = new SubjectDAO();

    // lay danh sach mon hoc
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("user");
        String action = req.getParameter("action");

        List<Subject> list;

        if ("search".equals(action)) {
            String key = req.getParameter("keyword");

            if (key == null || key.trim().isEmpty()) {
                list = dao.findByUser(user.getId());
            } else {
                list = dao.findByName(user.getId(), key);
            }

            req.setAttribute("keyword", key);
        } else {
            list = dao.findByUser(user.getId());
        }

        // set data
        req.setAttribute("subjects", list);
        // set layout
        req.setAttribute("activePage", "subjects");
        req.setAttribute("pageTitle", "Danh sách môn học");
        req.setAttribute("pageCss", "subject.css");
        req.setAttribute("contentPage", "/views/subject/subject-list.jsp");
        // forward
        req.getRequestDispatcher("/views/common/layout.jsp")
            .forward(req, resp);
    }
    
    // create + delete (khi xóa 1 môn học thì tất cả các dữ liệu kèm theo như assignment,.. cũng bị xóa theo)
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws IOException {

        String action = req.getParameter("action");

        User user = (User) req.getSession().getAttribute("user");

        if ("create".equals(action)) {

            Subject s = new Subject();
            s.setUserId(user.getId());
            s.setSubjectName(req.getParameter("name"));
            s.setDescription(req.getParameter("desc"));

            dao.insert(s);

        } else if ("delete".equals(action)) {

            int id = Integer.parseInt(req.getParameter("id"));
            dao.delete(id);
        }
        
        resp.sendRedirect("subjects");
    }
}