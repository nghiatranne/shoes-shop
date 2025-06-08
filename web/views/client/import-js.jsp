<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="<c:url value="/resources/vendors/popper/popper.min.js"/>"></script>
<script src="<c:url value="/resources/vendors/bootstrap/bootstrap.min.js"/>"></script>
<script src="<c:url value="/resources/vendors/anchorjs/anchor.min.js"/>"></script>
<script src="<c:url value="/resources/vendors/is/is.min.js"/>"></script>
<script src="<c:url value="/resources/vendors/fontawesome/all.min.js"/>"></script>
<script src="<c:url value="/resources/vendors/lodash/lodash.min.js"/>"></script>
<script src="<c:url value="/resources/vendors/list.js/list.min.js"/>"></script>
<script src="<c:url value="/resources/vendors/feather-icons/feather.min.js"/>"></script>
<script src="<c:url value="/resources/vendors/dayjs/dayjs.min.js"/>"></script>
<script src="<c:url value="/resources/assets/js/phoenix.js"/>"></script>
<script src="<c:url value="/resources/vendors/swiper/swiper-bundle.min.js"/>"></script>
<script src="<c:url value="/resources/assets/js/jquery.validate.min.js"/>"></script>
<script src="<c:url value="/resources/assets/js/toastify.js"/>"></script>
<script src="<c:url value="/resources/assets/js/show_toast.js"/>"></script>
<script>
  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".swiper-container").forEach(function (container) {
      const configAttr = container.getAttribute("data-swiper");
      const config = configAttr ? JSON.parse(configAttr) : {};

      const parent = container.closest(".swiper-theme-container");
      const nextBtn = parent?.querySelector(".swiper-button-next");
      const prevBtn = parent?.querySelector(".swiper-button-prev");

      new Swiper(container, {
        ...config,
        loop: true,
        autoplay: {
          delay: 7000,
          disableOnInteraction: false
        },
        navigation: {
          nextEl: nextBtn,
          prevEl: prevBtn
        }
      });
    });
  });
</script>