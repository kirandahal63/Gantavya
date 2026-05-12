package com.gantavya.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
    private static final String DEFAULT_DATE_FORMAT = "yyyy-MM-dd";
    private static final String DEFAULT_DATETIME_FORMAT = "yyyy-MM-dd'T'HH:mm";

    public static String formatDate(Date date) {
        if (date == null) return "";
        return new SimpleDateFormat(DEFAULT_DATE_FORMAT).format(date);
    }

    public static String formatDateTime(Date date) {
        if (date == null) return "";
        return new SimpleDateFormat(DEFAULT_DATETIME_FORMAT).format(date);
    }

    public static Date parseDate(String dateStr) {
        try {
            return new SimpleDateFormat(DEFAULT_DATE_FORMAT).parse(dateStr);
        } catch (Exception e) {
            return null;
        }
    }

    public static Date parseDateTime(String dateTimeStr) {
        try {
            return new SimpleDateFormat(DEFAULT_DATETIME_FORMAT).parse(dateTimeStr);
        } catch (Exception e) {
            return null;
        }
    }
}
