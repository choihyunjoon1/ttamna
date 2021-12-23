<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>회원가입 페이지</h1>

<form method="post">
<div>
	아이디 : <input type="text" name="memberId" required>
	<br><br>
	비밀번호 : <input type="password" name="memberPw" required>
	<br><br>
	닉네임 : <input type="text" name="memberNick" required>
	<br><br>
	이름 : <input type="text" name="memberName" required>
	<br><br>
	이메일 : <input type="email" name="memberEmail" required>
	<br><br>
	휴대전화 : <input type="tel" name="memberPhone" required>
	<br><br>
	우편번호 : <input type="text" name="postcode">
	기본주소 : <input type="text" name="address">
	상세주소 : <input type="text" name="detailAddress">
</div>	
	<input type="submit" value="회원가입">
</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>