package controller.subject;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.Subject;
import model.User;
import dao.SubjectDAO;

import java.io.IOException;
import java.util.List;

public class SubjectController extends HttpServlet {

    private SubjectDAO dao = new SubjectDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("user");

        List<Subject> list = dao.findByUser(user.getId());
        req.setAttribute("subjects", list);

        req.getRequestDispatcher("views/subject/list.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        User user = (User) req.getSession().getAttribute("user");

        Subject s = new Subject();
        s.setUserId(user.getId());
        s.setSubjectName(req.getParameter("name"));
        s.setDescription(req.getParameter("description"));

        dao.insert(s);
        resp.sendRedirect("subjects");
    }
}