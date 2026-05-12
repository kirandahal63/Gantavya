package com.gantavya.service;

import java.sql.SQLException;
import java.util.List;
import com.gantavya.dao.BusDao;
import com.gantavya.model.BusModel;
import com.gantavya.util.Validation;

public class BusService {
    private BusDao busDao = new BusDao();

    public List<BusModel> getAllBuses(String search) {
        return busDao.getAllBuses(search);
    }

    public boolean addBus(BusModel bus) throws SQLException {
        if (!Validation.isValidBusNumber(bus.getBusNumber()) || !Validation.isPositive(bus.getCapacity())) {
            return false;
        }
        String nextId = busDao.generateNextBusId();
        bus.setBusId(nextId);
        busDao.saveOrUpdateBus(bus, "add");
        return true;
    }

    public boolean updateBus(BusModel bus) throws SQLException {
        if (!Validation.isValidBusNumber(bus.getBusNumber()) || !Validation.isPositive(bus.getCapacity())) {
            return false;
        }
        busDao.saveOrUpdateBus(bus, "update");
        return true;
    }

    public void deleteBus(String id) throws SQLException {
        busDao.deleteBus(id);
    }
}
