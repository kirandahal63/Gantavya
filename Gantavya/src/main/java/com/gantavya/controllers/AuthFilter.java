package com.gantavya.controllers;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * AuthFilter intercepts ALL requests and enforces role-based access control.
 *
 * Roles:
 *   "ADMIN"     → staff/admin, can access /admin and /dashboard
 *   "PASSENGER" → registered user, can access /home
 *
 * Public paths (no session needed): /login, /Register, /CSS/*, /images/*
 */
@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  req  = (HttpServletRequest)  request;
        HttpServletResponse res  = (HttpServletResponse) response;

        String path = req.getServletPath();
        
        if (path == null || path.equals("/") || path.isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        boolean isPublic = path.equals("/login")
                        || path.equals("/Register")
                        //remove it later
                        || path.equals("/home")
                        || path.equals("/password-reset")
                        || path.equals("/admin")
                        || path.equals("/bus")
                        || path.equals("/route")
                        || path.startsWith("/CSS/")
                        || path.startsWith("/images/")
                        || path.equals("/");          // root / index page

        if (isPublic) {
            chain.doFilter(request, response);
            return;
        }

        // ── 2. All other paths require a valid session ────────────────────────
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("role") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String role = (String) session.getAttribute("role"); // "ADMIN" or "PASSENGER"

        // ── 3. Admin-only paths: /admin, /dashboard ───────────────────────────
        if (path.startsWith("/admin") || path.startsWith("/dashboard") || path.startsWith("/bus") || path.startsWith("/route") || path.startsWith("/trip") ) {
            if ("ADMIN".equals(role)) {
                chain.doFilter(request, response);
            } else {
                // Passenger tried to access admin area → send to their home
                res.sendRedirect(req.getContextPath() + "/home");
            }
            return;
        }

        // ── 4. Passenger-only paths: /home ────────────────────────────────────
        if (path.startsWith("/home")) {
            if ("PASSENGER".equals(role)) {
                chain.doFilter(request, response);
            } else {
                // Admin tried to access passenger area → send to admin dashboard
                res.sendRedirect(req.getContextPath() + "/admin");
            }
            return;
        }
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}