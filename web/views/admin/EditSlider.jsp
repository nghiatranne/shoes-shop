<%-- 
    Document   : EditSlider
    Created on : Jun 3, 2024, 9:37:12 AM
    Author     : USA
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Slider</title>
        <jsp:include page="import-css.jsp"/>
    </head>
    <body>
        <jsp:include page="layout/navigation.jsp"/>
        <jsp:include page="layout/header-nav.jsp"/>

        <div class="content">
            <form id="editSliderForm" method="post" action="${pageContext.request.contextPath}/admin/sliders/edit?id=${slider.id}" enctype="multipart/form-data">
                <div class="row g-3 flex-between-end mb-5">
                    <div class="col-auto">
                        <h2 class="mb-2">Edit Slider</h2>
                    </div>
                    <div class="col-auto">
                        <a href="${pageContext.request.contextPath}/admin/sliders" class="btn btn-phoenix-secondary me-2 mb-2 mb-sm-0" type="button">Cancel</a>
                        <button class="btn btn-phoenix-primary me-2 mb-2 mb-sm-0" type="submit">Update Slider</button>
                    </div>
                </div>
                <div class="row g-5">
                    <div class="col-12">
                        <div class="row">
                            <div class="col-6 mb-5">
                                <h4 class="mb-3">Title</h4>
                                <input name="title" id="title" class="form-control" type="text" placeholder="Slider title" value="${slider.title}" />
                                <input name="sliderId" class="form-control d-none" type="hidden" value="${slider.id}" />
                            </div>
                            <div class="col-3 mb-5">
                                <h4 class="mb-3">Current Image</h4>
                                <img class="img-thumbnail w-100" src="<c:url value='/resources/slider_image/${slider.imageUrl}'/>" alt="Current Slider Image" />
                                <input name="old-imageUrl" class="form-control d-none" type="hidden" value="${slider.imageUrl}" />
                            </div>
                            <div class="col-3 mb-5">
                                <h4 class="mb-3">Change Image (optional)</h4>
                                <input id="inputImageUrlField" name="imageUrl" class="form-control" type="file" accept="image/png, image/jpeg" />
                                <input class="form-check-input" id="checkboxInputFile" type="checkbox" name="notUpdateImageUrl" />
                                <label class="form-check-label" for="checkboxInputFile">Don't want to update image!</label>
                            </div>
                            <div class="col-6 mb-5">
                                <h4 class="mb-3">Link URL</h4>
                                <input name="linkUrl" id="linkUrl" class="form-control" type="text" placeholder="Link URL" value="${slider.linkUrl}" />
                            </div>
                            <div class="col-6 mb-5">
                                <h4 class="mb-3">Start Date</h4>
                                <input name="startDate" id="startDate" class="form-control" type="date" value="${slider.startDate}"/>
                            </div>
                            <div class="col-6 mb-5">
                                <h4 class="mb-3">End Date</h4>
                                <input name="endDate" id="endDate" class="form-control" type="date" value="${slider.endDate}"/>
                            </div>
                        </div>
                    </div>
                </div>
                <input type="hidden" name="id" value="${slider.id}" />
            </form>
        </div>

        <jsp:include page="import-js.jsp"/>
        <script>
            let dashboard_tag = document.getElementById('sliders-manage');
            dashboard_tag.classList.add('active');
        </script>

        <script>
            $(document).ready(function () {
                $('#checkboxInputFile').change(function () {
                    if ($('#checkboxInputFile').is(':checked')) {
                        $('#inputImageUrlField').hide();
                    } else {
                        $('#inputImageUrlField').show();
                    }
                });

                $("#editSliderForm").validate({
                    errorPlacement: function (label, element) {
                        label.addClass('invalid-feedback');
                        label.insertAfter(element);
                    },
                    wrapper: 'div',
                    rules: {
                        title: {
                            required: true,
                            minlength: 5,
                            maxlength: 200
                        },
                        linkUrl: {
                            required: true
                        },
                        imageUrl: {
                            required: $('#checkboxInputFile').is(':checked') === false,
                            accept: "image/*"
                        },
                        startDate: {
                            required: true
                        },
                        endDate: {
                            required: true
                        }
                    },
                    messages: {
                    }
                });
            });
        </script>
    </body>
</html>