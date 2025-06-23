<%-- 
    Document   : ListBook
    Created on : Mar 2, 2024, 3:27:57 AM
    Author     : hoaht
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart</title>

        <jsp:include page="import-css.jsp"/>
    </head>
    <body>
        <main class="main" id="top">
            <jsp:include page="layout/header.jsp"/>

            <jsp:include page="layout/navigation.jsp"/>

            <section class="pt-5 pb-9">
                <div class="container-small cart">
                    <h2 class="mb-6">Orders</h2>

                    <c:if test="${sessionScope.recentOrder != null}">
                        <span class="badge badge-phoenix fs-0 badge-phoenix-info mb-3">
                            <span class="badge-label">Your Most Recent Order</span>
                            <span class="ms-1 fs-0" data-feather="info"></span>
                        </span>
                        <div class="row g-5 mb-5">
                            <div class="col-12">
                                <div>
                                    <div class="table-responsive scrollbar mx-n1 px-1">
                                        <table class="table table-sm fs--1 mb-0">
                                            <thead>
                                                <tr>
                                                    <th class=" align-middle" scope="col" style="width:10%;">ORDER ID</th>
                                                    <th class=" align-middle" scope="col" style="width:22%; min-width: 250px;">PRODUCT</th>
                                                    <th class=" align-middle pe-3" scope="col" style="width:15%;">TOTAL COST</th>
                                                    <th class=" align-middle text-start pe-3" scope="col" style="width:12%; min-width: 200px;">PAYMENT STATUS</th>
                                                    <th class=" align-middle text-start" scope="col" style="width:30%;">SHIPPING STATUS</th>
                                                    <th class=" align-middle text-end pe-0" scope="col" style="width:30%;">DATE</th>
                                                    <th class=" align-middle text-end pe-0" scope="col" ></th>
                                                </tr>
                                            </thead>
                                            <tbody class="list" id="order-table-body">
                                                <tr class="hover-actions-trigger btn-reveal-trigger position-static">
                                                    <td class="order align-middle white-space-nowrap py-3 ps-1">
                                                        <a href="${pageContext.request.contextPath}/orders/order-detail?id=${orderRecent.order.order_id}">#${orderRecent.order.order_id}</a>
                                                    </td>
                                                    <td class="total align-middle text-start fw-semi-bold text-1000 fs-0">
                                                        ${orderRecent.productName}
                                                    </td>
                                                    <td class="customer align-middle text-start pe-3 fs-0">
                                                        <fmt:formatNumber value="${orderRecent.totalCost}" type="currency" pattern="###,### ₫"/>
                                                    </td>
                                                    <td class="phone align-middle white-space-nowrap text-start fw-bold text-700 pe-3">
                                                        <c:choose>
                                                            <c:when test="${orderRecent.order.paid}">
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
                                                    <td class="fulfilment_status align-middle white-space-nowrap text-start fw-bold text-700">
                                                        <span class="badge badge-phoenix fs--1 badge-phoenix-primary">
                                                            <span class="badge-label">${orderRecent.order.status}</span>
                                                        </span>
                                                    </td>
                                                    <td class="date align-middle text-700 fs-0 text-end">
                                                        ${orderRecent.order.createDate}
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${sessionScope.recentOrder == null}">
                        <span class="badge badge-phoenix fs-0 badge-phoenix-warning mb-3">
                            <span class="badge-label">You have no recent new orders!</span>
                            <span class="ms-1 fs-0" data-feather="info"></span>
                        </span>
                    </c:if>

                    <hr>

                    <c:if test="${sessionScope.recentOrder == null}">
                        <span class="badge badge-phoenix fs-0 badge-phoenix-success mb-3">
                            <span class="badge-label">List of orders you have placed:</span>
                        </span>
                    </c:if>

                    <div class="row g-5 mb-5">
                        <div class="col-12">
                            <div>
                                <div class="table-responsive scrollbar mx-n1 px-1">
                                    <table class="table table-sm fs--1 mb-0">
                                        <c:choose>
                                            <c:when test="${sessionScope.recentOrder == null}">
                                                <thead>
                                                    <tr>
                                                        <th class=" align-middle" scope="col" style="width:10%;">ORDER ID</th>
                                                        <th class=" align-middle" scope="col" style="width:22%; min-width: 250px;">PRODUCT</th>
                                                        <th class=" align-middle pe-3" scope="col" style="width:15%;">TOTAL COST</th>
                                                        <th class=" align-middle text-start pe-3" scope="col" style="width:12%; min-width: 200px;">PAYMENT STATUS</th>
                                                        <th class=" align-middle text-start" scope="col" style="width:30%;">SHIPPING STATUS</th>
                                                        <th class=" align-middle text-end pe-0" scope="col" style="width:30%;">DATE</th>
                                                        <th class=" align-middle text-end pe-0" scope="col" ></th>
                                                    </tr>
                                                </thead>
                                            </c:when>
                                            <c:otherwise>
                                                <thead>
                                                    <tr>
                                                        <th class=" align-middle" scope="col" style="width:10%;"></th>
                                                        <th class=" align-middle" scope="col" style="width:22%; min-width: 250px;"></th>
                                                        <th class=" align-middle pe-3" scope="col" style="width:15%;"></th>
                                                        <th class=" align-middle text-start pe-3" scope="col" style="width:12%; min-width: 200px;"></th>
                                                        <th class=" align-middle text-start" scope="col" style="width:30%;"></th>
                                                        <th class=" align-middle text-end pe-0" scope="col" style="width:30%;"></th>
                                                        <th class=" align-middle text-end pe-0" scope="col" ></th>
                                                    </tr>
                                                </thead>
                                            </c:otherwise>
                                        </c:choose>
                                        <tbody class="list" id="order-table-body">
                                            <c:forEach items="${orders}" var="o">
                                                <tr class="hover-actions-trigger btn-reveal-trigger position-static">
                                                    <td class="order align-middle white-space-nowrap py-3 ps-1">
                                                        <a href="${pageContext.request.contextPath}/orders/order-detail?id=${o.order.order_id}">#${o.order.order_id}</a>
                                                    </td>
                                                    <td class="total align-middle text-start fw-semi-bold text-1000 fs-0">
                                                        ${o.productName}
                                                    </td>
                                                    <td class="customer align-middle text-start pe-3 fs-0">
                                                        <fmt:formatNumber value="${o.totalCost}" type="currency" pattern="###,### ₫"/>
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
                                                    <td class="fulfilment_status align-middle white-space-nowrap text-start fw-bold text-700">
                                                        <span class="badge badge-phoenix fs--1 badge-phoenix-primary">
                                                            <span class="badge-label">${o.order.status}</span>
                                                        </span>
                                                    </td>
                                                    <td class="date align-middle text-700 fs-0 text-end">
                                                        ${o.order.createDate}
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
            </section>
        </main>
    </body>

    <jsp:include page="import-js.jsp"/>
</html>
