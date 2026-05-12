package com.gantavya.service;

import java.sql.SQLException;
import java.util.List;
import com.gantavya.dao.RouteDao;
import com.gantavya.model.RouteModel;

public class RouteService {
    private RouteDao routeDao = new RouteDao();

    public List<RouteModel> getAllRoutes(String search) {
        return routeDao.getAllRoutes(search);
    }

    public boolean addRoute(RouteModel route) throws SQLException {
        String nextId = routeDao.generateNextRouteId();
        route.setRouteId(nextId);
        routeDao.saveOrUpdateRoute(route, "add");
        return true;
    }

    public boolean updateRoute(RouteModel route) throws SQLException {
        routeDao.saveOrUpdateRoute(route, "update");
        return true;
    }

    public void deleteRoute(String id) throws SQLException {
        routeDao.deleteRoute(id);
    }
}
