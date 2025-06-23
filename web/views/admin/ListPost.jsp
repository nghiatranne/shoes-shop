<%-- 
    Document   : ListPost
    Created on : Jun 1, 2024, 7:48:25 PM
    Author     : hoaht
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Post Manage</title>
        <jsp:include page="import-css.jsp"/>
    </head>
    <body>
        <jsp:include page="layout/navigation.jsp"/>

        <jsp:include page="layout/header-nav.jsp"/>

        <div class="content">
            <div class="mb-9">
                <div class="row g-3 mb-4">
                    <div class="col-auto">
                        <h2 class="mb-0">Post Management</h2>
                    </div>
                </div>
                <div id="books">
                    <div class="mb-4">
                        <div class="row g-3">
                            <div class="col-auto">
                                <div class="search-box">
                                    <form class="position-relative" action="" method="get">
                                        <input class="form-control search-input search" name="q" type="search" placeholder="Search post by title" aria-label="Search" />
                                        <span class="fas fa-search search-box-icon"></span>
                                    </form>
                                </div>
                            </div>
                            <div class="col-auto">
                                <select class="form-select form-select-sm" data-list-filter="data-list-filter">
                                    <option selected="" value="">Select status</option>
                                    <option value="PUBLISHING">Publishing</option>
                                    <option value="HIDING">Hiding</option>
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
                                <form class="position-relative" action="" method="get">
                                    <select class="form-select form-select-sm" name="a_id" onchange="this.form.submit()">
                                        <option selected="" value="">Select Author</option>
                                        <c:forEach items="${accounts}" var="a">
                                            <option value="${a.id}" ${acIdChoose == a.id ? "selected" : ""} >${a.fullname}</option>
                                        </c:forEach>
                                    </select>
                                </form>
                            </div>
                            <div class="col-auto">
                                <a href="posts/add" class="btn btn-phoenix-secondary" id="addBtn">
                                    <span class="fas fa-plus me-2"></span>Create New Post
                                </a>
                            </div>
                        </div>
                    </div>
                    <div id="tableExample2" class="mx-n4 px-4 mx-lg-n6 px-lg-6 bg-white border-top border-bottom border-200 position-relative top-1" data-list='{"valueNames":["title","author","status","createAt"],"page":5,"pagination":true,"filter":{"key":"status"}}'>
                        <div class="table-responsive scrollbar mx-n1 px-1">
                            <table class="table fs--1 mb-0">
                                <thead>
                                    <tr>
                                        <th class="white-space-nowrap fs--1 align-middle ps-0" style="width:300px;">IMAGE</th>
                                        <th class="sort white-space-nowrap align-middle ps-4" data-sort="title" scope="col" style="width:400px;">TITLE</th>
                                        <th class="sort align-middle ps-3 text-end" data-sort="author" scope="col" style="width:250px;">AUTHOR</th>
                                        <th class="align-middle ps-3" scope="col" style="width:250px;">CATEGORIES</th>
                                        <th class="sort align-middle ps-3" data-sort="status" scope="col" style="width:200px;">STATUS</th>
                                        <th class="sort align-middle ps-4" data-sort="createAt" scope="col" style="width:150px;">CREATE AT</th>
                                        <th class="text-end align-middle pe-0 ps-4" scope="col"></th>
                                    </tr>
                                </thead>
                                <tbody class="list" >
                                    <c:forEach items="${posts}" var="p">
                                        <tr class="product position-static">
                                            <td class="align-middle white-space-nowrap p-0 py-1">
                                                <div class="border rounded-2">
                                                    <img class="rounded-2 p-0" src="<c:url value="/resources/post_image/${p.thumbnail}"/>" width="100%" />
                                                </div>
                                            </td>
                                            <td class="title align-middle ps-4 fs-0">
                                                <a class="fw-semi-bold line-clamp-3 mb-0" href="${pageContext.request.contextPath}/admin/posts/post?id=${p.id}">
                                                    ${p.title}
                                                </a>
                                            </td>
                                            <td class="author align-middle white-space-nowrap text-end fw-bold text-1000 fs-0 ps-4">
                                                ${p.account.fullname}
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
                                                    <c:when test="${p.status}">
                                                        <span class="text-success fw-bold fs--1"><span class="fas fa-check-circle me-1"></span>PUBLISHING</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-warning fw-bold fs--1"><span class="fas fa-check-circle me-1"></span>HIDING</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="createAt align-middle white-space-nowrap text-600 ps-4">
                                                <fmt:formatDate value="${p.createAt}" pattern="dd MMMM, yyyy" />
                                            </td>
                                            <td class="align-middle">
                                                <div class="mb-2">
                                                    <a href="${pageContext.request.contextPath}/admin/posts/edit?id=${p.id}" class="btn btn-phoenix-secondary btn-icon fs--2 px-0 ms-3" type="button">
                                                        <span class="" data-feather="edit"></span>
                                                    </a>
                                                </div>
                                                <div class="mb-2">
                                                    <c:choose>
                                                        <c:when test="${p.status == true}">
                                                            <a href="${pageContext.request.contextPath}/admin/posts/update-status?postId=${p.id}&status=false" class="btn btn-phoenix-secondary btn-icon fs--2 px-0 ms-3" type="button">
                                                                <span class="" data-feather="eye"></span>
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="${pageContext.request.contextPath}/admin/posts/update-status?postId=${p.id}&status=true" class="btn btn-phoenix-secondary btn-icon fs--2 px-0 ms-3" type="button">
                                                                <span class="" data-feather="eye-off"></span>
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div>
                                                    <button onclick="setDeletePost('${p.id}')" class="btn btn-phoenix-danger btn-icon fs--2 px-0 ms-3" type="button" data-bs-toggle="modal" data-bs-target="#model_delete">
                                                        <span class="" data-feather="trash-2"></span>
                                                    </button>
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

        <div class="modal fade" id="model_delete" tabindex="-1" aria-labelledby="verticallyCenteredModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body">
                        <p class="text-700 lh-lg mb-0">
                            Are you sure to delete this post?
                        </p>
                    </div>
                    <div class="modal-footer">
                        <a id="btn_deletePost" class="btn btn-danger" type="button">Okay</a>
                        <button class="btn btn-outline-primary" type="button" data-bs-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="import-js.jsp"/>

        <script>
            let dashboard_tag = document.getElementById('posts-manage');
            dashboard_tag.classList.add('active');



            const setDeletePost = (postID) => {
                $('#btn_deletePost').attr('href', 'posts/del?id=' + postID);
            };
        </script>
    </body>
</html>
