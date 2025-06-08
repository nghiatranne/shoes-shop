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
            <div class="mb-9">
                <div class="row align-items-center justify-content-between g-3 mb-4">
                    <div class="col-auto">
                        <h2 class="mb-0">Account details</h2>
                    </div>
                </div>
                <div class="row g-5">
                    <div class="col-12 col-xxl-4">
                        <div class="row g-3 g-xxl-0">
                            <div class="col-12 col-md-7 col-xxl-12 mb-xxl-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row align-items-center mb-0 text-center text-sm-start">
                                            <div class="col-12 col-sm-auto flex-1">
                                                <h3>${account_detail.fullname}</h3>
                                                <p>Role: <br>
                                                    <c:forEach items="${account_detail.roles}" var="ar">
                                                        <span class="badge badge-phoenix fs--2 badge-phoenix-info">${ar.role_name}</span>
                                                    </c:forEach>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-md-5 col-xxl-12 mb-xxl-3">
                                <div class="card">
                                    <div class="card-body pb-3">
                                        <div class="d-flex align-items-center mb-3">
                                            <h3 class="me-1">Detail Information</h3>
                                        </div>
                                        <div class="mb-3">
                                            <h5 class="text-800">Account ID</h5>${account_detail.id}
                                        </div>
                                        <div class="mb-3">
                                            <h5 class="text-800">Status</h5>

                                            <c:choose>
                                                <c:when test="${account_detail.status == true}">
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
                                        </div>
                                        <div class="mb-3">
                                            <h5 class="text-800">Email</h5><a href="mailto:shatinon@jeemail.com">${account_detail.email}</a>
                                        </div>
                                        <div class="mb-3">
                                            <h5 class="text-800">Gender</h5>
                                            <c:choose>
                                                <c:when test="${account_detail.gender != null}">
                                                    ${account_detail.gender}
                                                </c:when>
                                                <c:otherwise>
                                                    empty!
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="mb-3">
                                            <h5 class="text-800">Address</h5>
                                            <p class="text-800">${account_detail.address}</p>
                                        </div>
                                        <div class="mb-3">
                                            <h5 class="text-800">Phone</h5><a class="text-800" href="tel:+1234567890">${account_detail.telephone}</a>
                                        </div>
                                        <div>
                                            <h5 class="text-800">Birth Date</h5>
                                            <c:choose>
                                                <c:when test="${account_detail.birthdate != null}">
                                                    <fmt:formatDate value="${account_detail.birthdate}" pattern="MMMM dd, yyyy" />
                                                </c:when>
                                                <c:otherwise>
                                                    empty!
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-xxl-8">
                        <div class="mb-6">
                            <h3 class="mb-4">Orders [Đang phát triển]<span class="text-700 fw-normal">(${orders_totalSpent.size()})</span></h3>
                            <div class="border-top border-bottom border-200">
                                <div class="table-responsive scrollbar mx-n1 px-1">
                                    <table class="table table-sm fs--1 mb-0">
                                        <thead>
                                            <tr>
                                                <th class=" white-space-nowrap align-middle pe-3" scope="col" style="width:5%;">ORDER</th>
                                                <th class=" align-middle text-end" scope="col" style="width:6%;">TOTAL</th>
                                                <th class=" align-middle ps-8" scope="col" style="width:28%; min-width: 250px;">CUSTOMER</th>
                                                <th class=" align-middle pe-3" scope="col" style="width:10%;">TELEPHONE</th>
                                                <th class=" align-middle text-start pe-3" scope="col" style="width:12%; min-width: 200px;">FULFILMENT STATUS</th>
                                                <th class=" align-middle text-start" scope="col" style="width:30%;">DELIVERY TYPE</th>
                                                <th class=" align-middle text-end pe-0" scope="col" >DATE</th>
                                            </tr>
                                        </thead>
                                        <tbody class="list" id="order-table-body">
                                            <c:forEach items="${orders_totalSpent}" var="ot">
                                                <tr class="hover-actions-trigger btn-reveal-trigger position-static">
                                                    <td class="order align-middle white-space-nowrap py-0">
                                                        <a class="fw-semi-bold" href="${pageContext.request.contextPath}/admin/orders/order?order_id=${ot.key.order_id}">#${ot.key.order_id}</a>
                                                    </td>
                                                    <td class="total align-middle text-end fw-semi-bold text-1000 fs-1">
                                                        <fmt:formatNumber type="currency" currencySymbol="$" value="${ot.value}" />
                                                    </td>
                                                    <td class="customer align-middle white-space-nowrap ps-8">
                                                        <a class="d-flex align-items-center text-decoration-none" href="${pageContext.request.contextPath}/admin/orders/order?order_id=${ot.key.order_id}">
                                                            <h6 class="mb-0 text-900">${ot.key.account.acc_fullname}</h6>
                                                        </a>
                                                    </td>
                                                    <td class="phone align-middle white-space-nowrap text-start fw-bold text-700">
                                                        <a class="d-flex align-items-center text-decoration-none" href="tel:${bos.key.customer.phone}">
                                                            <h6 class="mb-0 text-900">${ot.key.account.acc_telephone}</h6>
                                                        </a>
                                                    </td>
                                                    <td class="fulfilment_status align-middle white-space-nowrap text-start fw-bold text-700">
                                                        <c:if test="${ot.key.status == 'PENDING'}">
                                                            <span class="badge badge-phoenix fs--2 badge-phoenix-warning">
                                                                <span class="badge-label">${ot.key.status}</span>
                                                                <span class="ms-1" data-feather="clock" style="height:12.8px;width:12.8px;"></span>
                                                            </span>
                                                        </c:if>
                                                        <c:if test="${ot.key.status == 'PROCESSING'}">
                                                            <span class="badge badge-phoenix fs--2 badge-phoenix-primary">
                                                                <span class="badge-label">${ot.key.status}</span>
                                                                <span class="ms-1" data-feather="package" style="height:12.8px;width:12.8px;"></span>
                                                            </span>
                                                        </c:if>
                                                        <c:if test="${ot.key.status == 'SHIPPING'}">
                                                            <span class="badge badge-phoenix fs--2 badge-phoenix-info">
                                                                <span class="badge-label">${ot.key.status}</span>
                                                                <span class="ms-1" data-feather="send" style="height:12.8px;width:12.8px;"></span>
                                                            </span>
                                                        </c:if>
                                                        <c:if test="${ot.key.status == 'COMPLETED'}">
                                                            <span class="badge badge-phoenix fs--2 badge-phoenix-success">
                                                                <span class="badge-label">${ot.key.status}</span>
                                                                <span class="ms-1" data-feather="check" style="height:12.8px;width:12.8px;"></span>
                                                            </span>
                                                        </c:if>
                                                        <c:if test="${ot.key.status == 'CANCELLED'}">
                                                            <span class="badge badge-phoenix fs--2 badge-phoenix-secondary">
                                                                <span class="badge-label">${ot.key.status}</span>
                                                                <span class="ms-1" data-feather="x" style="height:12.8px;width:12.8px;"></span>
                                                            </span>
                                                        </c:if>
                                                    </td>
                                                    <td class="delivery_type align-middle white-space-nowrap text-900 fs--1 text-start">
                                                        ${ot.key.payment.paymentMethod}
                                                    </td>
                                                    <td class="date align-middle white-space-nowrap text-700 fs--1 ps-4 text-end">
                                                        <fmt:formatDate value="${ot.key.createDate}" pattern="MMMM dd, yyyy" />
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="mb-6 w-60">
                            <h3 class="mb-4">Role<span class="text-700 fw-normal">(${account_detail.roles.size()})</span></h3>
                            <form class="mb-3 row" action="assign-role" method="post">
                                <input name="acc_id" class="d-none" value="${account_detail.id}"/>

                                <div class="col-4" style="padding-right: 0px">
                                    <select class="form-select" name="role_id">
                                        <option value="" disabled selected>Select role to assign</option>
                                        <c:forEach items="${roles_insert}" var="ri">
                                            <option value="${ri.id}">${ri.role_name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-2" style="padding-left: 0px">
                                    <button class="btn btn-phoenix-info me-1 mb-1" type="submit">Assign</button>
                                </div>


                                <div class="col-3" style="padding-left: 0px ">
                                    <button class="card card-body btn btn-phoenix-infobadge badge badge-phoenix fs--2 badge-phoenix-success badge-label me-1 mb-1" type="submit" name="status" value="available">AVAILABLE</button>
                                    <button class="card card-body btn btn-phoenix-infobadge badge badge-phoenix fs--2 badge-phoenix-danger badge-label me-1 mb-1" type="submit" name="status" value="not_available">NOT AVAILABLE</button>
                                </div>
                            </form>
                            <c:if test="${account_detail.roles.size() == 1}">
                                <span class="badge badge-phoenix fs--2 badge-phoenix-warning mb-4">
                                    <span class="badge-label">Account needs at least 1 role</span>
                                    <span class="ms-1" data-feather="alert-octagon" style="height:12.8px;width:12.8px;"></span>
                                </span>
                            </c:if>
                            <div class="border-top border-bottom border-200">
                                <div class="table-responsive scrollbar mx-n1 px-1">
                                    <table class="table table-sm fs--1 mb-0">
                                        <thead>
                                            <tr>
                                                <th class=" white-space-nowrap align-middle pe-3" scope="col" style="width:5%;">Role Name</th>
                                                <th class=" align-middle text-end pe-0" scope="col" >Action</th>
                                            </tr>
                                        </thead>
                                        <tbody class="list" id="order-table-body">
                                            <c:forEach items="${account_detail.roles}" var="r">
                                                <tr class="hover-actions-trigger btn-reveal-trigger position-static">
                                                    <td class="customer align-middle white-space-nowrap">
                                                        <span class="badge badge-phoenix fs--2 badge-phoenix-info">${r.role_name}</span>
                                                    </td>
                                                    <td class="date align-middle white-space-nowrap text-700 fs--1 ps-4 text-end">
                                                        <c:choose>
                                                            <c:when test="${account_detail.roles.size() > 1}">
                                                                <a href="${pageContext.request.contextPath}/admin/accounts/remove-role?acc_id=${account_detail.id}&role_id=${r.id}" class="btn btn-phoenix-danger" type="button">Remove</a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a class="btn btn-phoenix-danger disabled" type="button">Remove</a>
                                                            </c:otherwise>
                                                        </c:choose>
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

        <jsp:include page="import-js.jsp"/>

        <script>
            if (${nav_account_manage}) {
                let user_account = $('#account-manage');
                user_account.addClass('active');
            }
        </script>
    </body>
</html>
