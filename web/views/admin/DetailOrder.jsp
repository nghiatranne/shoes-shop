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
                <h2 class="mb-2">Order <span>#${oder_by_id.order_id}</span></h2>
                <div class="d-flex flex-wrap flex-between-center mb-1">

                </div>
                <div class="row g-5 gy-7">
                    <div class="col-12 col-xl-8 col-xxl-9">
                        <div id="order-detail-list">
                            <div class="table-responsive scrollbar">
                                <table class="table fs--1 mb-0 border-top border-200">
                                    <thead>
                                        <tr>
                                            <th class=" white-space-nowrap align-middle" scope="col">IMAGE</th>
                                            <th class=" white-space-nowrap align-middle" scope="col" style="min-width:400px;">TITLE</th>
                                            <th class=" align-middle ps-4" scope="col" style="width:150px;">AUTHOR</th>
                                            <th class=" align-middle ps-4" scope="col" style="width:300px;">ISBN</th>
                                            <th class=" align-middle text-end ps-4" scope="col" style="width:150px;">PRICE</th>
                                            <th class=" align-middle text-end ps-4" scope="col" style="width:200px;">QUANTITY</th>
                                            <th class=" align-middle text-end ps-4" scope="col" style="width:250px;">TOTAL</th>
                                        </tr>
                                    </thead>
                                    <tbody class="list" id="order-table-body">
                                        <c:forEach items="${orderDetailRAWs}" var="od">
                                            <tr class="hover-actions-trigger btn-reveal-trigger position-static">
                                                <td class="align-middle white-space-nowrap py-2">
                                                    <div class="border rounded-2">
                                                        <img src="<c:url value="/resources/book_image/${od.book.image}"/>" alt="" width="100" />
                                                    </div>
                                                </td>
                                                <td class="products align-middle py-0">
                                                    <a class="fw-semi-bold line-clamp-2 mb-0" href="${pageContext.request.contextPath}/books/book-detail?book_isbn=${od.book.isbn}">${od.book.title}</a>
                                                </td>
                                                <td class="color align-middle white-space-nowrap text-900 py-0 ps-4">
                                                    <c:forEach items="${od.book.authors}" var="a">
                                                        <a class="text-decoration-none" href="">
                                                            <span class="badge badge-tag me-2 mb-2">${a.fullName}</span>
                                                        </a>
                                                    </c:forEach>
                                                </td>
                                                <td class="size align-middle white-space-nowrap text-700 fw-semi-bold py-0 ps-4">${od.book.isbn}</td>
                                                <td class="price align-middle text-900 fw-semi-bold text-end py-0 ps-4">
                                                    <fmt:formatNumber value="${od.orderDetail.price}" type="currency" pattern="###,### ₫"/>
                                                </td>
                                                <td class="quantity align-middle text-end py-0 ps-4 text-700">
                                                    ${od.orderDetail.quantity}
                                                </td>
                                                <td class="total align-middle fw-bold text-1000 text-end py-0 ps-4">
                                                    <fmt:formatNumber value="${od.total}" type="currency" pattern="###,### ₫"/>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="d-flex flex-between-center py-3 border-bottom mb-7">
                            <p class="text-1100 fw-semi-bold lh-sm mb-0">Items subtotal :</p>
                            <p class="text-1100 fw-bold lh-sm mb-0">
                                <fmt:formatNumber value="${subtotal}" type="currency" pattern="###,### ₫"/>
                            </p>
                        </div>
                        <div class="row gx-4 gy-6 g-xl-7 justify-content-sm-center justify-content-xl-start">
                            <div class="col-12 col-sm-12">
                                <h4 class="mb-5">Customer details</h4>
                                <div class="row g-4 flex-sm-row">
                                    <div class="col-6 col-sm-3">
                                        <div class="d-flex align-items-center mb-1">
                                            <span class="me-2" data-feather="user" style="stroke-width:2.5;"></span>
                                            <h6 class="mb-0">Full Name</h6>
                                        </div>
                                        <p class="text-800 lh-sm mb-0">${oder_by_id.fullName}</p>
                                    </div>
                                    <div class="col-6 col-sm-3">
                                        <div class="d-flex align-items-center mb-1">
                                            <span class="me-2" data-feather="mail" style="stroke-width:2.5;"></span>
                                            <h6 class="mb-0">Email</h6>
                                        </div>
                                        <p class="text-800 lh-sm mb-0">${oder_by_id.email}</p>
                                    </div>
                                    <div class="col-6 col-sm-3">
                                        <div class="d-flex align-items-center mb-1">
                                            <span class="me-2" data-feather="phone" style="stroke-width:2.5;"></span>
                                            <h6 class="mb-0">Phone</h6>
                                        </div>
                                        <p class="text-800 lh-sm mb-0">${oder_by_id.tel}</p>

                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-sm-12">
                                <h4 class="mb-5">Order details</h4>
                                <div class="row g-4 flex-sm-row">
                                    <div class="col-6 col-sm-3">
                                        <div class="d-flex align-items-center mb-1">
                                            <span class="me-2" data-feather="calendar" style="stroke-width:2.5;"></span>
                                            <h6 class="mb-0">Create Date</h6>
                                        </div>
                                        <p class="mb-0 text-800 fs--1 ms-4">
                                            <fmt:formatDate value="${oder_by_id.createDate}" pattern="MMMM dd, yyyy" />
                                        </p>
                                    </div>
                                    <div class="col-6 col-sm-3">
                                        <div class="d-flex align-items-center mb-1">
                                            <span class="me-2" data-feather="credit-card" style="stroke-width:2.5;"></span>
                                            <h6 class="mb-0">Payment Method</h6>
                                        </div>
                                        <p class="mb-0 text-800 fs--1 ms-4">
                                            ${order.payment.paymentMethod}
                                        </p>
                                    </div>
                                    <div class="col-6 col-sm-6">
                                        <div class="d-flex align-items-center mb-1"><span class="me-2" data-feather="file-text" style="stroke-width:2.5;">  </span>
                                            <h6 class="mb-0">Note</h6>
                                        </div>
                                        <p class="mb-0 text-800 fs--1 ms-4">empty!</p>
                                    </div>
                                    <div class="col-6 col-sm-3 order-sm-1">
                                        <div class="d-flex align-items-center mb-1">
                                            <span class="me-2" data-feather="home" style="stroke-width:2.5;"></span>
                                            <h6 class="mb-0">Address Send</h6>
                                        </div>
                                        <div class="ms-4">
                                            <p class="text-800 mb-0 fs--1">${oder_by_id.receiveAddress}</p>
                                        </div>
                                    </div>
                                    <div class="col-6 col-sm-3 order-sm-1">
                                        <div class="d-flex align-items-center mb-1">
                                            <span class="me-2" data-feather="home" style="stroke-width:2.5;"></span>
                                            <h6 class="mb-0">Address Receive</h6>
                                        </div>
                                        <div class="ms-4">
                                            <p class="text-800 mb-0 fs--1">${oder_by_id.receiveAddress}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-xl-4 col-xxl-3">
                        <div class="row">
                            <div class="col-12">
                                <div class="card border border-2 mb-3">
                                    <div class="card-body">
                                        <h3 class="card-title mb-4">Summary</h3>
                                        <div>
                                            <div class="d-flex justify-content-between">
                                                <p class="text-900 fw-semi-bold">Items subtotal :</p>
                                                <p class="text-1100 fw-semi-bold">
                                                    <fmt:formatNumber value="${subtotal}" type="currency" pattern="###,### ₫"/>
                                                </p>
                                            </div>
                                        </div>
                                        <div class="d-flex justify-content-between border-top border-dashed pt-4">
                                            <h4 class="mb-0">Total :</h4>
                                            <h4 class="mb-0">
                                                <fmt:formatNumber value="${subtotal}" type="currency" pattern="###,### ₫"/>
                                            </h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="card border border-2 mb-3">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center justify-content-between mb-4">
                                            <h3 class="card-title m-0">Order Status</h3>
                                            <c:choose>
                                                <c:when test="${oder_by_id.status == 'CANCELED' || oder_by_id.status == 'REJECTED'}">
                                                    <span class="badge badge-phoenix fs--1 badge-phoenix-danger">
                                                        <span class="badge-label">${oder_by_id.status}</span>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-phoenix fs--1 badge-phoenix-primary">
                                                        <span class="badge-label">${oder_by_id.status}</span>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <c:choose>
                                            <c:when test="${oder_by_id.status == 'COMPLETED'}">
                                                <div class="alert alert-soft-success bg-white border border-success-500" role="alert">
                                                    <h4 class="alert-heading fw-semi-bold">Attention!</h4>
                                                    <p>You can't change the status of this order.</p>
                                                    <hr class="bg-300" />
                                                    <p class="mb-0">This order is completed.</p>
                                                </div>
                                            </c:when>
                                            <c:when test="${oder_by_id.status == 'CANCELED'}">
                                                <div class="alert alert-soft-danger bg-white border border-danger-500" role="alert">
                                                    <h4 class="alert-heading fw-semi-bold">Attention!</h4>
                                                    <p>You can't change the status of this order.</p>
                                                    <hr class="bg-300" />
                                                    <p class="mb-0">This order is canceled.</p>
                                                </div>
                                            </c:when>
                                            <c:when test="${oder_by_id.status == 'SHIPPING' && sessionScope.isWarehouse == true}">
                                                <div class="alert alert-soft-danger bg-white border border-danger-500" role="alert">
                                                    <h4 class="alert-heading fw-semi-bold">Attention!</h4>
                                                    <p>You can't change the status of this order.</p>
                                                    <hr class="bg-300" />
                                                    <p class="mb-0">This order will handle by Seller.</p>
                                                </div>
                                            </c:when>
                                            <c:when test="${(sessionScope.isSale == true || sessionScope.isSaleManager == true) && oder_by_id.status != 'CONFIRMED' && oder_by_id.status != 'PACKAGING'}">
                                                <form class="m-0 p-0" method="post">
                                                    <h6 class="mb-2">Status</h6>
                                                    <input name="order_id" class="d-none" value="${oder_by_id.order_id}"/>
                                                    <select name="order_status" class="form-select mb-2" aria-label="delivery type">
                                                        <c:forEach items="${list_status}" var="ls">
                                                            <c:choose>
                                                                <c:when test="${realStatus == ls}">
                                                                    <option value="${ls}" selected="true">${ls}</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="${ls}">${ls}</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </select>
                                                    <button class="btn btn-phoenix-secondary me-1 w-100" type="submit">UPDATE</button>
                                                </form>
                                            </c:when>
                                            <c:when test="${sessionScope.isWarehouse == true}">
                                                <form class="m-0 p-0" method="post">
                                                    <h6 class="mb-2">Status</h6>
                                                    <input name="order_id" class="d-none" value="${oder_by_id.order_id}"/>
                                                    <select name="order_status" class="form-select mb-2" aria-label="delivery type">
                                                        <c:forEach items="${list_status}" var="ls">
                                                            <c:choose>
                                                                <c:when test="${realStatus == ls}">
                                                                    <option value="${ls}" selected="true">${ls}</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="${ls}">${ls}</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </select>
                                                    <button class="btn btn-phoenix-secondary me-1 w-100" type="submit">UPDATE</button>
                                                </form>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="alert alert-soft-warning bg-white border border-warning-500" role="alert">
                                                    <h4 class="alert-heading fw-semi-bold">Attention!</h4>
                                                    <p>You can't change the status of this order.</p>
                                                    <hr class="bg-300" />
                                                    <p class="mb-0">Store staff will handle this order.</p>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <c:if test="${isSaleManager == true}">
                                    <div class="card border border-2">
                                        <div class="card-body">
                                            <h3 class="card-title mb-4">Assign to other seller</h3>
                                            <h6 class="mb-2">CURRENT SELLER: ${saleNameManageOrder}</h6>
                                            <c:choose>
                                                <c:when test="${oder_by_id.status == 'COMPLETED'}">
                                                    <div class="alert alert-soft-success bg-white border border-success-500" role="alert">
                                                        <h4 class="alert-heading fw-semi-bold">Attention!</h4>
                                                        <p>You can't change the seller of this order.</p>
                                                        <hr class="bg-300" />
                                                        <p class="mb-0">This order is completed.</p>
                                                    </div>
                                                </c:when>
                                                <c:when test="${oder_by_id.status == 'CANCELED'}">
                                                    <div class="alert alert-soft-danger bg-white border border-danger-500" role="alert">
                                                        <h4 class="alert-heading fw-semi-bold">Attention!</h4>
                                                        <p>You can't change the seller of this order.</p>
                                                        <hr class="bg-300" />
                                                        <p class="mb-0">This order is canceled.</p>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <form class="m-0 p-0" method="post" action="${pageContext.request.contextPath}/order/assign-account">
                                                        <h6 class="mb-2">List other seller</h6>
                                                        <input name="order_id" class="d-none" value="${oder_by_id.order_id}"/>
                                                        <select name="account_id" class="form-select mb-2" aria-label="delivery type">
                                                            <c:forEach items="${accountsRoleSale}" var="ars">
                                                                <option value="${ars.account.id}">${ars.account.fullname} - ${ars.totalOrder} order(s)</option>
                                                            </c:forEach>
                                                        </select>
                                                        <button class="btn btn-phoenix-secondary me-1 w-100" type="submit">UPDATE</button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="import-js.jsp"/>


        <script>
            let dashboard_tag = document.getElementById('order-manage');
            dashboard_tag.classList.add('active');
        </script>
    </body>
</html>
