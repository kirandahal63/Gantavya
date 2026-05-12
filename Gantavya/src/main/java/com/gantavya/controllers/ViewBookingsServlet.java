package com.gantavya.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import com.gantavya.dao.BookingDao;
import com.gantavya.dao.TripDao;
import com.gantavya.model.BookingModel;
import com.gantavya.model.TripModel;

@WebServlet("/viewBookings")
public class ViewBookingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	TripDao tripDao = new TripDao();
        BookingDao bookingDao = new BookingDao();

        String tripId = request.getParameter("tripId");
        String searchTrip = request.getParameter("searchTrip");
        String sortBy = request.getParameter("sort");
        
        // If search is used, it takes precedence
        if (searchTrip != null && !searchTrip.trim().isEmpty()) {
            tripId = searchTrip.trim();
        }
        
        List<TripModel> allTrips = tripDao.getAllTrips("");
        request.setAttribute("trips", allTrips);
        request.setAttribute("pageName", "viewBookings");

        if (tripId != null && !tripId.isEmpty()) {
            List<BookingModel> bookings = bookingDao.getBookingsByTripId(tripId);
            TripModel selectedTrip = tripDao.getTripById(tripId);
            request.setAttribute("selectedTrip", selectedTrip);
            request.setAttribute("selectedTripId", tripId);

            if (bookings != null && selectedTrip != null) {
                // Calculate and store total fare for each booking temporarily for sorting
                // and calculate totals for the header cards
                long totalRevenue = 0;
                int totalPassengers = 0;
                
                for (BookingModel booking : bookings) {
                    if (booking.getSeatNumber() != null) {
                        String[] seats = booking.getSeatNumber().split(",");
                        int passengerCount = seats.length;
                        totalPassengers += passengerCount;
                        totalRevenue += (passengerCount * selectedTrip.getFare());
                    }
                }
                
                // Sorting logic
                if (sortBy != null) {
                    if ("fare".equals(sortBy)) {
                        sortByFare(bookings, selectedTrip.getFare());
                    } else if ("date".equals(sortBy)) {
                        sortByDate(bookings);
                    }
                    request.setAttribute("currentSort", sortBy);
                }

                request.setAttribute("bookings", bookings);
                request.setAttribute("totalRevenue", totalRevenue);
                request.setAttribute("totalPassengers", totalPassengers);
            }
        }

        request.getRequestDispatcher("/WEB-INF/Pages/ViewBookings.jsp").forward(request, response);
    }

    /**
     * Sorts bookings by total fare using INSERTION SORT.  Descending order.
     * Ideal for small lists (like bus seats) and is stable.
     */
    private void sortByFare(List<BookingModel> list, long unitFare) {
        if (list == null || list.size() < 2) return;

        for (int i = 1; i < list.size(); i++) {
            BookingModel key = list.get(i);
            long keyFare = unitFare * key.getSeatNumber().split(",").length;
            int j = i - 1;

            while (j >= 0) {
                long currentFare = unitFare * list.get(j).getSeatNumber().split(",").length;
                if (currentFare < keyFare) {
                    list.set(j + 1, list.get(j));
                    j = j - 1;
                } else {
                    break;
                }
            }
            list.set(j + 1, key);
        }
    }

    /**
     * Sorts bookings by date using MERGE SORT. Ascending order.
     * Ideal for guaranteed O(n log n) performance and stability.
     */
    private void sortByDate(List<BookingModel> list) {
        if (list == null || list.size() < 2) return;
        mergeSort(list, 0, list.size() - 1);
    }

    private void mergeSort(List<BookingModel> list, int left, int right) {
        if (left < right) {
            int mid = (left + right) / 2;
            mergeSort(list, left, mid);
            mergeSort(list, mid + 1, right);
            merge(list, left, mid, right);
        }
    }

    private void merge(List<BookingModel> list, int left, int mid, int right) {
        int n1 = mid - left + 1;
        int n2 = right - mid;

        BookingModel[] L = new BookingModel[n1];
        BookingModel[] R = new BookingModel[n2];

        for (int i = 0; i < n1; ++i) L[i] = list.get(left + i);
        for (int j = 0; j < n2; ++j) R[j] = list.get(mid + 1 + j);

        int i = 0, j = 0;
        int k = left;
        while (i < n1 && j < n2) {
            java.sql.Timestamp d1 = L[i].getBookingDate();
            java.sql.Timestamp d2 = R[j].getBookingDate();
            
            if (d1 != null && d2 != null && d1.before(d2)) {
                list.set(k, L[i]);
                i++;
            } else {
                list.set(k, R[j]);
                j++;
            }
            k++;
        }

        while (i < n1) {
            list.set(k, L[i]);
            i++;
            k++;
        }
        while (j < n2) {
            list.set(k, R[j]);
            j++;
            k++;
        }
    }
}


