<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="theme-color" content="#ffffff">
<script src="<c:url value="/resources/vendors/imagesloaded/imagesloaded.pkgd.min.js"/>"></script>
<script src="<c:url value="/resources/vendors/simplebar/simplebar.min.js"/>"></script>
<script src="<c:url value="/resources/assets/js/config.js"/>"></script>
<link href="<c:url value="/resources/vendors/choices/choices.min.css"/>" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com/">
<link rel="preconnect" href="https://fonts.gstatic.com/" crossorigin="">
<link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;600;700;800;900&amp;display=swap" rel="stylesheet">
<link href="<c:url value="/resources/vendors/simplebar/simplebar.min.css"/>" rel="stylesheet">
<link href="<c:url value="/resources/assets/css/theme-rtl.min.css"/>" type="text/css" rel="stylesheet" id="style-rtl">
<link href="<c:url value="/resources/assets/css/theme.min.css"/>" type="text/css" rel="stylesheet" id="style-default">
<link href="<c:url value="/resources/assets/css/user-rtl.min.css"/>" type="text/css" rel="stylesheet" id="user-style-rtl">
<link href="<c:url value="/resources/assets/css/user.min.css"/>" type="text/css" rel="stylesheet" id="user-style-default">
<script>
  let phoenixIsRTL = window.config.config.phoenixIsRTL;
  if (phoenixIsRTL) {
    let linkDefault = document.getElementById('style-default');
    let userLinkDefault = document.getElementById('user-style-default');
    linkDefault.setAttribute('disabled', true);
    userLinkDefault.setAttribute('disabled', true);
    document.querySelector('html').setAttribute('dir', 'rtl');
  } else {
    let linkRTL = document.getElementById('style-rtl');
    let userLinkRTL = document.getElementById('user-style-rtl');
    linkRTL.setAttribute('disabled', true);
    userLinkRTL.setAttribute('disabled', true);
  }
</script>
<link href="<c:url value="/resources/vendors/leaflet/leaflet.css"/>" rel="stylesheet">
<link href="<c:url value="/resources/vendors/leaflet.markercluster/MarkerCluster.css"/>" rel="stylesheet">
<link href="<c:url value="/resources/vendors/leaflet.markercluster/MarkerCluster.Default.css"/>" rel="stylesheet">
<link href="<c:url value="/resources/vendors/dropzone/dropzone.min.css"/>" rel="stylesheet">

<link href="<c:url value="/resources/vendors/flatpickr/flatpickr.min.css"/>" rel="stylesheet">
<link href="<c:url value="/resources/assets/css/toastify.css"/>" rel="stylesheet">
