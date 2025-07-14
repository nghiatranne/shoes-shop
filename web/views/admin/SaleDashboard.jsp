<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Admin Dashboard</title>
        <jsp:include page="import-css.jsp"/>
    </head>
    <body>
        <main class="main" id="top">
            <jsp:include page="layout/navigation.jsp"/>
            <jsp:include page="layout/header-nav.jsp"/>

            <div class="content">
                <div class="row">
                    <div class="col-12">
                        <c:if test="${error_month == true}">
                            <div class="alert alert-soft-warning bg-white border border-warning-500" role="alert">
                                <h4 class="alert-heading fw-semi-bold">Attention!</h4>
                                <p>You can only filter for a period of 3 months</p>
                            </div>
                        </c:if>

                    </div>
                    <div class="col-8 mb-3">
                        <div class="card">
                            <div class="card-header d-flex align-items-center justify-content-between p-3">
                                <h3>Order Statistics ${totalOrder}</h3>
                                <form method="get">
                                    <div class="d-flex align-items-end gap-2">
                                        <div>
                                            <label class="form-label" for="datepicker1">Start Date</label>
                                            <input class="form-control datetimepicker" id="datepicker1" type="text" name="dateFrom" value="${dateFrom}" placeholder="dd/mm/yyyy" data-options='{"disableMobile":true,"dateFormat":"d/m/Y"}' />
                                        </div>

                                        <div>
                                            <label class="form-label" for="datepicker2">Start Date</label>
                                            <input class="form-control datetimepicker" id="datepicker2" type="text" name="dateTo" value="${dateTo}" placeholder="dd/mm/yyyy" data-options='{"disableMobile":true,"dateFormat":"d/m/Y"}' />
                                        </div>

                                        <button class="btn btn-phoenix-primary" type="submit">Filter</button>
                                    </div>
                                </form>
                            </div>
                            <div class="card-body">
                                <div id="revenue-order-chart" style="height:500px; width:100%" data-echart-responsive="data-echart-responsive"></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-4 mb-3 row d-flex justify-content-center">
                        <div class="col-8">
                            <div class="col-12 mb-2">
                                <a class="text-decoration-none">
                                    <div class="d-flex align-items-center justify-content-between border border-2 p-3 rounded-3 hover-shadow position-relative">
                                        <div class="d-flex align-items-center">
                                            <span class="fas fa-shopping-bag text-primary fs-3"></span>
                                            <div class="ms-3">
                                                <h5 class="mb-0">SUBMITTED: <fmt:formatNumber value="${totalOrderByStatusSUBMITTED / totalOrder * 100}" type="number" maxFractionDigits="2"/>%</h5>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-12 mb-2">
                                <a class="text-decoration-none">
                                    <div class="d-flex align-items-center justify-content-between border border-2 p-3 rounded-3 hover-shadow position-relative">
                                        <div class="d-flex align-items-center">
                                            <span class="far fa-check-circle text-primary fs-3"></span>
                                            <div class="ms-3">
                                                <h5 class="mb-0">CONFIRMED: <fmt:formatNumber value="${totalOrderByStatusCONFIRMED / totalOrder * 100}" type="number" maxFractionDigits="2"/>%</h5>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-12 mb-2">
                                <a class="text-decoration-none">
                                    <div class="d-flex align-items-center justify-content-between border border-2 p-3 rounded-3 hover-shadow position-relative">
                                        <div class="d-flex align-items-center">
                                            <span class="fas fa-box-open text-primary fs-3"></span>
                                            <div class="ms-3">
                                                <h5 class="mb-0">PACKAGING: <fmt:formatNumber value="${totalOrderByStatusPACKAGING / totalOrder * 100}" type="number" maxFractionDigits="2"/>%</h5>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-12 mb-2">
                                <a class="text-decoration-none">
                                    <div class="d-flex align-items-center justify-content-between border border-2 p-3 rounded-3 hover-shadow position-relative">
                                        <div class="d-flex align-items-center">
                                            <span class="fas fa-shipping-fast text-primary fs-3"></span>
                                            <div class="ms-3">
                                                <h5 class="mb-0">SHIPPING: <fmt:formatNumber value="${totalOrderByStatusSHIPPING / totalOrder * 100}" type="number" maxFractionDigits="2"/>%</h5>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-12 mb-2">
                                <a class="text-decoration-none">
                                    <div class="d-flex align-items-center justify-content-between border border-2 p-3 rounded-3 hover-shadow position-relative">
                                        <div class="d-flex align-items-center">
                                            <span class="fas fa-dolly text-primary fs-3"></span>
                                            <div class="ms-3">
                                                <h5 class="mb-0">SHIPPED: <fmt:formatNumber value="${totalOrderByStatusSHIPPED / totalOrder * 100}" type="number" maxFractionDigits="2"/>%</h5>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-12 mb-2">
                                <a class="text-decoration-none">
                                    <div class="d-flex align-items-center border border-2 p-3 rounded-3 hover-shadow position-relative">
                                        <span class="fas fa-check text-primary fs-3"></span>
                                        <div class="ms-3">
                                            <h5 class="mb-0">COMPLETED: <fmt:formatNumber value="${totalOrderByStatusCOMPLETED / totalOrder * 100}" type="number" maxFractionDigits="2"/>%</h5>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-12 mb-2">
                                <a class="text-decoration-none">
                                    <div class="d-flex align-items-center border border-2 p-3 rounded-3 hover-shadow position-relative">
                                        <span class="far fa-times-circle text-danger fs-3"></span>
                                        <div class="ms-3">
                                            <h5 class="mb-0 text-danger">CANCELED: <fmt:formatNumber value="${totalOrderByStatusCANCELED / totalOrder * 100}" type="number" maxFractionDigits="2"/>%</h5>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-12">
                                <a class="text-decoration-none">
                                    <div class="d-flex align-items-center border border-2 p-3 rounded-3 hover-shadow position-relative">
                                        <span class="far fa-times-circle text-danger fs-3"></span>
                                        <div class="ms-3">
                                            <h5 class="mb-0 text-danger">REJECTED: <fmt:formatNumber value="${totalOrderByStatusREJECTED / totalOrder * 100}" type="number" maxFractionDigits="2"/>%</h5>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header d-flex align-items-center justify-content-between p-3">
                                <h3>Order Statistics</h3>
                                <form method="get">
                                    <div class="d-flex align-items-end gap-2">
                                        <div>
                                            <label class="form-label" for="seller">Seller</label>
                                            <select class="form-select" id="seller" name="seller" data-choices="data-choices" data-options='{"removeItemButton":true,"placeholder":true}'>
                                                <option value="">Select seller...</option>
                                                <c:forEach items="${listAccountRoleSale}" var="ars">
                                                    <option value="${ars.account.id}" ${ars.account.id == sellerKey ? 'checked' : ''}>${ars.account.fullname}</option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <div>
                                            <label class="form-label" for="status">Status</label>
                                            <select class="form-select" id="status" name="status" data-choices="data-choices" data-options='{"removeItemButton":true,"placeholder":true}'>
                                                <option value="">Select status...</option>
                                                <c:forEach items="${orderStatusesValue}" var="osv">
                                                    <option value="${osv}" ${osv == statusKey ? 'checked' : ''}>${osv}</option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <div>
                                            <label class="form-label" for="datepickerorder1">Start Date</label>
                                            <input class="form-control datetimepicker" id="datepickerorder1" type="text" name="dateFromO" value="${dateFromO}" placeholder="dd/mm/yyyy" data-options='{"disableMobile":true,"dateFormat":"d/m/Y"}' />
                                        </div>

                                        <div>
                                            <label class="form-label" for="datepickerorder2">Start Date</label>
                                            <input class="form-control datetimepicker" id="datepickerorder2" type="text" name="dateToO" value="${dateToO}" placeholder="dd/mm/yyyy" data-options='{"disableMobile":true,"dateFormat":"d/m/Y"}' />
                                        </div>

                                        <button class="btn btn-phoenix-primary" type="submit">Filter</button>
                                    </div>
                                </form>
                            </div>
                            <div class="card-body">
                                <div id="revenue-order-chart2" style="height:500px; width:100%" data-echart-responsive="data-echart-responsive"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <jsp:include page="import-js.jsp"/>
        <script>
            function scrollToSection(sectionId) {
                document.getElementById(sectionId).scrollIntoView({behavior: 'smooth'});
            }

            let dashboard_tag = document.getElementById('dashboard-manage');
            dashboard_tag.classList.add('active');

            // Order Statistics Chart
            let revenueOrderChart = echarts.init(document.getElementById('revenue-order-chart'), 'macarons', {
                renderer: 'canvas',
                useDirtyRect: false
            });

            let revenueOrderChartOption = {
                tooltip: {
                    trigger: 'item'
                },
                legend: {
                    top: '5%',
                    left: 'center'
                },
                series: [
                    {
                        name: 'Access From',
                        type: 'pie',
                        radius: '50%',
                        data: [
                            {value: ${totalOrderByStatusSUBMITTED}, name: 'SUBMITTED ORDER'},
                            {value: ${totalOrderByStatusCONFIRMED}, name: 'CONFIRMED ORDER'},
                            {value: ${totalOrderByStatusPACKAGING}, name: 'PACKAGING ORDER'},
                            {value: ${totalOrderByStatusSHIPPING}, name: 'SHIPPING ORDER'},
                            {value: ${totalOrderByStatusSHIPPED}, name: 'SHIPPED ORDER'},
                            {value: ${totalOrderByStatusCOMPLETED}, name: 'COMPLETED ORDER'},
                            {value: ${totalOrderByStatusCANCELED}, name: 'CANCELED ORDER'},
                            {value: ${totalOrderByStatusREJECTED}, name: 'REJECTED ORDER'}
                        ],
                        emphasis: {
                            itemStyle: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };

            revenueOrderChart.setOption(revenueOrderChartOption);

            let revenueOrderChart2 = echarts.init(document.getElementById('revenue-order-chart2'), 'macarons', {
                renderer: 'canvas',
                useDirtyRect: false
            });

            let data1 = [
            <c:forEach items="${orderRevenues}" var="o" varStatus="status">
            '${o.date}'<c:if test="${!status.last}">,</c:if>
            </c:forEach>
            ];

            let data2 = [
            <c:forEach items="${orderRevenues}" var="o" varStatus="status">
                ${o.totalRevenue}<c:if test="${!status.last}">,</c:if>
            </c:forEach>
            ];

            let revenueOrderChartOption2 = {
                xAxis: {
                    type: 'category',
                    data: data1
                },
                yAxis: {
                    type: 'value'
                },
                series: [
                    {
                        data: data2,
                        type: 'bar'
                    }
                ]
            };

            revenueOrderChart2.setOption(revenueOrderChartOption2);
            window.addEventListener('resize', revenueOrderChart2.resize);
        </script>
    </body>
</html>
