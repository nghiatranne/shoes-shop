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
        <title>Reset pass</title>

        <jsp:include page="import-css.jsp"/>
    </head>
    <body>
        <main class="main" id="top">
            <jsp:include page="layout/header.jsp"/>

            <jsp:include page="layout/navigation.jsp"/>

            <section class="pt-5 pb-9">
                <div class="container-small">
                    <form id="update-pass-form" method="post" class="m-0">
                        <div class="row col-4 g-3 mb-3">
                            <div class="d-none">
                                <input class="form-control d-none" name="email" type="text" value="${sessionScope.a_email}"/>
                                <input class="form-control d-none" name="token" type="text" value="${param.token}"/>
                            </div>
                            <div class="col-12 col-lg-12">
                                <label class="form-label text-1000 fs-0 ps-0 text-capitalize lh-sm" for="new-pass">New Password</label>
                                <input class="form-control" id="new-pass" name="newPass" type="text" placeholder="*****"/>
                            </div>
                            <div class="col-12 col-lg-12">
                                <label class="form-label text-1000 fs-0 ps-0 text-capitalize lh-sm" for="confirm-new-pass">Confirm New Password</label>
                                <input class="form-control" id="confirm-new-pass" name="confirmNewPass" type="text" placeholder="*****"/>
                            </div>
                        </div>
                        <div class="text-start"><button class="btn btn-primary px-7">Save changes</button></div>
                    </form>
                </div><!-- end of .container-->
            </section>
        </main>
    </body>

    <jsp:include page="import-js.jsp"/>

    <script>
        $(document).ready(function () {
            $.validator.addMethod("equal_password", function (value, element) {
                return $('#new-pass').val().indexOf(value.trim()) !== -1;
            }, "Confirm password must be equal to new password!");

            $.validator.addMethod("equal_password_confirm", function (value, element) {
                return $('#confirm-new-pass').val().indexOf(value.trim()) !== -1;
            }, "Confirm password must be equal to new password!");

            $("#update-pass-form").validate({
                errorPlacement: function (label, element) {
                    label.addClass('invalid-feedback');
                    label.insertAfter(element);
                },
                wrapper: 'div',
                rules: {
                    newPass: {
                        required: true,
                        equal_password_confirm: true
                    },
                    confirmNewPass: {
                        required: true,
                        equal_password: true
                    }
                },
                messages: {
                    newPass: {
                        required: "You must input this field!"
                    },
                    confirmNewPass: {
                        required: "You must input this field!"
                    }
                }
            });
        });
    </script>
</html>
