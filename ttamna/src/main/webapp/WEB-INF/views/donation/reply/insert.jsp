<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<h2>댓글 넣기</h2>
<form method="post">
	<input type="hidden" name="memberId" value="${sessionScope.uid}">
	
	댓글 쓰기<input type="text" name="donationReplyContent">
	<input type="submit" value="등록">
</form>