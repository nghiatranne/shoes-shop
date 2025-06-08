<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Feedback Detail</title>
        <jsp:include page="import-css.jsp"/>
    </head>
    <body>
        <jsp:include page="layout/navigation.jsp"/>
        <jsp:include page="layout/header-nav.jsp"/>

        <div class="content">
            <div class="mb-9">
                <div class="row g-3 mb-4">
                    <div class="col-auto">
                        <h2 class="mb-0">Feedback Detail</h2>
                    </div>
                </div>
                <div id="feedback-detail">
                    <div class="mb-4">
                        <h3>Contact Information</h3>
                        <p>Full Name: ${feedback.account.fullname}</p>
                        <p>Email: ${feedback.account.email}</p>
                        <p>Mobile: ${feedback.account.telephone}</p>
                    </div>
                    <div class="mb-4">
                        <h3>Product Information</h3>
                        <p>Product Name: ${feedback.book.title}</p>
                    </div>
                    <div class="mb-4">
                        <h3>Feedback</h3>
                        <p>Rated Star: ${feedback.ratedStar}</p>
                        <p>Content: ${feedback.content}</p>
                    </div>
                    <div class="mb-4">
                        <h3>Feedback Images</h3>
                        <c:if test="${not empty feedback.image}">
                            <div class="feedback-images">
                                <c:forEach var="image" items="${feedback.image}">
                                    <img src="<c:url value='/resources/feedback_image/${feedback.image}'/>" alt="Feedback Image" style="max-width: 500px; height: auto; margin-bottom: 10px;">
                                </c:forEach>
                            </div>
                        </c:if>
                        <c:if test="${empty feedback.image}">
                            <p>No images available.</p>
                        </c:if>
                    </div>
                    <div class="mb-4">
                        <h3>Status</h3>
                        <c:choose>
                            <c:when test="${feedback.status == true}">
                                <span class="text-success fw-bold fs--1"><span class="fas fa-check-circle me-1"></span>SHOWING</span>
                            </c:when>
                            <c:otherwise>
                                <span class="text-warning fw-bold fs--1"><span class="fas fa-check-circle me-1"></span>HIDDEN</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="mb-4">
                        <form action="${pageContext.request.contextPath}/admin/feedbacks/update-status" method="get">
                            <input type="hidden" name="accountId" value="${feedback.account.id}">
                            <input type="hidden" name="isbn" value="${feedback.book.isbn}">
                            <input type="hidden" name="status" value="<c:out value='${!feedback.status}'/>">
                            <button class="btn btn-phoenix-secondary" type="submit">
                                <c:choose>
                                    <c:when test="${feedback.status == true}">
                                        Hide Feedback
                                    </c:when>
                                    <c:otherwise>
                                        Show Feedback
                                    </c:otherwise>
                                </c:choose>
                            </button>
                        </form>
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
