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
        <title>Sign Up</title>

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
                                                <h3 class="text-1000">Sign Up</h3>
                                            </div>
                                            <form id="sign-up-form" method="post">
                                                <div class="mb-3 text-start">
                                                    <label class="form-label" for="fullName">Full name</label>
                                                    <input class="form-control" id="fullName" name="fullName" type="text" placeholder="Name" />
                                                </div>
                                                <div class="mb-3 text-start">
                                                    <label class="form-label" for="telephone">Phone number</label>
                                                    <input class="form-control" id="telephone" name="telephone" placeholder="Phone number" />
                                                </div>
                                                <div class="mb-3 text-start">
                                                    <label class="form-label" for="email">Email address</label>
                                                    <input class="form-control" id="email" type="email" name="email" placeholder="name@example.com" />
                                                </div>
                                                <div class="row align-items-center g-3 mb-3">
                                                    <div class="col-12 col-md-12 col-lg-12 col-xxl-6">
                                                        <label class="form-label" for="gender_male">Male</label>
                                                        <input class="form-check-input" id="gender_male" type="radio" name="gender" value="true"/>
                                                        <label class="form-label" for="gender_female">Female</label>
                                                        <input class="form-check-input" id="gender_female" type="radio" name="gender" value="false"/>
                                                    </div>
                                                    <div class="col-12 col-md-12 col-lg-12 col-xxl-6">
                                                        <label class="form-label" for="birthDate">Birth Date</label>
                                                        <input class="form-control" id="birthDate" name="birthDate" type="date" placeholder="MM/dd/yyyy"/>
                                                    </div>
                                                </div>
                                                <div class="mb-3 text-start">
                                                    <label class="form-label" for="address">Address</label>
                                                    <input class="form-control" id="address" type="text" name="address" placeholder="Address" />
                                                </div>
                                                <div class="row g-3 mb-3">
                                                    <div class="col-xl-6">
                                                        <label class="form-label" for="password">Password</label>
                                                        <input class="form-control form-icon-input" id="password" name="password" type="password" placeholder="Password" />
                                                    </div>
                                                    <div class="col-xl-6">
                                                        <label class="form-label" for="confirmPassword">Confirm Password</label>
                                                        <input class="form-control form-icon-input" id="confirmPassword" name="confirm_password" type="password" placeholder="Confirm Password" />
                                                    </div>
                                                    <c:if test="${error_email == true}">
                                                        <div class="invalid-feedback" style="display: block;">
                                                            <label>This email address is already existed!  <a class="fs--1 fw-bold" href="${pageContext.request.contextPath}/login">Login</a></label>
                                                        </div>
                                                    </c:if>
                                                </div>
                                                <button class="btn btn-primary w-100 mb-3" id="registerButton">Sign up</button>
                                            </form>
                                            <div class="text-center"><a class="fs--1 fw-bold" href="${pageContext.request.contextPath}/login">Sign in to an existing account</a></div>
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
        $.validator.addMethod("equal_password", function (value, element) {
            return $('#password').val().indexOf(value.trim()) !== -1;
        }, "Confirm password must be equal to password!");

        $.validator.addMethod("equal_password_confirm", function (value, element) {
            return $('#confirmPassword').val().indexOf(value.trim()) !== -1;
        }, "Confirm password must be equal to password!");

        $.validator.addMethod("custom_email", function (value, element) {
            // Check for consecutive periods
            var regex1 = /(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/;
            var consecutivePeriods = /(^.*[^.]\.\..*[^.].*$)|(^.*[^.]\.\.$)|(^\.\..*[^.].*$)/;

            // Perform both email regex and consecutive period checks
            return this.optional(element) || (regex1.test(value) && !consecutivePeriods.test(value));
        }, "Please enter a valid email address without consecutive periods!");


        $("#sign-up-form").validate({
            errorPlacement: function (label, element) {
                label.addClass('invalid-feedback');
                label.insertAfter(element);
            },
            wrapper: 'div',
            rules: {
                fullName: {
                    required: true,
                    maxlength: 50,
                    minlength: 1
                },
                address: {
                    required: true,
                    maxlength: 150,
                    minlength: 1
                },
                email: {
                    required: true,
                    maxlength: 50,
                    email: true,
                    custom_email: true
                },
                password: {
                    required: true,
                    minlength: 1,
                    equal_password_confirm: true
                },
                confirm_password: {
                    required: true,
                    minlength: 1,
                    equal_password: true
                },
                telephone: {
                    required: true,
                    maxlength: 10,
                    minlength: 10
                }

            },
            messages: {
                fullName: {
                    required: "Full name is cannot empty!",
                    maxlength: "Full name must be less than 50 characters!"
                },
                address: {
                    required: "Address is cannot empty!",
                    maxlength: "Address must be less than 150 characters!"
                },
                email: {
                    required: "Email is cannot empty!",
                    maxlength: "Email must be lass than 50 characters!"
                },
                password: {
                    required: "Password is cannot empty!"
                },
                confirm_password: {
                    required: "Confirm password is cannot empty!",
                },
                telephone: {
                    required: "Telephone is cannot empty!",
                    maxlength: "Telephone number must be 10 characters!",
                    minlength: "Telephone number must be 10 characters!"
                }
            }
        });
    </script>
</html>
