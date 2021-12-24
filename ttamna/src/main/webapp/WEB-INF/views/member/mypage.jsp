<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link ref="stylesheet" type="text/css" href="${root }/resources/css/commons.css">


<div class="container-1000 container-center container-side-menu">		
<h1 align="center">마이페이지</h1>
	<div class="container-side-left">
		<div class="row">
			<ul>
				<li><a href = "${root }/member/mypage">내 정보</a></li>
				<li><a href = "${root }/member/edit">정보 수정</a></li>
				<li><a href = "${root }/member/changePw">비밀번호 변경</a></li>
				<li><a href = "${root }/member/myBoard">내 게시글 보기</a></li>
				<li><a href = "${root }/member/myDonation">기부 목록</a></li>
				<li><a href = "${root }/member/myOrder">주문 내역</a></li>
				<li><a href = "${root }/member/myBasket">장바구니</a></li>
				<li><a href = "${root }/member/logout">로그아웃</a></li>
			</ul>
		</div>
	</div>
	<div class="container-side-center">
		<div class="row">
			<div>센터메뉴${i}:부가적인메뉴</div>
			<div>센터메뉴${i}:부가적인메뉴</div>
			<div>센터메뉴${i}:부가적인메뉴</div>
			<div>센터메뉴${i}:부가적인메뉴</div>
			<div>센터메뉴${i}:부가적인메뉴</div>
			<div>센터메뉴${i}:부가적인메뉴</div>
			<div>센터메뉴${i}:부가적인메뉴</div>
			<div>센터메뉴${i}:부가적인메뉴</div>
			<div>센터메뉴${i}:부가적인메뉴</div>
		</div>
		<a href="${root }/member/logout">로그아웃</a>
	</div>
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>