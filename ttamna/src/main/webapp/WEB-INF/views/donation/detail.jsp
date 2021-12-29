<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
	<div class="row">
		<div class="col">
			<c:forEach var="donationDto" items='${donationDto}'>
				<div class="row">
					<div class="col-5">
					<c:if test="${donationImgDtoList ne null}">
						<c:forEach var="donationImgDto" items="${donationImgDtoList}">
							<img src="donaimg?donationImgNo=${donationImgDto.donationImgNo}&donationNo=${donationDto.donationNo}" style="width:100%;">
						</c:forEach>
					</c:if>
					</div>
				</div>
				<div class="cols-12 mt-3">
				<p>
					${donationDto.donationContent}
				</p>
				</div>
				<div class="col-12 mt-3">
				현재후원금액 : ${donationDto.donationNowFund}원
				</div>
				<div class="col-12 mt-3">
				목표후원금액 : ${donationDto.donationTotalFund}원
				</div>
				<div class="col-8 mt-3">
				<a href="edit?donationNo=${donationDto.donationNo}" class="btn btn-primary">수정</a>
				<!-- 추후에 얼럿 창을 한번 띄워서 확인을 누르면 삭제가 되게끔 코드 -->
				<a href="delete?donationNo=${donationDto.donationNo}" class="btn btn-primary">삭제</a>
				</div>
			</c:forEach>
		</div>
		<div class="col-12 mt-5">
			<form action="kakao/fund" method="post">
				<c:forEach var="donationDto" items="${donationDto}">
				<input type="hidden" name="donationNo" value="${donationDto.donationNo}">
				<input type="hidden" name="partner_user_id" value="${sessionScope.uid}">
				<input type="number" name="total_amount" class="form-control" min="1000" max="${donationDto.donationTotalFund - donationDto.donationNowFund}">
				<input type="submit" value="기부하기" class="btn btn-primary">
				</c:forEach>
			</form>
		</div>
		<div class="col-12 mt-5">
			<form action="kakao/autofund" method="post" id="auto">
				<c:forEach var="donationDto" items="${donationDto}">
				<input type="hidden" name="donationNo" value="${donationDto.donationNo}">
				<input type="hidden" name="partner_user_id" value="${sessionScope.uid}">
				<input type="number" name="total_amount" class="form-control" min="1000" max="${donationDto.donationTotalFund*0.3}">
				<input type="submit" value="정기기부하기" class="btn btn-primary">
				</c:forEach>
			</form>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>