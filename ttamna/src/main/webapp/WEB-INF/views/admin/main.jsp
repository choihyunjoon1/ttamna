<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<div class="container-600 bg-white container-center" align="center">
	<div class="mt-4 mb-5"><h3>관리 메뉴</h3></div>
	<div class="list-group mb-5">
	  <a href="${root}/admin/member/list" class="list-group-item list-group-item-action">회원 관리</a>
	  <a href="#" class="list-group-item list-group-item-action">후원 상품 관리</a>
	  <a href="#" class="list-group-item list-group-item-action">기부 게시판 관리</a>
	  <a href="#" class="list-group-item list-group-item-action">내새끼자랑 게시판 관리</a>
	  <a href="#" class="list-group-item list-group-item-action">방문자 통계</a>
	  <a href="#" class="list-group-item list-group-item-action">기부 금액 통계</a>
	  <a href="#" class="list-group-item list-group-item-action">후원 상품 판매 금액 통계</a>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
