<%-- 
    Document   : AddBook
    Created on : May 19, 2024, 9:14:22 AM
    Author     : hoaht
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Admin dashboard</title>
        <jsp:include page="import-css.jsp"/>
    </head>
    <body>

        <jsp:include page="layout/navigation.jsp"/>

        <jsp:include page="layout/header-nav.jsp"/>
        
        <div class="content">
            <form id="addNewProductForm" method="post" action="${pageContext.request.contextPath}/admin/products/add/save" enctype="multipart/form-data">
                <div class="row g-3 flex-between-end mb-5">
                    <div class="col-auto">
                        <h2 class="mb-2">Add New Product</h2>
                    </div>
                    <div class="col-auto">
                        <button class="btn btn-phoenix-primary me-2 mb-2 mb-sm-0" type="submit">Add new product</button>
                        <button class="btn btn-phoenix-warning me-2 mb-2 mb-sm-0" type="reset">Reset</button>
                    </div>
                </div>

                <!-- Basic Information -->
                <div class="card mb-3">
                    <div class="card-body">
                        <h4 class="mb-3">Basic Information</h4>
                        <div class="row g-3">
                            <div class="col-12">
                                <label class="form-label" for="title">Product Title</label>
                                <input class="form-control" id="title" name="title" type="text" required/>
                            </div>
                            <div class="col-12">
                                <label class="form-label" for="description">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                            </div>
                            <div class="col-12">
                                <label class="form-label" for="brand">Brand</label>
                                <select class="form-select" id="brand" name="brandId" required>
                                    <option value="">Select brand</option>
                                    <c:forEach items="${brands}" var="brand">
                                        <option value="${brand.id}">${brand.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-12">
                                <label class="form-label" for="categories">Categories</label>
                                <select class="form-select" id="categories" name="categoryIds" multiple required>
                                    <c:forEach items="${categories}" var="category">
                                        <option value="${category.id}">${category.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-12">
                                <label class="form-label" for="mainImage">Main Image</label>
                                <input class="form-control" id="mainImage" name="mainImage" type="file" accept="image/*" required/>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Product Variants -->
                <div class="card mb-3">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="mb-0">Product Variants</h4>
                            <button type="button" class="btn btn-phoenix-secondary btn-sm" id="addVariantBtn">
                                <span class="fas fa-plus me-2"></span>Add Variant
                            </button>
                        </div>
                        <div id="variantsContainer">
                            <!-- Variant template will be cloned here -->
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <!-- Variant Template -->
        <template id="variantTemplate">
            <div class="variant-item card mb-3">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="mb-0">Variant</h5>
                        <button type="button" class="btn btn-phoenix-danger btn-sm remove-variant">
                            <span class="fas fa-trash"></span>
                        </button>
                    </div>
                    <div class="row g-3">
                        <div class="col-12">
                            <label class="form-label">Variant Name</label>
                            <input class="form-control" name="variantNames[]" type="text" required/>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Import Price</label>
                            <input class="form-control" name="variantImportPrices[]" type="number" step="0.01" required/>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Selling Price</label>
                            <input class="form-control" name="variantPrices[]" type="number" step="0.01" required/>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Variant Image</label>
                            <input class="form-control" name="variantImages[]" type="file" accept="image/*" required/>
                        </div>
                        
                        <!-- Sizes -->
                        <div class="col-12">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h6 class="mb-0">Sizes</h6>
                                <button type="button" class="btn btn-phoenix-secondary btn-sm add-size">
                                    <span class="fas fa-plus me-2"></span>Add Size
                                </button>
                            </div>
                            <div class="sizes-container">
                                <!-- Size rows will be added here -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </template>

        <!-- Size Template -->
        <template id="sizeTemplate">
            <div class="size-row row g-3 mb-2">
                <div class="col-md-4">
                    <select class="form-select" name="sizeValues[]" required>
                        <option value="">Select size</option>
                        <c:forEach items="${sizes}" var="size">
                            <option value="${size.id}">${size.value}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3">
                    <input class="form-control" name="quantities[]" type="number" placeholder="Quantity" required/>
                </div>
                <div class="col-md-3">
                    <input class="form-control" name="holdings[]" type="number" placeholder="Holding" value="0" required/>
                </div>
                <div class="col-md-2">
                    <button type="button" class="btn btn-phoenix-danger btn-sm remove-size">
                        <span class="fas fa-trash"></span>
                    </button>
                </div>
            </div>
        </template>

        <jsp:include page="import-js.jsp"/>

        <script>
            $(document).ready(function() {
                // Set active menu
                $('#book-manage').addClass('active');

                // Initialize Choices.js for multiple select
                const categorySelect = new Choices('#categories', {
                    removeItemButton: true,
                    maxItemCount: 5,
                    searchResultLimit: 5,
                    renderChoiceLimit: 5
                });

                // Add variant functionality
                $('#addVariantBtn').on('click', function() {
                    const template = $('#variantTemplate').html();
                    $('#variantsContainer').append(template);
                });

                // Remove variant functionality using event delegation
                $(document).on('click', '.remove-variant', function() {
                    $(this).closest('.variant-item').remove();
                });

                // Add size functionality using event delegation
                $(document).on('click', '.add-size', function() {
                    const template = $('#sizeTemplate').html();
                    $(this).closest('.variant-item').find('.sizes-container').append(template);
                });

                // Remove size functionality using event delegation
                $(document).on('click', '.remove-size', function() {
                    $(this).closest('.size-row').remove();
                });

                // Form validation
                $('#addNewProductForm').on('submit', function(e) {
                    e.preventDefault();
                    
                    // Validate at least one variant
                    if ($('.variant-item').length === 0) {
                        showToast('error', 'Please add at least one variant');
                        return false;
                    }

                    // Validate each variant has at least one size
                    let valid = true;
                    $('.variant-item').each(function() {
                        if ($(this).find('.size-row').length === 0) {
                            valid = false;
                            return false; // break the loop
                        }
                    });

                    if (!valid) {
                        showToast('error', 'Each variant must have at least one size');
                        return false;
                    }

                    this.submit();
                });

                // Add first variant automatically when page loads
                $('#addVariantBtn').trigger('click');
            });
        </script>
    </body>
</html>

