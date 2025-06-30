<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-top fixed-top navbar-expand" id="navbarDefault">
    <div class="collapse navbar-collapse justify-content-between">
        <div class="navbar-logo">
            <button class="btn navbar-toggler navbar-toggler-humburger-icon hover-bg-transparent" type="button" data-bs-toggle="collapse" data-bs-target="#navbarVerticalCollapse" aria-controls="navbarVerticalCollapse" aria-expanded="false" aria-label="Toggle Navigation"><span class="navbar-toggle-icon"><span class="toggle-line"></span></span></button>
            <a class="navbar-brand me-1 me-sm-3" href="${pageContext.request.contextPath}/admin/orders">
                <div class="d-flex align-items-center">
                    <div class="d-flex align-items-center">
                        <img src="<c:url value="/resources/assets/img/icons/logo.png"/>" alt="phoenix" width="27" />
                    </div>
                </div>
            </a>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/homepage" class="btn btn-phoenix-secondary me-1 mb-1" type="button">
                <i    class="fas fa-home"></i> Home
              </a>
        </div>
    </div>
</nav>