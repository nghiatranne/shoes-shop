<%-- 
    Document   : DetailSlider
    Created on : Jun 3, 2024, 9:37:12 AM
    Author     : USA
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Slider Detail Information</title>
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
                                <h2 class="mb-0">Slider Detail Information</h2>
                            </div>
                            <div class="col-12 col-md-auto">
                                <div class="d-flex">
                                    <a class="btn btn-phoenix-secondary me-2" href="${pageContext.request.contextPath}/admin/sliders">
                                        Back
                                    </a>
                                    <a class="btn btn-phoenix-secondary me-2" href="${pageContext.request.contextPath}/admin/sliders/edit?id=${slider.id}">
                                        Edit Slider
                                    </a>
                                    <c:choose>
                                        <c:when test="${slider.status == true}">
                                            <a href="${pageContext.request.contextPath}/admin/sliders/update-status?sliderId=${slider.id}&status=false" class="btn btn-phoenix-secondary btn-icon fs--2 px-0" type="button">
                                                <span class="" data-feather="eye"></span>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/admin/sliders/update-status?sliderId=${slider.id}&status=true" class="btn btn-phoenix-secondary btn-icon fs--2 px-0" type="button">
                                                <span class="" data-feather="eye-off"></span>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="container-small">
                    <div class="row g-0 g-md-4 g-xl-6">
                        <div class="col-12">
                            <div class="sticky-leads-sidebar">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="card border border-3">
                                            <div class="card-body p-3">
                                                <div class="row g-3 text-center text-xxl-start">
                                                    <div class="col-12">
                                                        <h3 class="fw-bolder mb-2">${slider.title}</h3>
                                                        <div class="d-flex">
                                                            <p class="mb-0 me-2">Slider ID: <a class="fw-bold" href="">${slider.id}</a></p>
                                                            <p class="mb-0 me-2">Create at: <a class="fw-bold" href=""><fmt:formatDate value="${slider.createAt}" pattern="dd MMMM, yyyy" /></a></p>
                                                            <p class="mb-0">
                                                                Status:
                                                                <c:choose>
                                                                    <c:when test="${slider.status}">
                                                                        <span class="text-success fw-bold fs--1"><span class="fas fa-check-circle me-1"></span>SHOWING</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-warning fw-bold fs--1"><span class="fas fa-check-circle me-1"></span>HIDDEN</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <div class="col-12">
                                                        <img class="img-thumbnail w-100" src="<c:url value="/resources/slider_image/${slider.imageUrl}"/>" alt="" />
                                                    </div>
                                                    <div class="col-12">
                                                        <p><strong>Link URL: </strong><a href="${slider.linkUrl}" target="_blank">${slider.linkUrl}</a></p>
                                                    </div>
                                                </div>
                                            </div>  
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="import-js.jsp"/>

        <script>
            let dashboard_tag = document.getElementById('sliders-manage');
            dashboard_tag.classList.add('active');
        </script>
    </body>
</html>
