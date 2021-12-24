<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<style>
	.errorMsg{
		color:red;
	}
</style>  
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
<form method="post">
<div class="container-1000 bg-white" >
	<div class="container-400 container-center">
	<h1>로그인 페이지</h1>
		<div class="input-group mb-3 col">
			<div class="col">
				<input type="text" name="memberId" required class="form-control" placeholder="아이디 입력" aria-label="아이디 입력" aria-describedby="button-addon2" autocomplete="off">
			</div>
		</div>
		<div class="input-group mb-3 col">
			<div class="col">
				<input type="password" name="memberPw" required class="form-control" placeholder="비밀번호 입력" aria-label="비밀번호 입력" aria-describedby="button-addon2"  autocomplete="off">
			</div>
		</div>
		<div class="row mt-3">
			<div class="col">
				<button type="submit" class="btn btn-outline-primary">로그인</button>
				<a href="${pageContext.request.contextPath}" type="button" class="btn btn-outline-secondary">취소</a>
			</div>
		</div>
		<div class="row">
			<c:if test="${param.error != null }">
				<span class="errorMsg">아이디 또는 비밀번호가 틀렸습니다.</span>
			</c:if>
		</div>
	</div>
</div>
</form>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>