<%-- Document : ListBook Created on : Mar 2, 2024, 3:27:57 AM Author : hoaht
--%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %> <%@page contentType="text/html"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Products List</title>
		<link rel="stylesheet" href="../resources/assets/css/panigation-css.css" />
		<jsp:include page="../import-css.jsp" />
                <style>
        .product-card-container {
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.product-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
}

.product-card {
  background-color: #ffffff;
  border-radius: 1rem;
  padding: 1rem;
  height: 100%;
  border: 1px solid #eee;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.product-name {
  font-size: 1.5rem;
  font-weight: 600;
  color: #355e87; /* tone xanh đậm bạn hay dùng */
  min-height: 2em;
}

.badge-tag {
  background-color: #f0f4f9;
  color: #355e87;
  padding: 0.25rem 0.5rem;
  font-size: 0.5rem;
  border-radius: 0.5rem;
  margin-right: 0.25rem;
}

/*.img-thumbnail {
  border: none;
  border-radius: 0.75rem;
  background-color: #f9f9f9;
  transition: transform 0.3s ease;
}*/

.img-thumbnail:hover {
  transform: scale(1.03);
}

.text-1100 {
  color: #1a1a1a;
  font-weight: bold;
}

.line-clamp-3 {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

    </style>
	</head>
	<body>
		<main class="main" id="top">
			<jsp:include page="header.jsp" />

			<jsp:include page="navigation.jsp" />

			<section class="pt-5 pb-9">
				<div class="container">
					<button
						class="btn btn-sm btn-phoenix-secondary text-700 mb-5 d-lg-none"
						data-phoenix-toggle="offcanvas"
						data-phoenix-target="#productFilterColumn"
					>
						<span class="fa-solid fa-filter me-2"></span>Filter
					</button>
					<div class="row">
						<div class="col-lg-3 col-xxl-2 ps-2">
							<div
								class="product-filter-offcanvas bg-soft scrollbar phoenix-offcanvas phoenix-offcanvas-fixed"
								id="productFilterColumn"
							>
								<form id="filterForm" method="get" action="/ShoesShop/products">
									<div class="d-flex justify-content-between align-items-center mb-3">
										<div class="d-flex align-items-center gap-2">
											<h3 class="mb-0 ms-1">Filters</h3>
											<button type="button" class="btn btn-outline-secondary btn-sm ms-2" id="resetFilterBtn">
												<i class="fa fa-undo"></i> Reset
											</button>
										</div>
										<button class="btn d-lg-none p-0" data-phoenix-dismiss="offcanvas">
											<span class="uil uil-times fs-0"></span>
										</button>
									</div>
									
									<a
										class="btn px-0 ms-1 d-block collapse-indicator"
										data-bs-toggle="collapse"
										href="#collapseColorFamily"
										role="button"
										aria-expanded="true"
										aria-controls="collapseColorFamily"
									>
										<div
											class="d-flex align-items-center justify-content-between w-100"
										>
											<div class="fs-0 text-1000">Category</div>
											<span
												class="fa-solid fa-angle-down toggle-icon text-500"
											></span>
										</div>
									</a>
									<div class="collapse ms-1 show" id="collapseColorFamily">
										<div class="mb-2" id="category-filter-list">
											<c:forEach var="c" items="${categories}">
												<div class="form-check mb-0">
													<input
														class="form-check-input mt-0 category-filter"
														id="cat${c.id}"
														type="checkbox"
														value="${c.id}"
														name="category"
														<c:if test="${not empty param.category}">
															<c:forEach var="catId" items="${paramValues.category}">
																<c:if test="${catId == c.id}">checked</c:if>
															</c:forEach>
														</c:if>
													/>
													<label
														class="form-check-label d-block lh-sm fs-0 text-900 fw-normal mb-0"
														for="cat${c.id}"
														>${c.name}</label
													>
												</div>
											</c:forEach>
										</div>
									</div>
									<a
										class="btn px-0 ms-1 d-block collapse-indicator"
										data-bs-toggle="collapse"
										href="#collapseBrands"
										role="button"
										aria-expanded="true"
										aria-controls="collapseBrands"
									>
										<div
											class="d-flex align-items-center justify-content-between w-100"
										>
											<div class="fs-0 text-1000">Brands</div>
											<span
												class="fa-solid fa-angle-down toggle-icon text-500"
											></span>
										</div>
									</a>
									<div class="collapse ms-1 show" id="collapseBrands">
										<div class="mb-2" id="brand-filter-list">
											<c:forEach var="b" items="${brands}">
												<div class="form-check mb-0">
													<input
														class="form-check-input mt-0 brand-filter"
														id="brand${b.id}"
														type="checkbox"
														value="${b.id}"
														name="brand"
														<c:if test="${not empty param.brand}">
															<c:forEach var="brandId" items="${paramValues.brand}">
																<c:if test="${brandId == b.id}">checked</c:if>
															</c:forEach>
														</c:if>
													/>
													<label
														class="form-check-label d-block lh-sm fs-0 text-900 fw-normal mb-0"
														for="brand${b.id}"
														>${b.name}</label
													>
												</div>
											</c:forEach>
										</div>
									</div>
									<a
										class="btn px-0 ms-1 d-block collapse-indicator"
										data-bs-toggle="collapse"
										href="#collapsePriceRange"
										role="button"
										aria-expanded="true"
										aria-controls="collapsePriceRange"
									>
										<div
											class="d-flex align-items-center justify-content-between w-100"
										>
											<div class="fs-0 text-1000">Price range</div>
											<span
												class="fa-solid fa-angle-down toggle-icon text-500"
											></span>
										</div>
									</a>
									<div class="collapse ms-1 show" id="collapsePriceRange">
										<div class="d-flex justify-content-between mb-3">
											<div class="input-group me-2">
												<input
													class="form-control"
													type="text"
													aria-label="First name"
													placeholder="Min"
													name="minPrice"
													value="${param.minPrice != null ? param.minPrice : ''}"
												/>
												<input
													class="form-control"
													type="text"
													aria-label="Last name"
													placeholder="Max"
													name="maxPrice"
													value="${param.maxPrice != null ? param.maxPrice : ''}"
												/>
											</div>
											<button
												class="btn btn-phoenix-primary border-300 px-3"
												type="submit"
												id="priceGoBtn"
											>
												Go
											</button>
										</div>
									</div>
									<a
										class="btn px-0 y-4 ms-1 d-block collapse-indicator"
										data-bs-toggle="collapse"
										href="#collapseRating"
										role="button"
										aria-expanded="true"
										aria-controls="collapseRating"
									>
										<div
											class="d-flex align-items-center justify-content-between w-100"
										>
											<div class="fs-0 text-1000">Rating</div>
											<span
												class="fa-solid fa-angle-down toggle-icon text-500"
											></span>
										</div>
									</a>
									<div class="collapse ms-1 show" id="collapseRating">
										<div class="d-flex align-items-center mb-1">
											<input
												class="form-check-input me-3"
												id="ratingAll"
												type="radio"
												name="rating"
												value="all"
												<c:if test="${empty param.rating || param.rating == 'all'}">checked</c:if>
											/><label class="form-check-label" for="ratingAll"
												>All</label
											>
										</div>
										<div class="d-flex align-items-center mb-1">
											<input
												class="form-check-input me-3"
												id="flexRadio1"
												type="radio"
												name="rating"
												value="5"
												<c:if test="${param.rating == '5'}">checked</c:if>
											/><span class="fa fa-star text-warning fs--1 me-1"></span
											><span class="fa fa-star text-warning fs--1 me-1"></span
											><span class="fa fa-star text-warning fs--1 me-1"></span
											><span class="fa fa-star text-warning fs--1 me-1"></span
											><span class="fa fa-star text-warning fs--1 me-1"></span>
										</div>
										<div class="d-flex align-items-center mb-1">
											<input
												class="form-check-input me-3"
												id="flexRadio2"
												type="radio"
												name="rating"
												value="4"
												<c:if test="${param.rating == '4'}">checked</c:if>
											/><span class="fa fa-star text-warning fs--1 me-1"></span
											><span class="fa fa-star text-warning fs--1 me-1"></span
											><span class="fa fa-star text-warning fs--1 me-1"></span
											><span class="fa fa-star text-warning fs--1 me-1"></span
											><span
												class="fa-regular fa-star text-warning-300 fs--1 me-1"
											></span>
											<p class="ms-1 mb-0">&amp; above</p>
										</div>
										<div class="d-flex align-items-center mb-1">
											<input
												class="form-check-input me-3"
												id="flexRadio3"
												type="radio"
												name="rating"
												value="3"
												<c:if test="${param.rating == '3'}">checked</c:if>
											/><span class="fa fa-star text-warning fs--1 me-1"></span
											><span class="fa fa-star text-warning fs--1 me-1"></span
											><span class="fa fa-star text-warning fs--1 me-1"></span
											><span
												class="fa-regular fa-star text-warning-300 fs--1 me-1"
											></span
											><span
												class="fa-regular fa-star text-warning-300 fs--1 me-1"
											></span>
											<p class="ms-1 mb-0">&amp; above</p>
										</div>
										<div class="d-flex align-items-center mb-1">
											<input
												class="form-check-input me-3"
												id="flexRadio4"
												type="radio"
												name="rating"
												value="2"
												<c:if test="${param.rating == '2'}">checked</c:if>
											/><span class="fa fa-star text-warning fs--1 me-1"></span
											><span class="fa fa-star text-warning fs--1 me-1"></span
											><span
												class="fa-regular fa-star text-warning-300 fs--1 me-1"
											></span
											><span
												class="fa-regular fa-star text-warning-300 fs--1 me-1"
											></span
											><span
												class="fa-regular fa-star text-warning-300 fs--1 me-1"
											></span>
											<p class="ms-1 mb-0">&amp; above</p>
										</div>
										<div class="d-flex align-items-center mb-3">
											<input
												class="form-check-input me-3"
												id="flexRadio5"
												type="radio"
												name="rating"
												value="1"
												<c:if test="${param.rating == '1'}">checked</c:if>
											/><span class="fa fa-star text-warning fs--1 me-1"></span
											><span
												class="fa-regular fa-star text-warning-300 fs--1 me-1"
											></span
											><span
												class="fa-regular fa-star text-warning-300 fs--1 me-1"
											></span
											><span
												class="fa-regular fa-star text-warning-300 fs--1 me-1"
											></span
											><span
												class="fa-regular fa-star text-warning-300 fs--1 me-1"
											></span>
											<p class="ms-1 mb-0">&amp; above</p>
										</div>
									</div>
								</form>
							</div>
							<div
								class="phoenix-offcanvas-backdrop d-lg-none"
								data-phoenix-backdrop
							></div>
						</div>
						<div class="col-lg-9 col-xxl-10">
							<div class="row gx-3 gy-6 mb-8">
								<c:forEach items="${products}" var="p">
									<c:if test="${p.status == true}">
										<div class="col-4">
											<div class="product-card-container h-100">
												<div class="position-relative text-decoration-none product-card h-100">
													<div class="d-flex flex-col flex-wrap align-items-center h-100 gap-2">
														<div>
															<div class="border border-1 rounded-3 position-relative mb-3">
																<img style="height: 240px;object-fit: contain;" class="img-thumbnail" src="<c:url value='/resources/product_image/${p.image}'/>" alt=""/>
															</div>
															<a class="stretched-link text-decoration-none" href="${pageContext.request.contextPath}/products/product-detail?id=${p.id}"></a>
														</div>
														<div>
															<h5 class="lh-sm line-clamp-3 product-name">
																${p.title}
															</h5>
															<p class="mb-2" style="width: 100%">
																<c:forEach items="${p.categories}" var="c">
																	<a class="text-decoration-none" href="">
																		<span class="badge badge-tag">${c.name}</span>
																	</a>
																</c:forEach>
															</p>
															<div class="d-flex align-items-center mb-1">
																<h4 class="text-1100 mb-0">
																	<c:if test="${not empty p.productvariants}">
																		<fmt:formatNumber value="${p.productvariants[0].price}" type="currency" pattern="###,### ₫"/>
																	</c:if>
																</h4>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</div>
							<!--paginate-->
							<c:if test="${requestScope.numPages > 1}">
								<div class="pagination">
									<c:forEach begin="1" end="${requestScope.numPages}" var="i">
										<c:url value="/books/new-book" var="url">
											<c:param name="page" value="${i}" />
										</c:url>
										<c:choose>
											<c:when test="${i eq requestScope.currentPage}">
												<a href="${url}" class="active">${i}</a>
											</c:when>
											<c:otherwise>
												<a href="${url}">${i}</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</div>
							</c:if>
						</div>
					</div>
				</div>
				<!-- end of .container-->
			</section>
		</main>
	</body>

	<jsp:include page="../import-js.jsp" />

	<script>
		const addToCart = (book_isbn, id) => {
			$.ajax({
				url: "http://localhost:8080/BookShopping/api/cart/add?book_id=" + id,
				type: "POST",
				contentType: "application/json",
				dataType: "json",
				error: function (xhr, status, error) {
					if (xhr.status === 200) {
						showToast("Add new book to cart success!");
						let list_item_cart = [];

						if (localStorage.getItem("book_cart_key")) {
							list_item_cart = JSON.parse(
								localStorage.getItem("book_cart_key")
							);

							let isHas = false;

							list_item_cart.forEach((item, index) => {
								if (item.book_isbn === book_isbn) {
									list_item_cart[index].quantity += 1;
									isHas = true;
								}
							});

							if (!isHas)
								list_item_cart.push({ book_isbn: book_isbn, quantity: 1 });
						} else {
							list_item_cart.push({ book_isbn: book_isbn, quantity: 1 });
						}

						$("#cart_number").empty().append(list_item_cart.length);
						localStorage.setItem(
							"book_cart_key",
							JSON.stringify(list_item_cart)
						);
					}
					if (xhr.status === 403) showToast("You need to login to buy book!");
					return;
				},
			});
		};

		// Chỉ submit form khi nhấn Go ở Price Filter, các filter khác vẫn auto submit
		$(document).ready(function() {
			// Ngăn không cho input price tự động submit khi thay đổi
			$('#filterForm input[name="minPrice"], #filterForm input[name="maxPrice"]').on('change', function(e) {
				e.stopPropagation();
			});
			// Các filter khác vẫn auto submit
			$('#filterForm input').not('[name="minPrice"]').not('[name="maxPrice"]').on('change', function() {
				$('#filterForm').submit();
			});
			// Nhấn Go mới submit form cho price
			$('#priceGoBtn').on('click', function() {
				$('#filterForm').submit();
			});
			// Nút reset filter
			$('#resetFilterBtn').on('click', function() {
				window.location.href = window.location.pathname;
			});
		});
	</script>
</html>
