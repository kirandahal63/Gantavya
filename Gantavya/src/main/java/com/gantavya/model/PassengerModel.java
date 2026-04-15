package com.gantavya.model;

public class PassengerModel {

	private String id;
    private String fullName;
    private long contactNumber;
    private String dob; 
    private String gender;
    private String email;
    private String password;
    
    
    public PassengerModel(String fullName, long contactNumber, String dob, String gender, String email, String password) {
        this.fullName = fullName;
        this.contactNumber = contactNumber;
        this.dob = dob;
        this.gender = gender;
        this.email = email;
        this.password = password;
    }
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public long getContactNumber() {
		return contactNumber;
	}

	public void setContactNumber(long contactNumber) {
		this.contactNumber = contactNumber;
	}

	public String getDob() {
		return dob;
	}

	public void setDob(String dob) {
		this.dob = dob;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
