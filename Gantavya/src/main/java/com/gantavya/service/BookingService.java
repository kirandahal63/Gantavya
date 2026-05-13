package com.gantavya.service;

import java.util.List;
import com.gantavya.dao.BookingDao;
import com.gantavya.model.BookingModel;
import java.sql.Timestamp;

public class BookingService {
    private BookingDao bookingDao = new BookingDao();

    public List<BookingModel> getBookingsByTripId(String tripId) {
        return bookingDao.getBookingsByTripId(tripId);
    }

    public List<BookingModel> getPassengerBookings(String passengerId) {
        return bookingDao.getBookingsByPassengerId(passengerId);
    }
    public List<String> getBookedSeatsByTripId(String tripId) {
        return bookingDao.getBookedSeatsByTripId(tripId);
    }

    public String generateNextBookingId() {
        return bookingDao.generateNextBookingId();
    }

    public boolean saveBooking(BookingModel booking) throws java.sql.SQLException {
        return bookingDao.saveBooking(booking);
    }
    /**
     * Sorts bookings by total fare using INSERTION SORT. Descending order.
     */
    public void sortByFare(List<BookingModel> list, long unitFare) {
        if (list == null || list.size() < 2) return;

        for (int i = 1; i < list.size(); i++) {
            BookingModel key = list.get(i);
            long keyFare = unitFare * (key.getSeatNumber() != null ? key.getSeatNumber().split(",").length : 0);
            int j = i - 1;

            while (j >= 0) {
                long currentFare = unitFare * (list.get(j).getSeatNumber() != null ? list.get(j).getSeatNumber().split(",").length : 0);
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
     */
    public void sortByDate(List<BookingModel> list) {
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
            Timestamp d1 = L[i].getBookingDate();
            Timestamp d2 = R[j].getBookingDate();
            
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
