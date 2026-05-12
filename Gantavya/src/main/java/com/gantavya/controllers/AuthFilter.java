package com.gantavya.controllers;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;

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
        String contextPath = req.getContextPath();
        
        // Handle root path
        if (path == null || path.equals("/") || path.isEmpty()) {
            res.sendRedirect(contextPath + "/home");
            return;
        }

        // 1. Define Public Paths
        boolean isPublic = path.equals("/login")
                        || path.equals("/Register")
                        || path.equals("/home")
                        || path.equalsIgnoreCase("/search") 
                        || path.equals("/auth/google")
                        || path.equals("/404error.jsp")
                        || path.equals("/500error.jsp")
                        || path.equals("/error")
                        || path.equals("/profile")
                        || path.equals("/password-reset")
                        || path.startsWith("/about")
                        || path.startsWith("/contact")
                        || path.startsWith("/CSS/")
                        || path.equals("/logout")
                        || path.startsWith("/images/")
                        || path.equals("/terms")
                        || path.equals("/privacy")
                        || path.equals("/");

        if (isPublic) {
            chain.doFilter(request, response);
            return;
        }

        // 2. Check Authentication
        HttpSession session = req.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("role") != null);

        if (!isLoggedIn) {
            // Unauthenticated access to protected page (e.g., /booking)
            String queryString = req.getQueryString();
            String targetUrl = req.getRequestURI() + (queryString != null ? "?" + queryString : "");
            
            System.out.println("DEBUG: AuthFilter intercepting " + path);
            System.out.println("DEBUG: Saving targetUrl to session and param: " + targetUrl);
            
            // Save in session as backup
            req.getSession(true).setAttribute("targetUrl", targetUrl);
            
            // Redirect to login with targetUrl as parameter
            res.sendRedirect(contextPath + "/login?targetUrl=" + URLEncoder.encode(targetUrl, "UTF-8"));
            return;
        }

        // 3. Admin-only paths
        String role = (String) session.getAttribute("role");
        if (path.startsWith("/admin") || path.startsWith("/dashboard") || path.startsWith("/bus") || path.startsWith("/route") 
        	|| path.startsWith("/trip") || path.startsWith("viewBookings")) {
            if ("ADMIN".equals(role)) {
                chain.doFilter(request, response);
            } else {
                res.sendRedirect(contextPath + "/home");
            }
            return;
        }

        // 4. All other authenticated paths (like /booking)
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}