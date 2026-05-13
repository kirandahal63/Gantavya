package com.gantavya.service;

import java.sql.SQLException;
import java.util.List;
import com.gantavya.dao.TripDao;
import com.gantavya.model.TripModel;
import com.gantavya.util.Validation;

public class TripService {
    private TripDao tripDao = new TripDao();

    public List<TripModel> getAllTrips(String search) {
        return tripDao.getAllTrips(search);
    }

    public boolean addTrip(TripModel trip) throws SQLException {
        if (!Validation.isPositive(trip.getFare())) {
            return false;
        }
        String nextId = tripDao.generateNextTripId();
        trip.setTripId(nextId);
        tripDao.saveOrUpdateTrip(trip, "add");
        return true;
    }

    public boolean updateTrip(TripModel trip) throws SQLException {
        if (!Validation.isPositive(trip.getFare())) {
            return false;
        }
        tripDao.saveOrUpdateTrip(trip, "update");
        return true;
    }

    public void deleteTrip(String id) throws SQLException {
        tripDao.deleteTrip(id);
    }

    public TripModel getTripById(String id) {
        return tripDao.getTripById(id);
    }
    
    public List<TripModel> searchTrips(String from, String to, String date, int passengerCount) {
        return tripDao.searchTrips(from, to, date, passengerCount);
    }
}
