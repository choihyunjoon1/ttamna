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
	<div class="mt-4 mb-5"><h3>아이디 찾기</h3></div>
	<form method="post" id="login-form">
	<div class="mb-2">가입시 작성한 이메일 주소를 입력해 주세요</div>
		<div class="input-group mt-2 mb-3 col">
			<div class="col">
				<input type="text" name="certEmail" required class="form-control" placeholder="이메일 입력" aria-label="이메일 입력" autocomplete="off">
			</div>
		</div>
		<div class="row mt-3">
			<div class="d-grid gap-2 d-md-flex justify-content-md-end mb-5">
				<button type="submit" class="btn btn-primary">인증번호발송</button>
			</div>
		</div>
	</form>
	<c:if test="${param.error != null }">
		<div class="errorMsg">인증번호가 일치하지 않습니다</div>
	</c:if>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>