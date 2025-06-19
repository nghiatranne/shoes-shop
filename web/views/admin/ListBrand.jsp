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

        <div class="content pb-0">
            <div>
                <div class="row g-2 mb-4">
                    <div class="col-auto">
                        <h2 class="mb-0">Brand Management</h2>
                    </div>
                </div>
                <div class="row">
                    <div class="col-4">
                        <div class="card border border-2 rounded-3">
                            <div class="card-body">
                                <form id="addNewCategoryForm" method="post" action="${pageContext.request.contextPath}/admin/brands">
                                    <div class="mb-3">
                                        <label class="form-label" for="categoryIdIn">Brand ID </label>
                                        <input class="form-control" disabled id="categoryIdIn" placeholder="Brand ID is auto increase" />
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label" for="categoryNameIn">Brand Name </label>
                                        <input name="brand_name" class="form-control" id="categoryNameIn" type="text" />
                                    </div>
                                    <div class="d-flex justify-content-end">
                                        <input class="btn btn-phoenix-warning me-2" type="reset" value="Clear">
                                        <input class="btn btn-phoenix-primary" type="submit" value="Submit">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-8">
                        <div class="card border border-2 rounded-3">
                            <div class="card-body">
                                <div id="categories">
                                    <div class="mb-4">
                                        <div class="row g-3">
                                            <div class="col-auto">
                                                <div class="search-box">
                                                    <form class="position-relative m-0" onsubmit="event.preventDefault()">
                                                        <input class="form-control search-input search" type="search" placeholder="Search category"/>
                                                        <span class="fas fa-search search-box-icon"></span>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="table-responsive scrollbar mx-n1 px-1" style="height: 65vh">
                                        <table class="table fs--1 mb-0">
                                            <thead>
                                                <tr>
                                                    <th class=" align-middle pe-5" scope="col" style="width:15%; padding-left: 0">CATEGORY ID</th>
                                                    <th class=" align-middle pe-5 overflow-docs" scope="col" style="width:40%; min-width: 100px">BRAND NAME</th>
                                                    <th class=" align-middle" scope="col" style="width:14%;">CREATE DATE</th>
                                                    <th class=" align-middle" scope="col" style="width:15%;">UPDATE DATE</th>
                                                    <th class=" align-middle" scope="col" style="width:20%;">TOTAL PRODUCT</th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody class="list">
                                                <c:forEach var="brandEntry" items="${listBrand}">
                                                    <c:set var="l" value="${brandEntry.key}" />
                                                    <tr class="hover-actions-trigger btn-reveal-trigger position-static cursor-pointer" onclick="">
                                                        <td class="category_id align-middle white-space-nowrap pe-5 overflow-docs">
                                                            <a class="d-flex align-items-center text-decoration-none">
                                                                <p class="mb-0 text-1100 fw-bold">${l.id}</p>
                                                            </a>
                                                        </td>
                                                        <td class="category_name align-middle pe-5">
                                                            <p class="mb-0 text-1100 fw-bold">${l.name}</p>
                                                        </td>
                                                        <td class="create_date align-middle white-space-nowrap pe-5">
                                                            <p class="mb-0 text-1100 fw-bold">${l.createDate}</p>
                                                        </td>
                                                        <td class="update_date align-middle white-space-nowrap pe-5">
                                                            <p class="mb-0 text-1100 fw-bold">${l.updateDate}</p>
                                                        </td>
                                                        <td class="total_order align-middle white-space-nowrap fw-bold text-1100">
                                                            ${brandEntry.value} products 
                                                        </td>
                                                        <td class="align-middle">
                                                            <div class="d-flex justify-content-end">
                                                                <a href="brands/edit?id=${l.id}" class="btn btn-phoenix-secondary btn-icon fs--2 px-0 ms-3" type="button">
                                                                    <span data-feather="edit"></span>
                                                                </a>
                                                                <button onclick="setDeleteCategory(${l.id})" class="btn btn-phoenix-secondary btn-icon fs--2 text-danger px-0 ms-2" type="button" data-bs-toggle="modal" data-bs-target="#model_delete">
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

        <div class="modal fade" id="model_delete" tabindex="-1" aria-labelledby="verticallyCenteredModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body">
                        <p class="text-700 lh-lg mb-0">
                            Are you sure to delete this category?
                        </p>
                    </div>
                    <div class="modal-footer">
                        <a id="btn_deleteCategory" class="btn btn-danger" type="button">Okay</a>
                        <button class="btn btn-outline-primary" type="button" data-bs-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="import-js.jsp"/>
        <script>
            var options = {
                valueNames: ['category_id', 'category_name', 'total_order', 'create_date', 'update_date']
            };

            var categoryList = new List('categories', options);
        </script>
        
        <script>
            let dashboard_tag = document.getElementById('category-manage')
            dashboard_tag.classList.add('active')
        </script>
        <script>
            $(document).ready(function () {
                let list_category_name = [];

                fetch('http://localhost:8080/ShoesShop/api/brands')
                        .then(res => res.json())
                        .then(data => {
                            data.forEach((el) => {
                                list_category_name.push(el.name.toUpperCase());
                            });
                        })
                        .catch(error => {
                            console.log(error);
                        });

                $.validator.addMethod("alreadyexist_categoryName", function (value, element) {
                    return list_category_name.indexOf(value.trim().toUpperCase()) === -1;
                }, "Brand name is already exist!");

                $("#addNewCategoryForm").validate({
                    errorPlacement: function (label, element) {
                        label.addClass('invalid-feedback');
                        label.insertAfter(element);
                    },
                    wrapper: 'div',
                    rules: {
                        brand_name: {
                            required: true,
                            alreadyexist_categoryName: true,
                            maxlength: 20
                        }
                    },
                    messages: {
                        brand_name: {
                            required: 'Brand name is cannot empty!',
                            maxlength: 'Brand name required less than 20 characters!'
                        }
                    }
                });
            });
        </script>
        <script>
            const setDeleteCategory = (category_id) => {
                let btn_deleteCategory = $('#btn_deleteCategory')

                btn_deleteCategory.click(function () {
                    btn_deleteCategory.attr('href', 'brands/del?id=' + category_id)
                });
            };
        </script>
    </body>
</html>
