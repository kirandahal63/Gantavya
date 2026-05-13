package com.gantavya.service;

import com.gantavya.dao.PaymentDao;
import com.gantavya.model.PaymentModel;
import java.sql.SQLException;

public class PaymentService {
    private PaymentDao paymentDao = new PaymentDao();

    public boolean savePayment(PaymentModel payment) throws SQLException {
        return paymentDao.savePayment(payment);
    }
}
