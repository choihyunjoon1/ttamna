<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<h1>로그인 페이지</h1>
아이디 : <input type="text" name="memberId" required>
비밀번호 : <input type="password" name = "memberPw" required>
<input type="submit" value="로그인">

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>