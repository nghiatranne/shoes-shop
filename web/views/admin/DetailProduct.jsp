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
            <div class="pb-9">
                <div class="row">
                    <div class="col-12">
                        <div class="row align-items-center justify-content-between g-3 mb-3">
                            <div class="col-12 col-md-auto">
                                <h2 class="mb-0">Product Detail Information</h2>
                            </div>
                            <div class="col-12 col-md-auto">
                                <div class="d-flex">
                                    <a class="btn btn-phoenix-secondary me-2" href="${pageContext.request.contextPath}/admin/products/edit?product_id=${productId}">
                                        Update Product
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row g-0 g-md-4 g-xl-6">
                    <div class="col-12">
                        <div class="sticky-leads-sidebar">
                            <div class="row">
                                <div class="col-6">
                                    <c:forEach items="${listProductVariants}" var="pv">
                                        <div class="card border border-3 mb-2">
                                            <div class="card-body p-3">
                                                <div class="row g-3 text-center text-xxl-start">
                                                    <div class="col-4">
                                                        <img class="img-thumbnail w-100" src="<c:url value="/resources/product_image/${pv.image}"/>" alt="" />
                                                    </div>
                                                    <div class="col-8">
                                                        <div class="d-flex flex-column justify-content-between h-100">
                                                            <div>
                                                                <h3 class="fw-bolder mb-2">${pv.name}</h3>
                                                                <p class="mb-0">ID: <a class="fw-bold" href="">${pv.id}</a></p>
                                                                <p class="mb-0">Import Price: <a class="fw-bold" href=""><fmt:formatNumber value="${pv.importPrice}" type="currency" pattern="###,### ₫"/></a></p>
                                                                <p class="mb-0">Price: <a class="fw-bold" href=""><fmt:formatNumber value="${pv.price}" type="currency" pattern="###,### ₫"/></a></p>
                                                                <p class="mb-0">Create Date: <a class="fw-bold" href="">${pv.createDate}</a></p>
                                                                <p class="mb-0">Update Date: <a class="fw-bold" href="">${pv.updateDate}</a></p>
                                                            </div>
                                                            <div class="d-flex align-items-center justify-content-between">
                                                                <div class="d-flex justify-content-center align-items-center gap-2">
                                                                    Status: 
                                                                    <c:choose>
                                                                        <c:when test="${pv.status == true}">
                                                                            <span class="badge badge-phoenix fs--2 badge-phoenix-success">
                                                                                <span class="badge-label">Showing</span>
                                                                                <span class="ms-1" data-feather="check" style="height:12.8px;width:12.8px;"></span>
                                                                            </span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span class="badge badge-phoenix fs--2 badge-phoenix-danger">
                                                                                <span class="badge-label">Hiding</span>
                                                                                <span class="ms-1" data-feather="x" style="height:12.8px;width:12.8px;"></span>
                                                                            </span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                                
                                                                <div>
                                                                    <a class="btn btn-phoenix-secondary me-2" href="${pageContext.request.contextPath}/admin/products/product?id=${productId}&productVariant=${pv.id}">
                                                                        Sizes Information
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <c:if test="${not_display_listProductVariantSizes == false}">
                                    <div class="col-6">
                                        <div class="card border border-3">
                                            <div class="card-body p-3">
                                                <div class="d-flex align-items-center mb-5">
                                                    <h3>Size information</h3>
                                                </div>
                                                <div class="mb-4">
                                                    <table class="table table-sm fs-0 mb-0">
                                                        <thead>
                                                            <tr>
                                                                <th>Size Value</th>
                                                                <th>Quantity In Stock</th>
                                                                <th>Holding</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach items="${listProductVariantSizes}" var="pvs">
                                                                <tr>
                                                                    <td>${pvs.size.value}</td>
                                                                    <td>${pvs.quantityInStock}</td>
                                                                    <td>${pvs.quantityHolding}</td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
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
            let dashboard_tag = document.getElementById('book-manage')
            dashboard_tag.classList.add('active')
        </script>

        <script>
            if (${nav_book_manage}) {
                let user_account = $('#book-manage');
                user_account.addClass('active');
            }
        </script>
    </body>
</html>
