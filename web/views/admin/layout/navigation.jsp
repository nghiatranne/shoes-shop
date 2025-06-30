<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-vertical navbar-expand-lg">
	<script>
		var navbarStyle = window.config.config.phoenixNavbarStyle;
		if (navbarStyle && navbarStyle !== "transparent") {
			document.querySelector("body").classList.add(`navbar-${navbarStyle}`);
		}
	</script>
	<div class="collapse navbar-collapse" id="navbarVerticalCollapse">
		<!-- scrollbar removed-->
		<div class="navbar-vertical-content">
			<ul class="navbar-nav flex-column" id="navbarVerticalNav">
				<li class="nav-item">
					<c:if test="${sessionScope.isMaketer == true}">
						<!--Dashboard-->
						<div class="nav-item-wrapper">
							<a
								id="dashboard-manage"
								class="nav-link label-1 p-3"
								href="${pageContext.request.contextPath}/admin/marketer-dashboard"
								role="button"
								data-bs-toggle=""
								aria-expanded="false"
							>
								<div class="d-flex align-items-center">
									<span class="nav-link-icon me-2 fs-4">
										<span data-feather="pie-chart"></span>
									</span>
									<span class="nav-link-text-wrapper">
										<span
											class="nav-link-text fw-semibold"
											style="font-size: 16px"
											>Marketing Dashboard</span
										>
									</span>
								</div>
							</a>
						</div>
						<!--Book management-->
						<div class="nav-item-wrapper">
							<a
								id="book-manage"
								class="nav-link label-1 p-3"
								href="${pageContext.request.contextPath}/admin/books"
								role="button"
								data-bs-toggle=""
								aria-expanded="false"
							>
								<div class="d-flex align-items-center">
									<span class="nav-link-icon me-2 fs-4">
										<span data-feather="book"></span>
									</span>
									<span class="nav-link-text-wrapper">
										<span
											class="nav-link-text fw-semibold"
											style="font-size: 16px"
										>
											Book Management
										</span>
									</span>
								</div>
							</a>
						</div>
						<!--Customer-->
						<div class="nav-item-wrapper">
							<a
								id="customer-manage"
								class="nav-link label-1 p-3"
								href="${pageContext.request.contextPath}/admin/customers"
								role="button"
								data-bs-toggle=""
								aria-expanded="false"
							>
								<div class="d-flex align-items-center">
									<span class="nav-link-icon me-2 fs-4">
										<span data-feather="user"></span>
									</span>
									<span class="nav-link-text-wrapper">
										<span
											class="nav-link-text fw-semibold"
											style="font-size: 16px"
										>
											Customer Management
											<!--Customer-->
										</span>
									</span>
								</div>
							</a>
						</div>
						<!--Feedback-->
						<div class="nav-item-wrapper">
							<a
								id="feedbacks-manage"
								class="nav-link label-1 p-3"
								href="${pageContext.request.contextPath}/admin/feedbacks"
								role="button"
								data-bs-toggle=""
								aria-expanded="false"
							>
								<div class="d-flex align-items-center">
									<span class="nav-link-icon me-2 fs-4">
										<span data-feather="message-square"></span>
									</span>
									<span class="nav-link-text-wrapper">
										<span
											class="nav-link-text fw-semibold"
											style="font-size: 16px"
										>
											Feedback Management
										</span>
									</span>
								</div>
							</a>
						</div>
						<!--Payment management-->
						<div class="nav-item-wrapper">
							<a
								id="payment-manage"
								class="nav-link label-1 p-3"
								href="${pageContext.request.contextPath}/admin/payments"
								role="button"
								data-bs-toggle=""
								aria-expanded="false"
							>
								<div class="d-flex align-items-center">
									<span class="nav-link-icon me-2 fs-4">
										<span data-feather="credit-card"></span>
									</span>
									<span class="nav-link-text-wrapper">
										<span
											class="nav-link-text fw-semibold"
											style="font-size: 16px"
											>Payment Management</span
										>
									</span>
								</div>
							</a>
						</div>
					</c:if>

					<c:if
						test="${sessionScope.isSale == true || sessionScope.isSaleManager == true || sessionScope.isWarehouse == true}"
					>
						<!--Dashboard-->
						<div class="nav-item-wrapper">
							<a
								id="dashboard-manage"
								class="nav-link label-1 p-3"
								href="${pageContext.request.contextPath}/admin/sale-dashboard"
								role="button"
								data-bs-toggle=""
								aria-expanded="false"
							>
								<div class="d-flex align-items-center">
									<span class="nav-link-icon me-2 fs-4">
										<span data-feather="pie-chart"></span>
									</span>
									<span class="nav-link-text-wrapper">
										<span
											class="nav-link-text fw-semibold"
											style="font-size: 16px"
											>Sale Dashboard</span
										>
									</span>
								</div>
							</a>
						</div>

						<!--Slider-->
						<div class="nav-item-wrapper">
							<a
								id="sliders-manage"
								class="nav-link label-1 p-3"
								href="${pageContext.request.contextPath}/admin/sliders"
								role="button"
								data-bs-toggle=""
								aria-expanded="false"
							>
								<div class="d-flex align-items-center">
									<span class="nav-link-icon me-2 fs-4">
										<span data-feather="sliders"></span>
									</span>
									<span class="nav-link-text-wrapper">
										<span
											class="nav-link-text fw-semibold"
											style="font-size: 16px"
										>
											Slider Management
										</span>
									</span>
								</div>
							</a>
						</div>
						<!--Post-->
						<div class="nav-item-wrapper">
							<a
								id="posts-manage"
								class="nav-link label-1 p-3"
								href="${pageContext.request.contextPath}/admin/posts"
								role="button"
								data-bs-toggle=""
								aria-expanded="false"
							>
								<div class="d-flex align-items-center">
									<span class="nav-link-icon me-2 fs-4">
										<span data-feather="file-text"></span>
									</span>
									<span class="nav-link-text-wrapper">
										<span
											class="nav-link-text fw-semibold"
											style="font-size: 16px"
										>
											Post Management
										</span>
									</span>
								</div>
							</a>
						</div>
						<!--Category-->
						<div class="nav-item-wrapper">
							<a
								id="posts-manage"
								class="nav-link label-1 p-3"
								href="${pageContext.request.contextPath}/admin/categories"
								role="button"
								data-bs-toggle=""
								aria-expanded="false"
							>
								<div class="d-flex align-items-center">
									<span class="nav-link-icon me-2 fs-4">
										<span data-feather="tag"></span>
									</span>
									<span class="nav-link-text-wrapper">
										<span
											class="nav-link-text fw-semibold"
											style="font-size: 16px"
										>
											Category Management
										</span>
									</span>
								</div>
							</a>
						</div>
						<!--Brand-->
						<div class="nav-item-wrapper">
							<a
								id="posts-manage"
								class="nav-link label-1 p-3"
								href="${pageContext.request.contextPath}/admin/brands"
								role="button"
								data-bs-toggle=""
								aria-expanded="false"
							>
								<div class="d-flex align-items-center">
									<span class="nav-link-icon me-2 fs-4">
										<span data-feather="package"></span>
									</span>
									<span class="nav-link-text-wrapper">
										<span
											class="nav-link-text fw-semibold"
											style="font-size: 16px"
										>
											Brand Management
										</span>
									</span>
								</div>
							</a>
						</div>
						<!--Size-->
						<div class="nav-item-wrapper">
							<a
								id="posts-manage"
								class="nav-link label-1 p-3"
								href="${pageContext.request.contextPath}/admin/sizes"
								role="button"
								data-bs-toggle=""
								aria-expanded="false"
							>
								<div class="d-flex align-items-center">
									<span class="nav-link-icon me-2 fs-4">
										<span data-feather="crop"></span>
									</span>
									<span class="nav-link-text-wrapper">
										<span
											class="nav-link-text fw-semibold"
											style="font-size: 16px"
										>
											Sizes Management
										</span>
									</span>
								</div>
							</a>
						</div>
						<!--Payment management-->
						<div class="nav-item-wrapper">
							<a
								id="payment-manage"
								class="nav-link label-1 p-3"
								href="${pageContext.request.contextPath}/admin/payments"
								role="button"
								data-bs-toggle=""
								aria-expanded="false"
							>
								<div class="d-flex align-items-center">
									<span class="nav-link-icon me-2 fs-4">
										<span data-feather="credit-card"></span>
									</span>
									<span class="nav-link-text-wrapper">
										<span
											class="nav-link-text fw-semibold"
											style="font-size: 16px"
											>Payment Management</span
										>
									</span>
								</div>
							</a>
						</div>
						<!--Product management-->
						<div class="nav-item-wrapper">
							<a
								id="payment-manage"
								class="nav-link label-1 p-3"
								href="${pageContext.request.contextPath}/admin/products"
								role="button"
								data-bs-toggle=""
								aria-expanded="false"
							>
								<div class="d-flex align-items-center">
									<span class="nav-link-icon me-2 fs-4">
										<span data-feather="box"></span>
									</span>
									<span class="nav-link-text-wrapper">
										<span
											class="nav-link-text fw-semibold"
											style="font-size: 16px"
											>Product Management</span
										>
									</span>
								</div>
							</a>
						</div>
						<!--Order-->
						<div class="nav-item-wrapper">
							<a
								id="order-manage"
								class="nav-link label-1 p-3"
								href="${pageContext.request.contextPath}/admin/orders"
								role="button"
								data-bs-toggle=""
								aria-expanded="false"
							>
								<div class="d-flex align-items-center">
									<span class="nav-link-icon me-2 fs-4">
										<span data-feather="shopping-cart"></span>
									</span>
									<span class="nav-link-text-wrapper">
										<span
											class="nav-link-text fw-semibold"
											style="font-size: 16px"
										>
											Orders Management
											<!--Orders-->
										</span>
									</span>
								</div>
							</a>
						</div>
					</c:if>
					<c:if test="${sessionScope.isAdmin}">
						<!--Dashboard-->
						<div class="nav-item-wrapper">
							<a
								id="dashboard-manage"
								class="nav-link label-1 p-3"
								href="${pageContext.request.contextPath}/admin/dashboard"
								role="button"
								data-bs-toggle=""
								aria-expanded="false"
							>
								<div class="d-flex align-items-center">
									<span class="nav-link-icon me-2 fs-4">
										<span data-feather="pie-chart"></span>
									</span>
									<span class="nav-link-text-wrapper">
										<span
											class="nav-link-text fw-semibold"
											style="font-size: 16px"
											>Admin Dashboard</span
										>
									</span>
								</div>
							</a>
						</div>
						<!--Account management-->
						<div class="nav-item-wrapper">
							<a
								id="account-manage"
								class="nav-link label-1 p-3"
								href="${pageContext.request.contextPath}/admin/accounts"
								role="button"
								data-bs-toggle=""
								aria-expanded="false"
							>
								<div class="d-flex align-items-center">
									<span class="nav-link-icon me-2 fs-4">
										<span data-feather="users"></span>
									</span>
									<span class="nav-link-text-wrapper">
										<span
											class="nav-link-text fw-semibold"
											style="font-size: 16px"
										>
											Account Management
										</span>
									</span>
								</div>
							</a>
						</div>
						<!--Role management-->
						<div class="nav-item-wrapper">
							<a
								id="role-manage"
								class="nav-link label-1 p-3"
								href="${pageContext.request.contextPath}/admin/roles"
								role="button"
								data-bs-toggle=""
								aria-expanded="false"
							>
								<div class="d-flex align-items-center">
									<span class="nav-link-icon me-2 fs-4">
										<span data-feather="shield"></span>
									</span>
									<span class="nav-link-text-wrapper">
										<span
											class="nav-link-text fw-semibold"
											style="font-size: 16px"
										>
											Setting Management
										</span>
									</span>
								</div>
							</a>
						</div>
					</c:if>

					<c:if test="${sessionScope.isWarehouse == true}">
						<div class="nav-item-wrapper">
							<a
								id="book-manage"
								class="nav-link label-1 p-3"
								href="${pageContext.request.contextPath}/admin/books"
								role="button"
								data-bs-toggle=""
								aria-expanded="false"
							>
								<div class="d-flex align-items-center">
									<span class="nav-link-icon me-2 fs-4">
										<span data-feather="book"></span>
									</span>
									<span class="nav-link-text-wrapper">
										<span
											class="nav-link-text fw-semibold"
											style="font-size: 16px"
										>
											Book Management
										</span>
									</span>
								</div>
							</a>
						</div>
					</c:if>
				</li>
			</ul>
		</div>
	</div>
	<div class="navbar-vertical-footer">
		<button
			class="btn navbar-vertical-toggle border-0 fw-semi-bold w-100 white-space-nowrap d-flex align-items-center"
		>
			<span class="uil uil-left-arrow-to-left fs-0"></span
			><span class="uil uil-arrow-from-right fs-0"></span
			><span class="navbar-vertical-footer-text ms-2">Collapsed View</span>
		</button>
	</div>
</nav>
