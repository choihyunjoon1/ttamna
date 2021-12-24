<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<style>
	.errorMsg{
		color:red;
	}
</style>  
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<h1>로그인 페이지</h1>
<form method="post">
<div class="container-400 container-center">
	<div class="row">
		<label>아이디</label>	
		<input type="text" name="memberId" required class="form-input">
	</div>
	<div class="row">
		<label>비밀번호</label>
		<input type="password" name = "memberPw" required class="form-input">
	</div>
	<div class="row">
		<input type="submit" value="로그인" class="form-btn">
	</div>
	<div class="row">
		<c:if test="${param.error != null }">
			<span class="errorMsg">아이디 또는 비밀번호가 틀렸습니다.</span>
		</c:if>
	</div>
</div>
</form>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>