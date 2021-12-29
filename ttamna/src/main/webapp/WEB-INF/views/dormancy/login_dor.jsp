<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>  
<script src = "https://code.jquery.com/jquery-3.6.0.js"></script>
<style>
	.errorMsg{
		color:red;
	}
	.container-height-300{
	 	height: 300px;
	}
</style> 
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<div class="container-500 bg-white container-center container-height-300" >
	<div class="mt-4 mb-5"><h3>휴면계정 전환</h3></div>
	<form method="post" id="login-form">
	<div class="mb-2">가입시 작성한 이메일 주소를 입력해 주세요</div>
		<div class="input-group mt-2 mb-2 col">
			<div class="col">
				<input type="text" name="certEmail" required class="form-control" placeholder="이메일 입력" aria-label="이메일 입력" autocomplete="off">
			</div>
		</div>
	<div class="mb-2">가입시 작성한 아이디를 입력해주세요</div>
	
		<div class="input-group mt-2 mb-2 col">
			<div class="col">
				<input type="text" name="memberId" required class="form-control" placeholder="아이디입력" aria-label="아이디 입력" autocomplete="off">
			</div>
		</div>
	<c:if test="${param.error != null }">
		<div class="errorMsg">인증번호가 일치하지 않습니다</div>
	</c:if>
		<div class="row mt-3">
			<div class="d-grid gap-2 d-md-flex justify-content-md-end mb-5">
				<button type="submit" class="btn btn-primary">인증번호 받기
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-envelope-plus" viewBox="0 0 16 16">
		  				<path d="M2 2a2 2 0 0 0-2 2v8.01A2 2 0 0 0 2 14h5.5a.5.5 0 0 0 0-1H2a1 1 0 0 1-.966-.741l5.64-3.471L8 9.583l7-4.2V8.5a.5.5 0 0 0 1 0V4a2 2 0 0 0-2-2H2Zm3.708 6.208L1 11.105V5.383l4.708 2.825ZM1 4.217V4a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1v.217l-7 4.2-7-4.2Z"/>
		  				<path d="M16 12.5a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0Zm-3.5-2a.5.5 0 0 0-.5.5v1h-1a.5.5 0 0 0 0 1h1v1a.5.5 0 0 0 1 0v-1h1a.5.5 0 0 0 0-1h-1v-1a.5.5 0 0 0-.5-.5Z"/>
					</svg>
				</button>
			</div>
		</div>
	</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>