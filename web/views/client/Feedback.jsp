<%-- 
    Document   : Feedback
    Created on : Jun 17, 2024, 1:06:50 AM
    Author     : USA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Feedback</title>
        <jsp:include page="import-css.jsp"/>
        <!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Feedback Form</title>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
            <style>
                .feedback-container {
                    display: flex;
                    flex-wrap: wrap;
                    justify-content: space-between;
                    align-items: flex-start;
                    gap: 20px;
                    background: #f9f9f9;
                    padding: 20px;
                    border-radius: 10px;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                }
                .feedback-container img {
                    max-width: 100%;
                    height: auto;
                    border-radius: 10px;
                }
                .feedback-form {
                    flex: 1;
                    min-width: 280px;
                }
                .feedback-form textarea {
                    resize: vertical;
                }
                .alert {
                    padding: 20px;
                    background-color: #59b543;
                    color: white;
                    margin-bottom: 15px;
                    border-radius: 5px;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }
                .closebtn {
                    margin-left: 15px;
                    color: white;
                    font-weight: bold;
                    font-size: 20px;
                    cursor: pointer;
                    transition: 0.3s;
                }
                .closebtn:hover {
                    color: black;
                }
                .form-label {
                    font-weight: bold;
                    color: #333;
                }
                .form-control, .form-select {
                    border-radius: 5px;
                    border: 1px solid #ddd;
                    padding: 10px;
                    width: 100%;
                    box-sizing: border-box;
                }
                .form-control:focus, .form-select:focus {
                    border-color: #007bff;
                    box-shadow: 0 0 5px rgba(0, 123, 255, 0.25);
                }
                .btn {
                    padding: 10px 20px;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                    transition: background-color 0.3s;
                }
                .btn-primary {
                    background-color: #007bff;
                    color: white;
                }
                .btn-primary:hover {
                    background-color: #0056b3;
                }
                .btn-secondary {
                    background-color: #6c757d;
                    color: white;
                }
                .btn-secondary:hover {
                    background-color: #5a6268;
                }
                .d-flex {
                    display: flex;
                    justify-content: space-between;
                }
            </style>
        </head>
        <body>
            <main class="main" id="top">
                <jsp:include page="layout/header.jsp"/>
                <jsp:include page="layout/navigation.jsp"/>

                <section class="pt-5 pb-9">
                    <div class="container-small">
                        <div class="d-flex justify-content-between align-items-end mb-4">
                            <h3 class="mb-0">Feedback for: ${bookDetail.title}</h3>
                        </div>
                        <c:if test="${active}">
                            <div class="alert">
                                <span>Bạn đã feedback cho cuốn sách này.</span>
                                <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span>
                            </div>
                        </c:if>
                        <div class="feedback-container">
                            <div class="text-center">
                                <img src="<c:url value='/resources/book_image/${bookDetail.image}'/>" alt="${bookDetail.title}">
                            </div>
                            <form id="feedbackForm" method="post" class="feedback-form" enctype="multipart/form-data">
                                <div class="mb-3">
                                    <label for="fullName" class="form-label">Full Name</label>
                                    <input type="text" class="form-control" id="fullName" name="fullName" value="${acc.fullname}" readonly>
                                </div>
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" value="${acc.email}" readonly>
                                </div>
                                <div class="mb-3">
                                    <label for="mobile" class="form-label">Mobile</label>
                                    <input type="text" class="form-control" id="mobile" name="mobile" value="${acc.telephone}" readonly>
                                </div>
                                <div class="mb-3">
                                    <label for="rating" class="form-label">Rating</label>
                                    <select class="form-select" id="rating" name="rating" ${active ? 'disabled' : ''} required>
                                        <option value="" disabled ${not empty feedback.ratedStar ? '' : 'selected'}>Select your rating</option>
                                        <c:forEach var="i" begin="1" end="5">
                                            <option value="${i}" ${i == feedback.ratedStar ? 'selected' : ''}>${i} Star</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="feedback" class="form-label">Feedback</label>
                                    <textarea class="form-control" id="feedback" name="feedback" rows="3" ${active ? 'readonly' : ''} required>${feedback.content}</textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="feedbackImages" class="form-label">Feedback Images</label>
                                    <input id="inputImageUrlField" name="imageUrl" class="form-control" type="file" accept="image/png, image/jpeg" />
                                    <div class="form-check mt-2">
                                        <input class="form-check-input" id="checkboxInputFile" type="checkbox" name="notUpdateImageUrl" />
                                        <label class="form-check-label" for="checkboxInputFile">Don't want to update image!</label>
                                    </div>
                                </div>
                                <input type="hidden" id="book_isbn" name="isbn" value="${bookDetail.isbn}" />
                                <div class="d-flex">
                                    <button type="submit" class="btn btn-primary" ${active ? 'disabled' : ''}>Submit Feedback</button>
                                    <button type="button" class="btn btn-secondary" onclick="history.back()">Back</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </section>
            </main>
            <jsp:include page="import-js.jsp"/>
        </body>
    </html>
