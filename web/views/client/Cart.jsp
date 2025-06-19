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
		<style>
			#cart-table-body td,
			#cart-table-body th {
				vertical-align: middle;
				text-align: center;
			}
			#cart-table-body img {
				border-radius: 8px;
				border: 1px solid #eee;
				background: #fafafa;
			}
			.cart-qty-btn {
				background: #f5f5f5;
				border: 1px solid #ccc;
				border-radius: 4px;
				width: 28px;
				height: 28px;
				font-weight: bold;
				color: #333;
				transition: background 0.2s;
			}
			.cart-qty-btn:disabled {
				opacity: 0.5;
			}
			.cart-qty-btn:hover:not(:disabled) {
				background: #e0e0e0;
			}
			.cart-remove-btn {
				background: #fff0f0;
				border: 1px solid #ffb3b3;
				color: #d90429;
				border-radius: 4px;
				padding: 2px 10px;
				font-weight: bold;
				transition: background 0.2s, color 0.2s;
			}
			.cart-remove-btn:hover {
				background: #ffb3b3;
				color: #fff;
			}
			.cart-total-bold {
				font-weight: bold;
				color: #1a1a1a;
				font-size: 1.1em;
			}
		</style>
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
												<th>Image</th>
												<th>Product</th>
												<th>Size</th>
												<th>Price</th>
												<th>Quantity</th>
												<th></th>
												<th>Total</th>
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
			let subTotal = 0;
			cartItems.forEach(function (item) {
				const itemTotal = item.price * item.quantity;
				subTotal += itemTotal;
				var productDisplay = "<strong>" + item.productVariantName + "</strong>";
				
				var newRow =
					"<tr>" +
					'<td><img src="http://localhost:9999/ShoesShop/resources/product_image/' +
					item.productVariantImage +
					'" style="width:60px;height:60px;object-fit:cover;"></td>' +
					"<td>" +
					productDisplay +
					"</td>" +
					"<td>" +
					item.sizeValue +
					"</td>" +
					"<td class='cart-total-bold'>" +
					item.price.toLocaleString("vi-VN") +
					" đ</td>" +
					"<td>" +
					'<button class="cart-qty-btn" onclick="changeQuantity(' +
					item.pvsId +
					", " +
					(item.quantity - 1) +
					')" ' +
					(item.quantity <= 1 ? "disabled" : "") +
					">-</button>" +
					'<span style="margin:0 8px;min-width:32px;display:inline-block;">' +
					item.quantity +
					"</span>" +
					'<button class="cart-qty-btn" onclick="changeQuantity(' +
					item.pvsId +
					", " +
					(item.quantity + 1) +
					')">+</button>' +
					"</td>" +
					'<td><button class="cart-remove-btn" onclick="removeCart(' +
					item.pvsId +
					')">Xóa</button></td>' +
					'<td class="text-end cart-total-bold">' +
					itemTotal.toLocaleString("vi-VN") +
					" đ</td>" +
					"</tr>";
				tbody.innerHTML += newRow;
			});
			document.getElementById("sub_total").textContent =
				subTotal.toLocaleString("vi-VN") + " đ";
			document.getElementById("total").textContent =
				subTotal.toLocaleString("vi-VN") + " đ";
		}

		function changeQuantity(pvsId, newQuantity) {
			if (newQuantity < 1) return;
			const url =
				newQuantity > 1
					? "http://localhost:9999/ShoesShop/api/carts/increase"
					: "http://localhost:9999/ShoesShop/api/carts/decrease";
			fetch(url, {
				method: "POST",
				headers: { "Content-Type": "application/x-www-form-urlencoded" },
				body: `book_id=${pvsId}&quantity=${newQuantity}`,
			}).then((res) => {
				fetchCart();
			});
		}

		function removeCart(pvsId) {
			fetch(
				`http://localhost:9999/ShoesShop/api/carts/del?book_id=${pvsId}`
			).then((res) => fetchCart());
		}

		document.addEventListener("DOMContentLoaded", fetchCart);
	</script>
</html>
