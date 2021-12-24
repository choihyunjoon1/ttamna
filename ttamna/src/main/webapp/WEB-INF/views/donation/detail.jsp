<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
	<c:forEach var="donationDto" items='${donationDto}'>
		<div class="row">
		${donationDto.donationWriter}
		</div>
		<div class="row">
		이미지영역
		</div>
		<div class="row">
		후원금액 : ${donationDto.donationPrice}원
		</div>
		<div class="row">
		<a href="edit?donationNo=${donationDto.donationNo}">수정</a>
		<!-- 추후에 얼럿 창을 한번 띄워서 확인을 누르면 삭제가 되게끔 코드 -->
		<a href="delete?donationNo=${donationDto.donationNo}">삭제</a>
		</div>
	</c:forEach>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>