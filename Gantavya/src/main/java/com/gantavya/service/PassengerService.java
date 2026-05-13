package com.gantavya.service;

import com.gantavya.dao.PassengerDao;
import com.gantavya.model.PassengerModel;

public class PassengerService {
    private PassengerDao passengerDao = new PassengerDao();

    public boolean registerPassenger(PassengerModel passenger) {
        return passengerDao.registerPassenger(passenger);
    }

    public boolean isEmailExists(String email) {
        return passengerDao.isEmailExists(email);
    }

    public boolean isNumberExists(long contactNumber) {
        return passengerDao.isNumberExists(contactNumber);
    }

    public boolean authenticatePassenger(String email, String plainPassword) {
        return passengerDao.authenticatePassenger(email, plainPassword);
    }

    public boolean updatePassword(String email, String plainPassword) {
        return passengerDao.updatePassword(email, plainPassword);
    }

    public PassengerModel getPassengerByEmail(String email) {
        return passengerDao.getPassengerByEmail(email);
    }

    public boolean updatePassengerDetails(PassengerModel passenger) {
        return passengerDao.updatePassengerDetails(passenger);
    }
}
