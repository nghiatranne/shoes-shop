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
        <title>Cart Completion</title>

        <jsp:include page="import-css.jsp"/>
    </head>
    <body>
        <main class="main" id="top">
            <jsp:include page="layout/header.jsp"/>

            <jsp:include page="layout/navigation.jsp"/>

            <div class="container-fluid">
                <div class="row flex-center position-relative py-5">
                    <div style="width: 1000px">
                        <div class="card border border-200 auth-card">
                            <div class="card-body pe-md-0">
                                <div class="row align-items-center gx-0 gy-7 p-3">
                                    <h5 class="text-center mb-2">Hey ${sessionScope.uName},</h5>
                                    <h3 class="text-center mt-0 mb-2">Your Order is Confirmed!</h3>
                                    <p class="m-0 text-center">We'll send you a shipping confirmation email as soon as your order ships.</p>
                                    
                                    <div class="d-flex justify-content-center">
                                        <a href="${pageContext.request.contextPath}/orders" class="btn btn-sm btn-earth-red btn-hover w-100 fs--1 fs-sm-0" style="width: 250px !important">
                                            <span class="fas fa-shopping-cart me-2"></span>Check order
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </body>

    <jsp:include page="import-js.jsp"/>
</html>
