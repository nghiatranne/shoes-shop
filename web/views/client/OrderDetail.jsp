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
        <title>Order Detail</title>

        <jsp:include page="import-css.jsp"/>
    </head>
    <body>
        <main class="main" id="top">
            <jsp:include page="layout/header.jsp"/>

            <jsp:include page="layout/navigation.jsp"/>

            <section class="pt-5 pb-9">
                <div class="container-small">
                    <div class="d-flex justify-content-between align-items-end mb-4">
                        <h2 class="mb-0">Order: #${detailOrder.order_id}</h2>
                        <div>
                            <c:choose>
                                <c:when test="${detailOrder.status == 'SUBMITTED' && detailOrder.paid == false}">
                                    <a href="${pageContext.request.contextPath}/orders/cancel?order_id=${detailOrder.order_id}" class="btn btn-phoenix-danger" type="button">Cancel order</a>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-phoenix-danger" type="button" disabled="">Cancel order</button>
                                </c:otherwise>
                            </c:choose>
                            <c:choose>
                                <c:when test="${detailOrder.status == 'SUBMITTED'}">
                                    <button class="btn btn-phoenix-info" type="button" data-bs-toggle="modal" data-bs-target="#verticallyCentered">Change the address</button>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-phoenix-info" type="button" disabled="">Change the address</button>
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${detailOrder.status == 'SHIPPED'}">
                                <a href="${pageContext.request.contextPath}/orders/receive?order_id=${detailOrder.order_id}" class="btn btn-phoenix-success" type="button">Received the goods</a>
                            </c:if>
                        </div>
                    </div>
                    <c:if test="${cancelOrderSuccess == true}">
                        <span class="badge badge-phoenix badge-phoenix-info mb-3" style="font-size: 15px">
                            <span class="badge-label">You have canceled this order</span>
                            <span class="ms-1" data-feather="check" style="height:12.8px;width:12.8px;"></span>
                        </span>
                    </c:if>
                    <% session.removeAttribute("cancelOrderSuccess");%>
                    <c:if test="${detailOrder.status == 'COMPLETED'}">
                        <div class="row justify-content-center my-3 cursor-pointer g-1" id="thank-text">
                            <h1 class="col-auto">✨</h1>
                            <h1 class="col-auto text-gradient-info">
                                Thank you for trusting and using our services
                            </h1>
                            <h1 class="col-auto">✨</h1>
                        </div>
                        <div style="display: none" class="row justify-content-center my-3 cursor-pointer g-1" id="buy-text">
                            <h1 class="col-auto">✨</h1>
                            <h1 class="col-auto text-gradient-info">
                                Wishing you happy reading
                            </h1>
                            <h1 class="col-auto">✨</h1>
                        </div>
                    </c:if>
                    <div class="bg-soft dark__bg-1100 p-4 mb-4 rounded-2">
                        <div class="row g-4">
                            <div class="col-12 col-sm-6 col-lg-6">
                                <div class="row g-4 gy-lg-5">
                                    <div class="col-12 col-lg-4">
                                        <h6 class="mb-2"> Order No :</h6>
                                        <p class="fs--1 text-800 fw-semi-bold mb-0">${detailOrder.order_id}</p>
                                    </div>
                                    <div class="col-12 col-lg-4">
                                        <h6 class="mb-2"> Order Date :</h6>
                                        <p class="fs--1 text-800 fw-semi-bold mb-0">
                                            <fmt:formatDate value="${detailOrder.createDate}" pattern="MM.dd.yyyy"/>
                                        </p>
                                    </div>
                                    <div class="col-12 col-lg-4">
                                        <h6 class="mb-2"> Full Name :</h6>
                                        <p class="fs--1 text-800 fw-semi-bold mb-0">${detailOrder.fullName}</p>
                                    </div>
                                    <div class="col-12 col-lg-4">
                                        <h6 class="mb-2"> Email :</h6>
                                        <p class="fs--1 text-800 fw-semi-bold mb-0">${detailOrder.email}</p>
                                    </div>
                                    <div class="col-12 col-lg-4">
                                        <h6 class="mb-2"> Phone Number :</h6>
                                        <p class="fs--1 text-800 fw-semi-bold mb-0">${detailOrder.tel}</p>
                                    </div>
                                    <div class="col-12 col-lg-4">
                                        <h6 class="mb-1"> Order Status :</h6>
                                        <span class="badge badge-phoenix fs--1 badge-phoenix-primary">
                                            <span class="badge-label">${detailOrder.status}</span>
                                        </span>
                                    </div>
                                    <div class="col-12 col-lg-4">
                                        <h6 class="mb-2"> Total cost :</h6>
                                        <p class="fs--1 text-800 fw-semi-bold mb-0">
                                            <fmt:formatNumber value="${sub_total}" type="currency" pattern="###,### ₫"/>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-sm-6 col-lg-6">
                                <div class="row g-4">
                                    <div class="col-12 col-lg-6">
                                        <h6 class="mb-2"> Receive Address :</h6>
                                        <div class="fs--1 text-800 fw-semi-bold mb-0">
                                            <p class="mb-2">${detailOrder.receiveAddress}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="px-0">
                        <c:choose>
                            <c:when test="${detailOrder.status == 'COMPLETED'}">
                                <span class="badge badge-phoenix badge-phoenix-info mb-3" style="font-size: 15px">
                                    <span class="badge-label">Please leave a review of our products</span>
                                    <span class="ms-1" data-feather="check" style="height:12.8px;width:12.8px;"></span>
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-phoenix badge-phoenix-warning mb-3" style="font-size: 15px">
                                    <span class="badge-label">You can feedback when order is completed</span>
                                    <span class="ms-1" data-feather="alert-octagon" style="height:12.8px;width:12.8px;"></span>
                                </span>
                            </c:otherwise>
                        </c:choose>

                        <div class="table-responsive scrollbar">
                            <table class="table fs--1 text-900 mb-0">
                                <thead class="bg-200">
                                    <tr>
                                        <th scope="col" style="width: 24px;"></th>
                                        <th scope="col" style="min-width: 30px;">IMAGE</th>
                                        <th scope="col" style="min-width: 280px;">TITLE</th>
                                        <th class="ps-5" scope="col" style="min-width: 150px;">SIZE</th>
                                        <th class="text-end" scope="col" style="width: 80px;">Quantity</th>
                                        <th class="text-end" scope="col" style="width: 100px;">Price</th>
                                        <th class="text-end" scope="col" style="width: 138px;">Category</th>
                                        <th class="text-end" scope="col" style="min-width: 100px;">Total</th>
                                        <th scope="col" style="width: 50px;"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${orderDetails}" var="od">
                                        <tr>
                                            <td class="border-0"></td>
                                            <td class="align-middle">
                                                <img class="rounded-2 p-0" src="<c:url value="/resources/product_image/${od.orderDetail.productVariantSize.productVariant.image}"/>" width="100%" />
                                            </td>
                                            <td class="align-middle">
                                                <p class="line-clamp-1 mb-0 fw-semi-bold">
                                                    ${od.orderDetail.productVariantSize.productVariant.name}
                                                </p>
                                            </td>
                                            <td class="align-middle ps-5">
                                                ${od.orderDetail.productVariantSize.size.value}
                                            </td>
                                            <td class="align-middle text-end text-1000 fw-semi-bold">
                                                <fmt:formatNumber value="${od.orderDetail.quantity}" />
                                            </td>
                                            <td class="align-middle text-end fw-semi-bold">
                                                <fmt:formatNumber value="${od.orderDetail.price}" type="currency" pattern="###,### ₫"/>
                                            </td>
                                            <td class="align-middle text-end">
                                                <c:forEach items="${od.orderDetail.productVariantSize.productVariant.product.categories}" var="c">
                                                    <a class="text-decoration-none" href="">
                                                        <span class="badge badge-tag me-1 mb-2">${c.name}</span>
                                                    </a>
                                                </c:forEach>
                                            </td>
                                            <td class="align-middle text-end fw-semi-bold">
                                                <fmt:formatNumber value="${od.orderDetail.quantity * od.orderDetail.price}" type="currency" pattern="###,### ₫"/>
                                            </td>
                                            <td class="border-0 align-middle">
                                                <a href="${pageContext.request.contextPath}/products/product-detail?id=${od.orderDetail.productId}" class="btn btn-phoenix-primary btn-icon fs-1 px-0 mb-1 ms-3" type="button" data-bs-toggle="tooltip" data-bs-placement="right" title="Re buy">
                                                    <span class="" data-feather="shopping-bag"></span>
                                                </a>
                                                <c:choose>
                                                    <c:when test="${detailOrder.status == 'COMPLETED' && od.feedback == false}">
                                                        <a class="btn btn-phoenix-primary btn-icon fs-1 px-0 mb-1 ms-3" type="button" data-bs-toggle="tooltip" data-bs-placement="right" title="Feedback" href="${pageContext.request.contextPath}/orders/order-detail/feedback?id=${od.orderDetail.productVariantSize.id}&order_id=${detailOrder.order_id}">
                                                            <span class="" data-feather="message-square"></span>
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button disabled="true" class="btn btn-phoenix-primary btn-icon fs-1 px-0 mb-1 ms-3" type="button" data-bs-toggle="tooltip" data-bs-placement="right" title="Feedback">
                                                            <span class="" data-feather="message-square"></span>
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <tr class="bg-200">
                                        <td></td>
                                        <td class="align-middle fw-semi-bold" colspan="6">Subtotal</td>
                                        <td class="align-middle text-end fw-bold">
                                            <fmt:formatNumber value="${sub_total}" type="currency" pattern="###,### ₫"/>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td colspan="4"></td>
                                        <td class="align-middle fw-bold ps-15" colspan="2">Discount/Voucher</td>
                                        <td class="align-middle text-end fw-semi-bold text-danger" colspan="1">-0đ</td>
                                        <td></td>
                                    </tr>
                                    <tr class="bg-200">
                                        <td></td>
                                        <td class="align-middle fw-semi-bold" colspan="6">Subtotal</td>
                                        <td class="align-middle text-end fw-bold">
                                            <fmt:formatNumber value="${sub_total}" type="currency" pattern="###,### ₫"/>
                                        </td>
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </body>

    <div class="modal fade" id="verticallyCentered" tabindex="-1" data-bs-backdrop="static" aria-labelledby="verticallyCenteredModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="d-flex flex-column gap-2">
                        <form class="m-0 p-0" action="${pageContext.request.contextPath}/update-address?order_id=${detailOrder.order_id}" method="post">
                            <div id="address-table" class="d-flex flex-column gap-2 mb-2">
                                <c:forEach items="${addresses}" var="ad">
                                    <label class="d-flex align-items-center border p-2 rounded-2">
                                        <label class="form-check-label fs-0 w-100" for="${ad.id}">
                                            Full Name: ${ad.fullName} <br>
                                            Telephone: ${ad.tel} <br>
                                            Address: ${ad.address}
                                        </label>
                                        <div>
                                            <input class="form-check-input" id="${ad.id}" type="radio" name="idAddressChoose" value="${ad.id}" ${ad.choosen == true ? 'checked' : ''} />
                                        </div>
                                    </label>
                                </c:forEach>
                            </div>

                            <div class="d-flex gap-2">
                                <button class="btn btn-phoenix-secondary w-50" type="button" data-bs-dismiss="modal">Cancel</button>
                                <button class="btn btn-phoenix-primary w-50" type="button" data-bs-toggle="modal" data-bs-target="#createAddressModal">Create address</button>
                                <button class="btn btn-phoenix-primary w-50" type="submit">Choose</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="createAddressModal" tabindex="-1" data-bs-backdrop="static" aria-labelledby="createAddressModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="verticallyCenteredModalLabel">Create address</h5>
                    <button class="btn p-1" type="button" data-bs-dismiss="modal" aria-label="Close"><span class="fas fa-times fs--1"></span></button>
                </div>
                <div class="modal-body">
                    <div class="mb-2">
                        <label class="form-label" for="name">Full name </label>
                        <input class="form-control" name="name" id="name" placeholder="Name" />
                    </div>
                    <div class="mb-2">
                        <label class="form-label" for="address">Address </label>
                        <input class="form-control" name="address" id="address" placeholder="Address" />
                    </div>
                    <div class="mb-2">
                        <label class="form-label" for="tel">Telephone </label>
                        <input class="form-control" name="tel" id="tel" placeholder="Telephone" />
                    </div>
                    <div class="d-flex gap-2">
                        <button class="btn btn-phoenix-primary me-1 mb-1 w-50" type="submit" id="btnCreateAddress">Create</button>
                        <button class="btn btn-phoenix-secondary me-1 mb-1 w-50" type="button" data-bs-toggle="modal" data-bs-target="#verticallyCentered" onclick="loadAddresses()">Choose address</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="import-js.jsp"/>

    <script>
        $(document).ready(function () {
            // Attach a submit event handler to the form or button click event
            $('#btnCreateAddress').on('click', function (e) {
                e.preventDefault();  // Prevent default form submission

                // Send the POST request to the server endpoint
                $.ajax({
                    url: '${pageContext.request.contextPath}/api/address/add', // The URL of the API endpoint on your server
                    type: 'POST',
                    contentType: "application/x-www-form-urlencoded",
                    data: {
                        address: $('#address').val(),
                        name: $('#name').val(),
                        telephone: $('#tel').val()
                    },
                    success: function (data) {
                        showToast("Add new address successfull");

                        $('#address').val('');
                        $('#name').val('');
                        $('#tel').val('');
                    },
                    error: function (xhr, status, error) {

                    }
                });
            });
        });
    </script>

    <script>
        function loadAddresses() {
            fetch('http://localhost:8080/ShoesShop/api/addresses')
                    .then(res => res.json())
                    .then(data => {
                        var addressTable = document.getElementById('address-table');
                        addressTable.innerHTML = ''; // Clear previous contents

                        data.forEach(function (ad) {
                            // Determine if the input should be checked
                            var isChecked = ad.choosen ? 'checked' : '';

                            var addressHTML = '<label class="d-flex align-items-center border p-2 rounded-2">' +
                                    '<label class="form-check-label fs-0 w-100" for="' + ad.id + '">' +
                                    'Fullname: ' + ad.fullName + '<br>' +
                                    'Telephone: ' + ad.tel + '<br>' +
                                    'Address: ' + ad.address +
                                    '</label>' +
                                    '<div>' +
                                    // Apply the isChecked variable to the input element
                                    '<input class="form-check-input" id="' + ad.id + '" type="radio" name="idAddressChoose" value="' + ad.id + '" ' + isChecked + ' />' +
                                    '</div>' +
                                    '</label>';

                            addressTable.innerHTML += addressHTML; // Append new address entry
                        });
                    })
                    .catch(function (error) {
                        console.error('Error loading addresses:', error);
                        addressTable.innerHTML += '<p>Error loading addresses.</p>';
                    });
        }
    </script>

    <script>
        $(document).ready(function () {
            $('#thank-text').click(function () {
                $('#thank-text').slideUp(550, function () {
                    $('#buy-text').slideDown(550);
                });
            });

            $('#buy-text').click(function () {
                $('#buy-text').slideUp(550, function () {
                    $('#thank-text').slideDown(550);
                });
            });
        });
    </script>
</html>
