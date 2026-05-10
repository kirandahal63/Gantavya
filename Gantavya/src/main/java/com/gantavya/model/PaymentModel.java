package com.gantavya.model;

import java.sql.Timestamp;

public class PaymentModel {
    private String paymentId;
    private long paymentAmount;
    private Timestamp paymentDate;
    private String paymentMethod; 

    public PaymentModel() {}

    public PaymentModel(String paymentId, long paymentAmount, Timestamp paymentDate, String paymentMethod) {
        this.paymentId = paymentId;
        this.paymentAmount = paymentAmount;
        this.paymentDate = paymentDate;
        this.paymentMethod = paymentMethod;
    }

    // Getters and Setters
    public String getPaymentId() { 
    	return paymentId; 
    }
    public void setPaymentId(String paymentId) { 
    	this.paymentId = paymentId; 
    }

    public long getPaymentAmount() { 
    	return paymentAmount; 
    }
    public void setPaymentAmount(long paymentAmount) { 
    	this.paymentAmount = paymentAmount; 
    }

    public Timestamp getPaymentDate() { 
    	return paymentDate; 
    }
    public void setPaymentDate(Timestamp paymentDate) { 
    	this.paymentDate = paymentDate; 
    }

    public String getPaymentMethod() { 
    	return paymentMethod; 
    }
    public void setPaymentMethod(String paymentMethod) { 
    	this.paymentMethod = paymentMethod; 
    }
}
