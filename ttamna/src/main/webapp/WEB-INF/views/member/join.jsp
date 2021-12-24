<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%-- 페이지에서 사용할 JSTL 변수 --%>
<c:set var="login" value="${uid != null}"></c:set>
<c:set var="admin" value="${grade == '관리자'}"></c:set>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>    
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src = "https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="${root }/resources/js/address.js"></script>
<div class="container-center">
	<h1>회원가입 페이지</h1>
</div>

<form method="post">
<div class="container-400 container-center">
	<div class="row">
		<label>아이디</label>
		<input type="text" name="memberId" required class="form-input">
	</div>
	<div class="row">
		<label>비밀번호</label>
		<input type="password" name="memberPw" required class="form-input">
	</div>
	<div class="row">
		<label>닉네임</label>
		<input type="text" name="memberNick" required class="form-input">
	</div>
	<div class="row"></div>
	이름 : <input type="text" name="memberName" required class="form-input">
	<div class="row"></div>
	이메일 : <input type="email" name="memberEmail" required class="form-input">
	<div class="row"></div>
	휴대전화 : <input type="tel" name="memberPhone" required class="form-input">
	<div class="row">
		<input type="button"  value="우편번호 찾기" class="address-btn form-input">
		<input type="text" name="postcode" placeholder="우편번호" class="form-input">
		<input type="text" name="address" placeholder="기본주소" class="form-input">
		<input type="text" name="detailAddress" placeholder="상세주소" class="form-input">
	</div>
	<div class="row">
		<input type="submit" value="회원가입" class="input-btn form-btn">
	</div>
</div>	
</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>