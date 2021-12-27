<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>  
<style>
	.errorMsg{
		color:red;
	}
</style>  
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
<div class="container-500 bg-white container-center" >
	<div align="center" class="mt-5"><h1>LOGIN</h1></div>
	<div align="center" class="mt-2">
		<c:if test="${param.resetPw_complete != null }">
			<div>비밀번호 설정이 완료되었습니다. 로그인 해주세요</div>
		</c:if>
	</div>
	<form method="post" id="login-form">
		<div class="input-group mt-5 mb-3 col">
			<div class="col">
				<input type="text" name="memberId" required class="form-control" placeholder="아이디 입력" aria-label="아이디 입력" aria-describedby="button-addon2" autocomplete="off">
			</div>
		</div>
		<div class="input-group mb-3 col">
			<div class="col">
				<input type="password" name="memberPw" required class="form-control" placeholder="비밀번호 입력" aria-label="비밀번호 입력" aria-describedby="button-addon2"  autocomplete="off">
			</div>
		</div>
		<div class="row mt-3 mb-5">
			<div class="d-grid gap-2">
				<button type="submit" class="btn btn-primary">로그인</button>
			</div>
		</div>
			<div class="d-grid gap-2 d-md-flex justify-content-md-end mt-5 mb-5">
				<a href="${root}" type="button" class="btn btn-outline-secondary me-md-1">취소</a>
  				<a type="button" href="${root}/find/findId" class="btn btn-outline-primary">아이디 찾기</a>
  				<a type="button" href="${root}/find/findPw" class="btn btn-outline-primary">비밀번호 찾기</a>
			</div>
</form>
		<div class="row">
			<c:if test="${param.error != null }">
				<span class="errorMsg">아이디 또는 비밀번호가 틀렸습니다.</span>
			</c:if>
		</div>
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>