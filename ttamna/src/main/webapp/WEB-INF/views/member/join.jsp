<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%-- 페이지에서 사용할 JSTL 변수 --%>
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
					$(form).attr('onsubmit', 'e.preventDefault();');
	            }
	        }
   	   });
    });
    window.addEventListener("load", function(){
        var form  = document.querySelector('#join-form');
  		//비밀번호 정규표현식 검사
  		form.querySelector("input[name=memberPw]").addEventListener("input", function(e){
  	        var regex = /^(?=[a-z].*)[a-z0-9_?!@#$%]{4,20}$/;
  	        var inputPw = form.querySelector("input[name=memberPw]").value;	
  	        var message = form.querySelector("#pw-message");
  	        if(inputPw != ""){
  	           if(regex.test(inputPw)){
  	                console.log("비밀번호 정규표현식 검사 통과");
  	                message.textContent = "";
  	            }else{
  	                console.log("비밀번호 정규표현식 검사 실패");
  	                message.textContent = "영문 소문자, 숫자, 특수문자_!?@#$% 4~20자 이내로 입력해주세요";
  					$(form).attr('onsubmit', 'e.preventDefault();');
  	            }
  	        }
     	 });
      });
    window.addEventListener("load", function(){
        var form  = document.querySelector('#join-form');
  		//닉네임 정규표현식 검사
  		form.querySelector("input[name=memberNick]").addEventListener("input", function(e){
  	        var regex = /^[가-힣]{2,15}$/;
  	        var inputNick = form.querySelector("input[name=memberNick]").value;	
  	        var message = form.querySelector("#nick-message");
  	        if(inputNick != ""){
  	           if(regex.test(inputNick)){
  	                console.log("닉네임 정규표현식 검사 통과");
  	                message.textContent = "";
  	            }else{
  	                console.log("닉네임 정규표현식 검사 실패");
  	                message.textContent = "한글 2~15자 이내로 입력해주세요";
  					$(form).attr('onsubmit', 'e.preventDefault();');
  	            }
  	        }
     	 });
      });
    window.addEventListener("load", function(){
        var form  = document.querySelector('#join-form');
  		//이름 정규표현식 검사
  		form.querySelector("input[name=memberName]").addEventListener("input", function(e){
  	        var regex = /^[가-힣]{2,7}$/;
  	        var inputName = form.querySelector("input[name=memberName]").value;	
  	        var message = form.querySelector("#name-message");
  	        if(inputName != ""){
  	           if(regex.test(inputName)){
  	                console.log("이름 정규표현식 검사 통과");
  	                message.textContent = "";
  	            }else{
  	                console.log("이름 정규표현식 검사 실패");
  	                message.textContent = "한글 2~7자 이내로 입력해주세요";
  					$(form).attr('onsubmit', 'e.preventDefault();');
  	            }
  	        }
     	 });
      });
    window.addEventListener("load", function(){
        var form  = document.querySelector('#join-form');
  		//이름 정규표현식 검사
  		form.querySelector("input[name=memberEmail]").addEventListener("blur", function(e){
  	        var regex = /^[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*@[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*\.([a-zA-Z])+$/;
  	        var inputEmail = form.querySelector("input[name=memberEmail]").value;	
  	        var message = form.querySelector("#email-message");
  	        if(inputEmail != ""){
  	           if(regex.test(inputEmail)){
  	                console.log("이메일 정규표현식 검사 통과");
  	                message.textContent = "";
  	            }else{
  	                console.log("이메일 정규표현식 검사 실패");
  	                message.textContent = "이메일 형식에 맞지 않습니다";
  					$(form).attr('onsubmit', 'e.preventDefault();');
  	            }
  	        }
     	 });
      });
    window.addEventListener("load", function(){
        var form  = document.querySelector('#join-form');
  		//이름 정규표현식 검사
  		form.querySelector("input[name=memberPhone]").addEventListener("input", function(e){
  	        var regex = /^010-[0-9]{4}-[0-9]{4}$/;
  	        var inputPhone = form.querySelector("input[name=memberPhone]").value;	
  	        var message = form.querySelector("#phone-message");
  	        if(inputPhone != ""){
  	           if(regex.test(inputPhone)){
  	                console.log("폰번호 정규표현식 검사 통과");
  	                message.textContent = "";
  	            }else{
  	                console.log("폰번호 정규표현식 검사 실패");
  	                message.textContent = "010-0000-0000 형식으로 입력해 주세요";
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
<div class="container-500 container-center">
	<div class='container'>
	<div class="align-self-center">
		<h1>JOIN</h1>
    </div>
    </div>
	<form method="post" id="join-form">
	<div class='input-group mt-5 mb-2'>
		<input type="text" class="form-control input-id" name="memberId" required placeholder="아이디 입력" aria-label="아이디 입력">
	</div>
	<div class='row' id='id-message'></div>
	<div class='input-group mb-1'>
		<input type="password" class="form-control input-pw" name="memberPw" required placeholder="비밀번호 입력" aria-label="비밀번호 입력" aria-describedby="button-addon-pw">
  		<button class="toggleInputPw btn btn-outline-primary" type="button" id="button-addon-pw">보기</button>
	</div>
	<div id='pw-message'></div>
	<div class='input-group mb-3'>
		<input type="password" class="form-control reInput-pw" required placeholder="비밀번호 재입력" aria-label="비밀번호 재입력" aria-describedby="button-addon-rePw">
  		<button class="toggleReInputPw btn btn-outline-primary" type="button" id="button-addon-rePw">보기</button>
	</div>
	<div class='input-group mb-3'>
		<input type="text" class="form-control input-nick" name='memberNick' required placeholder="닉네임 입력" aria-label="닉네임 입력">
	</div>
	<div id='nick-message'></div>
	<div class='input-group mb-3'>
		<input type="text" class="form-control input-name" name='memberName' required placeholder="이름 입력" aria-label="이름 입력">
	</div>
	<div id='name-message'></div>
	<div class='input-group mb-3'>
		<input type="email" class="form-control input-email" name='memberEmail' required placeholder="이메일 입력" aria-label="이메일 입력">
	</div>
	<div id='email-message'></div>
	<div class='input-group mb-3'>
		<input type="text" class="form-control input-phone" name='memberPhone' required placeholder="핸드폰 번호 입력 010-0000-0000" aria-label="핸드폰 번호 입력 010-0000-0000">
	</div>
	<div id='phone-message'></div>
	<div class='input-group mb-1'>
		<input type="text" class="form-control input-phone"  name="postcode" placeholder='우편번호' aria-label="우편번호" aria-describedby="button-addon-postcode">
		<button class="address-btn btn btn-outline-primary" type="button" id="button-addon-postcode">우편번호 찾기</button>
	</div>
	<div class='input-group mb-1'>
		<input type="text" class="form-control" name="address" placeholder='기본주소' aria-label="기본주소">
	</div>
	<div class='input-group mb-3'>
		<input type="text" class="form-control" name="detailAddress" placeholder='상세주소' aria-label="상세주소">
	</div>
	<div class="d-grid gap-2">
    	<input class="btn btn-lg btn-primary" type="button" value="Join">
	</div>
	</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>