<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%-- 페이지에서 사용할 JSTL 변수 --%>
<c:set var="login" value="${uid != null}"></c:set>
<c:set var="admin" value="${grade == '관리자'}"></c:set>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
 <!-- jquery CDN 또는 파일을 불러오는 코드를 작성-->
 <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
 <!--daum post API관련 스크립트-->
 <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
 <script src="${root}/resources/js/address.js"></script>

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
	<input type="button" value="우편번호 찾기" class="find-address-btn"><br>
	기본주소 : <input type="text" name="address">
	상세주소 : <input type="text" name="detailAddress">
</div>	
	<input type="submit" value="회원가입">
</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>