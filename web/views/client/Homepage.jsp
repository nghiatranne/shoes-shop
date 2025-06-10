<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %> <%--<%@ page import="model.Author"
%>--%> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">
	<meta http-equiv="content-type" content="text/html;charset=utf-8" />

	<head>
		<meta charset="utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<title>Home - Shoes Shop</title>

		<jsp:include page="import-css.jsp" />
	</head>

	<body>
		<main class="main" id="top">
			<jsp:include page="layout/header.jsp" />

			<jsp:include page="layout/navigation.jsp" />

			<div class="container-small">
				<div class="swiper-theme-container" style="position: relative">
					<div
						class="swiper-container theme-slider"
						data-swiper='{
        "autoplay": true,
        "spaceBetween": 5,
        "loop": true,
        "loopedSlides": 5,
        "slideToClickedSlide": true,
        "navigation": {
          "nextEl": ".swiper-button-next",
          "prevEl": ".swiper-button-prev"
        }
      }'
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

					<!-- Moved outside of .swiper-nav and placed directly -->
					<div class="swiper-button-next">
						<span class="fas fa-chevron-right nav-icon"></span>
					</div>
					<div class="swiper-button-prev">
						<span class="fas fa-chevron-left nav-icon"></span>
					</div>
				</div>
			</div>

			<div class="ecommerce-homepage pt-5 mb-9">
				<section class="py-0 px-xl-3">
					<div class="container-small px-xl-0 px-xxl-3">
						<div class="mb-6">
							<div class="d-flex flex-between-center mb-3">
								<h3
									class="text-center w-100 fw-bold text-uppercase"
									style="font-size: 1.5rem"
								>
									Recommend For You
								</h3>
								<a
									class="btn btn-phoenix-primary me-1 mb-1"
									data-bs-toggle="tooltip"
									data-bs-placement="top"
									title="View all"
									href="books/new-book"
									type="button"
								>
									<span data-feather="arrow-right" class="fs--1 ms-1"></span>
								</a>
							</div>
							<div class="swiper-theme-container products-slider">
								<div
									class="swiper swiper-container theme-slider"
									data-swiper='{"slidesPerView":1,"spaceBetween":16,"breakpoints":{"450":{"slidesPerView":2,"spaceBetween":16},"576":{"slidesPerView":3,"spaceBetween":20},"768":{"slidesPerView":4,"spaceBetween":20},"992":{"slidesPerView":4,"spaceBetween":20},"1200":{"slidesPerView":4,"spaceBetween":16}}}'
								>
									<div class="swiper-wrapper">
										<c:forEach items="${listRCM}" var="l" varStatus="item">
											<c:if test="${item.index < 4 && l.status == true}">
												<div class="swiper-slide">
													<a
														href="${pageContext.request.contextPath}/products/product-detail?productId=${l.id}"
													>
														<div
															class="card h-100 bg-100 p-1"
														>
															<img class="img-thumbnail hover-shadow"
															src="<c:url
																value="/resources/product_image/${l.image}"
															/>" alt="${l.title}" style="height: 240px;
															object-fit: cover; width: 100%;" />
															<div class="card-body p-2 text-center">
																<h5 class="text-truncate mb-1 fw-bold" style=" text-transform: uppercase;">
                                                                                                                            ${l.title}
                                                                                                                        </h5>
                                                                                             
																<div
																	class=""
																>
																	<div
																		class="fw-bold text-primary mb-1"
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
						<div class="mb-6">
							<div class="d-flex flex-between-center mb-3">
								<h3
									class="text-center w-100 fw-bold text-uppercase"
									style="font-size: 1.5rem"
								>
									New Shoes
								</h3>
								<a
									class="btn btn-phoenix-primary me-1 mb-1"
									data-bs-toggle="tooltip"
									data-bs-placement="top"
									title="View all"
									type="button"
								>
									<span data-feather="arrow-right" class="fs--1 ms-1"></span>
								</a>
							</div>
							<div class="swiper-theme-container products-slider">
								<div
									class="swiper swiper-container theme-slider"
									data-swiper='{"slidesPerView":1,"spaceBetween":16,"breakpoints":{"450":{"slidesPerView":2,"spaceBetween":16},"576":{"slidesPerView":3,"spaceBetween":20},"768":{"slidesPerView":4,"spaceBetween":20},"992":{"slidesPerView":5,"spaceBetween":20},"1200":{"slidesPerView":5,"spaceBetween":16}}}'
								>
									<div class="swiper-wrapper">
										<c:forEach items="${listRCM}" var="l" varStatus="item">
											<c:if test="${item.index < 4 && l.status == true}">
												<div class="swiper-slide">
													<a
														href="${pageContext.request.contextPath}/products/product-detail?productId=${l.id}"
													>
														<div
															class="card h-100 bg-100 p-1"
														>
															<img class="img-thumbnail hover-shadow"
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
						<div class="mb-6">
							<div class="d-flex flex-between-center mb-3">
								<h3
									class="text-center w-100 fw-bold text-uppercase"
									style="font-size: 1.5rem"
								>
									Best Shoes Ever
								</h3>
								<a
									class="btn btn-phoenix-primary me-1 mb-1"
									data-bs-toggle="tooltip"
									data-bs-placement="top"
									title="View all"
									href="${pageContext.request.contextPath}/books?cid=24"
									type="button"
								>
									<span data-feather="arrow-right" class="fs--1 ms-1"></span>
								</a>
							</div>
							<div class="swiper-theme-container products-slider">
								<div
									class="swiper swiper-container theme-slider"
									data-swiper='{"slidesPerView":1,"spaceBetween":16,"breakpoints":{"450":{"slidesPerView":2,"spaceBetween":16},"576":{"slidesPerView":3,"spaceBetween":20},"768":{"slidesPerView":4,"spaceBetween":20},"992":{"slidesPerView":4,"spaceBetween":20},"1200":{"slidesPerView":4,"spaceBetween":16}}}'
								>
									<div class="swiper-wrapper">
										<c:forEach items="${listBS}" var="gpb" varStatus="item">
											<c:if test="${item.index < 4 && gpb.status == true}">
												<div class="swiper-slide">
													<a
														href="${pageContext.request.contextPath}/products/product-detail?productId=${l.id}"
													>
														<div
															class="card h-100 bg-100 p-1"
														>
															<img class="img-thumbnail hover-shadow"
															src="<c:url
																value="/resources/product_image/${lb.image}"
															/>" alt="${lb.title}" style="height: 200px;
															object-fit: cover; width: 100%;" />
															<div class="card-body p-2 text-center">
																<h6 class="text-truncate mb-1 fw-bold" style=" text-transform: uppercase;">
                                                                                                                            ${l.title}
                                                                                                                        </h6>
																<div
																	class=""
																>
																	<div
																		class="fw-bold text-primary mb-1"
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
						<div class="mb-6">
							<div class="d-flex flex-between-center mb-3">
								<h3
									class="text-center w-100 fw-bold text-uppercase"
									style="font-size: 1.5rem"
								>
									Blogs
								</h3>
								<a
									class="btn btn-phoenix-primary me-1 mb-1"
									data-bs-toggle="tooltip"
									data-bs-placement="top"
									title="View all"
									href="${pageContext.request.contextPath}/blog-list"
									type="button"
								>
									<span data-feather="arrow-right" class="fs--1 ms-1"></span>
								</a>
							</div>
							<div class="row g-3">
								<c:forEach items="${listBlog}" var="post" varStatus="item">
									<c:if test="${post.status && item.index < 4}">
										<div class="col-md-3">
											<div class="blog-card-container h-100">
												<div
													class="position-relative text-decoration-none blog-card h-100"
												>
													<div
														class="d-flex flex-column justify-content-between h-100"
													>
														<div
															class="border border-1 rounded-3 position-relative mb-3"
														>
															<img
																class="img-fluid w-100"
																src="<c:url value='/resources/post_image/${post.thumbnail}'/>"
																alt="${post.title}"
															/>
															<a
																class="stretched-link"
																href="${pageContext.request.contextPath}/blog/post-details?id=${post.id}"
															></a>
														</div>
														<div class="p-2">
															<h5 class="mb-1 text-truncate">${post.title}</h5>
															<p class="mb-1 small">
																Author: ${post.account.fullname}
															</p>
															<p class="mb-1 small">
																Categories:
																<c:forEach
																	items="${post.categories}"
																	var="category"
																>
																	<span class="badge badge-tag me-1 mb-1"
																		>${category.name}</span
																	>
																</c:forEach>
															</p>
														</div>
														<div class="p-2">
															<a
																href="${pageContext.request.contextPath}/blog/post-details?id=${post.id}"
																class="btn btn-primary w-100"
																>Read More</a
															>
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
				</section>
			</div>

			<jsp:include page="layout/Footer.jsp" />
		</main>
		<jsp:include page="import-js.jsp" />
	</body>
</html>
