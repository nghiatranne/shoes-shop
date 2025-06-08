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
        <title>Invoice</title>

        <jsp:include page="import-css.jsp"/>
    </head>
    <body>
        <main class="main" id="top">
            <jsp:include page="layout/header.jsp"/>

            <jsp:include page="layout/navigation.jsp"/>

            <section class="pt-5 pb-9">
                <div class="container-small">
                    <c:if test="${success_change_pass}">
                        <div class="alert alert-soft-success alert-dismissible fade show px-3 py-3" role="alert">
                            <strong>You have changed your password!</strong>
                        </div>
                    </c:if>
                    <% session.removeAttribute("success_change_pass");%>
                    <div class="row g-3 mb-6">
                        <div class="col-12 col-lg-4">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row align-items-center g-3 g-sm-5 text-center text-sm-start">
                                        <div class="col-12 col-sm-auto flex-1">
                                            <div class="avatar avatar-5xl avatar-bordered mb-3">
                                                <img class="rounded-circle " src="<c:url value="/resources/acc_image/${account.image}"/>" alt="" />
                                            </div>
                                            <h3>${account.fullname}</h3>
                                            <c:choose>
                                                <c:when test="${account.gender != ''}">
                                                    <p class="text-800 m-0">Gender: ${account.gender == "1" ? "Male" : "Female"}</p>
                                                </c:when>
                                                <c:otherwise>
                                                    <p class="text-800 m-0">Gender: Empty!</p>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-lg-8">
                            <div class="card h-100">
                                <div class="card-body">
                                    <div class="border-bottom border-dashed border-300">
                                        <h4 class="mb-3 lh-sm lh-xl-1">Information</h4>
                                    </div>
                                    <div class="row pt-4 g-4">
                                        <div class="col-6">
                                            <h5 class="text-1000">Email: </h5>
                                            <p class="text-800 m-0">${account.email}</p>
                                        </div>
                                        <div class="col-6">
                                            <h5 class="text-1000">Birth Date: </h5>
                                            <p class="text-800 m-0">
                                                <c:choose>
                                                    <c:when test="${account.birthdate != null}">
                                                        <fmt:formatDate value="${account.birthdate}" pattern="MM-dd-yyyy"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        Empty!
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                        <div class="col-6">
                                            <h5 class="text-1000">Telephone: </h5>
                                            <p class="text-800 m-0">${account.telephone}</p>
                                        </div>
                                        <div class="col-6">
                                            <h5 class="text-1000">Address </h5>
                                            <p class="text-800 m-0">${account.address}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="scrollbar">
                            <ul class="nav nav-underline flex-nowrap mb-3 pb-1" id="myTab" role="tablist">
                                <li class="nav-item me-3 ms-0">
                                    <a class="nav-link text-nowrap ${sessionScope.change_pass_tab == null ? 'active' : ''}" id="orders-tab" data-bs-toggle="tab" href="#tab-orders" role="tab" aria-controls="tab-orders" aria-selected="true">
                                        <span class="fas fa-shopping-cart me-2"></span>Orders <span class="text-700 fw-normal"> (${orders_sorted.size()})</span>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link me-3 ms-0 text-nowrap" id="personal-info-tab" data-bs-toggle="tab" href="#tab-personal-info" role="tab" aria-controls="tab-personal-info" aria-selected="true">
                                        <span class="fas fa-user me-2"></span>Personal info
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="tab-content" id="profileTabContent">
                            <div class="tab-pane fade ${sessionScope.change_pass_tab == null ? 'show active' : ''}" id="tab-orders" role="tabpanel" aria-labelledby="orders-tab">
                                <div class="border-top border-bottom border-200">
                                    <div class="table-responsive scrollbar">
                                        <table class="table fs--1 mb-0">
                                            <thead>
                                                <tr>
                                                    <th class="sort white-space-nowrap align-middle pe-3 ps-0" scope="col" style="width:15%; min-width:140px">ORDER</th>
                                                    <th class="sort align-middle pe-3" scope="col" style="width:15%; min-width:180px">STATUS</th>
                                                    <th class="sort align-middle text-start" scope="col" style="width:20%; min-width:160px">DELIVERY METHOD</th>
                                                    <th class="sort align-middle pe-0 text-end pe-2" scope="col" style="width:15%; min-width:160px">DATE</th>
                                                    <th class="sort align-middle text-end" scope="col" style="width:15%; min-width:160px">TOTAL</th>
                                                </tr>
                                            </thead>
                                            <tbody class="list" id="profile-order-table-body">
                                                <c:forEach items="${orders_sorted}" var="os">
                                                    <tr class="hover-actions-trigger btn-reveal-trigger position-static">
                                                        <td class="order align-middle white-space-nowrap py-2 ps-0">
                                                            <a class="fw-semi-bold text-primary" href="${pageContext.request.contextPath}/invoice?order_id=de027f582f">#${os.key.order_id}</a>
                                                        </td>
                                                        <td class="status align-middle white-space-nowrap text-start fw-bold text-700 py-2 pe-3">
                                                            <c:if test="${os.key.status == 'PENDING'}">
                                                                <span class="badge badge-phoenix fs--2 badge-phoenix-warning">
                                                                    <span class="badge-label">${os.key.status}</span>
                                                                    <span class="ms-1" data-feather="clock" style="height:12.8px;width:12.8px;"></span>
                                                                </span>
                                                            </c:if>
                                                            <c:if test="${os.key.status == 'PROCESSING'}">
                                                                <span class="badge badge-phoenix fs--2 badge-phoenix-primary">
                                                                    <span class="badge-label">${os.key.status}</span>
                                                                    <span class="ms-1" data-feather="package" style="height:12.8px;width:12.8px;"></span>
                                                                </span>
                                                            </c:if>
                                                            <c:if test="${os.key.status == 'SHIPPING'}">
                                                                <span class="badge badge-phoenix fs--2 badge-phoenix-info">
                                                                    <span class="badge-label">${os.key.status}</span>
                                                                    <span class="ms-1" data-feather="send" style="height:12.8px;width:12.8px;"></span>
                                                                </span>
                                                            </c:if>
                                                            <c:if test="${os.key.status == 'COMPLETED'}">
                                                                <span class="badge badge-phoenix fs--2 badge-phoenix-success">
                                                                    <span class="badge-label">${os.key.status}</span>
                                                                    <span class="ms-1" data-feather="check" style="height:12.8px;width:12.8px;"></span>
                                                                </span>
                                                            </c:if>
                                                            <c:if test="${os.key.status == 'CANCELLED'}">
                                                                <span class="badge badge-phoenix fs--2 badge-phoenix-secondary">
                                                                    <span class="badge-label">${os.key.status}</span>
                                                                    <span class="ms-1" data-feather="x" style="height:12.8px;width:12.8px;"></span>
                                                                </span>
                                                            </c:if>
                                                        </td>
                                                        <td class="delivery align-middle white-space-nowrap text-900 py">${os.key.payment.paymentMethod}</td>
                                                        <td class="total align-middle text-700 text-end py-2">
                                                            <fmt:formatDate value="${os.key.createDate}" pattern="MMMM dd, yyyy" />
                                                        </td>
                                                        <td class="date align-middle fw-semi-bold text-end py-2 text-1000">
                                                            <fmt:formatNumber type="currency" currencySymbol="$" value="${os.value}" />
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="tab-personal-info" role="tabpanel" aria-labelledby="personal-info-tab">
                                <form id="update-infor-form" method="post" class="m-0" enctype="multipart/form-data">
                                    <div class="row g-3 mb-3">
                                        <div class="col-12 col-lg-6">
                                            <label class="form-label text-1000 fs-0 ps-0 text-capitalize lh-sm" for="acc_img">Image</label>
                                            <input name="acc_img" id="acc_img" class="form-control" type="file" accept="image/png, image/jpeg" />
                                        </div>
                                        <div class="col-12 col-lg-6">
                                            <label class="form-label text-1000 fs-0 ps-0 text-capitalize lh-sm" for="fullName">Full name</label>
                                            <input class="form-control" name="fullName" type="text" placeholder="Full name" value="${account.fullname}"/>
                                            <input class="form-control d-none" name="acc_id" type="text" placeholder="Full name" value="${account.id}"/>
                                        </div>
                                        <div class="col-12 col-lg-6">
                                            <label class="form-label text-1000 fs-0 ps-0 text-capitalize lh-sm" for="gender">Gender</label>
                                            <select class="form-select" name="gender">
                                                <option value="1" ${account.gender == 1 ? "selected" : ""}>Male</option>
                                                <option value="0" ${account.gender == 0 ? "selected" : ""}>Female</option>
                                            </select>
                                        </div>
                                        <div class="col-12 col-lg-6">
                                            <label class="form-label text-1000 fs-0 ps-0 text-capitalize lh-sm" for="email">Email</label>
                                            <input class="form-control" name="email" type="email" placeholder="Email" value="${account.email}" disabled="true"/>
                                        </div>
                                        <div class="col-12 col-lg-6">
                                            <label class="form-label text-1000 fs-0 ps-0 text-capitalize lh-sm" for="birthDate">Birth Date</label>
                                            <input name="birthDate" id="birthDate" value="${account.birthdate}" class="form-control" type="date" placeholder="MM/dd/yyyy"/>
                                        </div>
                                        <div class="col-12 col-lg-6">
                                            <label class="form-label text-1000 fw-bold fs-0 ps-0 text-capitalize lh-sm" for="telephone">Phone</label>
                                            <input class="form-control" id="telephone" name="telephone" type="tel" placeholder="+1234567890" value="${account.telephone}"/>
                                        </div>
                                        <div class="col-12 col-lg-6">
                                            <label class="form-label text-1000 fs-0 ps-0 text-capitalize lh-sm" for="address">Address</label>
                                            <input class="form-control" name="address" type="text" placeholder="Address" value="${account.address}"/>
                                        </div>
                                    </div>
                                    <div class="text-start"><button class="btn btn-primary px-7">Save changes</button></div>
                                </form>
                            </div>
                        </div>
                    </div>
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
                    oldPass: {
                        required: true
                    },
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
                    oldPass: {
                        required: "You must input this field!"
                    },
                    newPass: {
                        required: "You must input this field!"
                    },
                    confirmNewPass: {
                        required: "You must input this field!"
                    }
                }
            });

            $("#update-infor-form").validate({
                errorPlacement: function (label, element) {
                    label.addClass('invalid-feedback');
                    label.insertAfter(element);
                },
                wrapper: 'div',
                rules: {
                    fullName: {
                        required: true,
                        maxlength: 50
                    },
                    address: {
                        required: true,
                        maxlength: 150
                    },
                    email: {
                        required: true,
                        maxlength: 150
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
                        maxlength: "Email must be lass than 150 characters!"
                    },
                    telephone: {
                        required: "Telephone is cannot empty!",
                        maxlength: "Telephone number must be 10 characters!",
                        minlength: "Telephone number must be 10 characters!"
                    }
                }
            });
        });
    </script>
</html>