<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<div class="container-700 bg-white container-center">
		
		<div class="mt-5 mb-3"><h3>ADMIN MENU</h3></div>
		<div class="list-group mb-5">
		  <a href="${root}/admin/member/list" class="list-group-item list-group-item-action p-3" aria-current="true">
		    <div class="d-flex w-100 justify-content-between">
		      <h5 class="mb-1">MEMBER</h5>
		      <small>회원 전체 목록으로 이동합니다</small>
		    </div>
		    <small>회원 목록 / 검색 / 조회 / 등급수정</small>
		  </a>
		  <a href="${root}/shop/" class="list-group-item list-group-item-action p-3" aria-current="true">
		    <div class="d-flex w-100 justify-content-between">
		      <h5 class="mb-1">SHOP</h5>
		      <small>해당 게시판의 목록으로 이동합니다</small>
		    </div>
		    <small>후원상품 목록 / 등록 / 수정 / 삭제</small>
		  </a>
		  <a href="${root}/donation/" class="list-group-item list-group-item-action p-3" aria-current="true">
		    <div class="d-flex w-100 justify-content-between">
		      <h5 class="mb-1">DONATION</h5>
		      <small>해당 게시판의 목록으로 이동합니다</small>
		    </div>
		    <small>기부 게시판 목록 / 등록 / 수정 / 삭제</small>
		  </a>		  
		  <a href="#" class="list-group-item list-group-item-action p-3" aria-current="true">
		    <div class="d-flex w-100 justify-content-between">
		      <h5 class="mb-1">MY BABY</h5>
			  <small>해당 게시판의 목록으로 이동합니다</small>
		    </div>
		    <small>내새끼자랑 게시판 목록 / 등록 / 수정 / 삭제</small>
		  </a>
		  <a href="#" class="list-group-item list-group-item-action p-3" aria-current="true">
		    <div class="d-flex w-100 justify-content-between">
		      <h5 class="mb-1">ADOPT</h5>
		      <small>해당 게시판의 목록으로 이동합니다</small>
		    </div>
		    <small>입양 공고 목록 / 등록 / 수정 / 삭제</small>
		  </a>
		  <a href="${root}/admin/statistics/menu" class="list-group-item list-group-item-action p-3" aria-current="true">
		    <div class="d-flex w-100 justify-content-between">
		      <h5 class="mb-1">STATISTICS</h5>
		   	 <small>통계 메뉴 페이지로 이동합니다</small>
		    </div>
		    <small>방문자 통계 / 기부금액 통계 / 후원상품 판매 통계</small>
		  </a>
		</div>

</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
