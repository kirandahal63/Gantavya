package com.gantavya.model;

public class TripModel {
    private String tripId;
    private String departureDate;
    private String arrivalDate;
    private String tripStatus;
    private long fare;
    private String routeId;
    private String busId;
    private String staffId;
    private String source;
    private String destination;
    private int availableSeats;

    public TripModel() {}

    public TripModel(String tripId, String departureDate, String arrivalDate, String tripStatus, long fare, String routeId, String busId, String staffId) {
        this.tripId = tripId;
        this.departureDate = departureDate;
        this.arrivalDate = arrivalDate;
        this.tripStatus = tripStatus;
        this.fare = fare;
        this.routeId = routeId;
        this.busId = busId;
        this.staffId = staffId;
    }

    public String getTripId() {
        return tripId;
    }

    public void setTripId(String tripId) {
        this.tripId = tripId;
    }

    public String getDepartureDate() {
        return departureDate;
    }

    public void setDepartureDate(String departureDate) {
        this.departureDate = departureDate;
    }

    public String getArrivalDate() {
        return arrivalDate;
    }

    public void setArrivalDate(String arrivalDate) {
        this.arrivalDate = arrivalDate;
    }

    public String getTripStatus() {
        return tripStatus;
    }

    public void setTripStatus(String tripStatus) {
        this.tripStatus = tripStatus;
    }

    public long getFare() {
        return fare;
    }

    public void setFare(long fare) {
        this.fare = fare;
    }

    public String getRouteId() {
        return routeId;
    }

    public void setRouteId(String routeId) {
        this.routeId = routeId;
    }

    public String getBusId() {
        return busId;
    }

    public void setBusId(String busId) {
        this.busId = busId;
    }

    public String getStaffId() {
        return staffId;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }
    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public int getAvailableSeats() {
        return availableSeats;
    }

    public void setAvailableSeats(int availableSeats) {
        this.availableSeats = availableSeats;
    }
}
