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
                                <h2 class="mb-0">Post Detail Information</h2>
                            </div>
                            <div class="col-12 col-md-auto">
                                <div class="d-flex">
                                    <a class="btn btn-phoenix-secondary me-2" href="${pageContext.request.contextPath}/admin/posts">
                                        Back
                                    </a>
                                    <a class="btn btn-phoenix-secondary me-2" href="${pageContext.request.contextPath}/admin/posts/edit?id=${post.id}">
                                        Edit Post
                                    </a>
                                    <c:choose>
                                        <c:when test="${post.status == true}">
                                            <a href="${pageContext.request.contextPath}/admin/posts/update-status-d?postId=${post.id}&status=false" class="btn btn-phoenix-secondary btn-icon fs--2 px-0" type="button">
                                                <span class="" data-feather="eye"></span>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/admin/posts/update-status-d?postId=${post.id}&status=true" class="btn btn-phoenix-secondary btn-icon fs--2 px-0" type="button">
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
                                                        <h3 class="fw-bolder mb-2">${post.title}</h3>
                                                        <div class="d-flex">
                                                            <p class="mb-0 me-2">Post ID: <a class="fw-bold" href="">${post.id}</a></p>
                                                            <p class="mb-0 me-2">
                                                                Author: <a class="fw-bold" href="">${post.account.fullname}</a>
                                                            </p>
                                                            <p class="mb-0 me-2">Create at: <a class="fw-bold" href=""><fmt:formatDate value="${post.createAt}" pattern="dd MMMM, yyyy" /></a></p>
                                                            <p class="mb-0">
                                                                Status:
                                                                <c:choose>
                                                                    <c:when test="${post.status}">
                                                                        <span class="text-success fw-bold fs--1"><span class="fas fa-check-circle me-1"></span>PUBLISHING</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-warning fw-bold fs--1"><span class="fas fa-check-circle me-1"></span>HIDING</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </p>
                                                        </div>
                                                        <p class="mb-0">Categories:
                                                            <c:forEach items="${post.categories}" var="c">
                                                                <a class="text-decoration-none" href="">
                                                                    <span class="badge badge-tag me-1 mb-1">${c.name}</span>
                                                                </a>
                                                            </c:forEach>
                                                        </p>
                                                    </div>
                                                    <div class="col-12">
                                                        <img class="img-thumbnail w-100" src="<c:url value="/resources/post_image/${post.thumbnail}"/>" alt="" />
                                                    </div>
                                                    <div class="col-12">
                                                        ${post.content}
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
            let dashboard_tag = document.getElementById('posts-manage')
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
