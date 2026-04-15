<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%-- Import your Trip model class here --%>
<%-- <%@ page import="com.gantavya.models.Trip" %> --%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Admin Dashboard — Gantavya</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <style>
        /* CSS remains exactly the same as your previous version */
        :root { --navy: #1a2744; --accent: #2563eb; --white: #ffffff; --font: 'Plus Jakarta Sans', sans-serif; }
        body { font-family: var(--font); background: #f8faff; margin: 0; display: flex; }
        .sidebar { width: 256px; background: #111c35; min-height: 100vh; color: white; position: fixed; }
        .main { margin-left: 256px; flex: 1; padding: 20px; }
    </style>
</head>
<body>

<aside class="sidebar">
    <div style="padding: 22px; font-weight: 800; font-size: 1.18rem; color: white;">Gan<span style="color:#60a5fa">tavya</span></div>
    
    <div style="position: absolute; bottom: 20px; width: 100%; padding: 0 16px;">
        <div style="display: flex; align-items: center; gap: 10px; background: rgba(255,255,255,.06); padding: 10px; border-radius: 8px;">
            <div style="width: 34px; height: 34px; border-radius: 50%; background: #2563eb; display: flex; align-items: center; justify-content: center; font-weight: 700;">
                <% 
                    String name = (String) session.getAttribute("adminName");
                    if (name != null && name.length() >= 2) {
                        out.print(name.substring(0, 2).toUpperCase());
                    } else {
                        out.print("AD");
                    }
                %>
            </div>
            <div style="flex: 1; min-width: 0;">
                <div style="font-size: .8rem; font-weight: 600; color: white;">
                    <%= (name != null) ? name : "Administrator" %>
                </div>
                <div style="font-size: .68rem; color: rgba(255,255,255,.35);">Super Admin</div>
            </div>
        </div>
    </div>
</aside>

<main class="main">
    <div style="background: linear-gradient(120deg, #111c35 0%, #223058 100%); padding: 24px; border-radius: 12px; color: white;">
        <h2>Good day, <%= (name != null) ? name : "Admin" %> 👋</h2>
        <p style="opacity: 0.6; font-size: 0.85rem;">Here's what's happening on Gantavya today.</p>
    </div>

    <div style="margin-top: 24px; background: white; border: 1px solid #e2e8f8; border-radius: 12px; overflow: hidden;">
        <div style="padding: 16px 20px; border-bottom: 1px solid #e2e8f8; font-weight: 700;">Recent Trips</div>
        <table style="width: 100%; border-collapse: collapse;">
            <tr style="background: #f8faff; text-align: left; font-size: 0.7rem; color: #8492b4;">
                <th style="padding: 10px 16px;">ROUTE</th>
                <th style="padding: 10px 16px;">STATUS</th>
            </tr>
            <% 
                List trips = (List) request.getAttribute("recentTrips");
                if (trips != null && !trips.isEmpty()) {
                    for (Object obj : trips) { 
                        // You can cast obj to Trip here
            %>
                <tr style="border-bottom: 1px solid #e2e8f8; font-size: 0.8rem;">
                    <td style="padding: 13px 16px;">Trip Details Available</td>
                    <td style="padding: 13px 16px;"><span style="color: #16a34a;">Active</span></td>
                </tr>
            <% 
                    } 
                } else { 
            %>
                <tr>
                    <td colspan="2" style="padding: 40px; text-align: center; color: #8492b4; font-size: 0.8rem;">
                        No recent trips found.
                    </td>
                </tr>
            <% } %>
        </table>
    </div>
</main>

</body>
</html>