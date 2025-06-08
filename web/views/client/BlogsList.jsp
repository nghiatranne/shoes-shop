<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Blog List Page</title>
        <link rel="stylesheet" href="<c:url value='/resources/assets/css/pagination-css.css'/>"/>
        <jsp:include page="import-css.jsp"/>
        <style>
            #searchForm {
                max-width: 500px; /* Limits the width of the form for better aesthetics */
                margin: 20px auto; /* Centers the form on the page */
            }
            #searchInput {
                border-radius: 20px 0 0 20px; /* Rounded corners on the left side of the input */
                border-right: none; /* Hide the right border where the input meets the button */
            }
            #searchButton {
                border-radius: 0 20px 20px 0; /* Rounded corners on the right side of the button */
                border-left: none; /* Hide the left border to merge with the input field */
            }
        </style>
    </head>
    <body>
        <main class="main" id="top">
            <jsp:include page="layout/header.jsp"/>
            <jsp:include page="layout/navigation.jsp"/>

            <div class="container-small">
                <form id="searchForm" action="${pageContext.request.contextPath}/blog-list" method="get" class="d-flex justify-content-center">
                    <input type="text" id="searchInput" class="form-control" placeholder="Search by title" name="titleSearch" value="${titleSearch}">
                    <button id="searchButton" class="btn btn-primary" type="submit">Search</button>
                </form>
            </div>

            <section class="pt-8 pb-9">
                <div class="container-small">
                    <div class="row">
                        <div class="col-lg-12 col-xxl-12">
                            <div class="row gx-3 gy-10 mb-8">
                                <c:forEach items="${posts}" var="post">
                                    <c:if test="${post.status}">
                                        <div class="col-12 col-sm-6 col-md-4 col-xxl-3">
                                            <div class="blog-card-container h-100">
                                                <div class="position-relative text-decoration-none blog-card h-100">
                                                    <div class="d-flex flex-column justify-content-between h-100">
                                                        <div class="border border-1 rounded-3 position-relative mb-3">
                                                            <img class="img-fluid w-100" src="<c:url value='/resources/post_image/${post.thumbnail}'/>" alt="${post.title}" />
                                                            <a class="stretched-link" href="${pageContext.request.contextPath}/blog/post-details?id=${post.id}"></a>
                                                        </div>
                                                        <div class="p-2">
                                                            <h5 class="mb-1">${post.title}</h5>
                                                            <p class="mb-1">Author: ${post.account.fullname}</p>
                                                            <p class="mb-1">Categories: 
                                                                <c:forEach items="${post.categories}" var="category">
                                                                    <span class="badge badge-tag me-1 mb-1">${category.name}</span>
                                                                </c:forEach>
                                                            </p>
                                                        </div>
                                                        <div class="p-2">
                                                            <a href="${pageContext.request.contextPath}/blog/post-details?id=${post.id}" class="btn btn-primary w-100">Read More</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <nav>
                        <ul class="pagination justify-content-center">
                            <c:forEach begin="1" end="${noOfPages}" var="i">
                                <li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
                                    <a class="page-link" href="${pageContext.request.contextPath}/blog-list?page=${i}">${i}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </nav>
                </div>
            </section>
        </main>
        <jsp:include page="import-js.jsp"/>
    </body>
</html>
