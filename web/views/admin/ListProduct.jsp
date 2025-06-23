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
                        <h2 class="mb-0">Product Management</h2>
                    </div>
                </div>
                <div id="books">
                    <div class="mb-4">
                        <div class="row g-3">
                            <div class="col-auto">
                                <div class="search-box">
                                    <form class="position-relative" action="" method="get">
                                        <input class="form-control search-input search" name="q" type="search" placeholder="Search products" aria-label="Search" />
                                        <span class="fas fa-search search-box-icon"></span>
                                    </form>
                                </div>
                            </div>
                            <div class="col-auto">
                                <select class="form-select form-select-sm" data-list-filter="data-list-filter">
                                    <option selected="" value="">Select status</option>
                                    <option value="SHOWING">Showing</option>
                                    <option value="HIDDEN">Hidden</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <form class="position-relative" action="" method="get">
                                    <select class="form-select form-select-sm" name="c_id" onchange="this.form.submit()">
                                        <option selected="" value="">Select category</option>
                                        <c:forEach items="${categories}" var="c">
                                            <option value="${c.id}" ${idChoose == c.id ? "selected" : ""} >${c.name}</option>
                                        </c:forEach>
                                    </select>
                                </form>
                            </div>
                            <div class="col-auto">
                                <c:choose>
                                    <c:when test="${sessionScope.isWarehouse == true}">
                                    </c:when>
                                    <c:otherwise>
                                        <a href="products/add" class="btn btn-phoenix-secondary" id="addBtn">
                                            <span class="fas fa-plus me-2"></span>Add New Product
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    <div id="tableExample2" class="mx-n4 px-4 mx-lg-n6 px-lg-6 bg-white border-top border-bottom border-200 position-relative top-1" data-list='{"valueNames":["isbn","title","price","publisher","status","createAt"],"page":5,"pagination":true,"filter":{"key":"status"}}'>
                        <div class="table-responsive scrollbar mx-n1 px-1">
                            <table class="table fs--1 mb-0">
                                <thead>
                                    <tr>
                                        <th class="white-space-nowrap fs--1 align-middle ps-0" style="width:350px;">IMAGE</th>
                                        <th class="sort white-space-nowrap fs--1 align-middle ps-3" data-sort="isbn" style="max-width:150px; width: 150px;">ID</th>
                                        <th class="sort white-space-nowrap align-middle ps-4" data-sort="title" scope="col" style="width:400px;">TITLE</th>
                                        <th class="sort align-middle text-end ps-4" data-sort="price" scope="col" style="width:150px;">DESCRIPTION</th>
                                        <th class="sort align-middle text-end ps-4" data-sort="publisher" scope="col" style="width:150px;">BRAND</th>
                                        <th class="align-middle ps-3" scope="col" style="width:250px;">CATEGORIES</th>
                                        <th class="sort align-middle ps-3" data-sort="status" scope="col" style="width:200px;">STATUS</th>
                                        <th class="sort align-middle ps-4" data-sort="createAt" scope="col" style="width:150px;">CREATE AT</th>
                                        <th class="sort align-middle ps-4" data-sort="createAt" scope="col" style="width:150px;">UPDATE AT</th>
                                        <th class="text-end align-middle pe-0 ps-4" scope="col"></th>
                                    </tr>
                                </thead>
                                <tbody class="list" >
                                    <c:forEach items="${products}" var="p">
                                        <tr class="product position-static">
                                            <td class="align-middle white-space-nowrap p-0 py-1">
                                                <div class="border rounded-2">
                                                    <img class="rounded-2 p-0" src="<c:url value="/resources/product_image/${p.image}"/>" width="100%" />
                                                </div>
                                            </td>
                                            <td class="isbn fs--1 align-middle ps-3">
                                                <a href="products/product?id=${p.id}">${p.id}</a>
                                            </td>
                                            <td class="title align-middle ps-4">
                                                <a class="fw-semi-bold line-clamp-3 mb-0" href="products/product?id=${p.id}">
                                                    ${p.title}
                                                </a>
                                            </td>
                                            <td class="align-middle white-space-nowrap text-end fw-bold text-1000 fs--1 ps-4">
                                                ${p.description}
                                            </td>
                                            <td class="publisher align-middle white-space-nowrap text-end fw-bold text-1000 fs--1 ps-4">
                                                ${p.brand.name}
                                            </td>
                                            <td class=" align-middle review pb-2 ps-3">
                                                <c:forEach items="${p.categories}" var="c">
                                                    <a class="text-decoration-none" href="">
                                                        <span class="badge badge-tag me-2 mb-2">${c.name}</span>
                                                    </a>
                                                </c:forEach>
                                            </td>
                                            <td class="status align-middle review pb-2 ps-3" style="min-width:225px;">
                                                <c:choose>
                                                    <c:when test="${p.status == true}">
                                                        <span class="badge badge-phoenix fs--2 badge-phoenix-success">
                                                            <span class="badge-label">SHOWING</span>
                                                            <span class="ms-1" data-feather="check" style="height:12.8px;width:12.8px;"></span>
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-phoenix fs--2 badge-phoenix-danger">
                                                            <span class="badge-label">HIDDEN</span>
                                                            <span class="ms-1" data-feather="x" style="height:12.8px;width:12.8px;"></span>
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="createAt align-middle white-space-nowrap text-600 ps-4">
                                                <fmt:formatDate value="${p.createDate}" pattern="dd MMMM, yyyy" />
                                            </td>
                                            <td class="createAt align-middle white-space-nowrap text-600 ps-4">
                                                <fmt:formatDate value="${p.updateDate}" pattern="dd MMMM, yyyy" />
                                            </td>
                                            <td class="align-middle">
                                                <div class="mb-2">
                                                    <a href="${pageContext.request.contextPath}/admin/products/edit?product_id=${p.id}" class="btn btn-phoenix-secondary btn-icon fs--2 px-0 ms-3" type="button">
                                                        <span class="" data-feather="edit"></span>
                                                    </a>
                                                </div>
                                                <div>
                                                    <c:choose>
                                                        <c:when test="${b.status == true}">
                                                            <a href="products/product/toggle-hide?id=${p.id}&status=false" class="btn btn-phoenix-secondary btn-icon fs--2 px-0 ms-3" type="button">
                                                                <span class="" data-feather="eye"></span>
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="products/product/toggle-hide?id=${p.id}&status=true" class="btn btn-phoenix-secondary btn-icon fs--2 px-0 ms-3" type="button">
                                                                <span class="" data-feather="eye-off"></span>
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="d-flex justify-content-center my-3"><button class="page-link" data-list-pagination="prev"><span class="fas fa-chevron-left"></span></button>
                            <ul class="mb-0 pagination"></ul><button class="page-link pe-0" data-list-pagination="next"><span class="fas fa-chevron-right"></span></button>
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
    </body>
</html>
