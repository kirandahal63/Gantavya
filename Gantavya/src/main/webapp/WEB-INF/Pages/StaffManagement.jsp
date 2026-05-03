<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Gantavya Admin - Staff Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Sidenav.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Buses.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<div class="app-shell">
    <jsp:include page="/WEB-INF/Pages/SideNav.jsp" />

    <div class="main-panel">
        <header class="header-nav">
            <div class="header-left">
                <h1 class="page-title">Staff Management</h1>
                <p class="breadcrumb">Admin / <span class="active-crumb">Staff</span></p>
            </div>
        </header>

        <div class="content-wrapper">
    
            <%-- SECTION 1: ADD NEW STAFF --%>
            <c:if test="${editableStaff == null}">
                <div class="glass-card form-container">
                    <div class="card-header">
                        <h3>Register New Staff</h3>
                    </div>
                    <form action="staff" method="POST">
                        <input type="hidden" name="action" value="add">
                        <div class="input-grid">
                            <div class="input-group">
                                <label>Full Name</label>
                                <input type="text" name="staffName" required>
                            </div>
                            <div class="input-group">
                                <label>Email</label>
                                <input type="text" name="staffId" required>
                            </div>                            
                            <div class="input-group">
                                <label>DOB</label>
                                <input type="text" name="dob" placeholder="dd-mm-yyyy" onfocus="(this.type='date')" onblur="if(!this.value) this.type='text'" required>
                            </div>
                            <div class="input-group">
                                <label>Role</label>
                                <select name="memberType">
                                    <option value="DRIVER">Driver</option>
                                    <option value="CONDUCTOR">Conductor</option>
                                    <option value="MANAGER">Manager</option>
                                </select>
                            </div>                            
                            <div class="input-group">
                                <label>Joining Date</label>
                                <input type="text" name="joiningdate" placeholder="dd-mm-yyyy" onfocus="(this.type='date')" onblur="if(!this.value) this.type='text'" required>
                            </div>
                            <div class="input-group">
                                <label>Salary</label>
                                <input type="number" name="salary" required>
                            </div>
                            
                            <div class="btn-group-row" style="display: flex; gap: 10px; align-items: flex-end;">
                                <button type="submit" class="btn-primary">Register</button>
                                <button type="button" class="btn-secondary" onclick="window.location.href='staff'">Cancel</button>
                            </div>
                        </div>
                    </form>
                </div>
            </c:if>

            <%-- SECTION 2: EDIT STAFF MODAL --%>
            <c:if test="${editableStaff != null}">
                <div class="modal-overlay">
                    <div class="glass-card modal-content" style="max-width: 650px;">
                        <div class="card-header">
                            <h3>Update Staff Details</h3>
                            <p>Modifying: ${editableStaff.staffName}</p>
                        </div>
                        <form action="staff" method="POST">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="staffId" value="${editableStaff.staffId}">
                            
                            <div class="input-grid-modal">
                                <div class="input-group">
                                    <label>Staff ID</label>
                                    <input type="text" value="${editableStaff.staffId}" disabled style="background-color: #f8fafc; cursor: not-allowed; color: #64748b;">
                                </div>
                                <div class="input-group">
                                    <label>Full Name</label>
                                    <input type="text" name="staffName" value="${editableStaff.staffName}" required>
                                </div>
                                <div class="input-group">
                                    <label>Role</label>
                                    <select name="memberType">
                                        <option value="DRIVER" ${editableStaff.memberType == 'DRIVER' ? 'selected' : ''}>Driver</option>
                                        <option value="CONDUCTOR" ${editableStaff.memberType == 'CONDUCTOR' ? 'selected' : ''}>Conductor</option>
                                        <option value="MANAGER" ${editableStaff.memberType == 'MANAGER' ? 'selected' : ''}>Manager</option>
                                    </select>
                                </div>
                                <div class="input-group">
                                    <label>DOB</label>
                                    <input type="date" name="dob" value="${editableStaff.staffDob}" required>
                                </div>
                                <div class="input-group">
                                    <label>Joining Date</label>
                                    <input type="date" name="joiningdate" value="${editableStaff.joiningDate}" required>
                                </div>
                                <div class="input-group">
                                    <label>Salary</label>
                                    <input type="number" name="salary" value="${editableStaff.salary}" required>
                                </div>
                            </div>

                            <div class="btn-group-row" style="display: flex; gap: 10px; justify-content: flex-end; margin-top: 30px;">
                                <button type="button" class="btn-secondary" onclick="window.location.href='staff'">Cancel</button>
                                <button type="submit" class="btn-primary">Update</button>
                            </div>
                        </form>
                    </div>
                </div>
            </c:if>

            <%-- SECTION 3: STAFF TABLE --%>
            <div class="table-card">
                <div class="table-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                    <h3>Current Personnel</h3>
                    
                    <form action="staff" method="GET" class="search-form" style="display: flex; gap: 15px;">
                        <input type="text" name="search" placeholder="Search by name or ID..." class="search-input">
                        <button type="submit" class="btn-primary">Search</button>
                    </form>
                </div>

                <table class="gantavya-table">
                    <thead>
                        <tr>
                            <th>Staff ID</th>
                            <th>Name</th>
                            <th>DOB</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th>Joined Date</th>
                            <th>Manage</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="s" items="${staffList}">
                            <tr>
                                <td><span class="id-badge">${s.staffId}</span></td>
                                <td><strong>${s.staffName}</strong></td>
                                <td>${s.staffDob}</td>
                                <td>
                                    <span class="status-dot ${s.memberType == 'ADMIN' ? 'dot-green' : 'dot-orange'}">
                                        ${s.memberType}
                                    </span>
                                </td>
								<td>${s.staffStatus}</td>
                                <td>${s.joiningDate}</td>
                                <td>
                                    <div class="action-icons">
                                        <a href="staff?action=edit&id=${s.staffId}" class="edit-link"><i class="fa-solid fa-pen"></i></a>
                                        <a href="staff?action=delete&id=${s.staffId}" class="delete-link" 
                                           onclick="return confirm('Remove ${s.staffName} from system?')">
                                            <i class="fa-solid fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

</body>
</html>