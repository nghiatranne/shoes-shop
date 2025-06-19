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
    <title>Shoes Shop</title>
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
                  <span data-feather="arrow-right" class="fs--1 ms-1"></span>
                </a>
              </div>
              <div class="col-lg-12 col-xxl-12">
                <div class="row gx-3 mb-8" style="align-items: flex-start">
                  <c:forEach items="${newProducts}" var="np" varStatus="item">
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
                                    <img style="height: 240px;object-fit: contain;" class="img-thumbnail" src="<c:url
                                    value="/resources/product_image/${np.image}"
                                  />" alt=""/>
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
                                <p class="mb-2" style="width: 100%">
                                    <c:forEach items="${np.categories}" var="c">
                                        <a class="text-decoration-none" href="">
                                            <span class="badge badge-tag">${c.name}</span>
                                        </a>
                                    </c:forEach>
                                </p>
                                <div class="d-flex align-items-center mb-1">
                                  <!--<p class="me-2 text-900 text-decoration-line-through text-danger mb-0">$8.99</p>-->
                                  <h4 class="text-1100 mb-0">
                                    <fmt:formatNumber value="${np.productvariants[0].price}" type="currency" pattern="###,### ₫"/>
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
              </div>
            </div>
          </div>
          <!-- end of .container-->
        </section>
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
									href="products/new-products"
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
