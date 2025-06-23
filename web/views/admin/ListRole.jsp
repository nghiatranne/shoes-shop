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
                            <form id="addNewRoleForm" method="post" action="roles/save">
                                <div class="mb-3">
                                    <label class="form-label" for="roleIdInput">Role ID</label>
                                    <input class="form-control" disabled id="roleIdInput" placeholder="Role ID is auto increase" />
                                </div>
                                <div class="mb-3">
                                    <label class="form-label" for="roleNameInput">Role Name</label>
                                    <input class="form-control" id="roleNameInput" type="text" name="role_name" />
                                </div>
                                <div class="d-flex justify-content-end">
                                    <input class="btn btn-phoenix-warning me-2" type="reset" value="Clear">
                                    <input class="btn btn-phoenix-primary" type="submit" value="Submit">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-8">
                    <div class="card border border-2 rounded-3">
                        <div class="card-body">
                            <div id="roles">
                                <div class="mb-4">
                                    <div class="row g-3">
                                        <div class="col-auto">
                                            <div class="search-box">
                                                <form class="position-relative m-0" onsubmit="event.preventDefault()" data-bs-toggle="search" data-bs-display="static">
                                                    <input class="form-control search-input search" type="search" placeholder="Search accounts" aria-label="Search"/>
                                                    <span class="fas fa-search search-box-icon"></span>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="mx-n4 px-4 px-lg-6 bg-white position-relative top-1">
                                    <div class="table-responsive scrollbar-overlay mx-n1 px-1">
                                        <table class="table fs--1 mb-0">
                                            <thead>
                                            <tr>
                                                <th class=" align-middle pe-5" scope="col" style="width:10%;padding-left: 0">ROLE ID</th>
                                                <th class=" align-middle pe-5" scope="col" style="width:10%; min-width: 130px">ROLE NAME</th>
                                                <th class=" align-middle ps-7" scope="col" style="width:1%;">TOTAL ACCOUNT</th>
                                                <th class=" align-middle ps-7" scope="col" style="width:10%; min-width: 200px">CREATE DATE</th>
                                                <th class=" align-middle ps-7" scope="col" style="width:10%; min-width: 200px">UPDATE DATE</th>
                                                <th></th>
                                            </tr>
                                            </thead>
                                            <tbody class="list">
                                            <c:forEach items="${roles}" var="r">
                                                <tr class="hover-actions-trigger btn-reveal-trigger position-static cursor-pointer" onclick="">
                                                    <td class="role_id align-middle white-space-nowrap pe-5">
                                                        <a onclick="" class="d-flex align-items-center text-decoration-none">
                                                            <p class="mb-0 text-1100 fw-bold">${r.key.id}</p>
                                                        </a>
                                                    </td>
                                                    <td class="role_name align-middle white-space-nowrap pe-5">
                                                        <p onclick="" class="mb-0 text-1100 fw-bold">${r.key.role_name}</p>
                                                    </td>
                                                    <td class="total_acc align-middle white-space-nowrap fw-bold text-end ps-3 text-1100">
                                                        ${r.value} accounts
                                                    </td>
                                                    <td class="create_date align-middle white-space-nowrap text-1000 ps-7">
                                                        <p class="mb-0 text-1100 fw-bold">${r.key.createDate}</p>
                                                    </td>
                                                    <td class="update_date align-middle white-space-nowrap text-1000 ps-7">
                                                        <p class="mb-0 text-1100 fw-bold">${r.key.updateDate}</p>
                                                    </td>
                                                    <td>
                                                        <div class="d-flex justify-content-end">
                                                            <a href="roles/edit?id=${r.key.id}" class="btn btn-phoenix-secondary btn-icon fs--2 px-0 ms-3" type="button">
                                                                <span class="" data-feather="edit"></span>
                                                            </a>
                                                            <button onclick="setDeleteRoleId(${r.key.id})" class="btn btn-phoenix-secondary btn-icon fs--2 text-danger px-0 ms-2" type="button" data-bs-toggle="modal" data-bs-target="#model_delete">
                                                                <span class="text-danger" data-feather="trash-2"></span>
                                                            </button>
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
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="model_delete" tabindex="-1" aria-labelledby="verticallyCenteredModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body">
                    <p class="text-700 lh-lg mb-0">
                        Are you sure to delete this role?
                    </p>
                </div>
                <div class="modal-footer">
                    <a id="btn_deleteRole" class="btn btn-danger" type="button">Okay</a>
                    <button class="btn btn-outline-primary" type="button" data-bs-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="import-js.jsp"/>
    <script>
        var options = {
            valueNames: ["role_id","role_name","total_acc", "create_date", "update_date"]
        };

        var roleList = new List('roles', options);
        
        if (${nav_role_manage}) {
            let user_account = $('#role-manage')
            user_account.addClass('active')
        }
    </script>
    <script>
        $(document).ready(function () {
            let list_role_name = [];
            let delete_role_id;

            fetch('http://localhost:8080/ShoesShop/api/roles')
                .then(res => res.json())
                .then(data => {
                    data.forEach((el) => {
                        list_role_name.push(el.role_name.toUpperCase())
                    })
                })
                .catch(error => {
                    console.log(error)
                })

            console.log(list_role_name)

            $.validator.addMethod("alreadyexist_rolename", function(value, element) {
                return list_role_name.indexOf(value.trim().toUpperCase()) === -1;
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
                        maxlength: 50,
                        alreadyexist_rolename: true
                    }
                },
                messages: {
                    role_name: {
                        required: "Role name is cannot empty!",
                        maxlength: "Role name required less than 50 characters"
                    }
                }
            });
        });
    </script>
    <script>
        const setDeleteRoleId = (role_id) => {
            let btn_deleteRole = $('#btn_deleteRole')

            btn_deleteRole.click(function () {
                btn_deleteRole.attr('href', 'roles/del?id=' + role_id)
            })
        }
    </script>
</body>
</html>
