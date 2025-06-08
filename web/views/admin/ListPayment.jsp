<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                                <form id="addNewPaymentForm" method="post" action="${pageContext.request.contextPath}/admin/payments">
                                    <div class="mb-3">
                                        <label class="form-label" for="paymentMethodIn">Payment Method </label>
                                        <input name="method" class="form-control" id="paymentMethodIn" type="text" required />
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label" for="imageLink">Image URL </label>
                                        <input name="imageLink" class="form-control" id="imageLink" type="text" required />
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label" for="noteIn">Note </label>
                                        <textarea name="note" id="noteIn" class="form-control" rows="20" required></textarea>
                                    </div>
                                    <div class="d-flex justify-content-end">
                                        <input class="btn btn-phoenix-warning me-2" type="reset" value="Clear">
                                        <input id="paymentBtn" class="btn btn-phoenix-primary" type="submit" value="Submit">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-8">
                        <div class="card border border-2 rounded-3">
                            <div class="card-body">
                                <div id="payments">
                                    <div class="mb-4">
                                        <div class="row g-3">
                                            <div class="col-auto">
                                                <div class="search-box">
                                                    <form class="position-relative m-0" onsubmit="event.preventDefault()">
                                                        <input class="form-control search-input search" type="search" placeholder="Search payment"/>
                                                        <span class="fas fa-search search-box-icon"></span>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mx-n4 px-4 px-lg-6 bg-white position-relative top-1">
                                        <div class="table-responsive scrollbar-overlay mx-n1 px-1">
                                            <table class="table fs--1 mb-0">
                                                <thead>
                                                    <tr>
                                                        <th class="align-middle pe-5" scope="col" style="width:20%; padding-left: 0">PAYMENT METHOD</th>
                                                        <th class="align-middle pe-5 overflow-docs" scope="col" style="width:40%; min-width: 200px">NOTE</th>
                                                        <th class="align-middle" scope="col" style="width:20%;">TOTAL ORDER</th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody class="list">
                                                    <c:forEach var="paymentMethod" items="${paymentMethods}">
                                                        <tr class="hover-actions-trigger btn-reveal-trigger position-static cursor-pointer">
                                                            <td class="payment_method align-middle white-space-nowrap pe-5 overflow-docs">
                                                                <a class="d-flex align-items-center text-decoration-none">
                                                                    <p class="mb-0 text-1100 fw-bold">${paymentMethod.key.method}</p>
                                                                </a>
                                                            </td>
                                                            <td class="payment_note align-middle pe-5">
                                                                <p class="mb-0 text-1100 fw-bold">${paymentMethod.key.note}</p>
                                                            </td>
                                                            <td class="total_order align-middle white-space-nowrap fw-bold text-1100">
                                                                ${paymentMethod.value} orders <!-- Replace with actual data if available -->
                                                            </td>
                                                            <td class="align-middle">
                                                                <div class="d-flex justify-content-end">
                                                                    <a href="payments/edit?method=${paymentMethod.key.method}" class="btn btn-phoenix-secondary btn-icon fs--2 px-0 ms-3" type="button">
                                                                        <span data-feather="edit"></span>
                                                                    </a>
                                                                    <button onclick="setDeletePayment('${paymentMethod.key.method}')" class="btn btn-phoenix-secondary btn-icon fs--2 text-danger px-0 ms-2" type="button" data-bs-toggle="modal" data-bs-target="#model_delete">
                                                                        <span class="text-danger" data-feather="trash-2"></span>
                                                                    </button>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
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
                            Are you sure to delete this payment?
                        </p>
                    </div>
                    <div class="modal-footer">
                        <a id="btn_deletePayment" class="btn btn-danger" type="button">Okay</a>
                        <button class="btn btn-outline-primary" type="button" data-bs-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="import-js.jsp"/>
        <script>
            var options = {
                valueNames: ['payment_method', 'payment_note', 'total_order']
            };

            var paymentList = new List('payments', options);
        </script>
        
        <script>
            let dashboard_tag = document.getElementById('payment-manage')
            dashboard_tag.classList.add('active')
        </script>
        
        <script>
            $(document).ready(function () {
                let list_paymentMethod = [];

                fetch('${pageContext.request.contextPath}/api/payments')
                        .then(res => res.json())
                        .then(data => {
                            data.forEach((el) => {
                                list_paymentMethod.push(el.method.toUpperCase());
                            });
                        })
                        .catch(error => {
                            console.log(error);
                        });

                $.validator.addMethod("alreadyexist_paymentMethod", function (value, element) {
                    return list_paymentMethod.indexOf(value.trim().toUpperCase()) === -1;
                }, "Payment method already exists!");

                $("#addNewPaymentForm").validate({
                    errorPlacement: function (label, element) {
                        label.addClass('invalid-feedback');
                        label.insertAfter(element);
                    },
                    wrapper: 'div',
                    rules: {
                        method: {
                            required: true,
                            alreadyexist_paymentMethod: true,
                            maxlength: 30,
                            minlength: 1
                        },
                        note: {
                            required: true,
                            minlength: 1,
                            maxlength: 255
                        },
                        imageLink: {
                            required: true,
                            minlength: 1,
                            maxlength: 255
                        }
                    },
                    messages: {
                        method: {
                            required: 'Payment method cannot be empty!',
                            maxlength: 'Payment method must be less than 30 characters!'
                        },
                        note: {
                            required: 'Note cannot be empty!'
                        },
                        imageLink: {
                            required: 'Image cannot be empty!'
                        }
                    }
                });
            });

            const setDeletePayment = (payment_method) => {
                $('#btn_deletePayment').attr('href', 'payments/del?method=' + payment_method);
            };
        </script>
    </body>
</html>
