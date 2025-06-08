<%-- 
    Document   : ListBook
    Created on : Mar 2, 2024, 3:27:57 AM
    Author     : hoaht
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>

        <jsp:include page="import-css.jsp"/>
    </head>
    <body>
        <main class="main" id="top">
            <jsp:include page="layout/header.jsp"/>

            <jsp:include page="layout/navigation.jsp"/>

            <div class="container-fluid">
                <div class="row flex-center position-relative py-5">
                    <div class="col-11 col-sm-10 col-xl-8">
                        <div class="card border border-200 auth-card">
                            <div class="card-body pe-md-0">
                                <div class="row align-items-center gx-0 gy-7">
                                    <div class="col mx-auto">
                                        <div class="auth-form-box">
                                            <div class="text-center mb-7">
                                                <h3 class="text-1000">Sign In</h3>
                                            </div>
                                            <form id="loginForm" method="post">
                                                <div class="mb-3 text-start">
                                                    <label class="form-label" for="email">Email address</label>
                                                    <div class="form-icon-container">
                                                        <input class="form-control form-icon-input" id="email" type="email" name="email" placeholder="name@example.com" />
                                                        <span class="fas fa-user text-900 fs--1 form-icon"></span>
                                                    </div>
                                                </div>
                                                <div class="mb-3 text-start"><label class="form-label" for="password">Password</label>
                                                    <div class="form-icon-container">
                                                        <input class="form-control form-icon-input" id="password" type="password" name="password" placeholder="Password" />
                                                        <span class="fas fa-key text-900 fs--1 form-icon"></span>
                                                    </div>
                                                    <c:if test="${error == true}">
                                                        <div class="invalid-feedback" style="display: block;">
                                                            <label>Email address or password is incorrect!</label>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${authen == true}">
                                                        <div class="invalid-feedback" style="display: block;">
                                                            <label>You can't use this account!</label>
                                                        </div>
                                                    </c:if>
                                                </div>
                                                <button class="btn btn-primary w-100 mb-3" id="loginButton">Sign In</button>
                                            </form>
                                            <div class="d-flex justify-content-center gap-5">
                                                <a class="fs--1 fw-bold" href="${pageContext.request.contextPath}/sign-up">Create an account</a>
                                                <a class="fs--1 fw-bold" href="${pageContext.request.contextPath}/forget-pass">Forgot password</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </body>

    <jsp:include page="import-js.jsp"/>

    <script>
        $("#loginForm").validate({
            errorPlacement: function (label, element) {
                label.addClass('invalid-feedback');
                label.insertAfter(element);
            },
            wrapper: 'div',
            rules: {
                email: {
                    required: true
                },
                password: {
                    required: true
                }
            },
            messages: {
                email: {
                    required: "Please enter your email!"
                },
                password: {
                    required: "Please enter your password!"
                }
            }
        });

        <c:if test="${sessionScope.signUp_success == true}">
            showToast('You have successfully registered an account!');
        </c:if>
        <%
            session.removeAttribute("signUp_success");
        %>
    </script>
</html>
