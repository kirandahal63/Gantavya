package com.gantavya.util;

import java.io.InputStream;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailUtil {

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";

    private static String SENDER_EMAIL;
    private static String APP_PASSWORD;

    static {
        try {
            Properties config = new Properties();
            ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
            if (classLoader == null) {
                classLoader = EmailUtil.class.getClassLoader();
            }

            InputStream input = classLoader.getResourceAsStream("email.properties");
            
            // Fallback 1: try without class loader (using Class.getResourceAsStream with absolute path)
            if (input == null) {
                input = EmailUtil.class.getResourceAsStream("/email.properties");
            }
            
            // Fallback 2: try relative to the class if still null
            if (input == null) {
                input = EmailUtil.class.getResourceAsStream("email.properties");
            }

            if (input == null) {
                System.err.println("ERROR: email.properties not found in classpath!");
            } else {
                config.load(input);
                SENDER_EMAIL = config.getProperty("email");
                APP_PASSWORD = config.getProperty("password");
                
                if (SENDER_EMAIL != null) SENDER_EMAIL = SENDER_EMAIL.trim();
                if (APP_PASSWORD != null) APP_PASSWORD = APP_PASSWORD.trim();
                
                if (SENDER_EMAIL == null || SENDER_EMAIL.trim().isEmpty()) {
                    System.err.println("ERROR: 'email' property is missing or empty in email.properties");
                }
                if (APP_PASSWORD == null || APP_PASSWORD.trim().isEmpty()) {
                    System.err.println("ERROR: 'password' property is missing or empty in email.properties");
                }
            }
        } catch (Exception e) {
            System.err.println("ERROR loading email.properties:");
            e.printStackTrace();
        }
    }

    public static boolean sendEmail(String recipientEmail, String subject, String body) {
        if (SENDER_EMAIL == null || APP_PASSWORD == null) {
            System.err.println("Cannot send email: SENDER_EMAIL or APP_PASSWORD is not initialized.");
            return false;
        }

        if (recipientEmail == null || recipientEmail.trim().isEmpty()) {
            System.err.println("Cannot send email: recipientEmail is null or empty.");
            return false;
        }

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject(subject);
            message.setText(body);

            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            System.err.println("MessagingException while sending email to " + recipientEmail);
            e.printStackTrace();
            return false;
        }
    }
}
