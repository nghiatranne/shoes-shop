<%-- Document : ListSlider Created on : Jun 3, 2024, 9:37:12 AM Author : USA
--%> <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@page
contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Slider Management</title>
		<jsp:include page="import-css.jsp" />
	</head>
	<body>
		<jsp:include page="layout/navigation.jsp" />

		<jsp:include page="layout/header-nav.jsp" />

		<div class="content">
			<div class="">
				<div class="row g-3 mb-4">
					<div class="col-auto">
						<h2 class="mb-0">Slider Management</h2>
					</div>
				</div>
				<div id="sliders">
					<div class="mb-4">
						<div class="row g-3">
							<div class="col-auto">
								<div class="search-box">
									<form class="position-relative" action="" method="get">
										<input
											class="form-control search-input search"
											name="q"
											type="search"
											placeholder="Search slider by title"
											aria-label="Search"
										/>
										<span class="fas fa-search search-box-icon"></span>
									</form>
								</div>
							</div>
							<div class="col-auto">
								<select
									class="form-select form-select-sm"
									data-list-filter="data-list-filter"
								>
									<option selected="" value="">Select status</option>
									<option value="SHOWING">Showing</option>
									<option value="HIDDEN">Hidden</option>
								</select>
							</div>
							<div class="col-auto">
								<button
									type="button"
									class="btn btn-phoenix-secondary"
									id="addBtn"
									data-bs-toggle="modal"
									data-bs-target="#addSliderModal"
								>
									<span class="fas fa-plus me-2"></span>Create New Slider
								</button>
							</div>
						</div>
					</div>
					<div
						id="tableExample2"
						class="mx-n4 px-4 mx-lg-n6 px-lg-6 bg-white border-top border-bottom border-200 position-relative top-1"
						data-list='{"valueNames":["title","status","createAt"],"page":5,"pagination":true,"filter":{"key":"status"}}'
					>
						<div class="table-responsive scrollbar mx-n1 px-1">
							<table class="table fs--1 mb-0">
								<thead>
									<tr>
										<th
											class="white-space-nowrap fs--1 align-middle ps-0"
											style="width: 200px"
										>
											IMAGE
										</th>
										<th
											class="sort white-space-nowrap align-middle ps-4"
											data-sort="title"
											scope="col"
											style="width: 400px"
										>
											TITLE
										</th>
										<th
											class="sort align-middle ps-3"
											data-sort="status"
											scope="col"
											style="width: 500px"
										>
											STATUS
										</th>
										<th
											class="sort align-middle ps-4"
											data-sort="createAt"
											scope="col"
											style="width: 500px"
										>
											START DATE
										</th>
										<th
											class="sort align-middle ps-4"
											data-sort="createAt"
											scope="col"
											style="width: 500px"
										>
											END DATE
										</th>
										<th
											class="sort align-middle ps-4"
											data-sort="createAt"
											scope="col"
											style="width: 500px"
										>
											CREATE AT
										</th>
										<th
											class="text-end align-middle pe-0 ps-4"
											scope="col"
										></th>
									</tr>
								</thead>
								<tbody class="list">
									<c:forEach items="${sliders}" var="s">
										<tr class="slider position-static">
											<td class="align-middle white-space-nowrap p-0 py-1">
												<div class="border rounded-2">
													<img
														class="rounded-2 p-0"
														src="<c:url value='/resources/slider_image/${s.imageUrl}'/>"
														width="100%"
													/>
												</div>
											</td>
											<td class="title align-middle ps-4 fs-0">
												<a
													class="fw-semi-bold line-clamp-3 mb-0"
													href="${pageContext.request.contextPath}/admin/sliders/slider?id=${s.id}"
												>
													${s.title}
												</a>
											</td>
											<td
												class="status align-middle review pb-2 ps-3"
												style="min-width: 225px"
											>
												<c:choose>
													<c:when test="${s.status}">
														<span class="text-success fw-bold fs--1"
															><span class="fas fa-check-circle me-1"></span
															>SHOWING</span
														>
													</c:when>
													<c:otherwise>
														<span class="text-warning fw-bold fs--1"
															><span class="fas fa-check-circle me-1"></span
															>HIDDEN</span
														>
													</c:otherwise>
												</c:choose>
											</td>
											<td
												class="createAt align-middle white-space-nowrap text-600 ps-4"
											>
												<fmt:formatDate
													value="${s.startDate}"
													pattern="dd MMMM, yyyy"
												/>
											</td>
											<td
												class="createAt align-middle white-space-nowrap text-600 ps-4"
											>
												<fmt:formatDate
													value="${s.endDate}"
													pattern="dd MMMM, yyyy"
												/>
											</td>
											<td
												class="createAt align-middle white-space-nowrap text-600 ps-4"
											>
												<fmt:formatDate
													value="${s.createAt}"
													pattern="dd MMMM, yyyy"
												/>
											</td>
											<td class="align-middle">
												<div class="mb-2">
													<a
														href="${pageContext.request.contextPath}/admin/sliders/edit?id=${s.id}"
														class="btn btn-outline-primary d-flex align-items-center justify-content-center mb-1 py-1 px-2"
														type="button"
													>
														<span class="fs-4 me-2" data-feather="edit"></span>
														Edit
													</a>
												</div>
												<div class="mb-2">
													<c:choose>
														<c:when test="${s.status == true}">
															<a
																href="${pageContext.request.contextPath}/admin/sliders/update-status?sliderId=${s.id}&status=false"
																class="btn btn-outline-secondary d-flex align-items-center justify-content-center mb-1 py-1 px-2"
																type="button"
															>
																<span
																	class="fs-4 me-2"
																	data-feather="eye"
																></span>
																Hide
															</a>
														</c:when>
														<c:otherwise>
															<a
																href="${pageContext.request.contextPath}/admin/sliders/update-status?sliderId=${s.id}&status=true"
																class="btn btn-outline-secondary d-flex align-items-center justify-content-center mb-1 py-1 px-2"
																type="button"
															>
																<span
																	class="fs-4 me-2"
																	data-feather="eye-off"
																></span>
																Show
															</a>
														</c:otherwise>
													</c:choose>
												</div>
												<div>
													<button
														class="btn btn-outline-danger d-flex align-items-center justify-content-center py-1 px-2"
														type="button"
														data-bs-toggle="modal"
														data-bs-target="#model_delete_${s.id}"
													>
														<span
															class="fs-4 me-2"
															data-feather="trash-2"
														></span>
														Delete
													</button>
												</div>

												<div
													class="modal fade"
													id="model_delete_${s.id}"
													tabindex="-1"
													aria-labelledby="exampleModalLabel"
													aria-hidden="true"
												>
													<div class="modal-dialog">
														<div class="modal-content">
															<div class="modal-header">
																<h5 class="modal-title" id="exampleModalLabel">
																	Delete Slider
																</h5>
																<button
																	type="button"
																	class="btn-close"
																	data-bs-dismiss="modal"
																	aria-label="Close"
																></button>
															</div>
															<div class="modal-body">
																Are you sure you want to delete this slider?
															</div>
															<div class="modal-footer">
																<button
																	type="button"
																	class="btn btn-secondary"
																	data-bs-dismiss="modal"
																>
																	Cancel
																</button>
																<a
																	href="${pageContext.request.contextPath}/admin/slider/delete?id=${s.id}"
																	class="btn btn-danger"
																	>Delete</a
																>
															</div>
														</div>
													</div>
												</div>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="d-flex justify-content-center my-3">
							<button class="page-link" data-list-pagination="prev">
								<span class="fas fa-chevron-left"></span>
							</button>
							<ul class="mb-0 pagination"></ul>
							<button class="page-link pe-0" data-list-pagination="next">
								<span class="fas fa-chevron-right"></span>
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<jsp:include page="import-js.jsp" />

		<script>
			let dashboard_tag = document.getElementById("sliders-manage");
			dashboard_tag.classList.add("active");
		</script>

		<!-- Modal for Add Slider -->
		<div
			class="modal fade"
			id="addSliderModal"
			tabindex="-1"
			aria-labelledby="addSliderModalLabel"
			aria-hidden="true"
		>
			<div class="modal-dialog">
				<form
					class="modal-content"
					id="addNewSlider"
					action="${pageContext.request.contextPath}/admin/sliders/add"
					method="post"
					enctype="multipart/form-data"
				>
					<div class="modal-header">
						<h5 class="modal-title" id="addSliderModalLabel">
							Create New Slider
						</h5>
						<button
							type="button"
							class="btn-close"
							data-bs-dismiss="modal"
							aria-label="Close"
						></button>
					</div>
					<div class="modal-body">
						<div class="mb-3">
							<label for="sliderTitle" class="form-label">Title</label>
							<input
								type="text"
								class="form-control"
								id="sliderTitle"
								name="title"
								placeholder="Slider title"
								required
							/>
						</div>
						<div class="mb-3">
							<label for="sliderImage" class="form-label">Image</label>
							<input
								type="file"
								class="form-control"
								id="sliderImage"
								name="imageUrl"
								accept="image/png, image/jpeg"
								required
							/>
						</div>
						<div class="mb-3">
							<label for="sliderLinkUrl" class="form-label">Link URL</label>
							<input
								type="text"
								class="form-control"
								id="sliderLinkUrl"
								name="linkUrl"
								placeholder="Link URL"
								required
							/>
						</div>
						<div class="mb-3">
							<label for="sliderStartDate" class="form-label">Start Date</label>
							<input
								type="date"
								class="form-control"
								id="sliderStartDate"
								name="startDate"
								required
							/>
						</div>
						<div class="mb-3">
							<label for="sliderEndDate" class="form-label">End Date</label>
							<input
								type="date"
								class="form-control"
								id="sliderEndDate"
								name="endDate"
								required
							/>
						</div>
					</div>
					<div class="modal-footer">
						<button
							type="button"
							class="btn btn-secondary"
							data-bs-dismiss="modal"
						>
							Cancel
						</button>
						<button type="submit" class="btn btn-primary">Create</button>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>
