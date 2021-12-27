<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="row">
	<div class="col">
		<div class="container">
		<c:forEach var="donationDto" items='${donationDto}'>
			<div class="row">
			${donationDto.donationWriter}
			</div>
			<div class="row">
			이미지영역
			</div>
			<div class="row">
			현재후원금액 : ${donationDto.donationNowFund}원
			</div>
			<div class="row">
			목표후원금액 : ${donationDto.donationTotalFund}원
			</div>
			<div class="row">
			<a href="edit?donationNo=${donationDto.donationNo}">수정</a>
			<!-- 추후에 얼럿 창을 한번 띄워서 확인을 누르면 삭제가 되게끔 코드 -->
			<a href="delete?donationNo=${donationDto.donationNo}">삭제</a>
			</div>
		</c:forEach>
		</div>
	</div>
	<div class="col-12 mt-5">
		<form action="kakao/fund" method="post">
			<input type="hidden" name="partner_user_id" value="${sessionScope.uid}">
			기부하기<input type="number" name="total_amount" class="form-input form-inline">
			<input type="submit" value="기부하기" class="form-btn form-inline">
		</form>
	</div>
	<div class="col-12 mt-5">
		<form action="kakao/autofund" method="post">
			<input type="hidden" name="partner_user_id" value="${sessionScope.uid}">
			정기 기부 신청하기<input type="number" name="total_amount" class="form-input form-inline">
			<input type="submit" value="정기기부하기" class="form-btn form-inline">
		</form>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>