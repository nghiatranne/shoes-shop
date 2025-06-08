<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Admin Dashboard - Customer Details</title>
        <jsp:include page="import-css.jsp"/>
    </head>
    <body>
        <jsp:include page="layout/navigation.jsp"/>
        <jsp:include page="layout/header-nav.jsp"/>

        <div class="content">
            <div class="mb-9">
                <!-- Customer Details Display and Edit Section -->
                <div class="row g-5">
                    <div class="col-12 col-lg-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">Customer Details</h5>
                            </div>
                            <div class="card-body">
                                <form id="updateCustomerForm" method="POST">
                                    <div class="mb-3">
                                        <label class="form-label">Full Name</label>
                                        <input type="text" class="form-control" name="fullname" id="fullname" value="${account_detail.fullname}">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Email</label>
                                        <input type="email" class="form-control" id="email" name="email" value="${account_detail.email}">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Mobile</label>
                                        <input type="text" class="form-control" name="mobile" id="mobile" value="${account_detail.telephone}">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Gender</label>
                                        <div>
                                            <input type="radio" id="genderMale" name="gender" value="true" ${account_detail.gender == false ? 'checked' : ''} required>
                                            <label for="genderMale">Male</label>
                                            <input type="radio" id="genderFemale" name="gender" value="false" ${account_detail.gender == true ? 'checked' : ''} required>
                                            <label for="genderFemale">Female</label>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Status</label>
                                        <input type="text" class="form-control" name="status" value="${account_detail.status}" disabled>
                                    </div>
                                    <button type="submit" class="btn btn-primary" id="btn-Change">Update Details</button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Customer Change History Section -->
                    <div class="col-12 col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">Change History</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>Email</th>
                                                <th>Full Name</th>
                                                <th>Gender</th>
                                                <th>Mobile</th>
                                                <th>Updated By</th>
                                                <th>Updated Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${changeHistory}" var="change" varStatus="status">
                                                <tr>
                                                    <td>${status.count}</td>
                                                    <td>${change.email}</td>
                                                    <td>${change.fullName}</td>
                                                    <td>
                                                        <c:if test="${change.gender != null}">
                                                            <c:choose>
                                                                <c:when test="${change.gender}">
                                                                    Male
                                                                </c:when>
                                                                <c:otherwise>
                                                                    Female
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:if>
                                                    </td>
                                                    <td>${change.mobile}</td>
                                                    <td>${change.changedBy.fullname}</td> 
                                                    <td>${change.changeDate}</td>
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

        <jsp:include page="import-js.jsp"/>

        <script>
            let user_account = $('#customer-manage');
            user_account.addClass('active');
            
            $(document).ready(function () {
                $("#updateCustomerForm").validate({
                    errorPlacement: function (label, element) {
                        label.addClass('invalid-feedback');
                        label.insertAfter(element);
                    },
                    wrapper: 'div',
                    rules: {
                        fullname: {
                            required: true,
                            minlength: 5,
                            maxlength: 50
                        },
                        email: {
                            required: true,
                            minlength: 5,
                            maxlength: 50,
                            email: true
                        },
                        mobile: {
                            required: true,
                            minlength: 10,
                            maxlength: 10
                        },
                        thumbnail: {
                            required: $('#checkboxInputFile').is(':checked') === false,
                            accept: "image/*"
                        }
                    },
                    messages: {
                    }
                });
            });
        </script>
    </body>
</html>
