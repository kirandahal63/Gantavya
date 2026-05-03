package com.gantavya.model;

public class BusModel {
	private String busId;
    private String busNumber;
    private String busType;
    private int capacity;
    private String status;
    
    public BusModel(String busId, String busNumber, String busType, int capacity, String status) {
        this.busId = busId;
        this.busNumber = busNumber;
        this.busType = busType;
        this.capacity = capacity;
        this.status = status;
    }
	public String getBusId() {
		return busId;
	}
	public void setBusId(String busId) {
		this.busId = busId;
	}
	public String getBusNumber() {
		return busNumber;
	}
	public void setBusNumber(String busNumber) {
		this.busNumber = busNumber;
	}
	public int getCapacity() {
		return capacity;
	}
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getBusType() {
		return busType;
	}
	public void setBusType(String busType) {
		this.busType = busType;
	}

}
