<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Feedback Management</title>
        <jsp:include page="import-css.jsp"/>
    </head>
    <body>
        <jsp:include page="layout/navigation.jsp"/>
        <jsp:include page="layout/header-nav.jsp"/>

        <div class="content">
            <div class="mb-9">
                <div class="row g-3 mb-4">
                    <div class="col-auto">
                        <h2 class="mb-0">Feedback Management</h2>
                    </div>
                </div>
                <div id="feedbacks">
                    <div class="mb-4">
                        <div class="row g-3">
                            <div class="col-auto">
                                <div class="search-box">
                                    <form class="position-relative" action="" method="get">
                                        <input class="form-control search-input search" name="q" type="search" placeholder="Search feedback by full name" aria-label="Search" />
                                        <span class="fas fa-search search-box-icon"></span>
                                    </form>
                                </div>
                            </div>
                            <div class="col-auto">
                                <form class="position-relative"  method="get">
                                    <select class="form-select form-select-sm" name="status" onchange="this.form.submit()">
                                        <option selected="" value="">Select status</option>
                                        <option value="true">Showing</option>
                                        <option value="false">Hidden</option>
                                    </select>
                                </form>
                            </div>
                            <div class="col-auto">
                                <form class="position-relative"  method="get">
                                    <select class="form-select form-select-sm" name="product" onchange="this.form.submit()">
                                        <option selected="" value="">Select product</option>
                                        <c:forEach items="${productVariants}" var="p">
                                            <option value="${p.id}">${p.name}</option>
                                        </c:forEach>
                                    </select>
                                </form>
                            </div>
                            <div class="col-auto">
                                <form class="position-relative" action="" method="get">
                                    <select class="form-select form-select-sm" name="ratedStar" onchange="this.form.submit()">
                                        <option selected="" value="">Select rated star</option>
                                        <option value="5">5 Stars</option>
                                        <option value="4">4 Stars</option>
                                        <option value="3">3 Stars</option>
                                        <option value="2">2 Stars</option>
                                        <option value="1">1 Star</option>
                                    </select>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div id="tableExample2" class="mx-n4 px-4 mx-lg-n6 px-lg-6 bg-white border-top border-bottom border-200 position-relative top-1" data-list='{"valueNames":["fullName","productName","ratedStar","status","content"],"page":5,"pagination":true,"filter":{"key":"status"}}'>
                        <div class="table-responsive scrollbar mx-n1 px-1">
                            <table class="table fs--1 mb-0">
                                <thead>
                                    <tr>
                                        <th class="sort white-space-nowrap align-middle ps-4" data-sort="fullName" scope="col" style="width:300px;">
                                            <a href="${pageContext.request.contextPath}/admin/feedbacks?sort=fullName&order=<c:out value='${param.order == "asc" ? "desc" : "asc"}'/>">FULL NAME</a>
                                        </th>
                                        <th class="sort align-middle ps-3 text-end" data-sort="productName" scope="col" style="width:350px;">PRODUCT NAME</th>
                                        <th class="sort align-middle ps-10" data-sort="ratedStar" scope="col" style="width:250px;">RATED STAR</th>
                                        <th class="sort align-middle ps-3" data-sort="status" scope="col" style="width:250px;">STATUS</th>
                                        <th class="sort align-middle ps-3" data-sort="content" scope="col" style="width:500px;">CONTENT</th>
                                        <th class="text-end align-middle pe-0 ps-4" scope="col"></th>
                                    </tr>
                                </thead>
                                <tbody class="list" >
                                    <c:forEach items="${feedbacks}" var="f">
                                        <tr class="feedback position-static">
                                            <td class="fullName align-middle ps-4">
                                                <a href="">
                                                    ${f.account.fullname}
                                                </a>
                                            </td>
                                            <td class="productName align-middle white-space-nowrap text-end fw-bold text-1000 fs--1 ps-4">
                                                ${f.pvs.productVariant.name}
                                            </td>
                                            <td class="ratedStar align-middle text-center">
                                                ${f.ratedStar}
                                            </td>
                                            <td class="status align-middle review pb-2 ps-3" style="min-width:150px;">
                                                <c:choose>
                                                    <c:when test="${f.status == true}">
                                                        <span class="text-success fw-bold fs--1"><span class="fas fa-check-circle me-1"></span>SHOWING</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-warning fw-bold fs--1"><span class="fas fa-check-circle me-1"></span>HIDDEN</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="content align-middle white-space-nowrap text-600 ps-4">
                                                ${f.content}
                                            </td>
                                            <td class="align-middle">
                                             
                                                <div>
                                                    <c:choose>
                                                        <c:when test="${f.status == true}">
                                                            <a href="${pageContext.request.contextPath}/admin/feedbacks/update-status?accountId=${f.account.id}&pvsId=${f.pvs.id}&status=false" class="btn btn-phoenix-secondary btn-icon fs--2 px-0 ms-3" type="button">
                                                                <span class="" data-feather="eye"></span>
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="${pageContext.request.contextPath}/admin/feedbacks/update-status?accountId=${f.account.id}&pvsId=${f.pvs.id}&status=true" class="btn btn-phoenix-secondary btn-icon fs--2 px-0 ms-3" type="button">
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
            let dashboard_tag = document.getElementById('feedbacks-manage');
            dashboard_tag.classList.add('active');
        </script>
    </body>
</html>
