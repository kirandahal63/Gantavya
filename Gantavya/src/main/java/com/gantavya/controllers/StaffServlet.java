package com.gantavya.controllers;

import com.gantavya.service.StaffService;
import com.gantavya.model.StaffModel;
import com.gantavya.util.Validation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/staff")
public class StaffServlet extends HttpServlet {
    private StaffService staffService = new StaffService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String searchQuery = request.getParameter("search");
        
        List<StaffModel> staffList;

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            staffList = staffService.searchStaff(searchQuery);
        } else {
            staffList = staffService.getAllStaff();
        }

        if ("edit".equals(action)) {
            String id = request.getParameter("id");
            StaffModel s = staffService.getStaffById(id);
            request.setAttribute("editableStaff", s);
        } 
        else if ("delete".equals(action)) {
            String id = request.getParameter("id");
            staffService.deleteStaff(id);
            response.sendRedirect("staff");
            return;
        }

        request.setAttribute("staffList", staffList);
        request.setAttribute("pageName", "staff");
        request.getRequestDispatcher("/WEB-INF/Pages/StaffManagement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        StaffModel s = new StaffModel();
        s.setStaffId(request.getParameter("staffId"));
        s.setStaffName(request.getParameter("staffName"));
        s.setStaffEmail(request.getParameter("staffEmail"));
        s.setMemberType(request.getParameter("memberType"));
        s.setStaffStatus(request.getParameter("staffStatus"));
        
        String dobStr = request.getParameter("dob");
        if (dobStr != null && !dobStr.trim().isEmpty()) {
            s.setStaffDob(java.sql.Date.valueOf(dobStr));
        }
        
        String joiningStr = request.getParameter("joiningdate");
        if (joiningStr != null && !joiningStr.trim().isEmpty()) {
            s.setJoiningDate(java.sql.Date.valueOf(joiningStr));
        }
        
        String salaryStr = request.getParameter("salary");
        long salary = 0;
        boolean hasError = false;

        // Salary Validation
        try {
            salary = (salaryStr != null && !salaryStr.isEmpty()) ? Long.parseLong(salaryStr) : 0L;
        } catch (NumberFormatException e) {
            hasError = true;
            request.setAttribute("salaryError", "Please enter salary in number.");
        }

        // Email Validation
        if (!Validation.isValidEmail(s.getStaffEmail())) {
            hasError = true;
            request.setAttribute("emailError", "Please enter a valid Email");
        }

        // Name Validation
        if (!Validation.isValidFullName(s.getStaffName())) {
            hasError = true;
            request.setAttribute("nameError", "Please enter a valid Name.");
        }

        // DOB Validation
        if (dobStr != null && !Validation.isValidDOB(dobStr)) {
            hasError = true;
            request.setAttribute("dobError", "Staff must be above 18 years.");
        }

        s.setSalary(salary);

        if (hasError) {
            request.setAttribute("errorStaff", s);
            // Forward back to doGet to reload list but with error attributes
            request.setAttribute("staffList", staffService.getAllStaff());
            request.setAttribute("pageName", "staff");
            
            // If we were updating, we need editableStaff to keep the modal open
            if ("update".equals(action)) {
                request.setAttribute("editableStaff", s);
            }
            
            request.getRequestDispatcher("/WEB-INF/Pages/StaffManagement.jsp").forward(request, response);
            return;
        }

        if ("add".equals(action)) {
            s.setPassword(request.getParameter("password"));
            staffService.registerStaff(s);
        } else if ("update".equals(action)) {
            staffService.updateStaff(s);
        }
        
        response.sendRedirect("staff");
    }
}
