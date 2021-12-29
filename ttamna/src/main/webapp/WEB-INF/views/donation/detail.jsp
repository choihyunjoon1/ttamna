<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="row">
	<div class="col">
		<div class="container">
			<c:forEach var="donationDto" items='${donationDto}'>
				<div class="row">${donationDto.donationWriter} /
					${donationDto.donationNo} 번 게시글</div>
				<div class="row">
					<div class="col-6">
						<c:if test="${donationImgDto ne null}">
							<img
								src="donaimg?donationImgNo=${donationImgDto.donationImgNo}&donationNo=${donationDto.donationNo}"
								style="width: 100%;">
						</c:if>
					</div>
				</div>
				<div class="row">현재후원금액 : ${donationDto.donationNowFund}원</div>
				<div class="row">목표후원금액 : ${donationDto.donationTotalFund}원</div>
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
			<input type="hidden" name="partner_user_id"
				value="${sessionScope.uid}"> 기부하기<input type="number"
				name="total_amount" class="form-input form-inline"> <input
				type="submit" value="기부하기" class="form-btn form-inline">
		</form>
	</div>
	<div class="col-12 mt-5">
		<form action="kakao/autofund" method="post" id="auto">
			<c:forEach var="donationDto" items="${donationDto}">
				<input type="hidden" name="donationNo"
					value="${donationDto.donationNo}">
			</c:forEach>
			<input type="hidden" name="partner_user_id"
				value="${sessionScope.uid}"> 정기 기부 신청하기<input type="number"
				name="total_amount" class="form-input form-inline"> <input
				type="submit" value="정기기부하기" class="form-btn form-inline">
		</form>
	</div>

	<!-- ------------------------------------------------------------------------------ -->
<!-- <script> -->
// $(function(){
//     $(".content-change").click(function(){
// 			$(this).parents("tr.view-row").hide();
// 			$(this).parents("tr.view-row").next("tr.edit-row").show();
// 		});
		
// 		$(".edit-row").find(".edit-cancel-btn").click(function(){
// 			$(this).parents("tr.edit-row").hide();
// 			$(this).parents("tr.edit-row").prev("tr.view-row").show();
// 		});
		
// 		$(".edit-row").hide();
// 	});
<!-- </script>     -->


	<div class="col-12">
		<form action="reply/" method="post">
			<c:forEach var="replyDto" items="${replyDto}">
				<h4>${replyDto.donationReplyNo}
					| ${replyDto.memberId} | ${replyDto.donationReplyContent} |
					${replyDto.donationReplyTime}
					<c:if test="${sessionScope.uid == replyDto.memberId}">
						
							<a href="edit?donationReplyNo=${replyDto.donationReplyNo}"	class="content-change">수정하기</a> 
							<a href="delete?donationReplyNo=${replyDto.donationReplyNo}">삭제하기</a>
						
					</c:if>
				</h4>
			</c:forEach>
		</form>

	</div>


	<div class="col-12">
		<form action="reply/insert" method="post">
			<c:forEach var="donationDto" items="${donationDto}">
				<input type="hidden" name="donationNo"
					value="${donationDto.donationNo}">
			</c:forEach>
			<input type="hidden" name="memberId" value="${sessionScope.uid}">
			댓글 쓰기<input type="text" name="donationReplyContent"> <input
				type="submit" value="등록">
		</form>
	</div>




	<!-- ------------------------------------------------------------------------------ -->
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>