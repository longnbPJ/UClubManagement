<%-- 
    Document   : topbarr
    Created on : Mar 13, 2025, 4:04:48 PM
    Author     : PC ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Topbar -->
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

    <!-- Sidebar Toggle (Topbar) -->
    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
        <i class="fa fa-bars"></i>
    </button>

    <!-- Topbar Navbar -->
    <ul class="navbar-nav ml-auto">

        <!-- Nav Item - Search Dropdown (Visible Only XS) -->
        <li class="nav-item dropdown no-arrow d-sm-none">
            <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-search fa-fw"></i>
            </a>
            <!-- Dropdown - Messages -->
            <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                 aria-labelledby="searchDropdown">
                <form class="form-inline mr-auto w-100 navbar-search">
                    <div class="input-group">
                        <input type="text" class="form-control bg-light border-0 small"
                               placeholder="Search for..." aria-label="Search"
                               aria-describedby="basic-addon2">
                        <div class="input-group-append">
                            <button class="btn btn-primary" type="button">
                                <i class="fas fa-search fa-sm"></i>
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </li>

        <!-- Nav Item - Messages -->
        <li class="nav-item dropdown no-arrow mx-1 d-flex align-items-lg-center justify-content-center">
            <a class="dropdown-toggle " href="Home" id="messagesDropdown">
                Home view & Notifications
                <i class="fas fa-envelope fa-fw"></i>
                <!-- Counter - Messages -->
                <c:if test="${ReceivantDAO.getNumberOfNotiNotRead(id) > 0}">
                    <span class="badge badge-danger badge-counter">${ReceivantDAO.getNumberOfNotiNotRead(id)}</span>
                </c:if>
            </a>
        </li>

        <div class="topbar-divider d-none d-sm-block"></div>

        <!-- Nav Item - User Information -->
        <li class="nav-item dropdown no-arrow">
            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">${user.getFullname()}</span>
                <img class="img-profile rounded-circle"
                     src="img/undraw_profile.svg">
            </a>
            <!-- Dropdown - User Information -->
            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                 aria-labelledby="userDropdown">
                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#viewAccountModal">
                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                    Profile
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                    Logout
                </a>
            </div>
        </li>

    </ul>

    <!-- 🟢 Modal Hiển Thị Tài Khoản -->
    <div class="modal fade" id="viewAccountModal" tabindex="-1" role="dialog"  aria-labelledby="viewAccountLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="viewAccountLabel">Account information</h5>
                </div>
                <div class="modal-body">
                    <p><strong>Fullname: </strong> <span id="viewName">${user.getFullname()}</span></p>
                    <p><strong>Email:</strong> <span id="viewEmail">${user.getEmail()}</span></p>
                </div>
                <div class="modal-footer">
                    <!-- Nút mở modal chỉnh sửa -->
                    <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#editAccountModal">
                        Change password
                    </button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 🟡 Modal Chỉnh Sửa Tài Khoản -->
    <div class="modal fade" id="editAccountModal" tabindex="-1" aria-labelledby="editAccountLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editAccountLabel">Change password</h5>
                </div>
                <form id="editForm" action="User" method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="currentPassword" class="form-label">Current password</label>
                            <input type="password" class="form-control ${error == "Incorrect password!" ? "is-invalid" : ""}" id="currentPassword" name="currentPassword" placeholder="Enter current password" value="${currentPassword}" required/>
                            <div class="invalid-feedback">${error}</div>
                        </div>
                        <div class="mb-3">
                            <label for="newPassword" class="form-label ${error == "Password length must > 6!" ? "is-invalid" : ""}">New password</label> 
                            <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Enter new password"  value="${newPassword}" required/>
                            <div class="invalid-feedback">${error}</div>
                        </div>
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label ${error == "Confirm password not match!" ? "is-invalid" : ""}">Confirm new password</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm new password"  value="${confirmPassword}" required/>
                            <div class="invalid-feedback">${error}</div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <input type="hidden" name="action" value="changePassword"/>
                        <input type="hidden" name="id" value="${id}"/>
                        <button type="submit" class="btn btn-primary" id="savePassword">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="Logout">Logout</a>
                </div>
            </div>
        </div>
    </div>

</nav>
<!-- End of Topbar -->
