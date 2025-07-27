<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: hoaht
  Date: 2/25/2024
  Time: 1:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin dashboard</title>

    <jsp:include page="import-css.jsp"/>
</head>
<body>
    <jsp:include page="layout/navigation.jsp"/>

    <jsp:include page="layout/header-nav.jsp"/>

    <div class="content">
        <div class="mb-9">
            <div class="row g-2 mb-4">
                <div class="col-auto">
                    <h2 class="mb-0">Role Management</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-4">
                    <div class="card border border-2 rounded-3">
                        <div class="card-body">
                            <form id="addNewRoleForm" method="post">
                                <div class="mb-3">
                                    <label class="form-label" for="roleIdInput">Role ID </label>
                                    <input class="form-control" disabled id="roleIdInput" type="email" value="${updateRole.id}"/>
                                    <input class="d-none" name="role_id" value="${updateRole.id}"/>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label" for="roleNameInput">Role Name </label>
                                    <input class="form-control" id="roleNameInput" type="text" name="role_name" value="${updateRole.role_name}" />
                                </div>
                                <div class="d-flex justify-content-end">
                                    <a href="${pageContext.request.contextPath}/admin/roles" class="btn btn-phoenix-secondary me-2" type="reset">Cancel</a>
                                    <input class="btn btn-phoenix-primary" type="submit" value="Update">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="import-js.jsp"/>
    <script>
        let account_management = $("#account-management")
        account_management.addClass('show')

        if (${nav_role_manage}) {
            let user_account = $('#role-manage')
            user_account.addClass('active')
        }
    </script>
    <script>
        $(document).ready(function () {
            let list_role_name = [];
            let role_name_update = $('#roleNameInput').val();

            fetch('http://localhost:8080/ShoesShop/api/roles')
                .then(res => res.json())
                .then(data => {
                    data.forEach((el) => {
                        if (el.role_name.trim().toUpperCase() !== role_name_update.trim().toUpperCase()) {
                            list_role_name.push(el.role_name.toUpperCase())
                        }
                    })
                })
                .catch(error => {
                    console.log(error)
                })

            console.log(list_role_name)

            $.validator.addMethod("alreadyexist_rolename", function(value, element) {
                return list_role_name.indexOf(value.toUpperCase()) === -1;
            }, "Role name is already exist!");

            $("#addNewRoleForm").validate({
                errorPlacement: function (label, element) {
                    label.addClass('invalid-feedback')
                    label.insertAfter(element)
                },
                wrapper: 'div',
                rules: {
                    role_name: {
                        required: true,
                        maxlength: 10,
                        alreadyexist_rolename: true
                    }
                },
                messages: {
                    role_name: {
                        required: "Role name is cannot empty!",
                        maxlength: "Role name required less than 10 characters"
                    }
                }
            });
        });
    </script>
</body>
</html>
