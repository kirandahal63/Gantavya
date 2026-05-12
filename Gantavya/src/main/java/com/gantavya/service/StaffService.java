package com.gantavya.service;

import java.util.List;
import com.gantavya.dao.StaffDao;
import com.gantavya.model.StaffModel;

public class StaffService {
    private StaffDao staffDao = new StaffDao();

    public List<StaffModel> getAllStaff() {
        return staffDao.getAllStaff();
    }

    public List<StaffModel> searchStaff(String term) {
        return staffDao.searchStaff(term);
    }

    public boolean registerStaff(StaffModel staff) {
        if (staff.getStaffId() == null || staff.getStaffId().trim().isEmpty()) {
            staff.setStaffId(staffDao.generateNextStaffId());
        }
        return staffDao.registerStaff(staff);
    }

    public boolean updateStaff(StaffModel staff) {
        return staffDao.updateStaff(staff);
    }

    public boolean deleteStaff(String id) {
        return staffDao.deleteStaff(id);
    }

    public StaffModel getStaffById(String id) {
        return staffDao.getStaffById(id);
    }

    public String authenticateStaff(String staffId, String password) {
        return staffDao.authenticateStaff(staffId, password);
    }
}
