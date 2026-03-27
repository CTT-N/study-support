package filter;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AuthFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        // Cho phép truy cập tự do khi chưa có tài khoản
        if (uri.contains("login") ||
            uri.contains("register") ||
            uri.contains("index.jsp") ||
            uri.endsWith("/") ||
            uri.contains("assets")) {

            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("login");
            return;
        }

        chain.doFilter(request, response);
    }
}