package com.gantavya.model;

public class RouteModel {
    private String routeId;
    private String routeName;
    private long distance;
    private String origin;
    private String destination;

    public RouteModel(String routeId, String routeName, long distance, String origin, String destination) {
        this.setRouteId(routeId);
        this.routeName = routeName;
        this.distance = distance;
        this.origin = origin;
        this.destination = destination;
    }

    public String getRouteId() {
		return routeId;
	}    
    
    public String getRouteName() { 
    	return routeName; 
    }
    
    public long getDistance() { 
    	return distance; 
    }
    
    public String getOrigin() { 
    	return origin; 
    }
    
    public String getDestination() { 
    	return destination; 
    }

	public void setRouteId(String routeId) {
		this.routeId = routeId;
	}
}