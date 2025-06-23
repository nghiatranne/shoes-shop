<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: hoaht
  Date: 2/25/2024
  Time: 1:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin dashboard</title>

    <jsp:include page="import-css.jsp"/>
</head>
<body>
    <jsp:include page="layout/navigation.jsp"/>

    <jsp:include page="layout/header-nav.jsp"/>

    <div class="content">
        <div class="mb-9">
            <div class="row g-2 mb-4">
                <div class="col-auto">
                    <h2 class="mb-0">Payment Management</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-4">
                    <div class="card border border-2 rounded-3">
                        <div class="card-body">
                            <form id="updatePaymentForm" method="post" action="${pageContext.request.contextPath}/admin/payments/edit">
                                <div class="mb-3">
                                    <label class="form-label" for="paymentMethodIn">Payment Method </label>
                                    <input name="method" class="form-control" id="paymentMethodIn" type="text" value="${paymentMethod.method}" required/>
                                    <input name="oldPaymentName" class="d-none" type="text" value="${paymentMethod.method}"/>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label" for="noteIn">Note </label>
                                    <textarea name="note" id="noteIn" class="form-control" rows="20" required>${paymentMethod.note}</textarea>
                                </div>
                                <div class="d-flex justify-content-end">
                                    <a class="btn btn-phoenix-warning me-2" href="${pageContext.request.contextPath}/admin/payments">Cancle</a>
                                    <input class="btn btn-phoenix-primary" type="submit" value="Update">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="import-js.jsp"/>
    <script>
        if (${nav_payment_manage}) {
            let user_account = $('#payment-manage');
            user_account.addClass('active');
        }
    </script>
    <script>
        $(document).ready(function () {
            let list_paymentMethod = [];
            let payment_method_update = $('#paymentMethodIn').val()

            fetch('http://localhost:8080/ShoesShop/api/payments')
                .then(res => res.json())
                .then(data => {
                    data.forEach((el) => {
                        if (el.paymentMethod.trim().toUpperCase() !== payment_method_update.trim().toUpperCase()) {
                            list_paymentMethod.push(el.paymentMethod.toUpperCase());
                        }
                    });
                })
                .catch(error => {
                    console.log(error);
                });
                
            console.log(list_paymentMethod)    

            $.validator.addMethod("alreadyexist_paymentMethod", function(value, element) {
                return list_paymentMethod.indexOf(value.trim().toUpperCase()) === -1;
            }, "Payment method is already exist!");

            $("#updatePaymentForm").validate({
                errorPlacement: function (label, element) {
                    label.addClass('invalid-feedback');
                    label.insertAfter(element);
                },
                wrapper: 'div',
                rules: {
                    paymentMethod: {
                        required: true,
                        alreadyexist_paymentMethod: true,
                        maxlength: 30
                    },
                    note: {
                        required: true
                    }
                },
                messages: {
                    paymentMethod: {
                        required: 'Payment method is cannot empty!',
                        maxlength: 'Payment method required less than 30 characters!'
                    },
                    note: {
                        required: 'Note payment is cannot empty!'
                    }
                }
            });
        });
    </script>
</body>
</html>
