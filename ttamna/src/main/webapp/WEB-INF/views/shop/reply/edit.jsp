<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<h2>댓글 수정</h2>
<h3>댓글 번호 : ${shopReplyDto.shopReplyNo}</h3>
<h3>작성자 : ${shopReplyDto.memberId}</h3>
<h3>댓글을 작성한 게시판 번호 : ${shopReplyDto.shopNo}</h3>
<h3>댓글 내용 : ${shopReplyDto.shopReplyContent}</h3>
<form method="post">
	<input type="hidden" name="memberId" value="${shopReplyDto.memberId}">
	<input type="hidden" name="shopNo" value="${shopReplyDto.shopNo}">
댓글 쓰기<input type="text" name="shopReplyContent" value="${shopReplyDto.shopReplyContent}">	
	<input type="submit" value="수정">
	
</form>