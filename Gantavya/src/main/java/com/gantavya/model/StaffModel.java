package com.gantavya.model;
import java.sql.Date;
public class StaffModel {	
	private String staffId;
    private String staffName;
    private Date staffDob;
    private String memberType;
    private Date joiningDate;
    private long salary;
    private String password;
    private String staffEmail;
    private String staffStatus;

    // Default constructor
    public StaffModel() {}
    
    public String getStaffId() { 
    	return staffId;
    }
    
    public void setStaffId(String staffId) { 
    	this.staffId = staffId; 
    }

    public String getStaffName() { 
    	return staffName; 
    }
    
    public void setStaffName(String staffName) { 
    	this.staffName = staffName; 
    }

    public Date getStaffDob() { 
    	return staffDob; 
    }
    
    public void setStaffDob(Date staffDob) { 
    	this.staffDob = staffDob; 
    }

    public String getMemberType() { 
    	return memberType; 
    }
    
    public void setMemberType(String memberType) { 
    	this.memberType = memberType; 
    }

    public Date getJoiningDate() { 
    	return joiningDate; 
    }
    
    public void setJoiningDate(Date joiningDate) { 
    	this.joiningDate = joiningDate; 
    }

    public long getSalary() { 
    	return salary; 
    }
    public void setSalary(long salary) { 
    	this.salary = salary; 
    }

    public String getPassword() { 
    	return password; 
    }
    public void setPassword(String password) { 
    	this.password = password; 
    }

	public String getStaffEmail() {
		return staffEmail;
	}

	public void setStaffEmail(String staffEmail) {
		this.staffEmail = staffEmail;
	}

	public String getStaffStatus() {
		return staffStatus;
	}

	public void setStaffStatus(String staffStatus) {
		this.staffStatus = staffStatus;
	}

}
