package com.gantavya.controllers;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getServletPath();

        // Allow public paths through without checking session
        boolean isPublic = path.equals("/login")
                        || path.equals("/register")
                        || path.startsWith("/CSS/")
                        || path.startsWith("/images/");

        if (isPublic) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        if (session == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String role = (String) session.getAttribute("role");

        // Admin-only path
        if (path.startsWith("/admin") || path.startsWith("/dashboard")) {
            if ("ADMIN".equals(role)) {
                chain.doFilter(request, response);
            } else {
                res.sendRedirect(req.getContextPath() + "/home"); // passengers go to /home
            }
            return;
        }

        // Passenger-only path
        if (path.startsWith("/home")) {
            if ("PASSENGER".equals(role)) {
                chain.doFilter(request, response);
            } else {
                res.sendRedirect(req.getContextPath() + "/admin"); // admins go to /admin
            }
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}