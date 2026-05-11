package com.gantavya.model;

import java.sql.Timestamp;

public class BookingModel {
    private String bookingId;
    private Timestamp bookingDate;
    private String seatNumber;
    private String otherPassengers;
    private String luggagePreferences;
    private String ticketId;
    private String paymentId;
    private String tripId;
    private String passengerId;
    private TripModel trip;
    
    public BookingModel() {}

    public BookingModel(String bookingId, Timestamp bookingDate, String seatNumber, String otherPassengers,
                        String luggagePreferences, String ticketId, String paymentId, String tripId, String passengerId) {
        this.bookingId = bookingId;
        this.bookingDate = bookingDate;
        this.seatNumber = seatNumber;
        this.otherPassengers = otherPassengers;
        this.luggagePreferences = luggagePreferences;
        this.ticketId = ticketId;
        this.paymentId = paymentId;
        this.tripId = tripId;
        this.passengerId = passengerId;
    }

    // Getters and Setters
    public String getBookingId() { 
    	return bookingId; 
    }
    public void setBookingId(String bookingId) { 
    	this.bookingId = bookingId; 
    }

    public Timestamp getBookingDate() { 
    	return bookingDate; 
    }
    public void setBookingDate(Timestamp bookingDate) { 
    	this.bookingDate = bookingDate; 
    }

    public String getSeatNumber() { 
    	return seatNumber; 
    }
    public void setSeatNumber(String seatNumber) { 
    	this.seatNumber = seatNumber; 
    }

    public String getOtherPassengers() { 
    	return otherPassengers; 
    }
    public void setOtherPassengers(String otherPassengers) { 
    	this.otherPassengers = otherPassengers; 
    }

    public String getLuggagePreferences() { 
    	return luggagePreferences; 
    }
    public void setLuggagePreferences(String luggagePreferences) { 
    	this.luggagePreferences = luggagePreferences; 
    }

    public String getTicketId() { 
    	return ticketId; 
    }
    public void setTicketId(String ticketId) { 
    	this.ticketId = ticketId; 
    }

    public String getPaymentId() { 
    	return paymentId; 
    }
    public void setPaymentId(String paymentId) { 
    	this.paymentId = paymentId; 
    }

    public String getTripId() { 
    	return tripId; 
    }
    public void setTripId(String tripId) { 
    	this.tripId = tripId; 
    }

    public String getPassengerId() { 
    	return passengerId; 
    }
    public void setPassengerId(String passengerId) { 
    	this.passengerId = passengerId; 
    }

	public TripModel getTrip() {
		return trip;
	}

	public void setTrip(TripModel trip) {
		this.trip = trip;
	}
}
