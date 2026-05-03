package com.gantavya.controllers;

import com.gantavya.dao.StaffDao;
import com.gantavya.model.StaffModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/staff")
public class StaffServlet extends HttpServlet {
    private StaffDao staffDao = new StaffDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String searchQuery = request.getParameter("search");
        
        List<StaffModel> staffList;

        // Logic for Searching Staff
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            staffList = staffDao.searchStaff(searchQuery);
        } else {
            staffList = staffDao.getAllStaff();
        }

        // Logic for Preparing Edit Modal
        if ("edit".equals(action)) {
            String id = request.getParameter("id");
            StaffModel s = staffDao.getStaffById(id);
            request.setAttribute("editableStaff", s);
        } 
        // Logic for Deletion
        else if ("delete".equals(action)) {
            String id = request.getParameter("id");
            staffDao.deleteStaff(id);
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

        // Map request parameters to Model
        StaffModel s = new StaffModel();
        s.setStaffId(request.getParameter("staffId"));
        s.setStaffName(request.getParameter("staffName"));
        s.setMemberType(request.getParameter("memberType"));
        
        String dobStr = request.getParameter("dob");
        if (dobStr != null && !dobStr.trim().isEmpty()) {
            s.setStaffDob(java.sql.Date.valueOf(dobStr));
        }
        
        String joiningStr = request.getParameter("joiningdate");
        if (joiningStr != null && !joiningStr.trim().isEmpty()) {
            s.setJoiningDate(java.sql.Date.valueOf(joiningStr));
        }
        
        // Handle numerical salary safely
        String salaryStr = request.getParameter("salary");
        s.setSalary(salaryStr != null ? Long.parseLong(salaryStr) : 0L);

        if ("add".equals(action)) {
            s.setPassword(request.getParameter("password"));
            staffDao.registerStaff(s);
        } else if ("update".equals(action)) {
            staffDao.updateStaff(s);
        }
        
        response.sendRedirect("staff");
    }
}