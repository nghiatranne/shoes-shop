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
                        <h2 class="mb-0">Category Management</h2>
                    </div>
                </div>
                <div class="row">
                    <div class="col-4">
                        <div class="card border border-2 rounded-3">
                            <div class="card-body">
                                <form id="addNewCategoryForm" method="post" action="${pageContext.request.contextPath}/admin/categories/edit">

                                    <div class="mb-3">
                                        <label class="form-label" for="categoryIdIn">Category ID </label>
                                        <input class="form-control" disabled id="categoryIdIn" value="${cate.id}" />
                                        <input class="d-none" name="category_id" value="${cate.id}" />
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label" for="categoryNameIn">Category Name </label>
                                        <input name="category_name" class="form-control" id="categoryNameIn" type="text" value="${cate.name}" />
                                    </div>
                                    <div class="d-flex justify-content-end">
                                        <a class="btn btn-phoenix-warning me-2" href="${pageContext.request.contextPath}/admin/categories">Cancel</a>
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

                fetch('http://localhost:8080/BookShopping/api/categorys')
                        .then(res => res.json())
                        .then(data => {
                            data.forEach((el) => {
                                if (el.name.trim().toUpperCase() !== category_name_update.trim().toUpperCase()) {
                                    list_category_name.push(el.name.toUpperCase());
                                }
                            })
                        })
                        .catch(error => {
                            console.log(error);
                        });
                console.log(list_category_name)

                $.validator.addMethod("alreadyexist_categoryName", function (value, element) {
                    return list_category_name.indexOf(value.trim().toUpperCase()) === -1;
                }, "Category name is already exist!");

                $("#addNewCategoryForm").validate({
                    errorPlacement: function (label, element) {
                        label.addClass('invalid-feedback');
                        label.insertAfter(element);
                    },
                    wrapper: 'div',
                    rules: {
                        category_name: {
                            required: true,
                            alreadyexist_categoryName: true,
                            maxlength: 30
                        }
                    },
                    messages: {
                        category_name: {
                            required: 'Category name is cannot empty!',
                            maxlength: 'Category name required less than 20 characters!'
                        }
                    }
                });
            });
        </script>
    </body>
</html>
