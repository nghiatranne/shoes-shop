<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Blog Detail Page</title>
    <link rel="stylesheet" href="<c:url value='/resources/assets/css/pagination-css.css'/>"/>
    <jsp:include page="import-css.jsp"/>
    <style>
        .center-content {
            display: flex;
            justify-content: center;
        }
        .content-container {
            max-width: 800px;
            width: 100%;
        }
    </style>
</head>
<body>

<main class="main" id="top">
    <jsp:include page="layout/header.jsp"/>
    <jsp:include page="layout/navigation.jsp"/>

    <section class="pt-5 pb-9">
        <div class="container center-content">
            <div class="content-container">
                <div class="row">
                    <!-- Blog post details -->
                    <div class="col-12">
                        <div class="card border border-3">
                            <div class="card-body p-3">
                                <div class="row g-3 text-center text-xxl-start">
                                    <div class="col-12">
                                        <h3 class="fw-bolder mb-2">${post.title}</h3>
                                        <div class="d-flex mb-3">
                                            <p class="mb-0 me-2">Post ID: <a class="fw-bold">${post.id}</a></p>
                                            <p class="mb-0 me-2">Author: <a class="fw-bold">${post.account.fullname}</a></p>
                                            <p class="mb-0 me-2">Create at: <a class="fw-bold"><fmt:formatDate value="${post.createAt}" pattern="dd MMMM, yyyy" /></a></p>
                                            <p class="mb-0">Status:
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
                                        <p class="mb-3">Categories:
                                            <c:forEach items="${post.categories}" var="c">
                                                <a class="text-decoration-none">
                                                    <span class="badge badge-tag me-1 mb-1">${c.name}</span>
                                                </a>
                                            </c:forEach>
                                        </p>
                                    </div>
                                    <div class="col-12">
                                        <img class="img-thumbnail w-100" src="<c:url value='/resources/post_image/${post.thumbnail}'/>" alt="${post.title}" />
                                    </div>
                                    <div class="col-12">
                                        <p>${post.content}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<jsp:include page="import-js.jsp"/>

</body>
</html>
