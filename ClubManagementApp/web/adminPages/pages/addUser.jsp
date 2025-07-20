<%-- 
    Document   : clubView
    Created on : Mar 13, 2025, 4:57:48 PM
    Author     : admin
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.UserRoleDAO"%>

<!DOCTYPE html>
<html>
    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Club View</title>

        <!-- Custom fonts for this template-->
        <link href="${pageContext.request.contextPath}/adminPages/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

        <!-- Custom styles for this template-->
        <link href="${pageContext.request.contextPath}/adminPages/css/sb-admin-2.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/adminPages/css/adminCss.css?v=1.0.1" rel="stylesheet">

    </head>
    <body id="page-top">
        <!-- Page Wrapper -->
        <div id="wrapper">

            <jsp:include page="../components/sidebar.jsp"/>

            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">

                <!-- Main Content -->
                <div id="content">

                    <jsp:include page="../components/topbar.jsp"/>

                    <!-- Begin Page Content -->
                    <div class="container-fluid">

                        <div class="row">

                            <div class="addUserTable">

                                <form action="User" method="post" enctype="multipart/form-data">
                                    <h1 class="h3 mb-4 text-gray-800">Add user by file</h1>

                                    <table>
                                        <tr>
                                            <td>Import file</td>
                                            <td><input type="file" name="addUserFile" accept=".csv"/></td>
                                        </tr>
                                    </table>

                                    <div class="addUserSubmit">
                                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#confirmModal1">Import</button>
                                    </div>

                                    <div class="modal fade" id="confirmModal1" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="confirmModalLabel">Confirm add user</h5>
                                                </div>
                                                <div class="modal-body">
                                                    Are you sure to add user by import file?
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                                    <input type="hidden" value="import" name="action"/>
                                                    <input type="submit" class="btn btn-primary" value="Add"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <br>
                                <hr>

                                <form action="User" method="post" enctype="multipart/form-data">
                                    <!-- Page Heading -->
                                    <h1 class="h3 mb-4 text-gray-800">Add user</h1>

                                    <table>
                                        <tr>
                                            <td>Full name</td>
                                            <td><input type="text" name="fullName" /></td>
                                        </tr>
                                        <tr>
                                            <td>Email</td>
                                            <td><input type="text" name="email" /></td>
                                        </tr>
                                        <tr>
                                            <td>User Role</td>
                                            <td>
                                                <select name="userRole" id="userRole" onchange="toggleInput()">
                                                    <c:forEach var="userRole" items="${UserRoleDAO.getUserRoles()}">
                                                        <option value="${userRole.getUserRoleID()}">${userRole.getUserRoleName()}</option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr id="extraInput1" style="display:none">
                                            <td>Student ID</td>
                                            <td><input type="text" name="studentID" /></td>
                                        </tr>
                                        <tr id="extraInput2"  style="display:none">
                                            <td>Major</td>
                                            <td><input type="text" name="major" /></td>
                                        </tr>
                                        <tr id="extraInput3"  style="display:none">
                                            <td>Course</td>
                                            <td><input type="text" name="course" /></td>
                                        </tr>
                                    </table>
                                    <div class="addUserSubmit">
                                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#confirmModal2">Add</button>
                                    </div>

                                    <div class="modal fade" id="confirmModal2" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="confirmModalLabel">Confirm import file</h5>
                                                </div>
                                                <div class="modal-body">
                                                    Are you sure to add user?
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                                    <input type="hidden" value="add" name="action"/>
                                                    <input type="submit" class="btn btn-primary" value="Add"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>

                        </div>

                    </div>
                    <!-- /.container-fluid -->

                </div>
                <!-- End of Main Content -->

                <!-- Footer -->
                <footer class="sticky-footer bg-white">
                    <div class="container my-auto">
                        <div class="copyright text-center my-auto">
                            <span>Copyright &copy; Your Website 2021</span>
                        </div>
                    </div>
                </footer>
                <!-- End of Footer -->

            </div>
            <!-- End of Content Wrapper -->

        </div>
        <!-- End of Page Wrapper -->

        <!-- Scroll to Top Button-->
        <a class="scroll-to-top rounded" href="#page-top">
            <i class="fas fa-angle-up"></i>
        </a>

        <script>
            function toggleInput() {
                var selectBox = document.getElementById("userRole");
                var inputBox1 = document.getElementById("extraInput1");
                var inputBox2 = document.getElementById("extraInput2");
                var inputBox3 = document.getElementById("extraInput3");

                // Nếu chọn "Khác", hiển thị ô input
                if (selectBox.value === "3") {
                    inputBox1.style.display = "table-row";
                    inputBox2.style.display = "table-row";
                    inputBox3.style.display = "table-row";
                } else {
                    inputBox1.style.display = "none";
                    inputBox2.style.display = "none";
                    inputBox3.style.display = "none";
                }
            }
        </script>

        <!-- Bootstrap core JavaScript-->
        <script src="${pageContext.request.contextPath}/adminPages/vendor/jquery/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- Core plugin JavaScript-->
        <script src="${pageContext.request.contextPath}/adminPages/vendor/jquery-easing/jquery.easing.min.js"></script>

        <!-- Custom scripts for all pages-->
        <script src="${pageContext.request.contextPath}/adminPages/js/sb-admin-2.min.js"></script>

        <!-- Page level plugins -->
        <script src="${pageContext.request.contextPath}/adminPages/vendor/datatables/jquery.dataTables.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/vendor/datatables/dataTables.bootstrap4.min.js"></script>

        <!-- Page level custom scripts -->
        <script src="${pageContext.request.contextPath}/adminPages/js/demo/datatables-demo.js"></script>

    </body>
</html>
