<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- views/client/ChangePass.jsp -->
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
        <jsp:include page="import-css.jsp"/>
        <style>
            .message-success {
                color: green;
            }
            .message-error {
                color: red;
            }
        </style>
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
                                                <h3 class="text-1000">Change Password</h3>
                                            </div>
                                            <form id="changePasswordForm" method="post" action="${pageContext.request.contextPath}/profile/change-pass">
                                                <div class="mb-3 text-start">
                                                    <label class="form-label" for="email">Email</label>
                                                    <div class="form-icon-container">
                                                        <input class="form-control form-icon-input" readonly id="email" value="${email}" type="email" name="email"/>
                                                        <span class="fas fa-user text-900 fs--1 form-icon"></span>
                                                    </div>
                                                </div>
                                                <div class="mb-3 text-start">
                                                    <label class="form-label" for="oldPassword">Old Password</label>
                                                    <div class="form-icon-container">
                                                        <input class="form-control form-icon-input" id="oldPassword" type="password" name="oldPassword" required/>
                                                        <span class="fas fa-key text-900 fs--1 form-icon"></span>
                                                    </div>
                                                </div>
                                                <div class="mb-3 text-start">
                                                    <label class="form-label" for="newPassword">New Password</label>
                                                    <div class="form-icon-container">
                                                        <input class="form-control form-icon-input" id="newPassword" type="password" name="newPassword" required/>
                                                        <span class="fas fa-key text-900 fs--1 form-icon"></span>
                                                    </div>
                                                </div>
                                                <div class="mb-3 text-start">
                                                    <label class="form-label" for="confirmPassword">Confirm Password</label>
                                                    <div class="form-icon-container">
                                                        <input class="form-control form-icon-input" id="confirmPassword" type="password" name="confirmPassword" required/>
                                                        <span class="fas fa-key text-900 fs--1 form-icon"></span>
                                                    </div>
                                                </div>
                                                <button class="btn btn-primary w-100 mb-3">Change Password</button>
                                            </form>
                                            <c:if test="${not empty message}">
                                                <div class="text-center mt-3">
                                                    <p class="<c:out value='${messageType == "success" ? "message-success" : "message-error"}'/>">${message}</p>
                                                </div>
                                            </c:if>
                                            <div class="text-center">
                                                <a class="fs--1 fw-bold" href="${pageContext.request.contextPath}/homepage">Back to home</a>
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
        <jsp:include page="import-js.jsp"/>
        <script>
            $("#changePasswordForm").validate({
                errorPlacement: function (label, element) {
                    label.addClass('invalid-feedback');
                    label.insertAfter(element);
                },
                wrapper: 'div',
                rules: {
                    oldPassword: {
                        required: true
                    },
                    newPassword: {
                        required: true
                    },
                    confirmPassword: {
                        required: true,
                        equalTo: "#newPassword"
                    }
                },
                messages: {
                    oldPassword: {
                        required: "Please enter your old password!"
                    },
                    newPassword: {
                        required: "Please enter your new password!"
                    },
                    confirmPassword: {
                        required: "Please confirm your new password!",
                        equalTo: "New password and confirm password do not match!"
                    }
                }
            });
        </script>
    </body>
</html>
