<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>  
<script src = "https://code.jquery.com/jquery-3.6.0.js"></script>
<style>
	.container-height-300{
	 	height: 300px;
	}
</style>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<div class="container-500 bg-white container-center container-height-300" >
	<div class="mt-4 mb-5"><h3>인증번호 입력</h3></div>
	<form action="checkByCertToId" method="post" id="login-form">
		<div class="mb-2">인증번호를 전송하였습니다.</div>
		<div class="mb-2">이메일을 확인하고 인증번호를 입력해주세요</div>
		<div class="input-group mt-5 mb-3 col">
			<div class="col">
				<input type="hidden" name="certEmail" value="${certEmail}" required>
			    <input type="text" name="certSerial" required class="form-control align-self-right" placeholder="인증번호 입력" aria-label="인증번호 입력" autocomplete="off">
			</div>
		</div>
		<div class="row mt-3">
			<div class="d-grid gap-2 d-md-flex justify-content-md-end mb-5">
				<button type="submit" class="btn btn-outline-secondary">인증하기</button>
			</div>
		</div>
	</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>