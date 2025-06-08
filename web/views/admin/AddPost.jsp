<%-- 
    Document   : ListPost
    Created on : Jun 1, 2024, 7:48:25 PM
    Author     : hoaht
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Post Manage</title>
        <jsp:include page="import-css.jsp"/>
        <script src="https://cdn.tiny.cloud/1/6qknrgxspgijrkn44j01eecicko6fll7qmlhjdipdvg0lcy4/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
        <script>
            tinymce.init({
                selector: 'textarea',
                menubar: false,
                plugins: 'anchor autolink charmap codesample emoticons image link lists media searchreplace table visualblocks',
                toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table mergetags | addcomment showcomments | spellcheckdialog a11ycheck typography | align lineheight | checklist numlist bullist indent outdent | emoticons charmap | removeformat',
                tinycomments_mode: 'embedded',
                tinycomments_author: 'Author name',
                mergetags_list: [
                    {value: 'First.Name', title: 'First Name'},
                    {value: 'Email', title: 'Email'},
                ],
                ai_request: (request, respondWith) => respondWith.string(() => Promise.reject("See docs to implement AI Assistant")),
            });
        </script>
    </head>
    <body>
        <jsp:include page="layout/navigation.jsp"/>

        <jsp:include page="layout/header-nav.jsp"/>

        <div class="content">
            <form id="addNewPost" method="post" action="" enctype="multipart/form-data">
                <div class="row g-3 flex-between-end mb-5">
                    <div class="col-auto">
                        <h2 class="mb-2">Create New Book</h2>
                    </div>
                    <div class="col-auto">
                        <button class="btn btn-phoenix-primary me-2 mb-2 mb-sm-0" type="submit">Create post</button>
                    </div>
                </div>
                <div class="row g-5">
                    <div class="col-12">
                        <div class="row">
                            <div class="col-6 mb-5">
                                <h4 class="mb-3">Title</h4>
                                <input name="title" id="title" class="form-control" type="text" placeholder="Post title" />
                            </div>
                            <div class="col-3 mb-5">
                                <h4 class="mb-3">Thumbnail</h4>
                                <input name="thumbnail" class="form-control" type="file" accept="image/png, image/jpeg" />
                            </div>
                            <div class="col-3 mb-5">
                                <h4 class="mb-3">Categories</h4>
                                <select class="form-select" name="list_category_choose" id="list_category_choose" multiple="multiple" data-choices="data-choices" multiple="multiple" data-options='{"removeItemButton":true}'>
                                    <c:forEach items="${categories}" var="c">
                                        <option value="${c.id}">${c.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-12 mb-5">
                                <h4 class="mb-3">Content</h4>
                                <c:if test="${invalid_content}">
                                    <div class="invalid-feedback fs-1" style="display: inline-block">Please write content</div>
                                </c:if>
                                <textarea class="tinymce w-100" name="content" required="true" rows="23"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <jsp:include page="import-js.jsp"/>
        <script>
            let dashboard_tag = document.getElementById('posts-manage');
            dashboard_tag.classList.add('active');
        </script>

        <script>
            $(document).ready(function () {
                $("#addNewPost").validate({
                    errorPlacement: function (label, element) {
                        label.addClass('invalid-feedback');
                        label.insertAfter(element);
                    },
                    wrapper: 'div',
                    rules: {
                        title: {
                            required: true,
                            minlength: 20,
                            maxlength: 200
                        },
                        thumbnail: {
                            required: true,
                            accept: "image/*"
                        },
                        content: {
                            required: true,
                        }
                    },
                    messages: {
                    }
                });
            });
        </script>
    </body>
</html>
