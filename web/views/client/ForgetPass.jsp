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
        <title>Forget Password</title>

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
                                                <h3 class="text-1000">Verify Email</h3>
                                            </div>
                                            <form id="forget-pass-form" method="post">
                                                <div class="mb-3 text-start">
                                                    <label class="form-label" for="email">Enter your registration email:</label>
                                                    <input class="form-control" id="email" name="email" type="text" placeholder="Email" />
                                                </div>
                                                <button class="btn btn-primary w-100 mb-3">Send</button>
                                                <c:if test="${success}">
                                                    <div class="invalid-feedback" style="display: block; color: green">
                                                        <label>We are sending to you a link to reset password, check it!</label>
                                                    </div>
                                                </c:if>
                                                <c:if test="${failed}">
                                                    <div class="invalid-feedback" style="display: block">
                                                        <label>This email is not existing!</label>
                                                    </div>
                                                </c:if>
                                            </form>
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
        $("#forget-pass-form").validate({
            errorPlacement: function (label, element) {
                label.addClass('invalid-feedback');
                label.insertAfter(element);
            },
            wrapper: 'div',
            rules: {
                email: {
                    required: true
                }
            },
            messages: {
                email: {
                    required: "Please enter your email!"
                }
            }
        });
    </script>
</html>