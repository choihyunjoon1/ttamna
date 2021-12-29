<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<h2>댓글 수정</h2>
<h3>댓글 번호 : ${donationReplyDto.donationReplyNo}</h3>
<h3>작성자 : ${donationReplyDto.memberId}</h3>
<h3>댓글을 작성한 게시판 번호 : ${donationReplyDto.donationNo}</h3>
<h3>댓글 내용 : ${donationReplyDto.donationReplyContent}</h3>
<form method="post">
	<input type="hidden" name="memberId" value="${donationReplyDto.memberId}">
	<input type="hidden" name="donationNo" value="${donationReplyDto.donationNo}">
댓글 쓰기<input type="text" name="donationReplyContent" value="${donationReplyDto.donationReplyContent}">	
	<input type="submit" value="수정">
	
</form>


<div class="container">
<form method="post">
	<c:forEach var="donationDto" items='${donationReplyDto}'>
				
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