<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<style>
	.float-item-right{
		border : 1px dotted black;
	}
	.float-item-left{
		border : 1px dotted black;
	}
	.float-item-center>.float-item-center{
		float:center;
	}
</style>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<div class="container-1000 container-center float-container">		
<h1 align="center">마이페이지</h1>
	<div class="container-200 float-item-left">
		<div class="row">
			<a href = "#">내 정보</a>
			<a href = "#">정보 수정</a>
			<a href = "#">비밀번호 변경</a>
			<a href = "#">내 게시글 보기</a>
			<a href = "#">기부 목록</a>
			<a href = "#">주문 내역</a>
			<a href = "#">장바구니</a>
			<a href = "#">로그아웃</a>
		</div>
	</div>
	<div class="container-600 float-item-center">
		<c:forEach begin="1" end="10" var="i">
		<div class="row">
			<div>센터메뉴${i}:부가적인메뉴</div>
		</div>
		</c:forEach>
	</div>
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>