<%-- 
    Document   : AddSlider
    Created on : Jun 3, 2024, 9:37:12 AM
    Author     : USA
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Slider Management</title>
        <jsp:include page="import-css.jsp"/>
    </head>
    <body>
        <jsp:include page="layout/navigation.jsp"/>
        <jsp:include page="layout/header-nav.jsp"/>
        
        <div class="content">
            <form id="addNewSlider" method="post" action="" enctype="multipart/form-data">
                <div class="row g-3 flex-between-end mb-5">
                    <div class="col-auto">
                        <h2 class="mb-2">Create New Slider</h2>
                    </div>
                    <div class="col-auto">
                        <button class="btn btn-phoenix-primary me-2 mb-2 mb-sm-0" type="submit">Create Slider</button>
                    </div>
                </div>
                <div class="row g-5">
                    <div class="col-12">
                        <div class="row">
                            <div class="col-6 mb-5">
                                <h4 class="mb-3">Title</h4>
                                <input name="title" id="title" class="form-control" type="text" placeholder="Slider title" />
                            </div>
                            <div class="col-3 mb-5">
                                <h4 class="mb-3">Image</h4>
                                <input name="imageUrl" class="form-control" type="file" accept="image/png, image/jpeg" />
                            </div>
                            <div class="col-3 mb-5">
                                <h4 class="mb-3">Link URL</h4>
                                <input name="linkUrl" id="linkUrl" class="form-control" type="text" placeholder="Link URL" />
                            </div>
                            <div class="col-3 mb-5">
                                <h4 class="mb-3">Start Date</h4>
                                <input name="startDate" id="startDate" class="form-control" type="date" />
                            </div>
                            <div class="col-3 mb-5">
                                <h4 class="mb-3">End Date</h4>
                                <input name="endDate" id="endDate" class="form-control" type="date" />
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <jsp:include page="import-js.jsp"/>
        <script>
            let dashboard_tag = document.getElementById('sliders-manage');
            dashboard_tag.classList.add('active');
        </script>

        <script>
            $(document).ready(function () {
                $("#addNewSlider").validate({
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
                        imageUrl: {
                            required: true,
                            accept: "image/*"
                        },
                        linkUrl: {
                            required: true
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
