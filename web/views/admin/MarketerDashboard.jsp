<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: hoaht
  Date: 12/3/2023
  Time: 11:05 PM
  To change this template use File | Settings | File Templates.
--%>
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
                            <div class="row align-items-center g-4">
                                <div class="col-12 col-md-4 col-lg-4 col-xl-3 col-xxl-2">
                                    <a class="text-decoration-none" href="${pageContext.request.contextPath}/admin/posts">
                                        <div class="d-flex align-items-center border border-2 p-3 rounded-3 hover-shadow position-relative">
                                            <span class="far fa-chart-bar text-primary fs-4"></span>
                                            <div class="ms-3">
                                                <h5 class="mb-0">${totalNewPostToday} new post(s)</h5>
                                                <p class="text-800 fs--1 mb-0">Total post: ${totalPost}</p>
                                            </div>
                                            <span class="fa-solid fa-circle text-warning ms-1 new-page-indicator notification-span position-absolute"></span>
                                        </div>
                                    </a>
                                </div>
                                <div class="col-12 col-md-4 col-lg-4 col-xl-3 col-xxl-2">
                                    <a class="text-decoration-none" href="${pageContext.request.contextPath}/admin/books">
                                        <div class="d-flex align-items-center border border-2 p-3 rounded-3 hover-shadow position-lg-relative">
                                            <span class="fas fa-box-open text-primary fs-4"></span>
                                            <div class="ms-3">
                                                <h5 class="mb-0">${totalBookCreateToday} new product(s)</h5>
                                                <p class="text-800 fs--1 mb-0">Total product: ${totalBook}</p>
                                            </div>
                                            <span class="fa-solid fa-circle text-warning ms-1 new-page-indicator notification-span position-absolute"></span>
                                        </div>
                                    </a>
                                </div>
                                <div class="col-12 col-md-4 col-lg-4 col-xl-3 col-xxl-2">
                                    <a class="text-decoration-none" href="${pageContext.request.contextPath}/admin/customers">
                                        <div class="d-flex align-items-center border border-2 p-3 rounded-3 hover-shadow">
                                            <span class="fas fa-users text-primary fs-4"></span>
                                            <div class="ms-3">
                                                <h5 class="mb-0">${totalCustomerToday} new customer(s)</h5>
                                                <p class="text-800 fs--1 mb-0">Total customer: ${totalCustomer}</p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="col-12 col-md-4 col-lg-4 col-xl-3 col-xxl-2">
                                    <a class="text-decoration-none" href="${pageContext.request.contextPath}/admin/feedbacks">
                                        <div class="d-flex align-items-center border border-2 p-3 rounded-3 hover-shadow position-relative">
                                            <span class="far fa-comment-alt text-primary fs-4"></span>
                                            <div class="ms-3">
                                                <h5 class="mb-0">${totalFeedbackToday} new feedback(s)</h5>
                                                <p class="text-800 fs--1 mb-0">Total feedback: ${totalFeedback}</p>
                                            </div>
                                            <span class="fa-solid fa-circle text-warning ms-1 new-page-indicator notification-span position-absolute"></span>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="mx-n4 px-4 mx-lg-n6 px-lg-6 bg-white pt-6 pb-9 border-top border-300">
                    <div class="row g-6">
                        <div class="col-12 col-xl-12">
                            <div class="me-xl-4">
                                <div class="mb-5">
                                    <h3 class="mb-3">Books Trend!</h3>
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
                                <div id="tableExample2" class="mx-n4 px-4 mx-lg-n6 px-lg-6 bg-white border-top border-bottom border-200 position-relative top-1" data-list='{"valueNames":["isbn","title","price","publisher","status","createAt"],"page":5,"pagination":true,"filter":{"key":"status"}}'>
                                    <div class="table-responsive scrollbar mx-n1 px-1">
                                        <table class="table fs--1 mb-0">
                                            <thead>
                                                <tr>
                                                    <th class="white-space-nowrap fs--1 align-middle ps-0" style="width:230px;">IMAGE</th>
                                                    <th class="sort white-space-nowrap fs--1 align-middle ps-3" data-sort="isbn" style="max-width:150px; width: 150px;">ISBN</th>
                                                    <th class="sort white-space-nowrap align-middle ps-4" data-sort="title" scope="col" style="width:525px;">TITLE</th>
                                                    <th class="sort align-middle text-end ps-4" data-sort="price" scope="col" style="width:225px;">PRICE</th>
                                                    <th class="sort align-middle text-end ps-4" data-sort="publisher" scope="col" style="width:150px;">PUBLISHER</th>
                                                    <th class="align-middle ps-3 text-end" scope="col" style="width:250px;">AUTHORS</th>
                                                    <th class="align-middle ps-3" scope="col" style="width:250px;">CATEGORIES</th>
                                                    <th class="sort align-middle ps-3" data-sort="status" scope="col" style="width:200px;">STATUS</th>
                                                    <th class="sort align-middle ps-4" data-sort="createAt" scope="col" style="width:50px;">TOTAL ACCOUNT SAVE TO CART</th>
                                                </tr>
                                            </thead>
                                            <tbody class="list" >
                                                <c:forEach items="${books}" var="b">
                                                    <tr class="product position-static">
                                                        <td class="align-middle white-space-nowrap p-0 py-1">
                                                            <div class="border rounded-2">
                                                                <img class="rounded-2 p-0" src="<c:url value="/resources/book_image/${b.book.image}"/>" width="100%" />
                                                            </div>
                                                        </td>
                                                        <td class="isbn fs--1 align-middle ps-3">
                                                            <a href="books/book?id=${b.book.id}">${b.book.isbn}</a>
                                                        </td>
                                                        <td class="title align-middle ps-4">
                                                            <a class="fw-semi-bold line-clamp-3 mb-0" href="books/book?id=${b.book.id}">
                                                                ${b.book.title}
                                                            </a>
                                                        </td>
                                                        <td class="price align-middle white-space-nowrap text-end fw-bold text-1000 fs--1 ps-4">
                                                            <fmt:formatNumber value="${b.book.price}" type="currency" pattern="###,### ₫"/>
                                                        </td>
                                                        <td class="publisher align-middle white-space-nowrap text-end fw-bold text-1000 fs--1 ps-4">
                                                            ${b.book.publisher.name}
                                                        </td>
                                                        <td class=" align-middle white-space-nowrap text-end fw-bold text-1000 fs-1 ps-4">
                                                            <c:forEach items="${b.book.authors}" var="a">
                                                                <a class="text-decoration-none" href="">
                                                                    <span class="badge badge-tag me-2 mb-2">${a.fullName}</span>
                                                                </a>
                                                            </c:forEach>
                                                        </td>
                                                        <td class=" align-middle review pb-2 ps-3">
                                                            <c:forEach items="${b.book.categories}" var="c">
                                                                <a class="text-decoration-none" href="">
                                                                    <span class="badge badge-tag me-2 mb-2">${c.name}</span>
                                                                </a>
                                                            </c:forEach>
                                                        </td>
                                                        <td class="status align-middle review pb-2 ps-3" style="min-width:225px;">
                                                            <c:choose>
                                                                <c:when test="${b.book.status == true}">
                                                                    <span class="badge badge-phoenix fs--2 badge-phoenix-success">
                                                                        <span class="badge-label">SHOWING</span>
                                                                        <span class="ms-1" data-feather="check" style="height:12.8px;width:12.8px;"></span>
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge badge-phoenix fs--2 badge-phoenix-danger">
                                                                        <span class="badge-label">HIDDEN</span>
                                                                        <span class="ms-1" data-feather="x" style="height:12.8px;width:12.8px;"></span>
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td class="createAt align-middle white-space-nowrap text-600 ps-4">
                                                            ${b.totalAccountAddToCart}
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="d-flex justify-content-center my-3"><button class="page-link" data-list-pagination="prev"><span class="fas fa-chevron-left"></span></button>
                                        <ul class="mb-0 pagination"></ul><button class="page-link pe-0" data-list-pagination="next"><span class="fas fa-chevron-right"></span></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <jsp:include page="import-js.jsp"/>
        <script>
            let dashboard_tag = document.getElementById('dashboard-manage')
            dashboard_tag.classList.add('active')
        </script>

        <script>
            let echart_revenue = document.getElementById('echart-revenue');
            let echart_order = document.getElementById('echart-order');
            let echart_finance = document.getElementById('echart-finance');

            let echart_revenue_init = echarts.init(echart_revenue, 'macarons', {
                renderer: 'canvas',
                useDirtyRect: false
            });
            let echart_order_init = echarts.init(echart_order, 'macarons', {
                renderer: 'canvas',
                useDirtyRect: false
            })
            let echart_finance_init = echarts.init(echart_finance, 'macarons', {
                renderer: 'canvas',
                useDirtyRect: false
            })

            let option_echart_revenue;
            let option_echart_order;
            let option_echart_finance;

            option_echart_revenue = {
                tooltip: {
                    trigger: 'item',
                    axisPointer: {type: 'link'}
                },
                xAxis: {
                    type: 'category',
                    data: [
                        '1/12', '2/12', '3/12', '4/12', '5/12', '6/12', '7/12', '8/12', '9/12', '10/12',
                        '11/12', '12/12', '13/12', '14/12', '15/12', '16/12', '17/12', '18/12', '19/12', '20/12'
                    ],
                },
                yAxis: {
                    type: 'value'
                },
                series: [
                    {
                        itemStyle: {normal: {color: '#dd4b39'}},
                        name: "Price",
                        data: [
                            22000000, 52000000, 23000000, 12000000, 15500000, 17500000, 10500000, 11700000, 2000000, 24350000,
                            22000000, 52000000, 23000000, 12000000, 15500000, 17500000, 10500000, 11700000, 2000000, 24350000
                        ],
                        type: 'bar',
                        barWidth: "50%",
                        smooth: false
                    }
                ]
            };

            option_echart_order = {
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'shadow'
                    }
                },
                legend: {},
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                xAxis: [
                    {
                        type: 'category',
                        data: ['01/12', '02/12', '03/12', '04/12', '05/12', '06/12', '07/12']
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
                    }
                ],
                series: [
                    {
                        name: 'Processing',
                        type: 'bar',
                        itemStyle: {
                            color: 'rgb(229, 120, 11)'
                        },
                        emphasis: {
                            focus: 'series'
                        },
                        data: [320, 332, 301, 334, 390, 330, 320],
                        barWidth: "12%",
                    },
                    {
                        name: 'Packing',
                        type: 'bar',
                        itemStyle: {
                            color: 'rgb(0, 151, 235)'
                        },
                        emphasis: {
                            focus: 'series'
                        },
                        data: [120, 132, 101, 134, 90, 230, 210],
                        barWidth: "12%",
                    },
                    {
                        name: 'Shipped',
                        type: 'bar',
                        itemStyle: {
                            color: 'rgb(49, 55, 74)'
                        },
                        emphasis: {
                            focus: 'series'
                        },
                        data: [220, 182, 191, 234, 290, 330, 310],
                        barWidth: "12%",
                    },
                    {
                        name: 'Refund',
                        type: 'bar',
                        itemStyle: {
                            color: 'rgb(237, 32, 0)'
                        },
                        emphasis: {
                            focus: 'series'
                        },
                        data: [150, 232, 201, 154, 190, 330, 410],
                        barWidth: "12%",
                    },
                    {
                        name: 'Cancle',
                        type: 'bar',
                        itemStyle: {
                            color: '#d54049'
                        },
                        emphasis: {
                            focus: 'series'
                        },
                        data: [150, 232, 201, 154, 190, 330, 410],
                        barWidth: "12%",
                    },
                    {
                        name: 'Completed',
                        type: 'bar',
                        itemStyle: {
                            color: 'rgb(37, 176, 3)'
                        },
                        data: [862, 1018, 964, 1026, 1679, 1600, 1570],
                        emphasis: {
                            focus: 'series'
                        },
                        markLine: {
                            lineStyle: {
                                type: 'dashed'
                            },
                            data: [[{type: 'min'}, {type: 'max'}]]
                        },
                        barWidth: "12%",
                    },
                ]
            };

            let revenue = [22000000, 30000000, 18000000, 32000000, 50000000, 10000000, 46000000];
            let cost = [10000000, 22000000, 10000000, 19000000, 45000000, 15000000, 28000000];
            let profit = [];
            for (let i = 0; i < cost.length; i++) {
                profit.push(revenue[i] - cost[i])
            }
            option_echart_finance = {
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: ['Revenue', 'Cost', 'Profit']
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                xAxis: {
                    type: 'category',
                    boundaryGap: false,
                    data: ['01/12', '02/12', '03/12', '04/12', '05/12', '06/12', '07/12']
                },
                yAxis: {
                    type: 'value'
                },
                series: [
                    {
                        name: 'Revenue',
                        type: 'line',
                        data: revenue,
                        smooth: true,
                        itemStyle: {
                            color: 'rgb(229, 120, 11)'
                        },
                    },
                    {
                        name: 'Cost',
                        type: 'line',
                        data: cost,
                        smooth: true,
                        itemStyle: {
                            color: '#d54049'
                        },
                    },
                    {
                        name: 'Profit',
                        type: 'line',
                        data: profit,
                        smooth: true,
                        itemStyle: {
                            color: 'rgb(37, 176, 3)'
                        },
                    }
                ]
            };

            echart_revenue_init.setOption(option_echart_revenue);
            echart_order_init.setOption(option_echart_order)
            echart_finance_init.setOption(option_echart_finance)

            window.addEventListener('resize', echart_revenue_init.resize);
            window.addEventListener('resize', echart_order_init.resize);
            window.addEventListener('resize', echart_finance_init.resize);
        </script>
    </body>
</html>
