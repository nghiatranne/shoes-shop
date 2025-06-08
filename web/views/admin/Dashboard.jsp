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
        <div class="pb-5">
            <div class="row g-4">
                <div class="col-12 col-xxl-12">
                    <div class="mb-8">
                        <h2 class="mb-2">Dashboard</h2>
                    </div>
                    <form method="get" action="${pageContext.request.contextPath}/admin/dashboard">
                        <div class="row align-items-center g-4">
                            <div class="col-6 col-md-3">
                                <label for="startDate" class="form-label">Start Date</label>
                                <input type="date" id="startDate" name="startDate" class="form-control" value="${startDate}">
                            </div>
                            <div class="col-6 col-md-3">
                                <label for="endDate" class="form-label">End Date</label>
                                <input type="date" id="endDate" name="endDate" class="form-control" value="${endDate}">
                            </div>
                            <div class="col-12 col-md-2">
                                <label for=" " class="form-label">&nbsp;</label>
                                <button type="submit" class="btn btn-primary w-100">Filter</button>
                            </div>
                        </div>
                    </form>
                    <div class="row align-items-center g-4 mt-4">
                        <!-- Statistics Row -->
                        <div class="row align-items-center g-4 mt-4">
                            <!-- Order Statistics -->
                            <div class="col-12 col-md-4 col-lg-2">
                                <div class="d-flex align-items-center border border-2 p-3 rounded-3 hover-shadow position-relative" onclick="scrollToSection('order-statistics-section')">
                                    <span class="fas fa-shopping-bag text-primary fs-4"></span>
                                    <div class="ms-3">
                                        <h5 class="mb-0">${orderStats.successOrders} success orders</h5>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-md-4 col-lg-2">
                                <div class="d-flex align-items-center border border-2 p-3 rounded-3 hover-shadow position-relative" onclick="scrollToSection('order-statistics-section')">
                                    <span class="fas fa-times text-primary fs-4"></span>
                                    <div class="ms-3">
                                        <h5 class="mb-0">${orderStats.cancelledOrders} canceled orders</h5>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-md-4 col-lg-2">
                                <div class="d-flex align-items-center border border-2 p-3 rounded-3 hover-shadow position-relative" onclick="scrollToSection('order-statistics-section')">
                                    <span class="fas fa-hourglass-half text-primary fs-4"></span>
                                    <div class="ms-3">
                                        <h5 class="mb-0">${orderStats.submittedOrders} submitted orders</h5>
                                    </div>
                                </div>
                            </div>
                            <!-- Total Revenue -->
                            <div class="col-12 col-md-4 col-lg-2">
                                <div class="d-flex align-items-center border border-2 p-3 rounded-3 hover-shadow position-relative" onclick="scrollToSection('order-statistics-section')">
                                    <span class="fas fa-dollar-sign text-primary fs-4"></span>
                                    <div class="ms-3">
                                        <h5 class="mb-0"><fmt:formatNumber value="${revenueStats.totalRevenue}" type="currency" pattern="###,### ₫"/> total revenue</h5>
                                    </div>
                                </div>
                            </div>
                            <!-- New Registered Customers -->
                            <div class="col-12 col-md-4 col-lg-2">
                                <div class="d-flex align-items-center border border-2 p-3 rounded-3 hover-shadow position-relative" onclick="scrollToSection('customer-statistics-section')">
                                    <span class="fas fa-user-plus text-primary fs-4"></span>
                                    <div class="ms-3">
                                        <h5 class="mb-0">${customerStats.newRegisteredCustomers} new registered customers</h5>
                                    </div>
                                </div>
                            </div>
                            <!-- New Bought Customers -->
                            <div class="col-12 col-md-4 col-lg-2">
                                <div class="d-flex align-items-center border border-2 p-3 rounded-3 hover-shadow position-relative" onclick="scrollToSection('customer-statistics-section')">
                                    <span class="fas fa-shopping-cart text-primary fs-4"></span>
                                    <div class="ms-3">
                                        <h5 class="mb-0">${customerStats.newBoughtCustomers} new bought customers</h5>
                                    </div>
                                </div>
                            </div>
                            <!-- Average Feedback Stars -->
                            <div class="col-12 col-md-4 col-lg-2">
                                <div class="d-flex align-items-center border border-2 p-3 rounded-3 hover-shadow position-relative" onclick="scrollToSection('customer-statistics-section')">
                                    <span class="fas fa-star text-primary fs-4"></span>
                                    <div class="ms-3">
                                        <h5 class="mb-0">${feedbackStats.averageStars} average stars</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div> 
                </div>
            </div>
        </div>
        <!-- Order Statistics Chart -->
        <div id="order-statistics-section" class="mx-n4 px-4 mx-lg-n6 px-lg-6 bg-white pt-6 pb-9 border-top border-300">
            <div class="row g-6">
                <div class="col-12 col-xl-6">
                    <div class="me-xl-4">
                        <div>
                            <h3>Order Statistics</h3>
                        </div>
                        <div id="order-statistics-chart" style="height:500px; width:100%" data-echart-responsive="data-echart-responsive"></div>
                    </div>
                </div>
                <div class="col-12 col-xl-6">
                    <div class="me-xl-4">
                        <div>
                            <h3>Revenue by Category</h3>
                        </div>
                        <div id="revenue-category-chart" style="height:500px; width:100%" data-echart-responsive="data-echart-responsive"></div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Customer Statistics Chart -->
        <div id="customer-statistics-section" class="mx-n4 px-4 mx-lg-n6 px-lg-6 bg-white pt-6 pb-9 border-top border-300">
            <div class="row g-6">
                <div class="col-12 col-xl-6">
                    <div class="me-xl-4">
                        <div>
                            <h3>Customer Statistics</h3>
                        </div>
                        <div id="customer-statistics-chart" style="height:500px; width:100%" data-echart-responsive="data-echart-responsive"></div>
                    </div>
                </div>
                <div class="col-12 col-xl-6">
                    <div class="me-xl-4">
                        <div>
                            <h3>Feedback Statistics</h3>
                        </div>
                        <div id="feedback-statistics-chart" style="height:500px; width:100%" data-echart-responsive="data-echart-responsive"></div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Order Trend Chart -->
        <div id="order-trend-section" class="mx-n4 px-4 mx-lg-n6 px-lg-6 bg-white pt-6 pb-9 border-top border-300">
            <div class="row g-6">
                <div class="col-12 col-xl-12">
                    <div class="me-xl-4">
                        <div>
                            <h3>Order Trend</h3>
                        </div>
                        <div id="order-trend-chart" style="height:500px; width:100%" data-echart-responsive="data-echart-responsive"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="import-js.jsp"/>
<script>
    function scrollToSection(sectionId) {
        document.getElementById(sectionId).scrollIntoView({ behavior: 'smooth' });
    }

    let dashboard_tag = document.getElementById('dashboard-manage');
    dashboard_tag.classList.add('active');

    // Order Statistics Chart
    let orderStatisticsChart = echarts.init(document.getElementById('order-statistics-chart'), 'macarons', {
        renderer: 'canvas',
        useDirtyRect: false
    });

    let orderStatisticsOption = {
        tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b} : {c} ({d}%)'
        },
        legend: {
            top: '5%',
            left: 'center'
        },
        series: [
            {
                name: 'Orders',
                type: 'pie',
                radius: ['40%', '70%'],
                avoidLabelOverlap: true,
                itemStyle: {
                    borderRadius: 10,
                    borderColor: '#fff',
                    borderWidth: 2
                },
                label: {
                    show: false, // Hide labels by default
                    position: 'center'
                },
                emphasis: {
                    label: {
                        show: true,
                        fontSize: '36',
                        fontWeight: 'bold'
                    }
                },
                labelLine: {
                    show: false // Hide label lines by default
                },
                data: [
                    {value: ${orderStats.successOrders}, name: 'Success'},
                    {value: ${orderStats.cancelledOrders}, name: 'Canceled'},
                    {value: ${orderStats.submittedOrders}, name: 'Submitted'}
                ]
            }
        ]
    };

    orderStatisticsChart.setOption(orderStatisticsOption);
    window.addEventListener('resize', orderStatisticsChart.resize);

    // Revenue by Category Chart
    let revenueCategoryChart = echarts.init(document.getElementById('revenue-category-chart'), 'macarons', {
        renderer: 'canvas',
        useDirtyRect: false
    });

    let revenueCategoryData = [
        <c:forEach var="entry" items="${revenueStats.revenueByCategory}">
            { value: ${entry.value}, name: '${entry.key}' }<c:if test="${!entryStatus.last}">,</c:if>
        </c:forEach>
    ];

    let revenueCategoryOption = {
        tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b} : {c} ({d}%)'
        },
        legend: {
            top: '5%',
            left: 'center'
        },
        series: [
            {
                name: 'Revenue by Category',
                type: 'pie',
                radius: ['40%', '70%'],
                avoidLabelOverlap: true,
                itemStyle: {
                    borderRadius: 10,
                    borderColor: '#fff',
                    borderWidth: 2
                },
                label: {
                    show: false, // Hide labels by default
                    position: 'center'
                },
                emphasis: {
                    label: {
                        show: true,
                        fontSize: '36',
                        fontWeight: 'bold'
                    }
                },
                labelLine: {
                    show: false // Hide label lines by default
                },
                data: revenueCategoryData
            }
        ]
    };

    revenueCategoryChart.setOption(revenueCategoryOption);
    window.addEventListener('resize', revenueCategoryChart.resize);

    // Customer Statistics Chart
    let customerStatisticsChart = echarts.init(document.getElementById('customer-statistics-chart'), 'macarons', {
        renderer: 'canvas',
        useDirtyRect: false
    });

    let customerStatisticsOption = {
        tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b} : {c} ({d}%)'
        },
        legend: {
            top: '5%',
            left: 'center'
        },
        series: [
            {
                name: 'Customers',
                type: 'pie',
                radius: ['40%', '70%'],
                avoidLabelOverlap: true,
                itemStyle: {
                    borderRadius: 10,
                    borderColor: '#fff',
                    borderWidth: 2
                },
                label: {
                    show: false, // Hide labels by default
                    position: 'center'
                },
                emphasis: {
                    label: {
                        show: true,
                        fontSize: '26',
                        fontWeight: 'bold'
                    }
                },
                labelLine: {
                    show: false // Hide label lines by default
                },
                data: [
                    {value: ${customerStats.newRegisteredCustomers}, name: 'New Registered'},
                    {value: ${customerStats.newBoughtCustomers}, name: 'New Bought'}
                ]
            }
        ]
    };

    customerStatisticsChart.setOption(customerStatisticsOption);
    window.addEventListener('resize', customerStatisticsChart.resize);

    // Feedback Statistics Chart
    let feedbackStatisticsChart = echarts.init(document.getElementById('feedback-statistics-chart'), 'macarons', {
        renderer: 'canvas',
        useDirtyRect: false
    });

    let feedbackCategoryData = [
        <c:forEach var="entry" items="${averageRatingByCategory}">
            { value: ${entry.value}, name: '${entry.key}' }<c:if test="${!entryStatus.last}">,</c:if>
        </c:forEach>
    ];

    let feedbackStatisticsOption = {
        tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b} : {c} ({d}%)'
        },
        legend: {
            top: '5%',
            left: 'center'
        },
        series: [
            {
                name: 'Feedback',
                type: 'pie',
                radius: ['40%', '70%'],
                avoidLabelOverlap: true,
                itemStyle: {
                    borderRadius: 10,
                    borderColor: '#fff',
                    borderWidth: 2
                },
                label: {
                    show: false, // Hide labels by default
                    position: 'center'
                },
                emphasis: {
                    label: {
                        show: true,
                        fontSize: '26',
                        fontWeight: 'bold'
                    }
                },
                labelLine: {
                    show: false // Hide label lines by default
                },
                data: feedbackCategoryData
            }
        ]
    };

    feedbackStatisticsChart.setOption(feedbackStatisticsOption);
    window.addEventListener('resize', feedbackStatisticsChart.resize);

    // Order Trend
    let orderTrendChart = echarts.init(document.getElementById('order-trend-chart'), 'macarons', {
        renderer: 'canvas',
        useDirtyRect: false
    });

    let orderTrendData = {
        dates: [],
        allOrders: [],
        successOrders: []
    };

    <c:forEach var="trend" items="${orderTrend}">
        orderTrendData.dates.push('${trend.date}');
        orderTrendData.allOrders.push(${trend.allOrders});
        orderTrendData.successOrders.push(${trend.successOrders});
    </c:forEach>

    let orderTrendOption = {
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: ['All Orders', 'Success Orders']
        },
        xAxis: {
            type: 'category',
            data: orderTrendData.dates
        },
        yAxis: {
            type: 'value'
        },
        series: [
            {
                name: 'All Orders',
                type: 'line',
                data: orderTrendData.allOrders
            },
            {
                name: 'Success Orders',
                type: 'line',
                data: orderTrendData.successOrders
            }
        ]
    };

    orderTrendChart.setOption(orderTrendOption);
    window.addEventListener('resize', orderTrendChart.resize);
</script>
</body>
</html>
