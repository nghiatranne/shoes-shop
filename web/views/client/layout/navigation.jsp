<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  <%@ page
        import="model.Category" %> <%@ page import="dao.CategoryDAO" %> <%@ page
        import="model.Category" %> <%@ page import="java.util.List" %><%-- --%><%
        CategoryDAO categoryDAO = new CategoryDAO(); List<Category>
          categories = categoryDAO.listAllCategory(); request.setAttribute("categories",
          categories); %>

            <nav
                class="ecommerce-navbar navbar-expand navbar-light bg-white justify-content-between"
                >
                <div
                    class="container-small d-flex flex-between-center"
                    data-navbar="data-navbar"
                    >
                    <div class="dropdown">
                        <button
                            class="btn text-900 ps-0 pe-5 text-nowrap dropdown-toggle dropdown-caret-none"
                            data-category-btn="data-category-btn"
                            data-bs-toggle="dropdown"
                            >
                            <span class="fas fa-bars me-2"></span>Category
                        </button>
                        <div class="dropdown-menu border py-0 category-dropdown-menu">
                            <div class="card border-0 scrollbar" style="max-height: 657px">
                                <div class="rd-body p-4">
                                    <div class="row gx-7">
                                        <c:forEach var="c" items="${categories}">
                                            <div class="col-12 col-sm-6 col-md-4">
                                                <a
                                                    class="text-black d-block mb-1 text-decoration-none hover-bg-100 px-2 py-1 rounded-2"
                                                    href="${pageContext.request.contextPath}/books?cid=${c.id}"
                                                    >${c.name}</a
                                                >
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <ul class="navbar-nav justify-content-end align-items-center">
                        <li class="nav-item" data-nav-item="data-nav-item">
                            <a
                                class="nav-link ps-0 active me-2"
                                href="${pageContext.request.contextPath}/homepage"
                                >Home</a
                            >
                        </li>
                        <li class="nav-item" data-nav-item="data-nav-item">
                            <a
                                class="nav-link ps-0 active me-2"
                                href="${pageContext.request.contextPath}/orders"
                                >Order</a
                            >
                        </li>
                        <li class="nav-item" data-nav-item="data-nav-item">
                            <a
                                class="nav-link ps-0 active me-2"
                                href="${pageContext.request.contextPath}/blog-list"
                                >Hot New</a
                            >
                        </li>
                        <li class="nav-item" data-nav-item="data-nav-item">
                            <a
                                class="nav-link ps-0 active me-2"
                                href="tel:0395071064"
                                >Contact</a
                            >
                        </li>
                    </ul>
                </div>
            </nav></Category
        >
