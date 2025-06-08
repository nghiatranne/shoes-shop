<%--
  Created by IntelliJ IDEA.
  User: hoaht
  Date: 2/24/2024
  Time: 8:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <div>
                <div class="row g-2 mb-4">
                    <div class="col-auto">
                        <h2 class="mb-0">Admin Accounts</h2>
                    </div>
                </div>
                <div id="accounts">
                    <div class="mb-4">
                        <div class="row g-3">
                            <div class="col-auto">
                                <div class="search-box">
                                    <form class="position-relative m-0" data-bs-toggle="search" data-bs-display="static">
                                        <input class="form-control search-input search" type="search" placeholder="Search accounts" aria-label="Search" />
                                        <span class="fas fa-search search-box-icon"></span>
                                    </form>
                                </div>
                            </div>
                            <div class="col-auto" style="margin-top: 3px">
                                <label for="sortSelect" class="form-label" style="padding-left: 0px">Chossen option</label>
                                <form id="sortForm" action="accounts" method="post">
                                    <select class="form-select" id="sortSelect" name="sort" onchange="document.getElementById('sortForm').submit();">
                                        <option value="8" ${selectedSort == '8' ? 'selected' : ''}>All</option>
                                        <option value="0" ${selectedSort == '0' ? 'selected' : ''}>Male</option>
                                        <option value="1" ${selectedSort == '1' ? 'selected' : ''}>Female</option>
                                        <option value="2" ${selectedSort == '2' ? 'selected' : ''}>Admin</option>
                                        <option value="3" ${selectedSort == '3' ? 'selected' : ''}>Customer</option>
                                        <option value="4" ${selectedSort == '4' ? 'selected' : ''}>Maketer</option>
                                        <option value="5" ${selectedSort == '5' ? 'selected' : ''}>Sale</option>
                                        <option value="6" ${selectedSort == '6' ? 'selected' : ''}>NOT AVAILABLE</option>
                                        <option value="7" ${selectedSort == '7' ? 'selected' : ''}>AVAILABLE</option>
                                    </select>
                                </form>
                            </div>
                            <div class="col-auto">
                                <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/accounts/add"><span class="fas fa-plus me-2"></span>Add new user</a> 
                            </div>
                        </div>
                    </div>
                    <div class="card bg-100 border border-2">
                        <div class="card-body px-2 py-1" data-list='{"valueNames":["id","fullname","email","tel","torder","tspent","status", "role"]}'>
                            <div class="table-responsive scrollbar mx-n1 px-1" style="height: 70vh">
                                <table class="table fs--1 mb-0">
                                    <thead>
                                        <tr>
                                            <th class="sort align-middle pe-5" data-sort="id" scope="col" style="width:10%;padding-left: 0">ID</th>
                                            <th class="align-middle pe-5" scope="col" style="width:10%;padding-left: 0">IMAGE</th>
                                            <th class="sort align-middle pe-5" data-sort="fullname" scope="col" style="width:10%;">FULLNAME</th>
                                            <th class="sort align-middle text-end" data-sort="email" scope="col" style="width:10%">EMAIL</th>
                                            <th class="sort align-middle text-end" data-sort="tel" scope="col" style="width:10%">TELEPHONE</th>
                                            <th class="sort align-middle text-end ps-3" data-sort="torder" scope="col" style="width:10%">TOTAL ORDER</th>
                                            <th class="sort align-middle ps-7" data-sort="tspent" scope="col" style="width:10%;">TOTAL SPENT</th>
                                            <th class="sort align-middle ps-7" data-sort="status" scope="col" style="width:5%;">STATUS</th>
                                            <th class="sort align-middle text-end pe-7" data-sort="role" scope="col" style="width:10%;">ROLE</th>
                                        </tr>
                                    </thead>
                                    <tbody class="list">
                                        <c:forEach items="${accounts}" var="account">
                                            <tr class="hover-actions-trigger btn-reveal-trigger position-static">
                                                <td class="id align-middle white-space-nowrap pe-5">
                                                    <a href="accounts/account?id=${account.id}" class="d-flex align-items-center text-decoration-none">
                                                        <p class="mb-0 text-1100 fw-bold">${account.id}</p>
                                                    </a>
                                                </td>
                                                <td class="align-middle white-space-nowrap pe-5">
                                                    <img src="${account.image}" alt="${account.image}"/>
                                                </td>
                                                <td class="fullname align-middle white-space-nowrap fw-semi-bold text-1000">
                                                    <a href="accounts/account?id=${account.id}" class="mb-0 text-1100 fw-bold" type="button">
                                                        ${account.fullname}
                                                    </a>
                                                </td>
                                                <td class="email align-middle white-space-nowrap fw-semi-bold text-end text-1000">
                                                    <a class="fw-semi-bold" href="mailto:${account.email}">${account.email}</a>
                                                </td>
                                                <td class="tel align-middle white-space-nowrap fw-bold text-end ps-3 text-1100">
                                                    ${account.telephone}
                                                </td>
                                                <td class="torder align-middle white-space-nowrap fw-bold text-end ps-3 text-1100">
                                                    100 orders
                                                </td>
                                                <td class="tspent align-middle white-space-nowrap text-1000 ps-7">
                                                    <fmt:formatNumber type="currency" currencySymbol="$" value="100" />
                                                </td>
                                                <td class="status align-middle white-space-nowrap text-1000 ps-7">
                                                    <c:choose>
                                                        <c:when test="${account.status == true}">
                                                            <span class="badge badge-phoenix fs--2 badge-phoenix-success">
                                                                <span class="badge-label">AVAILABLE</span>
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge badge-phoenix fs--2 badge-phoenix-danger">
                                                                <span class="badge-label">NOT AVAILABLE</span>
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="role align-middle white-space-nowrap text-700 text-end">
                                                    <c:forEach items="${account.roles}" var="role">
                                                        <span class="badge badge-phoenix fs--2 badge-phoenix-info">${role.role_name}</span>
                                                    </c:forEach>
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

        <jsp:include page="import-js.jsp"/>

        <script>
            var options = {
                valueNames: ['acc_id', 'acc_fullName', 'acc_email', 'acc_telephone', 'acc_status', 'acc_role']
            };

            var accountList = new List('accounts', options);

            if (${nav_account_manage}) {
                let user_account = $('#account-manage');
                user_account.addClass('active');
            }
        </script>
    </body>
</html>
