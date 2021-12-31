<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
<form method="post">
	<c:forEach var="donationDto" items='${donationDto}'>
		<div class="row">
		<input type="hidden" name="donationNo" value="${donationDto.donationNo}" >
		</div>
		<div class="row">
		${donationDto.donationWriter}
		</div>
		<div class="row">
		<label>
			제목<input type="text" name="donationTitle" value="${donationDto.donationTitle}" required class="form-input">
		</label>
		</div>
		<div class="row">
			<label>
			파일<input type="file" multiple name="attach" class="form-input" accept="image/*">
			</label>
		</div>
		<div class="row">
		<label>
			내용<input type="text" name="donationContent" value="${donationDto.donationContent}" required class="form-input">
		</label>
		</div>
		<div class="row">
		목표 후원금액 : ${donationDto.donationTotalFund}원
		</div>
		<div class="row">
		<a href="edit?donationNo=${donationDto.donationNo}">수정</a>
		<!-- 추후에 얼럿 창을 한번 띄워서 확인을 누르면 삭제가 되게끔 코드 -->
		<a href="delete?donationNo=${donationDto.donationNo}">삭제</a>
		</div>
		<div class="row">
			<input type="submit" value=" 수정하기" class="form-btn">
		</div>
	</c:forEach>
</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>