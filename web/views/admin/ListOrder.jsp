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
                <div class="row g-3 mb-4">
                    <div class="col-auto">
                        <h2 class="mb-0">Orders</h2>
                    </div>
                </div>
                <div class="row">
                    <div id="orders" class="col-12">
                        <div class="mb-4">
                            <div class="row g-3">
                                <div class="col-auto">
                                    <div class="search-box">
                                        <form class="position-relative" method="get">
                                            <input class="form-control search-input search" type="search" name="searchQuery" placeholder="Search orders by ID or Customer Name" aria-label="Search" />
                                            <button type="submit" class="fas fa-search search-box-icon"></button>
                                        </form>
                                    </div>
                                </div>
                                <div class="col-auto scrollbar overflow-hidden-y flex-grow-1">
                                    <div class="btn-group position-static" role="group">
                                        <div class="btn-group position-static text-nowrap" role="group">
                                            <button class="btn btn-sm btn-phoenix-secondary px-7 flex-shrink-0" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"> 
                                                Filter By Name<span class="fas fa-angle-down ms-2"></span>
                                            </button>
                                            <ul class="dropdown-menu dropdown-menu-end">
                                                <li>
                                                    <a class="dropdown-item" href="orders">All</a>
                                                </li>
                                                <c:forEach items="${orderName}" var="ls">
                                                    <li>
                                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/orders?orderName=${ls.fullName}">${ls.fullName}</a>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-auto scrollbar overflow-hidden-y flex-grow-1 text-midle">
                                    <div class="btn-group position-static " role="group " style="background: ">
                                        <div style="margin-left: 10px"st class="btn-group position-static text-nowrap" role="group">
                                            <form class="d-flex align-items-center gap-2" id="addNewPaymentForm" method="get" action="" style="padding: 2px;">
                                                <div>
                                                    <label class="form-label" for="paymentMethodIn">From: </label>
                                                    <input name="createDateFirst" class="form-control" id="paymentMethodIn" type="date" required value="${createDate}" />
                                                </div>
                                                <div>
                                                    <label class="form-label" for="paymentMethodIn">To: </label>
                                                    <input name="createDateSecond" class="form-control" id="paymentMethodIn" type="date" required value="${createDate1}"/>
                                                </div>
                                                <div class="d-flex justify-content-end">
                                                    <input class="btn btn-phoenix-primary" type="submit" value="Filter">
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row g-3">
                                <div class="col-2">
                                    <c:choose>
                                        <c:when test="${sessionScope.isWarehouse}">
                                            <a class="text-decoration-none" onclick="showToast('You do not have permission to access this page!');">
                                                <div class="d-flex align-items-center justify-content-between border border-2 p-3 rounded-3 hover-shadow position-relative bg-100 cursor-pointer">
                                                    <div class="d-flex align-items-center">
                                                        <span class="fas fa-shopping-bag text-primary fs-3"></span>
                                                        <div class="ms-3">
                                                            <h5 class="mb-0">${totalPending_order} SUBMITTED</h5>
                                                        </div>
                                                    </div>
                                                    <span class="text-secondary" data-feather="arrow-right" style="height: 30px; width: 30px;"></span>
                                                </div>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a class="text-decoration-none" href="${pageContext.request.contextPath}/admin/orders?status=0">
                                                <div class="d-flex align-items-center justify-content-between border border-2 p-3 rounded-3 hover-shadow position-relative">
                                                    <div class="d-flex align-items-center">
                                                        <span class="fas fa-shopping-bag text-primary fs-3"></span>
                                                        <div class="ms-3">
                                                            <h5 class="mb-0">${totalPending_order} SUBMITTED</h5>
                                                        </div>
                                                    </div>
                                                    <span class="text-secondary" data-feather="arrow-right" style="height: 30px; width: 30px;"></span>
                                                </div>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="col-2">
                                    <a class="text-decoration-none" href="${pageContext.request.contextPath}/admin/orders?status=1">
                                        <div class="d-flex align-items-center justify-content-between border border-2 p-3 rounded-3 hover-shadow position-relative">
                                            <div class="d-flex align-items-center">
                                                <span class="far fa-check-circle text-primary fs-3"></span>
                                                <div class="ms-3">
                                                    <h5 class="mb-0">${totalProcessing_order} CONFIRMED</h5>
                                                </div>
                                            </div>
                                            <span class="text-secondary" data-feather="arrow-right" style="height: 30px; width: 30px;"></span>
                                        </div>
                                    </a>
                                </div>
                                <div class="col-2">
                                    <a class="text-decoration-none" href="${pageContext.request.contextPath}/admin/orders?status=2">
                                        <div class="d-flex align-items-center justify-content-between border border-2 p-3 rounded-3 hover-shadow position-relative">
                                            <div class="d-flex align-items-center">
                                                <span class="fas fa-box-open text-primary fs-3"></span>
                                                <div class="ms-3">
                                                    <h5 class="mb-0">${totalShipping_order} PACKAGING</h5>
                                                </div>
                                            </div>
                                            <span class="text-secondary" data-feather="arrow-right" style="height: 30px; width: 30px;"></span>
                                        </div>
                                    </a>
                                </div>
                                <div class="col-2">
                                    <a class="text-decoration-none" href="${pageContext.request.contextPath}/admin/orders?status=3">
                                        <div class="d-flex align-items-center justify-content-between border border-2 p-3 rounded-3 hover-shadow position-relative">
                                            <div class="d-flex align-items-center">
                                                <span class="fas fa-shipping-fast text-primary fs-3"></span>
                                                <div class="ms-3">
                                                    <h5 class="mb-0">${totalCompleted_order} SHIPPING</h5>
                                                </div>
                                            </div>
                                            <span class="text-secondary" data-feather="arrow-right" style="height: 30px; width: 30px;"></span>
                                        </div>
                                    </a>
                                </div>
                                <div class="col-2">
                                    <a class="text-decoration-none" href="${pageContext.request.contextPath}/admin/orders?status=4">
                                        <div class="d-flex align-items-center justify-content-between border border-2 p-3 rounded-3 hover-shadow position-relative">
                                            <div class="d-flex align-items-center">
                                                <span class="fas fa-dolly text-primary fs-3"></span>
                                                <div class="ms-3">
                                                    <h5 class="mb-0">${totalCancelled_order} SHIPPED</h5>
                                                </div>
                                            </div>
                                            <span class="text-secondary" data-feather="arrow-right" style="height: 30px; width: 30px;"></span>
                                        </div>
                                    </a>
                                </div>
                                <div class="col-2">
                                    <a class="text-decoration-none" href="${pageContext.request.contextPath}/admin/orders?status=5">
                                        <div class="d-flex align-items-center border border-2 p-3 rounded-3 hover-shadow position-relative">
                                            <span class="fas fa-check text-primary fs-3"></span>
                                            <div class="ms-3">
                                                <h5 class="mb-0">${totalCancelled_order} COMPLETED</h5>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="col-3">
                                    <a class="text-decoration-none">
                                        <div class="d-flex align-items-center border border-2 p-3 rounded-3 hover-shadow position-relative">
                                            <span class="fas fa-money-check-alt fs-3"></span>
                                            <div class="ms-3">
                                                <h5 class="mb-0">Subtotal: <fmt:formatNumber value="${subTotal}" type="currency" pattern="###,### ₫"/></h5>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="col-5"></div>
                                <div class="col-2">
                                    <a class="text-decoration-none" href="${pageContext.request.contextPath}/admin/orders?status=-1">
                                        <div class="d-flex align-items-center border border-2 p-3 rounded-3 hover-shadow position-relative">
                                            <span class="far fa-times-circle text-danger fs-3"></span>
                                            <div class="ms-3">
                                                <h5 class="mb-0 text-danger">${totalCancelled_order} CANCELED</h5>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="col-2">
                                    <a class="text-decoration-none" href="${pageContext.request.contextPath}/admin/orders?status=-2">
                                        <div class="d-flex align-items-center border border-2 p-3 rounded-3 hover-shadow position-relative">
                                            <span class="far fa-times-circle text-danger fs-3"></span>
                                            <div class="ms-3">
                                                <h5 class="mb-0 text-danger">${totalCancelled_order} REJECTED</h5>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <c:if test="${sessionScope.update_status_success == true}">
                            <div class="alert alert-soft-warning alert-dismissible fade show w-auto mt-2 px-2 py-3">
                                <strong>Invoice with ID: <a href="orders/order?order_id=${sessionScope.order_id_updated}">#${sessionScope.order_id_updated}</a> has had its status updated successfully!</strong>
                            </div>
                        </c:if>
                        <% session.removeAttribute("update_status_success");%>
                        <% session.removeAttribute("order_id_updated");%>
                        <div id="tableExample2" class="table-responsive scrollbar mx-n1 px-1" data-list='{"valueNames":["order_date","customer_name","total_cost","status"],"page":10,"pagination":true}'>
                            <table class="table table-sm fs--1 mb-0">
                                <thead>
                                    <tr>
                                        <th class="white-space-nowrap align-middle pe-3" scope="col" style="width:5%;">ID</th>
                                        <th class="sort align-middle text-end" data-sort="order_date" scope="col" style="width:10%;">ORDERED DATE</th>
                                        <th class="sort align-middle ps-5" data-sort="customer_name" scope="col" style="width:15%; min-width: 235px;">CUSTOMER NAME</th>
                                        <th class="align-middle pe-3" scope="col" style="width:15%;">PRODUCT NAME</th>
                                        <th class="sort align-middle text-start pe-3" data-sort="total_cost" scope="col" style="width:12%; min-width: 150px;">TOTAL COST</th>
                                        <th class="align-middle text-start" scope="col" style="width:10%;">QUANTITY OF PRODUCT</th>
                                        <th class="sort align-middle text-start" data-sort="status" scope="col" style="width:10%;">STATUS</th>
                                        <th class="align-middle text-start" scope="col" style="width:10%;">PAYMENT STATUS</th>
                                        <th style="min-width:100px;" class="" scope="col"></th>
                                    </tr>
                                </thead>
                                <tbody class="list">
                                    <c:forEach items="${orders}" var="o">
                                        <tr class="product hover-actions-trigger btn-reveal-trigger position-static">
                                            <td class="align-middle white-space-nowrap py-3">
                                                <a class="fw-semi-bold" href="${pageContext.request.contextPath}/admin/orders/order?order_id=${o.order.order_id}">${o.order.order_id}</a>
                                            </td>
                                            <td class="order_date align-middle text-end fw-semi-bold text-1000 fs--1">
                                                <fmt:formatDate value="${o.order.createDate}" pattern="yyyy-MM-dd" />
                                            </td>
                                            <td class="customer_name align-middle white-space-nowrap ps-5">
                                                <a class="d-flex align-items-center text-decoration-none" href="orders/order?order_id=${o.order.order_id}">
                                                    <h6 class="mb-0 text-900">${o.order.fullName}</h6>
                                                </a>
                                            </td>
                                            <td class="align-middle white-space-nowrap pe-3">
                                                ${o.productName}
                                            </td>
                                            <td class="total_cost align-middle text-start pe-3">
                                                <fmt:formatNumber value="${o.totalCost}" type="currency" pattern="###,### ₫"/>
                                            </td>
                                            <td class="align-middle text-start pe-3">
                                                ${o.totalProduct}
                                            </td>
                                            <td class="status align-middle text-start">
                                                <c:choose>
                                                    <c:when test="${o.order.status == 'CANCELED' || o.order.status == 'REJECTED'}">
                                                        <span class="badge badge-phoenix fs--1 badge-phoenix-danger">
                                                            <span class="badge-label">${o.order.status}</span>
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-phoenix fs--1 badge-phoenix-primary">
                                                            <span class="badge-label">${o.order.status}</span>
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="phone align-middle white-space-nowrap text-start fw-bold text-700 pe-3">
                                                <c:choose>
                                                    <c:when test="${o.order.paid}">
                                                        <span class="badge badge-phoenix fs--1 badge-phoenix-success">
                                                            <span class="badge-label">PAID</span>
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-phoenix fs--1 badge-phoenix-warning">
                                                            <span class="badge-label">UNPAID</span>
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="align-middle">
                                                <c:if test="${statusCur == 'SUBMITTED' && (sessionScope.isSaleManager || sessionScope.isSale)}">
                                                    <a href="${pageContext.request.contextPath}/admin/orders/order/change-status?order_id=${o.order.order_id}&order_status=CONFIRMED" class="btn btn-phoenix-success btn-icon fs--2 px-0 ms-3" type="button" data-bs-toggle="tooltip" data-bs-placement="top" title="CONFIRM">
                                                        <span class="" data-feather="check"></span>
                                                    </a>
                                                </c:if>
                                                <c:if test="${statusCur == 'SUBMITTED'  && o.order.paid == false && (sessionScope.isSaleManager || sessionScope.isSale)}">
                                                    <a href="${pageContext.request.contextPath}/admin/orders/order/change-status?order_id=${o.order.order_id}&order_status=REJECTED" class="btn btn-phoenix-danger btn-icon fs--2 px-0 ms-3 mt-2" type="button" data-bs-toggle="tooltip" data-bs-placement="top" title="REJECT">
                                                        <span class="" data-feather="x"></span>
                                                    </a>
                                                </c:if>

                                                <c:if test="${statusCur == 'CONFIRMED' && (sessionScope.isSaleManager || sessionScope.isSale || sessionScope.isWarehouse)}">
                                                    <a href="${pageContext.request.contextPath}/admin/orders/order/change-status?order_id=${o.order.order_id}&order_status=PACKAGING" class="btn btn-phoenix-success btn-icon fs--2 px-0 ms-3" type="button" data-bs-toggle="tooltip" data-bs-placement="top" title="PACKAGING">
                                                        <span class="" data-feather="check"></span>
                                                    </a>
                                                </c:if>
                                                <c:if test="${statusCur == 'PACKAGING' && (sessionScope.isSaleManager || sessionScope.isSale || sessionScope.isWarehouse)}">
                                                    <a href="${pageContext.request.contextPath}/admin/orders/order/change-status?order_id=${o.order.order_id}&order_status=SHIPPING" class="btn btn-phoenix-success btn-icon fs--2 px-0 ms-3" type="button" data-bs-toggle="tooltip" data-bs-placement="top" title="SHIPPING">
                                                        <span class="" data-feather="check"></span>
                                                    </a>
                                                </c:if>
                                                
                                                <c:if test="${statusCur == 'SHIPPING' && (sessionScope.isSaleManager || sessionScope.isSale)}">
                                                    <a href="${pageContext.request.contextPath}/admin/orders/order/change-status?order_id=${o.order.order_id}&order_status=SHIPPED" class="btn btn-phoenix-success btn-icon fs--2 px-0 ms-3" type="button" data-bs-toggle="tooltip" data-bs-placement="top" title="SHIPPED">
                                                        <span class="" data-feather="check"></span>
                                                    </a>
                                                    
                                                    <a href="${pageContext.request.contextPath}/admin/orders/order/change-status?order_id=${o.order.order_id}&order_status=CANCELED" class="btn btn-phoenix-danger btn-icon fs--2 px-0 ms-3 mt-2" type="button" data-bs-toggle="tooltip" data-bs-placement="top" title="CANCEL">
                                                        <span class="" data-feather="x"></span>
                                                    </a>
                                                </c:if>
                                                <c:if test="${statusCur == 'SHIPPED' && (sessionScope.isSaleManager || sessionScope.isSale)}">
                                                    <a href="${pageContext.request.contextPath}/admin/orders/order/change-status?order_id=${o.order.order_id}&order_status=COMPLETED" class="btn btn-phoenix-success btn-icon fs--2 px-0 ms-3" type="button" data-bs-toggle="tooltip" data-bs-placement="top" title="COMPLETED">
                                                        <span class="" data-feather="check"></span>
                                                    </a>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <div class="d-flex justify-content-center my-3"><button class="page-link" data-list-pagination="prev"><span class="fas fa-chevron-left"></span></button>
                                <ul class="mb-0 pagination"></ul><button class="page-link pe-0" data-list-pagination="next"><span class="fas fa-chevron-right"></span></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="import-js.jsp"/>

        <script>
            let dashboard_tag = document.getElementById('order-manage')
            dashboard_tag.classList.add('active')
        </script>

        <script>
            var options = {
                valueNames: ['order', 'total', 'customer', 'phone', 'fulfilment_status', 'delivery_type', 'date']
            };

            var orderList = new List('orders', options);

            if (${nav_order_manage}) {
                let user_account = $('#order-manage');
                user_account.addClass('active');
            }
        </script>
    </body>
</html>
