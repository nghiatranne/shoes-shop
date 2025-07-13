<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%@taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@page
contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>${detail_product.title}</title>
		<jsp:include page="../import-css.jsp" />
		<style>
                    .header-info {
    display: flex;
    align-items: center;
    gap: 12px; /* khoảng cách giữa avatar và phần chữ */
    margin-bottom: 10px;
}

.avatar {
    width: 48px;
    height: 48px;
    border-radius: 50%;
    object-fit: cover;
    flex-shrink: 0; /* giữ kích thước cố định */
}

.info .name {
    font-weight: bold;
}

.info .date {
    font-size: 0.875rem;
    color: #6c757d;
}
                    .product-detail {
  margin-bottom: 2rem;
}

.product-detail h3 {
  font-size: 1.75rem;
  line-height: 1.4;
  margin-bottom: 1rem;
}

.product-price-range, #variant-price {
  font-size: 2.5rem;
  font-weight: bold;
  color: #007bff;
  margin-bottom: 1.2rem;
  margin-top: 0.5rem;
  display: block;
}

.product-stock-status {
  font-size: 1.2rem;
  color: #28a745;
  font-weight: 600;
  margin-bottom: 1rem;
}

.product-meta {
  margin-bottom: 1rem;
}

.product-meta p {
  margin-bottom: 0.3rem;
  font-size: 1rem;
}

.product-size-guide {
  display: inline-block;
  margin-top: 1rem;
  font-size: 1rem;
  color: #007bff;
}

.product-size-guide i {
  margin-right: 0.5rem;
}
			.rating-summary {
				display: flex;
				align-items: center;
				margin-bottom: 20px;
				font-size: 1.2rem;
			}

			.rating-summary .average-rating {
				font-size: 3rem;
				font-weight: bold;
				color: #ff6f00;
				margin-right: 20px;
			}

			.rating-summary .rating-stars {
				font-size: 1.5rem;
				color: #ffca28;
				margin-right: 10px;
			}

			.rating-summary .total-reviews {
				color: #555;
			}

			.rating-distribution {
				margin-bottom: 20px;
			}

			.rating-distribution .rating-bar {
				display: flex;
				align-items: center;
				margin-bottom: 5px;
			}

			.rating-distribution .rating-bar span {
				min-width: 50px;
				text-align: right;
				margin-right: 10px;
			}

			.rating-distribution .rating-bar .bar {
				flex: 1;
				height: 10px;
				background-color: #ddd;
				margin: 0 10px;
				position: relative;
				border-radius: 5px;
				overflow: hidden;
			}

			.rating-distribution .rating-bar .bar-fill {
				height: 100%;
				background-color: #ff6f00;
				position: absolute;
				top: 0;
				left: 0;
			}

			.feedback-section {
				margin-top: 40px;
			}

			.feedback-section h3 {
				margin-bottom: 20px;
				font-size: 1.5rem;
				font-weight: bold;
			}

			.feedback-section .feedback {
				display: flex;
				align-items: flex-start;
				margin-bottom: 20px;
				padding-bottom: 20px;
				border-bottom: 1px solid #ddd;
			}

			.feedback-section .feedback .content1 {
				flex: 1;
				margin-left: 20px;
			}

			.feedback-section .feedback .content1 .name {
				font-weight: bold;
				font-size: 1.2rem;
			}

			.feedback-section .feedback .content1 .date {
				color: #999;
				font-size: 0.9rem;
				margin-bottom: 10px;
			}

			.feedback-section .feedback .content1 .text {
				margin-top: 10px;
				font-size: 1rem;
				color: #333;
			}

			.feedback-section .feedback .content1 .rating-stars {
				color: #ffca28;
				padding: 0;
			}

			.feedback-section .feedback .content1 .rating-stars .far {
				color: #ccc;
			}

			.feedback-section .feedback .content1 img {
				max-width: 200px;
				height: auto;
				margin-top: 10px;
				border-radius: 5px;
			}

			.book-detail img {
				width: 100%;
				height: auto;
				border-radius: 5px;
			}

			.container-small {
				max-width: 1200px;
				margin: auto;
				padding: 0 15px;
			}

			#variant-stock {
				font-size: 1.3rem;
				color: #28a745;
				font-weight: 600;
				margin-bottom: 1rem;
				margin-top: 0.5rem;
				display: block;
			}
		</style>
	</head>
	<body>
		<!-- ===============================================-->
		<!--    Main Content-->
		<!-- ===============================================-->
		<main class="main" id="top">
			<!-- ============================================-->
			<!-- <section> begin ============================-->

			<!-- <section> close ============================-->
			<!-- ============================================-->

			<%@include file="header.jsp" %> <%@include file="navigation.jsp" %>

			<div class="pt-5 pb-9">
				<!-- ============================================-->
				<!-- <section> begin ============================-->
				<section class="py-0">
					<div class="container-small">
						<nav class="mb-3" aria-label="breadcrumb">
							<ol class="breadcrumb mb-0">
								<li class="breadcrumb-item"><a href="/products">Shoes</a></li>

								<li class="breadcrumb-item active" aria-current="page">
									${detail_product.title}
								</li>
							</ol>
						</nav>
						<div
							class="row g-5 mb-5 mb-lg-8"
							data-product-details="data-product-details"
						>
							<div class="col-12 col-lg-6">
								<div class="row g-3 mb-3">
									<div class="col-12">
										<!-- Swiper ảnh sản phẩm -->
										<div class="swiper-container product-image-swiper">
											<div class="swiper-wrapper">
												<div class="swiper-slide">
													<img src="../resources/product_image/${detail_product.image}" alt="${detail_product.title}" class="img-fluid rounded border" style="height: 600px; width: 600px; object-fit: contain;" />
												</div>
												<c:forEach items="${detail_product.productvariants}" var="variant">
													<c:if test="${not empty variant.image}">
														<div class="swiper-slide">
															<img src="../resources/product_image/${variant.image}" alt="${variant.name}" class="img-fluid rounded border" style="height: 600px; width: 600px; object-fit: contain;" />
														</div>
													</c:if>
												</c:forEach>
											</div>
											<div class="swiper-button-next"></div>
											<div class="swiper-button-prev"></div>
											<div class="swiper-pagination"></div>
										</div>
									</div>
								</div>
<!--								<div class="d-flex">
									<button
										class="btn btn-lg btn-outline-warning rounded-pill w-100 me-3 px-2 px-sm-4 fs--1 fs-sm-0"
									>
										<span class="me-2 far fa-heart"></span>Add to wishlist</button
									><button
										class="btn btn-lg btn-warning rounded-pill w-100 fs--1 fs-sm-0"
									>
										<span class="fas fa-shopping-cart me-2"></span>Add to cart
									</button>
								</div>-->
							</div>
							<div class="col-12 col-lg-6">
								<div class="d-flex flex-column justify-content-between h-100">
									<div>
										<div class="d-flex flex-wrap">
											<p class="text-primary fw-semi-bold mb-2">
												${allFeedbacks.size()} People rated and reviewed
											</p>
										</div>
										<div class="product-detail">
											<!-- Giá và số lượng -->
											<div id="variant-info">
												<c:choose>
													<c:when test="${not empty selected_variant_id}">
														<c:forEach items="${detail_product.productvariants}" var="variant">
															<c:if test="${variant.id == selected_variant_id}">
																<h3 id="variant-title">${variant.name}</h3>
																<div id="variant-price" class="product-price-range">
																	<span><fmt:formatNumber value="${variant.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></span>
																</div>
																<div id="variant-stock">
																	In stock: <span id="stock-value">
																		<c:set var="stock" value="${not empty variant.productvariantsizes ? variant.productvariantsizes[0].quantityInStock - variant.productvariantsizes[0].quantityHolding : 0}" />
																		${stock}
																	</span>
																</div>
															</c:if>
														</c:forEach>
													</c:when>
													<c:otherwise>
														<h3 id="variant-title">${detail_product.title}</h3>
														<div id="variant-price" class="product-price-range">
															Price: <span>
															<c:set var="minPrice" value="${Double.MAX_VALUE}" />
															<c:set var="maxPrice" value="${0.0}" />
															<c:forEach items="${detail_product.productvariants}" var="variant">
																<c:if test="${variant.status == true}">
																	<c:if test="${variant.price < minPrice}">
																		<c:set var="minPrice" value="${variant.price}" />
																	</c:if>
																	<c:if test="${variant.price > maxPrice}">
																		<c:set var="maxPrice" value="${variant.price}" />
																	</c:if>
																</c:if>
															</c:forEach>
															<c:if test="${minPrice != Double.MAX_VALUE}">
																<fmt:formatNumber value="${minPrice}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
																<c:if test="${minPrice != maxPrice}">
																	- <fmt:formatNumber value="${maxPrice}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
																</c:if>
															</c:if>
															</span>
														</div>
														<div id="variant-stock">
															In stock: <span id="stock-value">
																<c:set var="stock" value="${not empty detail_product.productvariants[0].productvariantsizes ? detail_product.productvariants[0].productvariantsizes[0].quantityInStock - detail_product.productvariants[0].productvariantsizes[0].quantityHolding : 0}" />
																${stock}
															</span>
														</div>
													</c:otherwise>
												</c:choose>
											</div>
											<div class="product-meta">
												<p><strong>Categories:</strong>
													<c:forEach items="${detail_product.categories}" var="category" varStatus="loop">
														${category.name}${!loop.last ? ', ' : ''}
													</c:forEach>
												</p>
												<p><strong>Brand:</strong> ${detail_product.brand.name}</p>
											</div>
										</div>
										<form id="addToCartForm" action="add-to-cart" method="POST">
											<input type="hidden" name="productId" value="${detail_product.id}">
											<input type="hidden" name="variantId" id="selected-variant-id">
											<!-- Danh sách variant (color/option) -->
											<div class="mb-3">
												<p class="fw-semi-bold mb-2 text-900">Color :</p>
												<div class="d-flex product-variants-list" id="variant-list">
													<c:forEach items="${detail_product.productvariants}" var="variant" varStatus="loop">
														<c:choose>
															<c:when test="${not empty selected_variant_id && variant.id == selected_variant_id}">
																<button type="button" class="btn btn-outline-primary me-2 variant-btn active" data-variant-index="${loop.index}" data-variant-id="${variant.id}">${variant.name}</button>
															</c:when>
															<c:otherwise>
																<button type="button" class="btn btn-outline-primary me-2 variant-btn" data-variant-index="${loop.index}" data-variant-id="${variant.id}">${variant.name}</button>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</div>
											</div>
											<div class="row g-3 g-sm-5 align-items-end">
												<div class="col-12 col-sm-auto">
													<p class="fw-semi-bold mb-2 text-900">Size :</p>
													<div class="d-flex align-items-center">
														<select class="form-select w-auto" id="size-select" name="size">
															<c:choose>
																<c:when test="${not empty selected_variant_id}">
																	<c:forEach items="${detail_product.productvariants}" var="variant">
																		<c:if test="${variant.id == selected_variant_id}">
																			<c:forEach items="${variant.productvariantsizes}" var="size">
																				<c:set var="stock" value="${size.quantityInStock - size.quantityHolding}" />
																				<option value="${size.size.id}" <c:if test="${stock <= 0}">disabled</c:if>>
																					${size.size.value} <c:if test="${stock <= 0}">(Hết hàng)</c:if>
																				</option>
																			</c:forEach>
																		</c:if>
																	</c:forEach>
																</c:when>
																<c:otherwise>
																	<c:forEach items="${detail_product.productvariants[0].productvariantsizes}" var="size">
																		<c:set var="stock" value="${size.quantityInStock - size.quantityHolding}" />
																		<option value="${size.size.id}" <c:if test="${stock <= 0}">disabled</c:if>>
																			${size.size.value} <c:if test="${stock <= 0}">(Hết hàng)</c:if>
																		</option>
																	</c:forEach>
																</c:otherwise>
															</c:choose>
														</select>
													</div>
												</div>
												<div class="col-12 col-sm">
													<p class="fw-semi-bold mb-2 text-900">Quantity :</p>
													<div class="d-flex justify-content-between align-items-end">
														<div class="d-flex flex-between-center" data-quantity="data-quantity">
															<button type="button" class="btn btn-phoenix-primary px-3 quantity-btn" data-type="minus">
																<span class="fas fa-minus"></span>
															</button>
															<input class="form-control text-center input-spin-none bg-transparent border-0 outline-none"
																style="width: 50px" type="text" min="1" value="1" id="quantity-input" name="quantity"/>
															<button type="button" class="btn btn-phoenix-primary px-3 quantity-btn" data-type="plus">
																<span class="fas fa-plus"></span>
															</button>
														</div>
													</div>
												</div>
											</div>
											<div class="d-flex mt-4">
												<button type="button" class="btn btn-lg btn-outline-warning rounded-pill w-100 me-3 px-2 px-sm-4 fs--1 fs-sm-0">
													<span class="me-2 far fa-heart"></span>Add to wishlist
												</button>
												<button type="submit" class="btn btn-lg btn-warning rounded-pill w-100 fs--1 fs-sm-0">
													<span class="fas fa-shopping-cart me-2"></span>Add to cart
												</button>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- end of .container-->
				</section>
				<!-- <section> close ============================-->
				<!-- ============================================-->

				<!-- ============================================-->
				<!-- <section> begin ============================-->
				<section class="py-0">
					<div class="container-small">
						<ul class="nav nav-underline mb-4" id="productTab" role="tablist">
							<li class="nav-item mx-3">
								<a
									class="nav-link active"
									id="description-tab"
									data-bs-toggle="tab"
									href="#tab-description"
									role="tab"
									aria-controls="tab-description"
									aria-selected="true"
									>Description</a
								>
							</li>

							<li class="nav-item mx-3">
								<a
									class="nav-link"
									id="reviews-tab"
									data-bs-toggle="tab"
									href="#tab-reviews"
									role="tab"
									aria-controls="tab-reviews"
									aria-selected="false"
									>Ratings &amp; reviews</a
								>
							</li>
						</ul>
						<div class="row gx-3 gy-7">
							<div class="col-12 col-lg-7 col-xl-8">
								<div
									class="tab-content"
									id="productTabContent"
									style="height: 1200px"
								>
									<div
										class="tab-pane pe-lg-6 pe-xl-12 fade show active text-1100"
										id="tab-description"
										role="tabpanel"
										aria-labelledby="description-tab"
									>
										<p class="mb-5">${detail_product.description}</p>
										<a
											href="../../../assets/img/products/23.png"
											data-gallery="gallery-description"
											><img
												class="img-fluid mb-5 rounded-3"
												src="../../../assets/img/products/23.png"
												alt=""
										/></a>
									</div>

									<div
										class="tab-pane fade"
										id="tab-reviews"
										role="tabpanel"
										aria-labelledby="reviews-tab"
									>
										<%-- Phần hiển thị rating trung bình --%>
										<div class="bg-white rounded-3 p-4 border border-200">
											<div class="row g-3 justify-content-between mb-4">
												<div class="col-auto">
													<div class="d-flex align-items-center flex-wrap">
														<h2 class="fw-bolder me-3">
															<fmt:formatNumber value="${avgRating}" maxFractionDigits="1"/>
															<span class="fs-0 text-500 fw-bold">/5</span>
														</h2>
														<div class="me-3">
															<c:forEach var="i" begin="1" end="5">
																<span class="fa fa-star <c:if test='${i > avgRating}'>text-secondary</c:if> text-warning fs-2"></span>
															</c:forEach>
														</div>
														<p class="text-900 mb-0 fw-semi-bold fs-1">
															<c:out value="${allFeedbacks.size()}"/> ratings &amp; reviews
														</p>
													</div>
												</div>
											</div>
											<div class="feedback-section">
												<h3>Customer Feedback</h3>
												<c:set var="pageSize" value="5"/>
												<c:set var="page" value="${param.page != null ? param.page : 1}"/>
												<c:set var="start" value="${(page-1)*pageSize}"/>
												<c:set var="end" value="${start+pageSize > allFeedbacks.size() ? allFeedbacks.size() : start+pageSize}"/>
												<c:forEach var="fb" items="${allFeedbacks}" varStatus="loop">
													<c:if test="${loop.index >= start && loop.index < end}">
														<div class="feedback mb-4 hover-actions-trigger btn-reveal-trigger">
															<div class="content1">
    <div class="header-info">
        <img src="https://ui-avatars.com/api/?name=${fb.accountName}&background=0D8ABC&color=fff" alt="Avatar" class="avatar" style="margin: 0px !important">
        <div class="info">
            <div class="name">
                ${fb.accountName}
                <span class="badge bg-info">${fb.productVariantName}</span>
            </div>
            <div class="date">
                <fmt:formatDate value="${fb.createDate}" pattern="dd/MM/yyyy"/>
            </div>
        </div>
    </div>

    <div class="rating-stars">
        <c:forEach var="i" begin="1" end="5">
            <c:choose>
                <c:when test="${i <= fb.ratedStar}">
                    <span class="fa fa-star text-warning"></span>
                </c:when>
                <c:otherwise>
                    <span class="fa fa-star text-secondary"></span>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>

    <div class="text">${fb.content}</div>

    <c:if test="${not empty fb.image}">
        <img src="../resources/feedback_image/${fb.image}" alt="Feedback image"/>
    </c:if>
</div>

														</div>
													</c:if>
												</c:forEach>
												<nav aria-label="Feedback pagination">
													<ul class="pagination">
														<c:set var="totalPages" value="${(allFeedbacks.size() + pageSize - 1) / pageSize}"/>
														<c:forEach var="i" begin="1" end="${totalPages}">
															<li class="page-item <c:if test='${i == page}'>active</c:if>">
																<a class="page-link" href="?id=${detail_product.id}&page=${i}#tab-reviews">${i}</a>
															</li>
														</c:forEach>
													</ul>
												</nav>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-12 col-lg-5 col-xl-4"></div>
						</div>
					</div>
					<!-- end of .container-->
				</section>
				<!-- <section> close ============================-->
				<!-- ============================================-->
			</div>

			<!-- ============================================-->
			<!-- <section> begin ============================-->
			<section class="py-0 mb-9">
				<div class="container">
					<div class="d-flex flex-between-center mb-3">
						<div>
							<h3>Similar Products</h3>
							<p class="mb-0 text-700 fw-semi-bold">
								Essential for a better life
							</p>
						</div>
						<button class="btn btn-sm btn-phoenix-primary">View all</button>
					</div>
					<div class="swiper-theme-container products-slider">
								<div
									class="swiper swiper-container theme-slider"
									data-swiper='{"slidesPerView":1,"spaceBetween":16,"breakpoints":{"450":{"slidesPerView":2,"spaceBetween":16},"576":{"slidesPerView":3,"spaceBetween":20},"768":{"slidesPerView":4,"spaceBetween":20},"992":{"slidesPerView":5,"spaceBetween":20},"1200":{"slidesPerView":5,"spaceBetween":16}}}'
								>
									<div class="swiper-wrapper">
										<c:forEach items="${product_related}" var="l" varStatus="item">
											<c:if test="${item.index < 4 && l.status == true}">
												<div class="swiper-slide">
													<a
														href="${pageContext.request.contextPath}/products/product-detail?productId=${l.id}"
													>
														<div
															class="card h-100 bg-100 p-1"
														>
                                                                                                                    <img style="width: 100% !important" class="img-thumbnail hover-shadow"
															src="<c:url
																value="/resources/product_image/${l.image}"
															/>" alt="${l.title}" style="height: 220px;
															object-fit: cover; width: 100%;" />
															<div class="card-body p-2 text-center">
																<h6 class="text-truncate mb-1 fw-bold" style=" text-transform: uppercase;">
                                                                                                                            ${l.title}
                                                                                                                        </h6>
																<div
																	class=""
																>
																	<div
																		class="fw-bold text-primary mb-1 "
																	>
																		<c:set
																			var="minPrice"
																			value="${Double.MAX_VALUE}"
																		/>
																		<c:set var="maxPrice" value="${0.0}" />
																		<c:forEach
																			items="${l.productvariants}"
																			var="variant"
																		>
																			<c:if test="${variant.status == true}">
																				<c:if
																					test="${variant.price < minPrice}"
																				>
																					<c:set
																						var="minPrice"
																						value="${variant.price}"
																					/>
																				</c:if>
																				<c:if
																					test="${variant.price > maxPrice}"
																				>
																					<c:set
																						var="maxPrice"
																						value="${variant.price}"
																					/>
																				</c:if>
																			</c:if>
																		</c:forEach>
																		<c:if
																			test="${minPrice != Double.MAX_VALUE}"
																		>
																			<fmt:formatNumber
																				value="${minPrice}"
																				type="currency"
																				currencySymbol="₫"
																				maxFractionDigits="0"
																			/>
																			<c:if test="${minPrice != maxPrice}">
																				-
																				<fmt:formatNumber
																					value="${maxPrice}"
																					type="currency"
																					currencySymbol="₫"
																					maxFractionDigits="0"
																				/>
																			</c:if>
																		</c:if>
																	</div>
																	
																</div>
															</div>
														</div>
													</a>
												</div>
											</c:if>
										</c:forEach>
									</div>
								</div>
								<div class="swiper-nav">
									<div class="swiper-button-next" style="top: 45%">
										<span class="fas fa-chevron-right nav-icon"></span>
									</div>
									<div class="swiper-button-prev" style="top: 45%">
										<span class="fas fa-chevron-left nav-icon"></span>
									</div>
								</div>
							</div>
				</div>
				<!-- end of .container-->
			</section>
			<!-- <section> close ============================-->
			<!-- ============================================-->

			<div class="support-chat-container">
				<div class="container-fluid support-chat">
					<div class="card bg-white">
						<div
							class="card-header d-flex flex-between-center px-4 py-3 border-bottom"
						>
							<h5 class="mb-0 d-flex align-items-center gap-2">
								Demo widget<span
									class="fa-solid fa-circle text-success fs--3"
								></span>
							</h5>
							<div class="btn-reveal-trigger">
								<button
									class="btn btn-link p-0 dropdown-toggle dropdown-caret-none transition-none d-flex"
									type="button"
									id="support-chat-dropdown"
									data-bs-toggle="dropdown"
									data-boundary="window"
									aria-haspopup="true"
									aria-expanded="false"
									data-bs-reference="parent"
								>
									<span class="fas fa-ellipsis-h text-900"></span>
								</button>
								<div
									class="dropdown-menu dropdown-menu-end py-2"
									aria-labelledby="support-chat-dropdown"
								>
									<a class="dropdown-item" href="#!">Request a callback</a
									><a class="dropdown-item" href="#!">Search in chat</a
									><a class="dropdown-item" href="#!">Show history</a
									><a class="dropdown-item" href="#!">Report to Admin</a
									><a class="dropdown-item btn-support-chat" href="#!"
										>Close Support</a
									>
								</div>
							</div>
						</div>
						<div class="card-body chat p-0">
							<div class="d-flex flex-column-reverse scrollbar h-100 p-3">
								<div class="text-end mt-6">
									<a
										class="mb-2 d-inline-flex align-items-center text-decoration-none text-1100 hover-bg-soft rounded-pill border border-primary py-2 ps-4 pe-3"
										href="#!"
									>
										<p class="mb-0 fw-semi-bold fs--1">
											I need help with something
										</p>
										<span
											class="fa-solid fa-paper-plane text-primary fs--1 ms-3"
										></span> </a
									><a
										class="mb-2 d-inline-flex align-items-center text-decoration-none text-1100 hover-bg-soft rounded-pill border border-primary py-2 ps-4 pe-3"
										href="#!"
									>
										<p class="mb-0 fw-semi-bold fs--1">
											I can?t reorder a product I previously ordered
										</p>
										<span
											class="fa-solid fa-paper-plane text-primary fs--1 ms-3"
										></span> </a
									><a
										class="mb-2 d-inline-flex align-items-center text-decoration-none text-1100 hover-bg-soft rounded-pill border border-primary py-2 ps-4 pe-3"
										href="#!"
									>
										<p class="mb-0 fw-semi-bold fs--1">
											How do I place an order?
										</p>
										<span
											class="fa-solid fa-paper-plane text-primary fs--1 ms-3"
										></span> </a
									><a
										class="false d-inline-flex align-items-center text-decoration-none text-1100 hover-bg-soft rounded-pill border border-primary py-2 ps-4 pe-3"
										href="#!"
									>
										<p class="mb-0 fw-semi-bold fs--1">
											My payment method not working
										</p>
										<span
											class="fa-solid fa-paper-plane text-primary fs--1 ms-3"
										></span>
									</a>
								</div>
								<div class="text-center mt-auto">
									<div class="avatar avatar-3xl status-online">
										<img
											class="rounded-circle border border-3 border-white"
											src="../../../assets/img/team/30.webp"
											alt=""
										/>
									</div>
									<h5 class="mt-2 mb-3">Eric</h5>
									<p class="text-center text-black mb-0">
										Ask us anything ? we?ll get back to you here or by email
										within 24 hours.
									</p>
								</div>
							</div>
						</div>
						<div
							class="card-footer d-flex align-items-center gap-2 border-top ps-3 pe-4 py-3"
						>
							<div
								class="d-flex align-items-center flex-1 gap-3 border rounded-pill px-4"
							>
								<input
									class="form-control outline-none border-0 flex-1 fs--1 px-0"
									type="text"
									placeholder="Write message"
								/><label
									class="btn btn-link d-flex p-0 text-500 fs--1 border-0"
									for="supportChatPhotos"
									><span class="fa-solid fa-image"></span></label
								><input
									class="d-none"
									type="file"
									accept="image/*"
									id="supportChatPhotos"
								/><label
									class="btn btn-link d-flex p-0 text-500 fs--1 border-0"
									for="supportChatAttachment"
								>
									<span class="fa-solid fa-paperclip"></span></label
								><input class="d-none" type="file" id="supportChatAttachment" />
							</div>
							<button class="btn p-0 border-0 send-btn">
								<span class="fa-solid fa-paper-plane fs--1"></span>
							</button>
						</div>
					</div>
				</div>
			</div>

			<!-- ============================================-->
			<!-- <section> begin ============================-->
			<%@include file="Footer.jsp" %>
		</main>
		<!-- ===============================================-->
		<!--    End of Main Content-->
		<!-- ===============================================-->

		<div
			class="offcanvas offcanvas-end settings-panel border-0"
			id="settings-offcanvas"
			tabindex="-1"
			aria-labelledby="settings-offcanvas"
		>
			<div class="offcanvas-header align-items-start border-bottom flex-column">
				<div
					class="pt-1 w-100 mb-6 d-flex justify-content-between align-items-start"
				>
					<div>
						<h5 class="mb-2 me-2 lh-sm">
							<span class="fas fa-palette me-2 fs-0"></span>Theme Customizer
						</h5>
						<p class="mb-0 fs--1">
							Explore different styles according to your preferences
						</p>
					</div>
					<button
						class="btn p-1 fw-bolder"
						type="button"
						data-bs-dismiss="offcanvas"
						aria-label="Close"
					>
						<span class="fas fa-times fs-0"> </span>
					</button>
				</div>
				<button
					class="btn btn-phoenix-secondary w-100"
					data-theme-control="reset"
				>
					<span class="fas fa-arrows-rotate me-2 fs--2"></span>Reset to default
				</button>
			</div>
			<div class="offcanvas-body scrollbar px-card" id="themeController">
				<div class="setting-panel-item mt-0">
					<h5 class="setting-panel-item-title">Color Scheme</h5>
					<div class="row gx-2">
						<div class="col-6">
							<input
								class="btn-check"
								id="themeSwitcherLight"
								name="theme-color"
								type="radio"
								value="light"
								data-theme-control="phoenixTheme"
							/><label
								class="btn d-inline-block btn-navbar-style fs--1"
								for="themeSwitcherLight"
							>
								<span class="mb-2 rounded d-block"
									><img
										class="img-fluid img-prototype mb-0"
										src="../../../assets/img/generic/default-light.png"
										alt="" /></span
								><span class="label-text">Light</span></label
							>
						</div>
						<div class="col-6">
							<input
								class="btn-check"
								id="themeSwitcherDark"
								name="theme-color"
								type="radio"
								value="dark"
								data-theme-control="phoenixTheme"
							/><label
								class="btn d-inline-block btn-navbar-style fs--1"
								for="themeSwitcherDark"
							>
								<span class="mb-2 rounded d-block"
									><img
										class="img-fluid img-prototype mb-0"
										src="../../../assets/img/generic/default-dark.png"
										alt="" /></span
								><span class="label-text"> Dark</span></label
							>
						</div>
					</div>
				</div>
				<div class="border rounded-3 p-4 setting-panel-item bg-white">
					<div class="d-flex justify-content-between align-items-center">
						<h5 class="setting-panel-item-title mb-1">RTL</h5>
						<div class="form-check form-switch mb-0">
							<input
								class="form-check-input ms-auto"
								type="checkbox"
								data-theme-control="phoenixIsRTL"
							/>
						</div>
					</div>
					<p class="mb-0 text-700">Change text direction</p>
				</div>
				<div class="border rounded-3 p-4 setting-panel-item bg-white">
					<div class="d-flex justify-content-between align-items-center">
						<h5 class="setting-panel-item-title mb-1">Support Chat</h5>
						<div class="form-check form-switch mb-0">
							<input
								class="form-check-input ms-auto"
								type="checkbox"
								data-theme-control="phoenixSupportChat"
							/>
						</div>
					</div>
					<p class="mb-0 text-700">Toggle support chat</p>
				</div>
				<div class="setting-panel-item">
					<h5 class="setting-panel-item-title">Navigation Type</h5>
					<div class="row gx-2">
						<div class="col-6">
							<input
								class="btn-check"
								id="navbarPositionVertical"
								name="navigation-type"
								type="radio"
								value="vertical"
								data-theme-control="phoenixNavbarPosition"
								disabled="disabled"
							/><label
								class="btn d-inline-block btn-navbar-style fs--1"
								for="navbarPositionVertical"
							>
								<span class="mb-2 rounded d-block"
									><img
										class="img-fluid img-prototype d-dark-none"
										src="../../../assets/img/generic/default-light.png"
										alt="" /><img
										class="img-fluid img-prototype d-light-none"
										src="../../../assets/img/generic/default-dark.png"
										alt="" /></span
								><span class="label-text">Vertical</span></label
							>
						</div>
						<div class="col-6">
							<input
								class="btn-check"
								id="navbarPositionHorizontal"
								name="navigation-type"
								type="radio"
								value="horizontal"
								data-theme-control="phoenixNavbarPosition"
								disabled="disabled"
							/><label
								class="btn d-inline-block btn-navbar-style fs--1"
								for="navbarPositionHorizontal"
							>
								<span class="mb-2 rounded d-block"
									><img
										class="img-fluid img-prototype d-dark-none"
										src="../../../assets/img/generic/top-default.png"
										alt="" /><img
										class="img-fluid img-prototype d-light-none"
										src="../../../assets/img/generic/top-default-dark.png"
										alt="" /></span
								><span class="label-text"> Horizontal</span></label
							>
						</div>
						<div class="col-6">
							<input
								class="btn-check"
								id="navbarPositionCombo"
								name="navigation-type"
								type="radio"
								value="combo"
								data-theme-control="phoenixNavbarPosition"
								disabled="disabled"
							/><label
								class="btn d-inline-block btn-navbar-style fs--1"
								for="navbarPositionCombo"
							>
								<span class="mb-2 rounded d-block"
									><img
										class="img-fluid img-prototype d-dark-none"
										src="../../../assets/img/generic/nav-combo-light.png"
										alt="" /><img
										class="img-fluid img-prototype d-light-none"
										src="../../../assets/img/generic/nav-combo-dark.png"
										alt="" /></span
								><span class="label-text"> Combo</span></label
							>
						</div>
						<div class="col-6">
							<input
								class="btn-check"
								id="navbarPositionTopDouble"
								name="navigation-type"
								type="radio"
								value="dual-nav"
								data-theme-control="phoenixNavbarPosition"
								disabled="disabled"
							/><label
								class="btn d-inline-block btn-navbar-style fs--1"
								for="navbarPositionTopDouble"
							>
								<span class="mb-2 rounded d-block"
									><img
										class="img-fluid img-prototype d-dark-none"
										src="../../../assets/img/generic/dual-light.png"
										alt="" /><img
										class="img-fluid img-prototype d-light-none"
										src="../../../assets/img/generic/dual-dark.png"
										alt="" /></span
								><span class="label-text"> Dual nav</span></label
							>
						</div>
					</div>
					<p class="text-warning-500 font-medium">
						<span
							class="fa-solid fa-triangle-exclamation me-2 text-warning"
						></span
						>You can't update navigation type in this page
					</p>
				</div>
				<div class="setting-panel-item">
					<h5 class="setting-panel-item-title">Vertical Navbar Appearance</h5>
					<div class="row gx-2">
						<div class="col-6">
							<input
								class="btn-check"
								id="navbar-style-default"
								type="radio"
								name="config.name"
								value="default"
								data-theme-control="phoenixNavbarVerticalStyle"
								disabled="disabled"
							/><label
								class="btn d-block w-100 btn-navbar-style fs--1"
								for="navbar-style-default"
							>
								<img
									class="img-fluid img-prototype d-dark-none"
									src="../../../assets/img/generic/default-light.png"
									alt=""
								/><img
									class="img-fluid img-prototype d-light-none"
									src="../../../assets/img/generic/default-dark.png"
									alt=""
								/><span class="label-text d-dark-none"> Default</span
								><span class="label-text d-light-none">Default</span></label
							>
						</div>
						<div class="col-6">
							<input
								class="btn-check"
								id="navbar-style-dark"
								type="radio"
								name="config.name"
								value="darker"
								data-theme-control="phoenixNavbarVerticalStyle"
								disabled="disabled"
							/><label
								class="btn d-block w-100 btn-navbar-style fs--1"
								for="navbar-style-dark"
							>
								<img
									class="img-fluid img-prototype d-dark-none"
									src="../../../assets/img/generic/vertical-darker.png"
									alt=""
								/><img
									class="img-fluid img-prototype d-light-none"
									src="../../../assets/img/generic/vertical-lighter.png"
									alt=""
								/><span class="label-text d-dark-none"> Darker</span
								><span class="label-text d-light-none">Lighter</span></label
							>
						</div>
					</div>
					<p class="text-warning-500 font-medium">
						<span
							class="fa-solid fa-triangle-exclamation me-2 text-warning"
						></span
						>You can't update vertical navbar appearance type in this page
					</p>
				</div>
				<div class="setting-panel-item">
					<h5 class="setting-panel-item-title">Horizontal Navbar Shape</h5>
					<div class="row gx-2">
						<div class="col-6">
							<input
								class="btn-check"
								id="navbarShapeDefault"
								name="navbar-shape"
								type="radio"
								value="default"
								data-theme-control="phoenixNavbarTopShape"
								disabled="disabled"
							/><label
								class="btn d-inline-block btn-navbar-style fs--1"
								for="navbarShapeDefault"
							>
								<span class="mb-2 rounded d-block"
									><img
										class="img-fluid img-prototype d-dark-none mb-0"
										src="../../../assets/img/generic/top-default.png"
										alt="" /><img
										class="img-fluid img-prototype d-light-none mb-0"
										src="../../../assets/img/generic/top-default-dark.png"
										alt="" /></span
								><span class="label-text">Default</span></label
							>
						</div>
						<div class="col-6">
							<input
								class="btn-check"
								id="navbarShapeSlim"
								name="navbar-shape"
								type="radio"
								value="slim"
								data-theme-control="phoenixNavbarTopShape"
								disabled="disabled"
							/><label
								class="btn d-inline-block btn-navbar-style fs--1"
								for="navbarShapeSlim"
							>
								<span class="mb-2 rounded d-block"
									><img
										class="img-fluid img-prototype d-dark-none mb-0"
										src="../../../assets/img/generic/top-slim.png"
										alt="" /><img
										class="img-fluid img-prototype d-light-none mb-0"
										src="../../../assets/img/generic/top-slim-dark.png"
										alt="" /></span
								><span class="label-text"> Slim</span></label
							>
						</div>
					</div>
					<p class="text-warning-500 font-medium">
						<span
							class="fa-solid fa-triangle-exclamation me-2 text-warning"
						></span
						>You can't update vertical navbar appearance type in this page
					</p>
				</div>
				<div class="setting-panel-item">
					<h5 class="setting-panel-item-title">Horizontal Navbar Appearance</h5>
					<div class="row gx-2">
						<div class="col-6">
							<input
								class="btn-check"
								id="navbarTopDefault"
								name="navbar-top-style"
								type="radio"
								value="default"
								data-theme-control="phoenixNavbarTopStyle"
								disabled="disabled"
							/><label
								class="btn d-inline-block btn-navbar-style fs--1"
								for="navbarTopDefault"
							>
								<span class="mb-2 rounded d-block"
									><img
										class="img-fluid img-prototype d-dark-none mb-0"
										src="../../../assets/img/generic/top-default.png"
										alt="" /><img
										class="img-fluid img-prototype d-light-none mb-0"
										src="../../../assets/img/generic/top-style-darker.png"
										alt="" /></span
								><span class="label-text">Default</span></label
							>
						</div>
						<div class="col-6">
							<input
								class="btn-check"
								id="navbarTopDarker"
								name="navbar-top-style"
								type="radio"
								value="darker"
								data-theme-control="phoenixNavbarTopStyle"
								disabled="disabled"
							/><label
								class="btn d-inline-block btn-navbar-style fs--1"
								for="navbarTopDarker"
							>
								<span class="mb-2 rounded d-block"
									><img
										class="img-fluid img-prototype d-dark-none mb-0"
										src="../../../assets/img/generic/navbar-top-style-light.png"
										alt="" /><img
										class="img-fluid img-prototype d-light-none mb-0"
										src="../../../assets/img/generic/top-style-lighter.png"
										alt="" /></span
								><span class="label-text d-dark-none">Darker</span
								><span class="label-text d-light-none">Lighter</span></label
							>
						</div>
					</div>
					<p class="text-warning-500 font-medium">
						<span
							class="fa-solid fa-triangle-exclamation me-2 text-warning"
						></span
						>You can't update vertical navbar appearance type in this page
					</p>
				</div>
				<a
					class="bun btn-primary d-grid mb-3 text-white dark__text-100 mt-5 btn btn-primary"
					href="https://themes.getbootstrap.com/product/phoenix-admin-dashboard-webapp-template/"
					target="_blank"
					>Purchase template</a
				>
			</div>
		</div>

		<jsp:include page="../import-js.jsp" />
		<script src="../resources/vendors/swiper/swiper-bundle.min.js"></script>
		<script>
			var variants = [
				<c:forEach items="${detail_product.productvariants}" var="variant" varStatus="loop">
					{
						id: "${variant.id}",
						name: "${variant.name}",
						price: ${variant.price},
						image: "${variant.image}",
						sizes: [
							<c:forEach items="${variant.productvariantsizes}" var="size" varStatus="sizeLoop">
								{
                                                                    id: "${size.size.id}",
									value: "${size.size.value}",
									stock: ${size.quantityInStock - size.quantityHolding}
								}<c:if test="${!sizeLoop.last}">,</c:if>
							</c:forEach>
						]
					}<c:if test="${!loop.last}">,</c:if>
				</c:forEach>
			];

			$(document).ready(function() {
				// Nếu có selected_variant_id thì tự động chọn variant đó
				var selectedVariantId = '<c:out value="${selected_variant_id}"/>';
				if (selectedVariantId === '' || selectedVariantId === 'null') selectedVariantId = null; else selectedVariantId = parseInt(selectedVariantId);
				if (selectedVariantId) {
					var btn = $(".variant-btn[data-variant-id='" + selectedVariantId + "']");
					if (btn.length) {
						btn.trigger('click');
						$('#selected-variant-id').val(selectedVariantId);
					}
				} else if (variants.length > 0) {
					// Nếu không có variant được chọn, chọn variant đầu tiên
					$('#selected-variant-id').val(variants[0].id);
				}

				// Khi click variant
				$(document).on('click', '.variant-btn', function() {
					$('.variant-btn').removeClass('active');
					$(this).addClass('active');
					var idx = $(this).data('variant-index');
					var variantId = $(this).data('variant-id');
					$('#selected-variant-id').val(variantId);
					var v = variants[idx];
					$('#variant-title').text(v.name);
					$('#variant-price').text(v.price.toLocaleString('vi-VN') + '₫');
					// Render lại size
					var $sizeSelect = $('#size-select');
					$sizeSelect.empty();
					$.each(v.sizes, function(i, s) {
						var text = s.value + (s.stock <= 0 ? ' (Hết hàng)' : '');
						var $opt = $('<option></option>').val(s.id).text(text);
						if (s.stock <= 0) $opt.prop('disabled', true);
						$sizeSelect.append($opt);
					});
					// Cập nhật số lượng còn lại theo size đầu tiên
					var stock = v.sizes.length > 0 ? v.sizes[0].stock : 0;
					$('#stock-value').text(stock);
					// Chuyển slide swiper (swiper instance đã được khởi tạo bởi import-js.jsp)
					var swiperInstance = $('.product-image-swiper')[0]?.swiper;
					if (swiperInstance) swiperInstance.slideTo(idx + 1);
				});

				// Khi chọn size, cập nhật số lượng còn lại
				$('#size-select').on('change', function() {
					var idx = $('.variant-btn.active').data('variant-index');
					var v = variants[idx] || variants[0];
					var selectedSize = $(this).val();
					var stock = 0;
					$.each(v.sizes, function(i, s) {
						if (s.id == selectedSize) stock = s.stock;
					});
					$('#stock-value').text(stock);
				});

				// Xử lý nút tăng giảm số lượng
				$(document).on('click', '.quantity-btn', function(e) {
					e.preventDefault(); // Ngăn form submit
					var type = $(this).data('type');
					var input = $('#quantity-input');
					var currentVal = parseInt(input.val()) || 1; // Nếu không phải số thì mặc định là 1
					var maxStock = parseInt($('#stock-value').text()) || 0;

					if (type === 'plus' && currentVal < maxStock) {
						input.val(currentVal + 1);
					} else if (type === 'minus' && currentVal > 1) {
						input.val(currentVal - 1);
					}
				});

				// Xử lý khi người dùng nhập trực tiếp vào input
				$('#quantity-input').on('input', function() {
					var currentVal = parseInt($(this).val()) || 1;
					var maxStock = parseInt($('#stock-value').text()) || 0;

					if (currentVal < 1) {
						$(this).val(1);
					} else if (currentVal > maxStock) {
						$(this).val(maxStock);
					}
				});

				// Validate form trước khi submit
				$('#addToCartForm').on('submit', function(e) {
					e.preventDefault();
					var productId = $('input[name="productId"]').val();
					var variantId = $('#selected-variant-id').val();
					var size = $('#size-select').val();
					var quantity = parseInt($('#quantity-input').val());
                                        var stock = parseInt($('#stock-value').text()) || 0;

					// Kiểm tra giá trị
					console.log('productId:', productId, 'variantId:', variantId, 'size:', size, 'quantity:', quantity);

					if (!variantId) {
						alert('Please select a color/variant');
						return false;
					}
					if (!size) {
						alert('Please select a size');
						return false;
					}
					if (quantity < 1) {
						alert('Quantity must be at least 1');
						return false;
					}
					if (quantity > stock) {
						alert('Quantity cannot exceed available stock');
						return false;
					}

					addToCart(productId, variantId, size, quantity);
				});
			});

			function addToCart(productId, variantId, size, quantity) {
				var url = 'http://localhost:8080/ShoesShop/api/cart/add'
					+ '?productId=' + encodeURIComponent(productId)
					+ '&variantId=' + encodeURIComponent(variantId)
					+ '&size=' + encodeURIComponent(size)
					+ '&quantity=' + encodeURIComponent(quantity);

				$.ajax({
					url: url,
					type: 'POST',
					contentType: 'application/json',
					dataType: 'json',
					success: function (data) {
						if (data.success) {
							alert("Thêm vào giỏ hàng thành công!");
							// Nếu muốn cập nhật số lượng trên icon giỏ hàng, có thể làm ở đây
							// updateCartNumber(data.cartItemCount);
						} else {
							alert(data.message || "Có lỗi xảy ra khi thêm vào giỏ hàng.");
						}
					},
					error: function (xhr, status, error) {
						if (xhr.status === 403) {
							alert("Bạn cần đăng nhập để mua hàng!");
						} else {
							alert("Lỗi kết nối đến server hoặc lỗi khác.");
						}
					}
				});
			}
		</script>
	</body>
</html>
