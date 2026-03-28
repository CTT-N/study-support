package controller.auth;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class LogoutController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws IOException, ServletException {
        // lay session hien tai neu co
        HttpSession s1 = req.getSession(false);
        
        if(s1 != null){
            s1.invalidate(); // xoa session
        }
        resp.sendRedirect("index.jsp");// ve trang ban dau (welcome)
    }
        
}
