<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>
 <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link ref="stylesheet" type="text/css" href="${root }/resources/css/commons.css">

<div class="container-700 container-center">
	 
	 <div class="mt-5 mb-3"><h3>STATISTICS MENU</h3></div>
		
		<div class="list-group">
		  <a href="${root}/admin/statistics/visitor_daily" class="list-group-item list-group-item-action p-3" aria-current="true">
		    <div class="d-flex w-100 justify-content-between">
		      <h5 class="mb-1">VISITOR Daily</h5>
		      <small>방문자 일별 통계</small>
		    </div>
		  </a>
		 <a href="${root}/admin/statistics/visitor_monthly" class="list-group-item list-group-item-action p-3" aria-current="true">
		    <div class="d-flex w-100 justify-content-between">
		      <h5 class="mb-1">VISITOR Monthly</h5>
		      <small>방문자 월별 통계</small>
		    </div>
		  </a>
		  <a href="${root}/admin/statistics/donation_daily" class="list-group-item list-group-item-action p-3" aria-current="true">
		    <div class="d-flex w-100 justify-content-between">
		      <h5 class="mb-1">Donation Amount Daily</h5>
		      <small>기부금액 일별 통계</small>
		    </div>
		  </a>
		 <a href="${root}/admin/statistics/donation_monthly" class="list-group-item list-group-item-action p-3" aria-current="true">
		    <div class="d-flex w-100 justify-content-between">
		      <h5 class="mb-1">Donation Amount Monthly</h5>
		      <small>기부금액 월별 통계</small>
		    </div>
		  </a>
		  <a href="#" class="list-group-item list-group-item-action p-3" aria-current="true">
		    <div class="d-flex w-100 justify-content-between">
		      <h5 class="mb-1">Shop Amount Daily</h5>
		      <small>후원상품 판매금액 일별 통계</small>
		    </div>
		  </a>
		 <a href="#" class="list-group-item list-group-item-action p-3" aria-current="true">
		    <div class="d-flex w-100 justify-content-between">
		      <h5 class="mb-1">Shop Amount Monthly</h5>
		      <small>후원상품 판매금액 월별 통계</small>
		    </div>
		  </a>
	  </div>
	  <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-5 mb-5">
		<a type="button" class="btn btn-outline-primary" href="${root}/admin/main">Back to Admin Menu</a>
	</div>

</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>