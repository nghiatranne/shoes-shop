<%-- 
    Document   : EditCategory
    Created on : May 13, 2024, 11:21:17 AM
    Author     : hoaht
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Edit Category</title>

        <jsp:include page="import-css.jsp"/>
    </head>
    <body>
        <jsp:include page="layout/navigation.jsp"/>

        <jsp:include page="layout/header-nav.jsp"/>

        <div class="content">
            <div class="mb-9">
                <div class="row g-2 mb-4">
                    <div class="col-auto">
                        <h2 class="mb-0">Size Management</h2>
                    </div>
                </div>
                <div class="row">
                    <div class="col-4">
                        <div class="card border border-2 rounded-3">
                            <div class="card-body">
                                <form id="addNewCategoryForm" method="post" action="${pageContext.request.contextPath}/admin/sizes/edit">
                                    <div class="mb-3">
                                        <label class="form-label" for="categoryIdIn">Size ID </label>
                                        <input class="form-control" disabled id="categoryIdIn" value="${size.id}" />
                                        <input class="d-none" name="size_id" value="${size.id}" />
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label" for="categoryNameIn">Size Value </label>
                                        <input name="size_value" class="form-control" id="categoryNameIn" type="text" value="${size.value}" />
                                    </div>
                                    <div class="d-flex justify-content-end">
                                        <a class="btn btn-phoenix-warning me-2" href="${pageContext.request.contextPath}/admin/sizes">Cancel</a>
                                        <input class="btn btn-phoenix-primary" type="submit" value="Submit">
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
            if (${nav_category_manage}) {
                let user_account = $('#category-manage');
                user_account.addClass('active');
            }
        </script>
        <script>
            $(document).ready(function () {
                let list_category_name = [];
                let category_name_update = $('#categoryNameIn').val()

                fetch('http://localhost:8080/ShoesShop/api/sizes')
                        .then(res => res.json())
                        .then(data => {
                            data.forEach((el) => {
                                if (String(el.size) !== category_name_update) {
                                    list_category_name.push(String(el.size));
                                }
                            })
                        })
                        .catch(error => {
                            console.log(error);
                        });
                console.log(list_category_name)

                $.validator.addMethod("alreadyexist_categoryName", function (value, element) {
                    return list_category_name.indexOf(value.trim()) === -1
                        && list_category_name.indexOf(Number(value.trim())) === -1;
                }, "Size value is already exist!");

                $("#addNewCategoryForm").validate({
                    errorPlacement: function (label, element) {
                        label.addClass('invalid-feedback');
                        label.insertAfter(element);
                    },
                    wrapper: 'div',
                    rules: {
                        size_value: {
                            required: true,
                            alreadyexist_categoryName: true,
                            maxlength: 30
                        }
                    },
                    messages: {
                        size_value: {
                            required: 'Size value is cannot empty!',
                            maxlength: 'Size value required less than 20 characters!'
                        }
                    }
                });
            });
        </script>
    </body>
</html>
