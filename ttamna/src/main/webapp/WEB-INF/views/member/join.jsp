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
    <script src="${root}/resources/js/address.js"></script>
    <!-- 비밀번호 토글 스크립트 -->
	<script type='text/javascript' src="${root}/resources/js/togglePw.js"></script>
    <script>
   window.addEventListener("load", function(){
    var form  = document.querySelector('#join-form');
		//아이디 정규표현식 검사
		form.querySelector("input[name=memberId]").addEventListener("input", function(e){
	        var regex = /^(?=[a-z].*)[a-z0-9_]{4,20}$/;
	        var inputId = form.querySelector("input[name=memberId]").value;	
	        var message = form.querySelector("#id-message");
	        if(inputId != ""){
	           if(regex.test(inputId)){
	                console.log("아이디 정규표현식 검사 통과");
	                message.textContent = "";
	            }else{
	                console.log("아이디 정규표현식 검사 실패");
	                message.textContent = "영문 소문자, 숫자, 특수문자_ 4~20자 이내로 입력해주세요";
					form.querySelector("input[name=usersId]").focus();
					$(form).attr('onsubmit', 'e.preventDefault();');
	            }
	        }
   	   });
  });
    </script>
    <style>
	.btn{
		padding: 0.15em 0.3rem;
	}
    </style>
<div class="container-600 container-center">
	<h1>회원가입 페이지</h1>
	<form method="post" id="join-form">
	<div class="column">
		<label>아이디</label>
		<input type="text" name="memberId" required>
		<button class='btn btn-primary reCheck' type='button'>중복확인</button>
		<div id='id-message'></div>
	</div>
	<div class="column">
		<label>비밀번호</label>
		<input type="password" name="memberPw" required class='input-pw'>
		<button type=button class="btn btn-primary toggleInputPw">보기</button>
	</div>
	<div class="column">
		<label>비밀번호 확인</label>
		<input type="password" required class='reInput-pw'>
		<button type=button class="btn btn-primary toggleReInputPw">보기</button>
	</div>
	<div class="column">
		닉네임 : <input type="text" name="memberNick" required>
	</div>
	<div class="column">
		이름 : <input type="text" name="memberName" required>
	</div>
	<div class="column">
		이메일 : <input type="email" name="memberEmail" required>
	</div>
	<div class="column">
		휴대전화 : <input type="tel" name="memberPhone" required>
	</div>
	<div class="column">
		<input type="button"  value="우편번호 찾기" class="address-btn"><br>
		우편번호 : <input type="text" name="postcode">
	</div>
	<div class="column">
		기본주소 : <input type="text" name="address">
	</div>
	<div class="column">
		상세주소 : <input type="text" name="detailAddress">
	</div>	
	<div class="column">
		<input type="submit" value="회원가입">
	</div>
	</form>
</div>
>>>>>>> branch 'main' of https://github.com/choihyunjoon1/ttamna

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>