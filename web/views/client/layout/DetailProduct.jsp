<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>${detail_product.title}</title>
		<jsp:include page="../import-css.jsp" />
		<style>
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

                        <%@include file="header.jsp" %>
                        <%@include file="navigation.jsp" %>
                        ${detail_product}
			<div class="pt-5 pb-9">
				<!-- ============================================-->
				<!-- <section> begin ============================-->
				<section class="py-0">
					<div class="container-small">
						<nav class="mb-3" aria-label="breadcrumb">
							<ol class="breadcrumb mb-0">
								<li class="breadcrumb-item"><a href="#">Fashion</a></li>
								<li class="breadcrumb-item"><a href="#">Womens fashion</a></li>
								<li class="breadcrumb-item"><a href="#">Footwear</a></li>
								<li class="breadcrumb-item active" aria-current="page">
									Hills
								</li>
							</ol>
						</nav>
						<div
							class="row g-5 mb-5 mb-lg-8"
							data-product-details="data-product-details"
						>
							<div class="col-12 col-lg-6">
								<div class="row g-3 mb-3">
									<div class="col-12 col-md-2 col-lg-12 col-xl-2">
										<div
											class="swiper-products-thumb swiper swiper-container theme-slider overflow-visible"
											id="swiper-products-thumb"
										></div>
									</div>
									<div class="col-12 col-md-10 col-lg-12 col-xl-10">
										<div
											class="d-flex align-items-center border rounded-3 text-center p-5 h-100"
										>
											<div
												class="swiper swiper-container theme-slider"
												data-thumb-target="swiper-products-thumb"
												data-products-swiper='{"slidesPerView":1,"spaceBetween":16,"thumbsEl":".swiper-products-thumb"}'
											></div>
										</div>
									</div>
								</div>
								<div class="d-flex">
									<button
										class="btn btn-lg btn-outline-warning rounded-pill w-100 me-3 px-2 px-sm-4 fs--1 fs-sm-0"
									>
										<span class="me-2 far fa-heart"></span>Add to wishlist</button
									><button
										class="btn btn-lg btn-warning rounded-pill w-100 fs--1 fs-sm-0"
									>
										<span class="fas fa-shopping-cart me-2"></span>Add to cart
									</button>
								</div>
							</div>
							<div class="col-12 col-lg-6">
								<div class="d-flex flex-column justify-content-between h-100">
									<div>
										<div class="d-flex flex-wrap">
											<div class="me-2">
												<span class="fa fa-star text-warning"></span
												><span class="fa fa-star text-warning"></span
												><span class="fa fa-star text-warning"></span
												><span class="fa fa-star text-warning"></span
												><span class="fa fa-star text-warning"></span>
											</div>
											<p class="text-primary fw-semi-bold mb-2">
												6548 People rated and reviewed
											</p>
										</div>
										<h3 class="mb-3 lh-sm">
											24" iMac® with Retina 4.5K display - Apple M1 8GB Memory -
											256GB SSD - w/Touch ID (Latest Model) - Blue
										</h3>
										<div class="d-flex flex-wrap align-items-start mb-3">
											<span
												class="badge bg-success fs--1 rounded-pill me-2 fw-semi-bold"
												>#1 Best seller</span
											><a class="fw-semi-bold" href="#!"
												>in Phoenix sell analytics 2021</a
											>
										</div>
										<div class="d-flex flex-wrap align-items-center">
											<h1 class="me-3">$1349.99</h1>
											<p
												class="text-500 text-decoration-line-through fs-2 mb-0 me-3"
											>
												$1499.99
											</p>
											<p class="text-warning-500 fw-bolder fs-2 mb-0">
												10% off
											</p>
										</div>
										<p class="text-success fw-semi-bold fs-1 mb-2">In stock</p>
										<p class="mb-2 text-800">
											<strong class="text-1000"
												>Do you want it on Saturday, July 29th?</strong
											>
											Choose
											<strong class="text-1000">Saturday Delivery </strong>at
											checkout if you want your order delivered within 12 hours
											43 minutes, <a class="fw-bold" href="#!">Details. </a
											><strong class="text-1000"
												>Gift wrapping is available.</strong
											>
										</p>
										<p class="text-danger-500 fw-bold mb-5 mb-lg-0">
											Special offer ends in 23:00:45 hours
										</p>
									</div>
									<div>
										<div class="mb-3">
											<p class="fw-semi-bold mb-2 text-900">
												Color :
												<span
													class="text-1100"
													data-product-color="data-product-color"
													>Blue</span
												>
											</p>
											<div
												class="d-flex product-color-variants"
												data-product-color-variants="data-product-color-variants"
											>
												<div
													class="rounded-1 border me-2 active"
													data-variant="Blue"
													data-products-images='["../../../assets/img/products/details/blue_front.png","../../../assets/img/products/details/blue_back.png","../../../assets/img/products/details/blue_side.png"]'
												>
													<img
														src="../../../assets/img/products/details/blue_front.png"
														alt=""
														width="38"
													/>
												</div>
												<div
													class="rounded-1 border me-2"
													data-variant="Red"
													data-products-images='["../../../assets/img/products/details/red_front.png","../../../assets/img/products/details/red_back.png","../../../assets/img/products/details/red_side.png"]'
												>
													<img
														src="../../../assets/img/products/details/red_front.png"
														alt=""
														width="38"
													/>
												</div>
												<div
													class="rounded-1 border me-2"
													data-variant="Green"
													data-products-images='["../../../assets/img/products/details/green_front.png","../../../assets/img/products/details/green_back.png","../../../assets/img/products/details/green_side.png"]'
												>
													<img
														src="../../../assets/img/products/details/green_front.png"
														alt=""
														width="38"
													/>
												</div>
												<div
													class="rounded-1 border me-2"
													data-variant="Purple"
													data-products-images='["../../../assets/img/products/details/purple_front.png","../../../assets/img/products/details/purple_back.png","../../../assets/img/products/details/purple_side.png"]'
												>
													<img
														src="../../../assets/img/products/details/purple_front.png"
														alt=""
														width="38"
													/>
												</div>
												<div
													class="rounded-1 border me-2"
													data-variant="Silver"
													data-products-images='["../../../assets/img/products/details/silver_front.png","../../../assets/img/products/details/silver_back.png","../../../assets/img/products/details/silver_side.png"]'
												>
													<img
														src="../../../assets/img/products/details/silver_front.png"
														alt=""
														width="38"
													/>
												</div>
												<div
													class="rounded-1 border me-2"
													data-variant="Yellow"
													data-products-images='["../../../assets/img/products/details/yellow_front.png","../../../assets/img/products/details/yellow_back.png","../../../assets/img/products/details/yellow_side.png"]'
												>
													<img
														src="../../../assets/img/products/details/yellow_front.png"
														alt=""
														width="38"
													/>
												</div>
												<div
													class="rounded-1 border me-2"
													data-variant="Orange"
													data-products-images='["../../../assets/img/products/details/orange_front.png","../../../assets/img/products/details/orange_back.png","../../../assets/img/products/details/orange_side.png"]'
												>
													<img
														src="../../../assets/img/products/details/orange_front.png"
														alt=""
														width="38"
													/>
												</div>
											</div>
										</div>
										<div class="row g-3 g-sm-5 align-items-end">
											<div class="col-12 col-sm-auto">
												<p class="fw-semi-bold mb-2 text-900">Size :</p>
												<div class="d-flex align-items-center">
													<select class="form-select w-auto">
														<option value="44">44</option>
														<option value="22">22</option>
														<option value="18">18</option></select
													><a class="ms-2 fs--1 fw-semi-bold" href="#!"
														>Size chart</a
													>
												</div>
											</div>
											<div class="col-12 col-sm">
												<p class="fw-semi-bold mb-2 text-900">Quantity :</p>
												<div
													class="d-flex justify-content-between align-items-end"
												>
													<div
														class="d-flex flex-between-center"
														data-quantity="data-quantity"
													>
														<button
															class="btn btn-phoenix-primary px-3"
															data-type="minus"
														>
															<span class="fas fa-minus"></span></button
														><input
															class="form-control text-center input-spin-none bg-transparent border-0 outline-none"
															style="width: 50px"
															type="number"
															min="1"
															value="2"
														/><button
															class="btn btn-phoenix-primary px-3"
															data-type="plus"
														>
															<span class="fas fa-plus"></span>
														</button>
													</div>
													<button class="btn btn-phoenix-primary px-3 border-0">
														<span class="fas fa-share-alt fs-1"></span>
													</button>
												</div>
											</div>
										</div>
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
							<li class="nav-item">
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
							<li class="nav-item">
								<a
									class="nav-link"
									id="specification-tab"
									data-bs-toggle="tab"
									href="#tab-specification"
									role="tab"
									aria-controls="tab-specification"
									aria-selected="false"
									>Specification</a
								>
							</li>
							<li class="nav-item">
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
								<div class="tab-content" id="productTabContent">
									<div
										class="tab-pane pe-lg-6 pe-xl-12 fade show active text-1100"
										id="tab-description"
										role="tabpanel"
										aria-labelledby="description-tab"
									>
										<p class="mb-5">
											CUPERTINO, CA , The M1 CPU allows Apple to deliver an
											all-new iMac with a lot more compact and impressively thin
											design. The new iMac delivers tremendous performance in an
											11.5-millimeter-thin design with a stunning side profile
											that almost vanishes. iMac includes a 24-inch 4.5K Retina
											display with 11.3 million pixels, 500 nits of brightness,
											and over a billion colors, giving a beautiful and vivid
											viewing experience. It is available in a variety of
											striking colors to match a user's own style and brighten
											any area. A 1080p FaceTime HD camera, studio-quality mics,
											and a six-speaker sound system are all included in the new
											iMac, making it the greatest camera and audio system ever
											in a Mac. Touch ID is also making its debut on the iMac,
											making it easier than ever to securely log in, make Apple
											Pay transactions, and switch user accounts with the touch
											of a finger. Apps launch at lightning speed, everyday
											chores seem astonishingly fast and fluid, and demanding
											workloads like editing 4K video and working with large
											photos are faster than ever before thanks to the power and
											performance of M1 and macOS Big Sur.
										</p>
										<a
											href="../../../assets/img/products/23.png"
											data-gallery="gallery-description"
											><img
												class="img-fluid mb-5 rounded-3"
												src="../../../assets/img/products/23.png"
												alt=""
										/></a>
										<p class="mb-0">
											The new iMac joins Apple's fantastic M1-powered Mac
											family, which includes the MacBook Air, 13-inch MacBook
											Pro, and Mac mini, and represents yet another step ahead
											in the company's shift to Apple silicon. Customers may
											order iMac starting Friday, April 30. It's the most
											personal, powerful, capable, and enjoyable it's ever been.
											In the second half of May, the iMac will be available."M1
											is a huge step forward for the Mac," said Greg Joswiak,
											Apple's senior vice president of Worldwide Marketing.
											"Today, we're delighted to present the all-new iMac, the
											first Mac developed around the groundbreaking M1
											processor." "The new iMac takes everything people love
											about iMac to an entirely new level, with its beautiful
											design in seven breathtaking colors, its immersive 4.5K
											Retina display, the greatest camera, mics, and speakers
											ever in a Mac, and Touch ID, combined with M1's incredible
											performance and macOS Big Sur's power."
										</p>
									</div>
									<div
										class="tab-pane pe-lg-6 pe-xl-12 fade"
										id="tab-specification"
										role="tabpanel"
										aria-labelledby="specification-tab"
									>
										<h3 class="mb-0 ms-4 fw-bold">Processor/Chipset</h3>
										<table class="table">
											<thead>
												<tr>
													<th style="width: 40%"></th>
													<th style="width: 60%"></th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td class="bg-100 align-middle">
														<h6
															class="mb-0 text-900 text-uppercase fw-bolder px-4 fs--1 lh-sm"
														>
															Chip name
														</h6>
													</td>
													<td class="px-5 mb-0">Apple M1 chip</td>
												</tr>
												<tr>
													<td class="bg-100 align-middle">
														<h6
															class="mb-0 text-900 text-uppercase fw-bolder px-4 fs--1 lh-sm"
														>
															Cpu core
														</h6>
													</td>
													<td class="px-5 mb-0">
														8 (4 performance and 4 efficiency)
													</td>
												</tr>
												<tr>
													<td class="bg-100 align-middle">
														<h6
															class="mb-0 text-900 text-uppercase fw-bolder px-4 fs--1 lh-sm"
														>
															Gpu core
														</h6>
													</td>
													<td class="px-5 mb-0">7</td>
												</tr>
												<tr>
													<td class="bg-100 align-middle">
														<h6
															class="mb-0 text-900 text-uppercase fw-bolder px-4 fs--1 lh-sm"
														>
															Neural engine
														</h6>
													</td>
													<td class="px-5 mb-0">16 cores</td>
												</tr>
											</tbody>
										</table>
										<h3 class="mb-0 mt-6 ms-4 fw-bold">Storage</h3>
										<table class="table">
											<thead>
												<tr>
													<th style="width: 40%"></th>
													<th style="width: 60%"></th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td class="bg-100 align-middle">
														<h6
															class="mb-0 text-900 text-uppercase fw-bolder px-4 fs--1 lh-sm"
														>
															Memory
														</h6>
													</td>
													<td class="px-5 mb-0">8 GB unified</td>
												</tr>
												<tr>
													<td class="bg-100 align-middle">
														<h6
															class="mb-0 text-900 text-uppercase fw-bolder px-4 fs--1 lh-sm"
														>
															SSD
														</h6>
													</td>
													<td class="px-5 mb-0">256 GB</td>
												</tr>
											</tbody>
										</table>
										<h3 class="mb-0 mt-6 ms-4 fw-bold">Display</h3>
										<table class="table">
											<thead>
												<tr>
													<th style="width: 40%"></th>
													<th style="width: 60%"></th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td class="bg-100 align-middle">
														<h6
															class="mb-0 text-900 text-uppercase fw-bolder px-4 fs--1 lh-sm"
														>
															Display type
														</h6>
													</td>
													<td class="px-5 mb-0">Retina</td>
												</tr>
												<tr>
													<td class="bg-100 align-middle">
														<h6
															class="mb-0 text-900 text-uppercase fw-bolder px-4 fs--1 lh-sm"
														>
															Size
														</h6>
													</td>
													<td class="px-5 mb-0">24? (actual diagonal 23.5?)</td>
												</tr>
												<tr>
													<td class="bg-100 align-middle">
														<h6
															class="mb-0 text-900 text-uppercase fw-bolder px-4 fs--1 lh-sm"
														>
															Resolution
														</h6>
													</td>
													<td class="px-5 mb-0">4480 x 2520</td>
												</tr>
												<tr>
													<td class="bg-100 align-middle">
														<h6
															class="mb-0 text-900 text-uppercase fw-bolder px-4 fs--1 lh-sm"
														>
															Brightness
														</h6>
													</td>
													<td class="px-5 mb-0">500 nits</td>
												</tr>
											</tbody>
										</table>
										<h3 class="mb-0 mt-6 ms-4 fw-bold">
											Additional Specifications
										</h3>
										<table class="table">
											<thead>
												<tr>
													<th style="width: 40%"></th>
													<th style="width: 60%"></th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td class="bg-100 align-middle">
														<h6
															class="mb-0 text-900 text-uppercase fw-bolder px-4 fs--1 lh-sm"
														>
															Camera
														</h6>
													</td>
													<td class="px-5 mb-0">1080p FaceTime HD camera</td>
												</tr>
												<tr>
													<td class="bg-100">
														<h6
															class="mb-0 mt-1 text-900 text-uppercase fw-bolder px-4 fs--1 lh-sm"
														>
															Video
														</h6>
													</td>
													<td class="px-5 mb-0">
														Full native resolution on built-in display at 1
														billion colors; <br />One external display with up
														to 6K resolution at 60Hz
													</td>
												</tr>
												<tr>
													<td class="bg-100">
														<h6
															class="mb-0 mt-1 text-900 text-uppercase fw-bolder px-4 fs--1 lh-sm"
														>
															Audio
														</h6>
													</td>
													<td class="px-5 mb-0">
														High-fidelity six-speaker with force-cancelling
														woofers <br />Wide stereo sound <br />Spatial audio
														with Dolby Atmos3<br />Studio-quality three-mic
														array with directional beamforming
													</td>
												</tr>
												<tr>
													<td class="bg-100">
														<h6
															class="mb-0 mt-1 text-900 text-uppercase fw-bolder px-4 fs--1 lh-sm"
														>
															Inputs
														</h6>
													</td>
													<td class="px-5 mb-0">
														Magic Keyboard<br />Magic Mouse
													</td>
												</tr>
												<tr>
													<td class="bg-100">
														<h6
															class="mb-0 mt-1 text-900 text-uppercase fw-bolder px-4 fs--1 lh-sm"
														>
															Wireless
														</h6>
													</td>
													<td class="px-5 mb-0">
														802.11ax Wi-Fi 6 (IEEE 802.11a/b/g/n/ac
														compatible)<br />Bluetooth 5.0 wireless technology
													</td>
												</tr>
												<tr>
													<td class="bg-100">
														<h6
															class="mb-0 mt-1 text-900 text-uppercase fw-bolder px-4 fs--1 lh-sm"
														>
															I/O &amp; expantions
														</h6>
													</td>
													<td class="px-5 mb-0">
														Thunderbolt / USB 4 ports x 2<br />3.5 mm headphone
														jack<br />Gigabit Ethernet<br />USB 3 ports x2
													</td>
												</tr>
												<tr>
													<td class="bg-100 align-middle">
														<h6
															class="mb-0 text-900 text-uppercase fw-bolder px-4 fs--1 lh-sm"
														>
															Operating System
														</h6>
													</td>
													<td class="px-5 mb-0">macOS Monterey</td>
												</tr>
											</tbody>
										</table>
										<h3 class="mb-3 mt-6 ms-4 fw-bold">In The Box</h3>
										<p class="lh-sm border-top mb-0 py-3 px-4">iMac 24?</p>
										<p class="lh-sm border-top mb-0 py-3 px-4">
											Magic Keyboard
										</p>
										<p class="lh-sm border-top mb-0 py-3 px-4">Magic Mouse</p>
										<p class="lh-sm border-top mb-0 py-3 px-4">
											143W power adapter
										</p>
										<p class="lh-sm border-top mb-0 py-3 px-4">2m Power Cord</p>
										<p class="lh-sm border-y mb-0 py-3 px-4">
											USB-C to Lightning Cable
										</p>
									</div>
									<div
										class="tab-pane fade"
										id="tab-reviews"
										role="tabpanel"
										aria-labelledby="reviews-tab"
									>
										<div class="bg-white rounded-3 p-4 border border-200">
											<div class="row g-3 justify-content-between mb-4">
												<div class="col-auto">
													<div class="d-flex align-items-center flex-wrap">
														<h2 class="fw-bolder me-3">
															4.9<span class="fs-0 text-500 fw-bold">/5</span>
														</h2>
														<div class="me-3">
															<span class="fa fa-star text-warning fs-2"></span
															><span class="fa fa-star text-warning fs-2"></span
															><span class="fa fa-star text-warning fs-2"></span
															><span class="fa fa-star text-warning fs-2"></span
															><span
																class="fa fa-star-half-alt star-icon text-warning fs-2"
															></span>
														</div>
														<p class="text-900 mb-0 fw-semi-bold fs-1">
															6548 ratings and 567 reviews
														</p>
													</div>
												</div>
												<div class="col-auto">
													<button
														class="btn btn-primary rounded-pill"
														data-bs-toggle="modal"
														data-bs-target="#reviewModal"
													>
														Rate this product
													</button>
													<div
														class="modal fade"
														id="reviewModal"
														tabindex="-1"
														aria-hidden="true"
													>
														<div class="modal-dialog modal-dialog-centered">
															<div class="modal-content p-4">
																<div class="d-flex flex-between-center mb-2">
																	<h5 class="modal-title fs-0 mb-0">
																		Your rating
																	</h5>
																	<button class="btn p-0 fs--2">Clear</button>
																</div>
																<div
																	class="mb-3"
																	data-rater='{"starSize":32,"step":0.5}'
																></div>
																<div class="mb-3">
																	<h5 class="text-1000 mb-3">Your review</h5>
																	<textarea
																		class="form-control"
																		id="reviewTextarea"
																		rows="5"
																		placeholder="Write your review"
																	>
																	</textarea>
																</div>
																<div
																	class="dropzone dropzone-multiple p-0 mb-3"
																	id="my-awesome-dropzone"
																	data-dropzone
																>
																	<div class="fallback">
																		<input name="file" type="file" multiple />
																	</div>
																	<div class="dz-preview d-flex flex-wrap">
																		<div
																			class="border bg-white rounded-3 d-flex flex-center position-relative me-2 mb-2"
																			style="height: 80px; width: 80px"
																		>
																			<img
																				class="dz-image"
																				src="../../../assets/img/products/23.png"
																				alt="..."
																				data-dz-thumbnail
																			/><a
																				class="dz-remove text-400"
																				href="#!"
																				data-dz-remove
																				><span data-feather="x"></span
																			></a>
																		</div>
																	</div>
																	<div
																		class="dz-message text-600 fw-bold fs--1 p-4"
																		data-dz-message
																	>
																		Drag your photo here
																		<span class="text-800">or </span
																		><button class="btn btn-link p-0">
																			Browse from device</button
																		><br /><img
																			class="mt-3 me-2"
																			src="../../../assets/img/icons/image-icon.png"
																			width="24"
																			alt=""
																		/>
																	</div>
																</div>
																<div class="d-sm-flex flex-between-center">
																	<div class="form-check flex-1">
																		<input
																			class="form-check-input"
																			id="reviewAnonymously"
																			type="checkbox"
																			value=""
																			checked=""
																		/><label
																			class="form-check-label mb-0 text-1100 fw-semi-bold"
																			for="reviewAnonymously"
																			>Review anonymously</label
																		>
																	</div>
																	<button
																		class="btn ps-0"
																		data-bs-dismiss="modal"
																	>
																		Close</button
																	><button class="btn btn-primary rounded-pill">
																		Submit
																	</button>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
											<div
												class="mb-4 hover-actions-trigger btn-reveal-trigger"
											>
												<div class="d-flex justify-content-between">
													<h5 class="mb-2">
														<span class="fa fa-star text-warning"></span
														><span class="fa fa-star text-warning"></span
														><span class="fa fa-star text-warning"></span
														><span class="fa fa-star text-warning"></span
														><span class="fa fa-star text-warning"></span
														><span class="text-800 ms-1"> by</span> Zingko
														Kudobum
													</h5>
													<div
														class="font-sans-serif btn-reveal-trigger position-static"
													>
														<button
															class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal"
															type="button"
															data-bs-toggle="dropdown"
															data-boundary="window"
															aria-haspopup="true"
															aria-expanded="false"
															data-bs-reference="parent"
														>
															<span class="fas fa-ellipsis-h fs--2"></span>
														</button>
														<div class="dropdown-menu dropdown-menu-end py-2">
															<a class="dropdown-item" href="#!">View</a
															><a class="dropdown-item" href="#!">Export</a>
															<div class="dropdown-divider"></div>
															<a class="dropdown-item text-danger" href="#!"
																>Remove</a
															>
														</div>
													</div>
												</div>
												<p class="text-700 fs--1 mb-1">35 mins ago</p>
												<p class="text-1000 mb-3">100% satisfied</p>
												<div class="row g-2 mb-2">
													<div class="col-auto">
														<a
															href="../../../assets/img/e-commerce/review-11.jpg"
															data-gallery="gallery-0"
															><img
																class="w-100"
																src="../../../assets/img/e-commerce/review-11.jpg"
																alt=""
																height="164"
														/></a>
													</div>
													<div class="col-auto">
														<a
															href="../../../assets/img/e-commerce/review-12.jpg"
															data-gallery="gallery-0"
															><img
																class="w-100"
																src="../../../assets/img/e-commerce/review-12.jpg"
																alt=""
																height="164"
														/></a>
													</div>
													<div class="col-auto">
														<a
															href="../../../assets/img/e-commerce/review-13.jpg"
															data-gallery="gallery-0"
															><img
																class="w-100"
																src="../../../assets/img/e-commerce/review-13.jpg"
																alt=""
																height="164"
														/></a>
													</div>
												</div>
												<div class="d-flex">
													<span class="fas fa-reply fa-rotate-180 me-2"></span>
													<div>
														<h5>
															Respond from store<span
																class="text-700 fs--1 ms-2"
																>5 mins ago</span
															>
														</h5>
														<p class="text-1000 mb-0">
															Thank you for your valuable feedback
														</p>
													</div>
												</div>
												<div class="hover-actions top-0">
													<button class="btn btn-sm btn-phoenix-secondary me-2">
														<span class="fas fa-thumbs-up"></span></button
													><button
														class="btn btn-sm btn-phoenix-secondary me-1"
													>
														<span class="fas fa-thumbs-down"></span>
													</button>
												</div>
											</div>
											<div
												class="mb-4 hover-actions-trigger btn-reveal-trigger"
											>
												<div class="d-flex justify-content-between">
													<h5 class="mb-2">
														<span class="fa fa-star text-warning"></span
														><span class="fa fa-star text-warning"></span
														><span class="fa fa-star text-warning"></span
														><span class="fa fa-star text-warning"></span
														><span
															class="fa-regular fa-star text-warning-300"
														></span
														><span class="text-800 ms-1"> by</span> Piere
														Auguste Renoir
													</h5>
													<div
														class="font-sans-serif btn-reveal-trigger position-static"
													>
														<button
															class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal"
															type="button"
															data-bs-toggle="dropdown"
															data-boundary="window"
															aria-haspopup="true"
															aria-expanded="false"
															data-bs-reference="parent"
														>
															<span class="fas fa-ellipsis-h fs--2"></span>
														</button>
														<div class="dropdown-menu dropdown-menu-end py-2">
															<a class="dropdown-item" href="#!">View</a
															><a class="dropdown-item" href="#!">Export</a>
															<div class="dropdown-divider"></div>
															<a class="dropdown-item text-danger" href="#!"
																>Remove</a
															>
														</div>
													</div>
												</div>
												<p class="text-700 fs--1 mb-1">23 Oct, 12:09 PM</p>
												<p class="text-1000 mb-1">
													Since the spring loaded event, I've been wanting an
													iMac, and it's exceeded my expectations. The screen is
													clear, the colors are vibrant (I got the blue one! ),
													and the performance is more than adequate for my needs
													as a college student. That's how good it is.
												</p>
												<div class="hover-actions top-0">
													<button class="btn btn-sm btn-phoenix-secondary me-2">
														<span class="fas fa-thumbs-up"></span></button
													><button
														class="btn btn-sm btn-phoenix-secondary me-1"
													>
														<span class="fas fa-thumbs-down"></span>
													</button>
												</div>
											</div>
											<div
												class="mb-4 hover-actions-trigger btn-reveal-trigger"
											>
												<div class="d-flex justify-content-between">
													<h5 class="mb-2">
														<span class="fa fa-star text-warning"></span
														><span class="fa fa-star text-warning"></span
														><span class="fa fa-star text-warning"></span
														><span
															class="fa fa-star-half-alt star-icon text-warning"
														></span
														><span
															class="fa-regular fa-star text-warning-300"
														></span
														><span class="text-800 ms-1"> by</span> Abel
														Kablmann
													</h5>
													<div
														class="font-sans-serif btn-reveal-trigger position-static"
													>
														<button
															class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal"
															type="button"
															data-bs-toggle="dropdown"
															data-boundary="window"
															aria-haspopup="true"
															aria-expanded="false"
															data-bs-reference="parent"
														>
															<span class="fas fa-ellipsis-h fs--2"></span>
														</button>
														<div class="dropdown-menu dropdown-menu-end py-2">
															<a class="dropdown-item" href="#!">View</a
															><a class="dropdown-item" href="#!">Export</a>
															<div class="dropdown-divider"></div>
															<a class="dropdown-item text-danger" href="#!"
																>Remove</a
															>
														</div>
													</div>
												</div>
												<p class="text-700 fs--1 mb-1">21 Oct, 12:00 PM</p>
												<p class="text-1000 mb-1">
													Over the years, I've preferred Apple products. My job
													has allowed me to use Windows products on laptops and
													PCs. I've owned Windows laptops and desktops for home
													use in the past and will never use them again.
												</p>
												<div class="hover-actions top-0">
													<button class="btn btn-sm btn-phoenix-secondary me-2">
														<span class="fas fa-thumbs-up"></span></button
													><button
														class="btn btn-sm btn-phoenix-secondary me-1"
													>
														<span class="fas fa-thumbs-down"></span>
													</button>
												</div>
											</div>
											<div
												class="mb-4 hover-actions-trigger btn-reveal-trigger"
											>
												<div class="d-flex justify-content-between">
													<h5 class="mb-2">
														<span class="fa fa-star text-warning"></span
														><span class="fa fa-star text-warning"></span
														><span class="fa fa-star text-warning"></span
														><span class="fa fa-star text-warning"></span
														><span class="fa fa-star text-warning"></span
														><span class="text-800 ms-1"> by</span> Pennywise
														Alfred
													</h5>
													<div
														class="font-sans-serif btn-reveal-trigger position-static"
													>
														<button
															class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal"
															type="button"
															data-bs-toggle="dropdown"
															data-boundary="window"
															aria-haspopup="true"
															aria-expanded="false"
															data-bs-reference="parent"
														>
															<span class="fas fa-ellipsis-h fs--2"></span>
														</button>
														<div class="dropdown-menu dropdown-menu-end py-2">
															<a class="dropdown-item" href="#!">View</a
															><a class="dropdown-item" href="#!">Export</a>
															<div class="dropdown-divider"></div>
															<a class="dropdown-item text-danger" href="#!"
																>Remove</a
															>
														</div>
													</div>
												</div>
												<p class="text-700 fs--1 mb-1">35 mins ago</p>
												<p class="text-1000 mb-3">
													Nice and beautiful product.
												</p>
												<div class="row g-2 mb-2">
													<div class="col-auto">
														<a
															href="../../../assets/img/e-commerce/review-14.jpg"
															data-gallery="gallery-3"
															><img
																class="w-100"
																src="../../../assets/img/e-commerce/review-14.jpg"
																alt=""
																height="164"
														/></a>
													</div>
													<div class="col-auto">
														<a
															href="../../../assets/img/e-commerce/review-15.jpg"
															data-gallery="gallery-3"
															><img
																class="w-100"
																src="../../../assets/img/e-commerce/review-15.jpg"
																alt=""
																height="164"
														/></a>
													</div>
													<div class="col-auto">
														<a
															href="../../../assets/img/e-commerce/review-16.jpg"
															data-gallery="gallery-3"
															><img
																class="w-100"
																src="../../../assets/img/e-commerce/review-16.jpg"
																alt=""
																height="164"
														/></a>
													</div>
												</div>
												<div class="hover-actions top-0">
													<button class="btn btn-sm btn-phoenix-secondary me-2">
														<span class="fas fa-thumbs-up"></span></button
													><button
														class="btn btn-sm btn-phoenix-secondary me-1"
													>
														<span class="fas fa-thumbs-down"></span>
													</button>
												</div>
											</div>
											<div class="d-flex justify-content-center">
												<nav>
													<ul class="pagination mb-0">
														<li class="page-item">
															<a class="page-link" href="#!"
																><span class="fas fa-chevron-left"> </span
															></a>
														</li>
														<li class="page-item">
															<a class="page-link" href="#!">1</a>
														</li>
														<li class="page-item">
															<a class="page-link" href="#!">2</a>
														</li>
														<li class="page-item">
															<a class="page-link" href="#!">3</a>
														</li>
														<li class="page-item active">
															<a class="page-link" href="#!">4</a>
														</li>
														<li class="page-item">
															<a class="page-link" href="#!">5</a>
														</li>
														<li class="page-item">
															<a class="page-link" href="#!"
																><span class="fas fa-chevron-right"></span
															></a>
														</li>
													</ul>
												</nav>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-12 col-lg-5 col-xl-4">
								<div class="card">
									<div class="card-body">
										<h5 class="text-black">Usually Bought Together</h5>
										<div class="w-75">
											<p class="text-700 fs--1 fw-bold line-clamp-1">
												with 24" iMac® with Retina 4.5K display - Apple M1 8GB
												Memory - 256GB SSD - w/Touch ID (Latest Model) - Blue
											</p>
										</div>
										<div class="border-dashed border-y py-4">
											<div class="d-flex align-items-center mb-5">
												<div class="form-check mb-0">
													<input
														class="form-check-input"
														type="checkbox"
														checked="checked"
													/><label class="form-check-label"></label>
												</div>
												<img
													class="border rounded"
													src="../../../assets/img/products/2.png"
													width="53"
													alt=""
												/>
												<div class="ms-2">
													<a
														class="fs--1 fw-bold line-clamp-2 mb-2"
														href="product-details.html"
													>
														iPhone 13 pro max-Pacific Blue- 128GB</a
													>
													<h5>$899.99</h5>
												</div>
											</div>
											<div class="d-flex align-items-center mb-5">
												<div class="form-check mb-0">
													<input
														class="form-check-input"
														type="checkbox"
														checked="checked"
													/><label class="form-check-label"></label>
												</div>
												<img
													class="border rounded"
													src="../../../assets/img/products/16.png"
													width="53"
													alt=""
												/>
												<div class="ms-2">
													<a
														class="fs--1 fw-bold line-clamp-2 mb-2"
														href="product-details.html"
														>Apple AirPods Pro</a
													>
													<h5>$59.00</h5>
												</div>
											</div>
											<div class="d-flex align-items-center mb-0">
												<div class="form-check mb-0">
													<input
														class="form-check-input"
														type="checkbox"
													/><label class="form-check-label"></label>
												</div>
												<img
													class="border rounded"
													src="../../../assets/img/products/10.png"
													width="53"
													alt=""
												/>
												<div class="ms-2">
													<a
														class="fs--1 fw-bold line-clamp-2 mb-2"
														href="product-details.html"
														>Apple Magic Mouse (Wireless, Rechargable) - Silver,
														Worst mouse ever</a
													>
													<h5>$89.00</h5>
												</div>
											</div>
										</div>
										<div
											class="d-flex align-items-end justify-content-between pt-3"
										>
											<div>
												<h5 class="mb-2 text-600">Total</h5>
												<h4 class="mb-0 text-1100">$958.99</h4>
											</div>
											<div class="btn btn-outline-warning">
												Add 3 items to cart<span
													class="fas fa-shopping-cart ms-2"
												></span>
											</div>
										</div>
									</div>
								</div>
							</div>
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
							data-swiper='{"slidesPerView":1,"spaceBetween":16,"breakpoints":{"450":{"slidesPerView":2,"spaceBetween":16},"768":{"slidesPerView":3,"spaceBetween":16},"992":{"slidesPerView":4,"spaceBetween":16},"1200":{"slidesPerView":5,"spaceBetween":16},"1540":{"slidesPerView":6,"spaceBetween":16}}}'
						>
							<div class="swiper-wrapper">
								<div class="swiper-slide">
									<div
										class="position-relative text-decoration-none product-card h-100"
									>
										<div
											class="d-flex flex-column justify-content-between h-100"
										>
											<div>
												<div
													class="border border-1 rounded-3 position-relative mb-3"
												>
													<button
														class="btn rounded-circle p-0 d-flex flex-center btn-wish z-index-2 d-toggle-container btn-outline-primary"
														data-bs-toggle="tooltip"
														data-bs-placement="top"
														title="Add to wishlist"
													>
														<span class="fas fa-heart d-block-hover"></span
														><span
															class="far fa-heart d-none-hover"
														></span></button
													><img
														class="img-fluid"
														src="../../../assets/img/products/1.png"
														alt=""
													/>
												</div>
												<a
													class="stretched-link text-decoration-none"
													href="product-details.html"
												>
													<h6 class="mb-2 lh-sm line-clamp-3 product-name">
														Fitbit Sense Advanced Smartwatch with Tools for
														Heart Health, Stress Management &amp;amp; Skin
														Temperature Trends Carbon/Graphite, One Size (S
														&amp; L Bands)
													</h6>
												</a>
												<p class="fs--1">
													<span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="text-500 fw-semi-bold ms-1"
														>(59 people rated)</span
													>
												</p>
											</div>
											<div>
												<div class="d-flex align-items-center mb-1">
													<p
														class="me-2 text-900 text-decoration-line-through mb-0"
													>
														$49.99
													</p>
													<h3 class="text-1100 mb-0">$34.99</h3>
												</div>
												<p class="text-700 fw-semi-bold fs--1 lh-1 mb-0">
													2 colors
												</p>
											</div>
										</div>
									</div>
								</div>
								<div class="swiper-slide">
									<div
										class="position-relative text-decoration-none product-card h-100"
									>
										<div
											class="d-flex flex-column justify-content-between h-100"
										>
											<div>
												<div
													class="border border-1 rounded-3 position-relative mb-3"
												>
													<button
														class="btn rounded-circle p-0 d-flex flex-center btn-wish z-index-2 d-toggle-container btn-outline-primary"
														data-bs-toggle="tooltip"
														data-bs-placement="top"
														title="Add to wishlist"
													>
														<span class="fas fa-heart d-block-hover"></span
														><span
															class="far fa-heart d-none-hover"
														></span></button
													><img
														class="img-fluid"
														src="../../../assets/img/products/3.png"
														alt=""
													/>
												</div>
												<a
													class="stretched-link text-decoration-none"
													href="product-details.html"
												>
													<h6 class="mb-2 lh-sm line-clamp-3 product-name">
														Apple MacBook Pro 13 inch-M1-8/256GB-Space Gray
													</h6>
												</a>
												<p class="fs--1">
													<span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="text-500 fw-semi-bold ms-1"
														>(13 people rated)</span
													>
												</p>
											</div>
											<div>
												<p class="fs--1 text-1000 fw-bold mb-2">
													Apple care included
												</p>
												<div class="d-flex align-items-center mb-1">
													<p
														class="me-2 text-900 text-decoration-line-through mb-0"
													>
														$1299.00
													</p>
													<h3 class="text-1100 mb-0">$1149.00</h3>
												</div>
												<p class="text-700 fw-semi-bold fs--1 lh-1 mb-0">
													2 colors
												</p>
											</div>
										</div>
									</div>
								</div>
								<div class="swiper-slide">
									<div
										class="position-relative text-decoration-none product-card h-100"
									>
										<div
											class="d-flex flex-column justify-content-between h-100"
										>
											<div>
												<div
													class="border border-1 rounded-3 position-relative mb-3"
												>
													<button
														class="btn rounded-circle p-0 d-flex flex-center btn-wish z-index-2 d-toggle-container btn-outline-primary"
														data-bs-toggle="tooltip"
														data-bs-placement="top"
														title="Add to wishlist"
													>
														<span class="fas fa-heart d-block-hover"></span
														><span
															class="far fa-heart d-none-hover"
														></span></button
													><img
														class="img-fluid"
														src="../../../assets/img/products/5.png"
														alt=""
													/>
												</div>
												<a
													class="stretched-link text-decoration-none"
													href="product-details.html"
												>
													<h6 class="mb-2 lh-sm line-clamp-3 product-name">
														Razer Kraken v3 x Wired 7.1 Surroung Sound Gaming
														headset
													</h6>
												</a>
												<p class="fs--1">
													<span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="text-500 fw-semi-bold ms-1"
														>(64 people rated)</span
													>
												</p>
											</div>
											<div>
												<h3 class="text-1100">$59.00</h3>
												<p class="text-700 fw-semi-bold fs--1 lh-1 mb-0">
													1 colors
												</p>
											</div>
										</div>
									</div>
								</div>
								<div class="swiper-slide">
									<div
										class="position-relative text-decoration-none product-card h-100"
									>
										<div
											class="d-flex flex-column justify-content-between h-100"
										>
											<div>
												<div
													class="border border-1 rounded-3 position-relative mb-3"
												>
													<button
														class="btn rounded-circle p-0 d-flex flex-center btn-wish z-index-2 d-toggle-container btn-outline-primary"
														data-bs-toggle="tooltip"
														data-bs-placement="top"
														title="Add to wishlist"
													>
														<span class="fas fa-heart d-block-hover"></span
														><span
															class="far fa-heart d-none-hover"
														></span></button
													><img
														class="img-fluid"
														src="../../../assets/img/products/2.png"
														alt=""
													/><span
														class="badge bg-success fs--2 product-verified-badge"
														>Verified<span class="fas fa-check ms-1"></span
													></span>
												</div>
												<a
													class="stretched-link text-decoration-none"
													href="product-details.html"
												>
													<h6 class="mb-2 lh-sm line-clamp-3 product-name">
														iPhone 13 pro max-Pacific Blue, 128GB storage
													</h6>
												</a>
												<p class="fs--1">
													<span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="text-500 fw-semi-bold ms-1"
														>(32 people rated)</span
													>
												</p>
											</div>
											<div>
												<p class="fs--1 text-1000 fw-bold mb-2">
													Stock limited
												</p>
												<div class="d-flex align-items-center mb-1">
													<p
														class="me-2 text-900 text-decoration-line-through mb-0"
													>
														$899.99
													</p>
													<h3 class="text-1100 mb-0">$855.00</h3>
												</div>
												<p class="text-700 fw-semi-bold fs--1 lh-1 mb-0">
													5 colors
												</p>
											</div>
										</div>
									</div>
								</div>
								<div class="swiper-slide">
									<div
										class="position-relative text-decoration-none product-card h-100"
									>
										<div
											class="d-flex flex-column justify-content-between h-100"
										>
											<div>
												<div
													class="border border-1 rounded-3 position-relative mb-3"
												>
													<button
														class="btn rounded-circle p-0 d-flex flex-center btn-wish z-index-2 d-toggle-container btn-outline-primary"
														data-bs-toggle="tooltip"
														data-bs-placement="top"
														title="Add to wishlist"
													>
														<span class="fas fa-heart d-block-hover"></span
														><span
															class="far fa-heart d-none-hover"
														></span></button
													><img
														class="img-fluid"
														src="../../../assets/img/products/16.png"
														alt=""
													/>
												</div>
												<a
													class="stretched-link text-decoration-none"
													href="product-details.html"
												>
													<h6 class="mb-2 lh-sm line-clamp-3 product-name">
														Apple AirPods Pro
													</h6>
												</a>
												<p class="fs--1">
													<span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="text-500 fw-semi-bold ms-1"
														>(39 people rated)</span
													>
												</p>
											</div>
											<div>
												<p class="fs--1 text-1000 fw-bold mb-1">
													free with iPhone 5s
												</p>
												<p class="fs--1 text-700 mb-2">Ships to Canada</p>
												<h3 class="text-1100">$59.00</h3>
												<p class="text-700 fw-semi-bold fs--1 lh-1 mb-0">
													3 colors
												</p>
											</div>
										</div>
									</div>
								</div>
								<div class="swiper-slide">
									<div
										class="position-relative text-decoration-none product-card h-100"
									>
										<div
											class="d-flex flex-column justify-content-between h-100"
										>
											<div>
												<div
													class="border border-1 rounded-3 position-relative mb-3"
												>
													<button
														class="btn rounded-circle p-0 d-flex flex-center btn-wish z-index-2 d-toggle-container btn-outline-primary"
														data-bs-toggle="tooltip"
														data-bs-placement="top"
														title="Add to wishlist"
													>
														<span class="fas fa-heart d-block-hover"></span
														><span
															class="far fa-heart d-none-hover"
														></span></button
													><img
														class="img-fluid"
														src="../../../assets/img/products/10.png"
														alt=""
													/>
												</div>
												<a
													class="stretched-link text-decoration-none"
													href="product-details.html"
												>
													<h6 class="mb-2 lh-sm line-clamp-3 product-name">
														Apple Magic Mouse (Wireless, Rechargable) - Silver
													</h6>
												</a>
												<p class="fs--1">
													<span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="text-500 fw-semi-bold ms-1"
														>(6 people rated)</span
													>
												</p>
											</div>
											<div>
												<p class="fs--1 text-1000 fw-bold mb-1">
													Bundle availabe
												</p>
												<p class="fs--1 text-700 mb-2">Charger not included</p>
												<h3 class="text-1100">$89.00</h3>
												<p class="text-700 fw-semi-bold fs--1 lh-1 mb-0">
													2 colors
												</p>
											</div>
										</div>
									</div>
								</div>
								<div class="swiper-slide">
									<div
										class="position-relative text-decoration-none product-card h-100"
									>
										<div
											class="d-flex flex-column justify-content-between h-100"
										>
											<div>
												<div
													class="border border-1 rounded-3 position-relative mb-3"
												>
													<button
														class="btn rounded-circle p-0 d-flex flex-center btn-wish z-index-2 d-toggle-container btn-outline-primary"
														data-bs-toggle="tooltip"
														data-bs-placement="top"
														title="Add to wishlist"
													>
														<span class="fas fa-heart d-block-hover"></span
														><span
															class="far fa-heart d-none-hover"
														></span></button
													><img
														class="img-fluid"
														src="../../../assets/img/products/6.png"
														alt=""
													/>
												</div>
												<a
													class="stretched-link text-decoration-none"
													href="product-details.html"
												>
													<h6 class="mb-2 lh-sm line-clamp-3 product-name">
														PlayStation 5 DualSense Wireless Controller
													</h6>
												</a>
												<p class="fs--1">
													<span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="fa fa-star text-warning"></span
													><span class="text-500 fw-semi-bold ms-1"
														>(67 people rated)</span
													>
												</p>
											</div>
											<div>
												<div class="d-flex align-items-center mb-1">
													<p
														class="me-2 text-900 text-decoration-line-through mb-0"
													>
														$125.00
													</p>
													<h3 class="text-1100 mb-0">$89.00</h3>
												</div>
												<p class="text-700 fw-semi-bold fs--1 lh-1 mb-0">
													2 colors
												</p>
											</div>
										</div>
									</div>
								</div>
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
	</body>
</html>
