<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	.ecommerce-topbar {
		padding-top: 10px;
		padding-bottom: 10px;
	}
	.logo-text {
		font-size: 1.5rem !important;
		font-weight: bold;
	}
	.ecommerce-topbar img[alt="phoenix"] {
		width: 40px !important;
		height: auto;
	}
	.navbar-nav .nav-link,
	.navbar-nav .icon-indicator {
		font-size: 1rem !important;
	}
	.search-input {
		font-size: 1.1rem !important;
		height: 2.5rem !important;
	}
	.search-box-icon {
		font-size: 1.3rem !important;
	}
	.dropdown-profile .card-body h6 {
		font-size: 1.1rem !important;
	}
</style>

<section class="py-0">
	<div class="container-small">
		<div class="ecommerce-topbar">
			<nav class="navbar navbar-expand-lg navbar-light px-0">
				<div class="row gx-0 gy-2 w-100 flex-between-center">
					<div class="col-auto">
						<a
							class="text-decoration-none"
							href="${pageContext.request.contextPath}/homepage"
						>
							<div class="d-flex align-items-center">
								<img src="<c:url
									value="/resources/assets/img/logos/logo.jpg"
								/>" alt="phoenix" width="48" />
								<p class="logo-text ms-2">Shoes Shop</p>
							</div>
						</a>
					</div>
					<div class="col-auto order-md-1">
						<ul class="navbar-nav navbar-nav-icons flex-row me-n2">
							<li class="nav-item">
								<a
									class="nav-link px-2 icon-indicator icon-indicator-primary"
									href="${pageContext.request.contextPath}/cart"
									role="button"
								>
									<span
										class="text-700"
										data-feather="shopping-cart"
										style="height: 24px; width: 24px; margin-right: 16px"
									></span>
									<span class="icon-indicator-number" id="cart_number">0</span>
								</a>
							</li>
							<li class="nav-item dropdown">
								<a
									class="nav-link px-2"
									id="navbarDropdownUser"
									href="#"
									role="button"
									data-bs-toggle="dropdown"
									data-bs-auto-close="outside"
									aria-haspopup="true"
									aria-expanded="false"
								>
									<span
										class="text-700"
										data-feather="user"
										style="height: 24px; width: 24px"
									></span>
								</a>
								<div
									class="dropdown-menu dropdown-menu-end navbar-dropdown-caret py-0 dropdown-profile shadow border border-300 mt-2"
									aria-labelledby="navbarDropdownUser"
								>
									<div class="card position-relative border-0">
										<c:choose>
											<c:when test="${sessionScope.uName != null}">
												<div class="card-body p-0">
													<div class="text-center pt-4 pb-3">
														<h6 class="mt-2 text-black">
															${sessionScope.uName}
														</h6>
													</div>
												</div>
												<div
													class="overflow-auto scrollbar"
													style="height: 10rem"
												>
													<ul class="nav d-flex flex-column mb-2 pb-1">
														<li class="nav-item">
															<a
																class="nav-link px-3"
																href="${pageContext.request.contextPath}/profile"
															>
																<span
																	class="me-2 text-900"
																	data-feather="user"
																></span
																><span>Profile</span>
															</a>
														</li>
														<li class="nav-item">
															<a
																class="nav-link px-3"
																href="${pageContext.request.contextPath}/profile/change-pass"
															>
																<span
																	class="me-2 text-900"
																	data-feather="user"
																></span
																><span>Change Pass</span>
															</a>
														</li>
														<c:if test="${sessionScope.isAdmin}">
															<li class="nav-item">
																<a
																	class="nav-link px-3"
																	href="${pageContext.request.contextPath}/admin/dashboard"
																>
																	<span
																		class="me-2 text-900"
																		data-feather="user"
																	></span
																	><span>Admin Dashboard</span>
																</a>
															</li>
														</c:if>
														<c:if test="${sessionScope.isMaketer}">
															<li class="nav-item">
																<a
																	class="nav-link px-3"
																	href="${pageContext.request.contextPath}/admin/marketer-dashboard"
																>
																	<span
																		class="me-2 text-900"
																		data-feather="book"
																	></span
																	><span>Marketing Dashboard</span>
																</a>
															</li>
														</c:if>
														<c:if test="${sessionScope.isSale}">
															<li class="nav-item">
																<a
																	class="nav-link px-3"
																	href="${pageContext.request.contextPath}/admin/sale-dashboard"
																>
																	<span
																		class="me-2 text-900"
																		data-feather="book"
																	></span
																	><span>Sale Dashboard</span>
																</a>
															</li>
														</c:if>
														<c:if test="${sessionScope.isSaleManager}">
															<li class="nav-item">
																<a
																	class="nav-link px-3"
																	href="${pageContext.request.contextPath}/admin/sale-dashboard"
																>
																	<span
																		class="me-2 text-900"
																		data-feather="book"
																	></span
																	><span>Sale Dashboard</span>
																</a>
															</li>
														</c:if>
														<c:if test="${sessionScope.isWarehouse}">
															<li class="nav-item">
																<a
																	class="nav-link px-3"
																	href="${pageContext.request.contextPath}/admin/orders"
																>
																	<span
																		class="me-2 text-900"
																		data-feather="book"
																	></span
																	><span>Orders confirmed</span>
																</a>
															</li>
														</c:if>
													</ul>
												</div>
												<div class="card-footer p-0 pt-2">
													<div class="px-3 pb-2">
														<a
															onclick="deleteLocalStorage()"
															class="btn btn-phoenix-secondary d-flex flex-center w-100"
															href="${pageContext.request.contextPath}/logout"
														>
															<span class="me-2" data-feather="log-out"> </span
															>Log out</a
														>
													</div>
												</div>
											</c:when>
											<c:otherwise>
												<div class="card-footer p-0 pt-2">
													<div class="px-3 pb-2">
														<a
															class="btn btn-phoenix-secondary d-flex flex-center w-100"
															href="${pageContext.request.contextPath}/login"
														>
															<span class="me-2" data-feather="log-in"></span
															>Login
														</a>
													</div>
												</div>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</li>
						</ul>
					</div>
					<div class="col-12 col-md-6">
						<div class="search-box ecommerce-search-box w-100">
							<form
								class="position-relative m-0"
								action="${pageContext.request.contextPath}/products"
							>
								<input
									class="form-control search-input search form-control-sm"
									type="search"
									style="text-align: center"
									placeholder="Search your shoes here..."
									name="key"
									value="${param.key != null ? param.key : ''}"
									aria-label="Search"
								/>
								<span class="fas fa-search search-box-icon"></span>
							</form>
						</div>
					</div>
				</div>
			</nav>
		</div>
	</div>
</section>
<script>
	const list_item_cart = localStorage.getItem("book_cart_key")
		? JSON.parse(localStorage.getItem("book_cart_key"))
		: [];
	$("#cart_number").empty().append(list_item_cart.length);

	const deleteLocalStorage = () => {
		localStorage.removeItem("book_cart_key");
	};
</script>

<script>
	console.log("OK");
	if ("${sessionScope.uName}" !== null) {
		localStorage.removeItem("book_cart_key");
		fetch("http://localhost:8080/ShoesShop/api/carts")
			.then((res) => res.json())
			.then((data) => {
				localStorage.setItem("product_cart_key", JSON.stringify(data));
				$("#cart_number").empty().append(data.length);
			})
			.catch((error) => {
				console.log(error);
			});
	}
</script>
