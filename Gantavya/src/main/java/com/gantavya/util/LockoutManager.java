package com.gantavya.util;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class LockoutManager {
    private static final Map<String, Integer> loginAttempts = new ConcurrentHashMap<>();
    private static final Map<String, Long> lockOutTime = new ConcurrentHashMap<>();
    private static final int MAX_ATTEMPTS = 5;
    private static final long LOCKOUT_DURATION = 5 * 60 * 1000; // 5 minutes

    public static boolean isLocked(String email) {
        if (email == null) return false;
        String id = email.trim().toLowerCase();
        if (lockOutTime.containsKey(id)) {
            long expiration = lockOutTime.get(id);
            if (System.currentTimeMillis() < expiration) {
                return true;
            } else {
                // Lock expired
                lockOutTime.remove(id);
                loginAttempts.remove(id);
            }
        }
        return false;
    }

    public static long getRemainingTimeMillis(String email) {
        if (email == null) return 0;
        String id = email.trim().toLowerCase();
        Long expiration = lockOutTime.get(id);
        if (expiration == null) return 0;
        return Math.max(0, expiration - System.currentTimeMillis());
    }

    public static void recordFailedAttempt(String email) {
        if (email == null) return;
        String id = email.trim().toLowerCase();
        int attempts = loginAttempts.getOrDefault(id, 0) + 1;
        loginAttempts.put(id, attempts);
        if (attempts >= MAX_ATTEMPTS) {
            lockOutTime.put(id, System.currentTimeMillis() + LOCKOUT_DURATION);
        }
    }

    public static void resetAttempts(String email) {
        if (email == null) return;
        String id = email.trim().toLowerCase();
        loginAttempts.remove(id);
        lockOutTime.remove(id);
    }

    public static int getRemainingAttempts(String email) {
        if (email == null) return MAX_ATTEMPTS;
        String id = email.trim().toLowerCase();
        return MAX_ATTEMPTS - loginAttempts.getOrDefault(id, 0);
    }
    
    public static int getMaxAttempts() {
        return MAX_ATTEMPTS;
    }
}
