<%-- Document : ListBook Created on : Mar 2, 2024, 3:27:57 AM Author : hoaht
--%> <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@page
contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Cart</title>

		<jsp:include page="import-css.jsp" />
	</head>
	<body>
		<main class="main" id="top">
			<jsp:include page="layout/header.jsp" />

			<jsp:include page="layout/navigation.jsp" />

			<section class="pt-5 pb-9">
				<div class="container-small cart">
					<h2 class="mb-6">Cart</h2>

					<c:if test="${paid_canceled == true}">
						<span class="badge badge-phoenix fs-0 badge-phoenix-warning mb-3">
							<span class="badge-label">You have canceled your payment!</span>
							<span class="ms-1 fs-0" data-feather="info"></span>
						</span>
					</c:if>

					<div class="row g-5">
						<div class="col-12 col-lg-8">
							<div>
								<div class="table-responsive scrollbar mx-n1 px-1">
									<table class="table fs--1 mb-0 border-top border-200">
										<thead>
											<tr>
												<th
													class="sort white-space-nowrap align-middle fs--2"
													scope="col"
													style="min-width: 100px"
												></th>
												<th
													class="sort white-space-nowrap align-middle"
													e="col"
													style="min-width: 150px"
												>
													Image
												</th>
												<th
													class="sort align-middle"
													scope="col"
													style="width: 80px"
												>
													Product
												</th>
												<th
													class="sort align-middle"
													scope="col"
													style="width: 150px"
												>
													Size
												</th>
												<th
													class="sort align-middle text-end"
													pe="col"
													style="width: 400px"
												>
													Price
												</th>
												<th
													class="sort align-middle ps-5"
													scope="col"
													style="width: 200px"
												>
													Quantity
												</th>
												<th
													class="sort text-end align-middle pe-0"
													scope="col"
												></th>
											</tr>
										</thead>
										<tbody class="list" id="cart-table-body"></tbody>
									</table>
									<div class="col-6 mt-3">
										<a
											href="${pageContext.request.contextPath}/homepage"
											class="btn btn-primary px-8 px-sm-11"
										>
											Choose More Product
										</a>
									</div>
								</div>
							</div>
						</div>
						<div class="col-12 col-lg-4">
							<div class="card">
								<div class="card-body">
									<div class="d-flex flex-between-center mb-3">
										<h3 class="card-title mb-0">Summary</h3>
									</div>
									<div>
										<div class="d-flex justify-content-between">
											<p class="text-900 fw-semi-bold">Items subtotal :</p>
											<p id="sub_total" class="text-1100 fw-semi-bold"></p>
										</div>
									</div>
									<div
										class="d-flex justify-content-between border-y border-dashed py-3 mb-4"
									>
										<h4 class="mb-0">Total :</h4>
										<h4 class="mb-0" id="total"></h4>
									</div>
									<a
										href="${pageContext.request.contextPath}/cart/infor"
										class="btn btn-primary w-100"
										>Proceed to check out<span
											class="fas fa-chevron-right ms-1 fs--2"
										></span
									></a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</main>
	</body>

	<jsp:include page="import-js.jsp" />

	<script>
		function fetchCart() {
			fetch("http://localhost:9999/ShoesShop/api/carts")
				.then((res) => res.json())
				.then((data) => renderCart(data));
		}

		function renderCart(cartItems) {
			const tbody = document.getElementById("cart-table-body");
			tbody.innerHTML = "";
			cartItems.forEach((item) => {
				const tr = document.createElement("tr");
				tr.innerHTML = `
                <td>
                    <img src="/resources/product_image/${
											item.productVariantImage
										}" style="width:60px;height:60px;object-fit:cover;">
                </td>
                <td>${item.productName}</td>
                <td>${item.sizeValue}</td>
                <td>
                    <button onclick="changeQuantity(${item.pvsId}, ${
					item.quantity - 1
				})" ${item.quantity <= 1 ? "disabled" : ""}>-</button>
                    <span style="margin:0 8px;">${item.quantity}</span>
                    <button onclick="changeQuantity(${item.pvsId}, ${
					item.quantity + 1
				})">+</button>
                </td>
                <td>
                    <button onclick="removeCart(${
											item.pvsId
										})" style="color:red;">Xóa</button>
                </td>
            `;
				tbody.appendChild(tr);
			});
		}

		function changeQuantity(pvsId, newQuantity) {
			if (newQuantity < 1) return;
			const url =
				newQuantity > 1 ? "http://localhost:9999/ShoesShop/api/carts/increase" : "http://localhost:9999/ShoesShop/api/carts/decrease";
			fetch(url, {
				method: "POST",
				headers: { "Content-Type": "application/x-www-form-urlencoded" },
				body: `book_id=${pvsId}&quantity=${newQuantity}`,
			}).then((res) => {
				fetchCart();
			});
		}

		function removeCart(pvsId) {
			fetch(`http://localhost:9999/ShoesShop/api/carts/del?book_id=${pvsId}`).then((res) => fetchCart());
		}

		document.addEventListener("DOMContentLoaded", fetchCart);
	</script>
</html>
