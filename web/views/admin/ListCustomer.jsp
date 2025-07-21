<%-- Created by IntelliJ IDEA. User: hoaht Date: 2/24/2024 Time: 8:30 PM To change this template use File | Settings | File Templates. --%>
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
                        <h2 class="mb-0">Customer Manager</h2>
                    </div>
                </div>
                <div id="accounts">
                    <div class="mb-4">
                        <div class="row g-3">   
                            <div class="col-auto">
                                <div class="search-box">
                                    <form class="position-relative" action="" method="get">
                                        <input class="form-control search-input search" name="keyword" type="search" placeholder="Search customer by name" aria-label="Search" />
                                        <span class="fas fa-search search-box-icon"></span>
                                    </form>
                                </div>
                            </div>
                            <!--  <div class="col-auto">
                        <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/customers/add"><span class="fas fa-plus me-2"></span>Add new user</a> 
                    </div> --> 
                        </div>
                    </div>
                    <div class="card bg-100 border border-2">
                        <div class="card-body px-2 py-1" data-list='{"valueNames":["id","fullname","gender","email","tel","status"]}'>
                            <div class="table-responsive scrollbar mx-n1 px-1" style="height: 70vh">
                                <table class="table fs--1 mb-0">
                                    <thead>
                                        <tr>
                                            <th class="sort align-middle pe-5" data-sort="id" scope="col" style="width:10%;padding-left: 0">ID</th>
                                            <th class="align-middle pe-5" scope="col" style="width:10%;padding-left: 0">IMAGE</th>
                                            <th class="sort align-middle pe-5" data-sort="fullname" scope="col" style="width:10%;">FULL NAME</th>
                                            <th class="align-middle pe-5" scope="col" style="width:10%;">GENDER</th>
                                            <th class="sort align-middle text-end" data-sort="email" scope="col" style="width:10%">EMAIL</th>
                                            <th class="sort align-middle text-end" data-sort="tel" scope="col" style="width:10%">TELEPHONE</th>
                                            <th class="sort align-middle ps-7" data-sort="status" scope="col" style="width:5%;">STATUS</th>
                                            <th class="" scope="col" style="width:5%;"></th>
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
                                                    <img src="${account.image}" alt="${account.fullname}'s image"/>
                                                </td>
                                                <td class="fullname align-middle white-space-nowrap fw-semi-bold text-1000">
                                                    <a href="customers/customer?id=${account.id}" class="mb-0 text-1100 fw-bold" type="button">
                                                        ${account.fullname}
                                                    </a>
                                                </td>
                                                <td class="gender align-middle white-space-nowrap fw-semi-bold text-1000">
                                                    ${account.gender}
                                                </td>
                                                <td class="email align-middle white-space-nowrap fw-semi-bold text-end text-1000">
                                                    <a class="fw-semi-bold" href="mailto:${account.email}">${account.email}</a>
                                                </td>
                                                <td class="tel align-middle white-space-nowrap fw-bold text-end ps-3 text-1100">
                                                    ${account.telephone}
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
                                                <td>
                                                    <div class="d-flex justify-content-end">

                                                        <!-- Edit Icon Button -->
                                                        <a href="${pageContext.request.contextPath}/admin/customers/customer?id=${account.id}" class="btn btn-phoenix-secondary btn-icon fs--2 px-0 ms-3" type="button">
                                                            <span data-feather="edit"></span>
                                                        </a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="d-flex justify-content-center my-3">
                                <button class="page-link" data-list-pagination="prev"><span class="fas fa-chevron-left"></span></button>
                                <ul class="mb-0 pagination"></ul>
                                <button class="page-link pe-0" data-list-pagination="next"><span class="fas fa-chevron-right"></span></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="import-js.jsp"/>

        <script>
            let user_account = $('#customer-manage');
            user_account.addClass('active');
        </script>
    </body>
</html>
