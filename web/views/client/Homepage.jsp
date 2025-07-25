<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %> <%@ page import="java.util.Map" %>
<%--<%@ page import="model.Author" %>--%> <%@page contentType="text/html"
pageEncoding="UTF-8"%> <% Map<Integer, Double>
	productAvgRating = (Map<Integer, Double
		>) request.getAttribute("productAvgRating"); Map<Integer, Integer>
			productReviewCount = (Map<Integer, Integer
				>) request.getAttribute("productReviewCount"); %>
				<!DOCTYPE html>
				<html lang="en-US" dir="ltr">
					<meta http-equiv="content-type" content="text/html;charset=utf-8" />

					<head>
						<meta charset="utf-8" />
						<meta http-equiv="X-UA-Compatible" content="IE=edge" />
						<meta
							name="viewport"
							content="width=device-width, initial-scale=1"
						/>
						<title>Home - Shoes Shop</title>

								<style>
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
				color: #355e87;
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
			.img-thumbnail:hover {
				transform: scale(1.03);
			}
			.product-category-badges {
				max-height: 2.4em; /* khoảng 2 dòng badge, điều chỉnh nếu cần */
				overflow: hidden;
				display: flex;
				flex-wrap: wrap;
				align-items: flex-start;
			}
			.theme-slider,
			.swiper-theme-container,
			.swiper-container {
				/*width: 100vw !important;*/
				max-width: 100vw !important;
				margin-left: calc(50% - 50vw) !important;
				margin-right: 0 !important;
				display: block;
			}
			.swiper-wrapper {
				width: 100% !important;
			}
			.theme-slider .swiper-slide,
			.swiper-theme-container .swiper-slide {
				display: flex !important;
				justify-content: center;
				align-items: center;
			}
			.theme-slider .swiper-slide img,
			.swiper-theme-container .swiper-slide img {
				/*width: 100vw;*/
				max-width: 100vw;
				height: 700px;
				max-height: 50vw;
				object-fit: contain;
				background: #e9e6e6;
				display: block;
				margin: 0 auto;
			}
			@media (max-width: 991.98px) {
				.theme-slider .swiper-slide img,
				.swiper-theme-container .swiper-slide img {
					height: 260px;
					max-height: 70vw;
				}
			}
			@media (max-width: 600px) {
				.theme-slider .swiper-slide img,
				.swiper-theme-container .swiper-slide img {
					height: 160px;
					max-height: 90vw;
				}
			}
		</style>

						<jsp:include page="import-css.jsp" />
					</head>

					<body>
						<main class="main" id="top">
							<jsp:include page="layout/header.jsp" />

							<jsp:include page="layout/navigation.jsp" />

							<div class="container-fluid px-0">
								<div class="swiper-theme-container px-0">
									<div
										class="swiper-container theme-slider"
										data-swiper='{"autoplay":true,"spaceBetween":5,"loop":true,"loopedSlides":5,"slideToClickedSlide":true}'
									>
										<div class="swiper-wrapper">
											<c:forEach items="${sliders}" var="s">
												<c:if test="${s.status == true}">
													<div class="swiper-slide">
														<a href="${s.linkUrl}">
															<img
																class="rounded-1 img-fluid"
																src="resources/slider_image/${s.imageUrl}"
																alt="${s.title}"
																title="${s.title}"
															/>
														</a>
													</div>
												</c:if>
											</c:forEach>
										</div>
									</div>
									<div class="swiper-nav">
										<div class="swiper-button-next">
											<span class="fas fa-chevron-right nav-icon"></span>
										</div>
										<div class="swiper-button-prev">
											<span class="fas fa-chevron-left nav-icon"></span>
										</div>
									</div>
								</div>
							</div>

							<div class="ecommerce-homepage pt-5 mb-9">
								<section class="py-0 px-xl-3">
									<div class="container-small px-xl-0 px-xxl-3">
										<div class="row mb-3">
											<div class="d-flex flex-between-center mb-3">
												<h3>New Shoes!</h3>
												<a
													class="btn btn-phoenix-primary me-1 mb-1"
													data-bs-toggle="tooltip"
													data-bs-placement="top"
													title="View all"
													href="books?cid=14"
													type="button"
												>
													<span
														data-feather="arrow-right"
														class="fs--1 ms-1"
													></span>
												</a>
											</div>
											<div class="col-lg-12 col-xxl-12">
												<div
													class="row g-3 mb-8"
													style="align-items: flex-start"
												>
													<c:forEach
														items="${newProducts}"
														var="np"
														varStatus="item"
													>
														<c:if test="${item.index < 8 && np.status == true}">
															<div class="col-3">
																<div class="product-card-container h-100">
																	<div
																		class="position-relative text-decoration-none product-card h-100"
																	>
																		<div
																			class="d-flex flex-col flex-wrap align-items-center h-100 gap-2"
																		>
																			<div>
																				<div
																					class="border border-1 rounded-3 position-relative mb-3"
																				>
																					<img
																						style="object-fit: contain"
																						class="img-thumbnail"
																						src="<c:url value='/resources/product_image/${np.image}'/>"
																						alt=""
																					/>
																				</div>
																				<a
																					class="stretched-link text-decoration-none"
																					href="${pageContext.request.contextPath}/products/product-detail?id=${np.id}"
																				></a>
																			</div>
																			<div>
																				<h5
																					class="lh-sm line-clamp-3 product-name"
																				>
																					${np.title}
																				</h5>
																				<p
																					class="mb-2 product-categories"
																					style="width: 100%"
																				>
																					<c:forEach
																						items="${np.categories}"
																						var="c"
																					>
																						<a
																							class="text-decoration-none"
																							href=""
																						>
																							<span class="badge badge-tag"
																								>${c.name}</span
																							>
																						</a>
																					</c:forEach>
																				</p>
																				<!-- Giá sản phẩm -->
																				<div class="mb-1">
																					<h4 class="text-1100 mb-0">
																						<c:if
																							test="${not empty np.productvariants}"
																						>
																							<fmt:formatNumber
																								value="${np.productvariants[0].price}"
																								type="currency"
																								pattern="###,### ₫"
																							/>
																						</c:if>
																					</h4>
																				</div>
																				<!-- Đánh giá -->
																				<div
																					class="d-flex align-items-center mb-1"
																				>
																					<c:choose>
																						<c:when
																							test="${productReviewCount[np.id] == null || productReviewCount[np.id] == 0}"
																						>
																							<span class="text-muted"
																								>Chưa có đánh giá</span
																							>
																						</c:when>
																						<c:otherwise>
																							<span>
																								<fmt:formatNumber
																									value="${productAvgRating[np.id]}"
																									maxFractionDigits="1"
																								/>
																								★ (<c:out
																									value="${productReviewCount[np.id]}"
																								/>
																								đánh giá)
																							</span>
																						</c:otherwise>
																					</c:choose>
																				</div>
																			</div>
																		</div>
																	</div>
																</div>
															</div>
														</c:if>
													</c:forEach>
												</div>
											</div>
										</div>
									</div>
									<!-- end of .container-->
								</section>
							</div>
							<div class="ecommerce-homepage pt-5 mb-9">
								<section class="py-0 px-xl-3">
									<div class="container-small px-xl-0 px-xxl-3">
										<div class="row mb-3">
											<div class="d-flex flex-between-center mb-3">
												<h3>Features Products</h3>
												<a
													class="btn btn-phoenix-primary me-1 mb-1"
													data-bs-toggle="tooltip"
													data-bs-placement="top"
													title="View all"
													href="books?cid=14"
													type="button"
												>
													<span
														data-feather="arrow-right"
														class="fs--1 ms-1"
													></span>
												</a>
											</div>
											<div class="col-lg-12 col-xxl-12">
												<div
													class="row g-3 mb-8"
													style="align-items: flex-start"
												>
													<c:forEach
														items="${bestSellers}"
														var="np"
														varStatus="item"
													>
														<c:if test="${item.index < 8 && np.status == true}">
															<div class="col-3">
																<div class="product-card-container h-100">
																	<div
																		class="position-relative text-decoration-none product-card h-100"
																	>
																		<div
																			class="d-flex flex-col flex-wrap align-items-center h-100 gap-2"
																		>
																			<div>
																				<div
																					class="border border-1 rounded-3 position-relative mb-3"
																				>
																					<img
																						style="object-fit: contain"
																						class="img-thumbnail"
																						src="<c:url value='/resources/product_image/${np.image}'/>"
																						alt=""
																					/>
																				</div>
																				<a
																					class="stretched-link text-decoration-none"
																					href="${pageContext.request.contextPath}/products/product-detail?id=${np.id}"
																				></a>
																			</div>
																			<div>
																				<h5
																					class="lh-sm line-clamp-3 product-name"
																				>
																					${np.title}
																				</h5>
																				<p
																					class="mb-2 product-categories"
																					style="width: 100%"
																				>
																					<c:forEach
																						items="${np.categories}"
																						var="c"
																					>
																						<a
																							class="text-decoration-none"
																							href=""
																						>
																							<span class="badge badge-tag"
																								>${c.name}</span
																							>
																						</a>
																					</c:forEach>
																				</p>
																				<!-- Giá sản phẩm -->
																				<div class="mb-1">
																					<h4 class="text-1100 mb-0">
																						<c:if
																							test="${not empty np.productvariants}"
																						>
																							<fmt:formatNumber
																								value="${np.productvariants[0].price}"
																								type="currency"
																								pattern="###,### ₫"
																							/>
																						</c:if>
																					</h4>
																				</div>
																				<!-- Đánh giá -->
																				<div
																					class="d-flex align-items-center mb-1"
																				>
																					<c:choose>
																						<c:when
																							test="${productReviewCount[np.id] == null || productReviewCount[np.id] == 0}"
																						>
																							<span class="text-muted"
																								>Chưa có đánh giá</span
																							>
																						</c:when>
																						<c:otherwise>
																							<span>
																								<fmt:formatNumber
																									value="${productAvgRating[np.id]}"
																									maxFractionDigits="1"
																								/>
																								★ (<c:out
																									value="${productReviewCount[np.id]}"
																								/>
																								đánh giá)
																							</span>
																						</c:otherwise>
																					</c:choose>
																				</div>
																			</div>
																		</div>
																	</div>
																</div>
															</div>
														</c:if>
													</c:forEach>
												</div>
											</div>
										</div>
									</div>
									<!-- end of .container-->
								</section>
							</div>
							<%-- Sua home page --%>
							<jsp:include page="layout/Footer.jsp" />
							<!-- <section> close ============================-->
							<!-- ============================================-->
						</main>
						<jsp:include page="import-js.jsp" />
					</body>
				</html> </Integer,></Integer,></Integer,
></Integer,>
