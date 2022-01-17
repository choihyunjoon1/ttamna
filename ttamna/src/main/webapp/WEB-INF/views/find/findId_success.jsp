<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>  
<script src = "https://code.jquery.com/jquery-3.6.0.js"></script>
<style>
	.containSer-height-300{
	 	height: 300px;
	}
</style>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<div class="container-500 bg-white container-center container-height-300" >
	<div class="align-self-center mt-5 mb-5">
		<h5>${param.memberEmail} 님의 아이디 입니다</h5>
	</div>
		
	<div class="card">
		<div class="card-body">
		    <h4>${param.findId}</h4>
		</div>
	</div>

	<div class="d-grid gap-2 d-md-flex justify-content-md-end mt-5 mb-5">
  		<a type="button" href="${root}/member/login" class="btn btn-outline-primary me-md-1">로그인</a>
  		<a type="button" href="${root}/find/findPw" class="btn btn-outline-primary">비밀번호 찾기</a>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>