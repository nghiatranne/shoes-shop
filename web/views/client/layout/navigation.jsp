<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ page
import="model.Category" %> <%@ page import="dao.CategoryDAO" %> <%@ page
import="model.Category" %> <%@ page import="java.util.List" %><%-- --%><%
CategoryDAO categoryDAO = new CategoryDAO(); List<Category>
	categories = categoryDAO.listAllCategory(); request.setAttribute("categories",
	categories); %>

	<nav
		class="ecommerce-navbar navbar-expand navbar-light bg-white justify-content-between mb-2"
		style="height: 50px; position: sticky; top: 0; z-index: 1020"
	>
		<div
			class="container-small d-flex flex-between-center"
			style="height: 50px"
			data-navbar="data-navbar"
		>
			<ul
				class="navbar-nav w-100 d-flex flex-row justify-content-between align-items-center"
				style="width: 100%"
			>
				<li
					class="nav-item flex-fill text-center"
					data-nav-item="data-nav-item"
				>
					<a
						style="
							font-size: 20px;
							font-weight: bold;
							text-transform: uppercase;
						"
						class="nav-link ps-0 active me-2"
						href="${pageContext.request.contextPath}/homepage"
						>Home</a
					>
				</li>
				<li
					class="nav-item flex-fill text-center dropdown position-static"
					onmouseover="this.classList.add('show');this.querySelector('.dropdown-menu').classList.add('show');"
					onmouseout="this.classList.remove('show');this.querySelector('.dropdown-menu').classList.remove('show');"
				>
					<a
						class="nav-link dropdown-toggle"
						href="#"
						id="categoryDropdown"
						role="button"
						data-bs-toggle="dropdown"
						aria-expanded="false"
						style="
							font-size: 20px;
							font-weight: bold;
							text-transform: uppercase;
						"
						>Category</a
					>
					<div
						class="dropdown-menu border py-0 category-dropdown-menu"
						aria-labelledby="categoryDropdown"
					>
						<div class="card border-0 scrollbar" style="max-height: 657px">
							<div class="rd-body p-4">
								<div class="row gx-7">
									<c:forEach var="c" items="${categories}">
										<div class="col-12 col-sm-6 col-md-4">
											<a
												style="font-size: 16px"
												class="text-black d-block mb-1 text-decoration-none hover-bg-100 px-2 py-1 rounded-2"
												href="${pageContext.request.contextPath}/products?category=${c.id}"
												>${c.name}</a
											>
										</div>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</li>
				<li
					class="nav-item flex-fill text-center"
					data-nav-item="data-nav-item"
				>
					<a
						style="
							font-size: 20px;
							font-weight: bold;
							text-transform: uppercase;
						"
						class="nav-link ps-0 active me-2"
						href="${pageContext.request.contextPath}/products"
						>Product</a
					>
				</li>
				<li
					class="nav-item flex-fill text-center"
					data-nav-item="data-nav-item"
				>
					<a
						style="
							font-size: 20px;
							font-weight: bold;
							text-transform: uppercase;
						"
						class="nav-link ps-0 active me-2"
						href="${pageContext.request.contextPath}/orders"
						>Order</a
					>
				</li>
				<li
					class="nav-item flex-fill text-center"
					data-nav-item="data-nav-item"
				>
					<a
						style="
							font-size: 20px;
							font-weight: bold;
							text-transform: uppercase;
						"
						class="nav-link ps-0 active me-2"
						href="${pageContext.request.contextPath}/blog-list"
						>Hot News</a
					>
				</li>
				<li
					class="nav-item flex-fill text-center"
					data-nav-item="data-nav-item"
				>
					<a
						style="
							font-size: 20px;
							font-weight: bold;
							text-transform: uppercase;
						"
						class="nav-link ps-0 active me-2"
						href="tel:0395071064"
						>Contact</a
					>
				</li>
			</ul>
		</div>
	</nav></Category
>
