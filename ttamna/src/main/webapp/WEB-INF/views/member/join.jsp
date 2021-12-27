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
<!-- 입력값 정규표현식 검사 -->
<script type='text/javascript' src="${root}/resources/js/input-regex-check.js"></script>
<!-- 아이디 중복검사 스크립트 -->
<%-- <script type='text/javascript' src="${root}/resources/js/ajax-id.js"></script> --%>
	
<script>

window.addEventListener("load", function(){
	 var form  = document.querySelector(".form-check");
	 var inputId = form.querySelector("input[name=memberId]").value;	
	 var message = form.querySelector(".id-message");
	 form.querySelector("input[name=memberId]").blur(function(){
		 if(inputId != ""){ //입력값이 빈값이 아닐 경우에만 중복검사 진행
			 ajaxId(inputId);
		 }
	 });
	 	function ajaxId(inputId){
	 		  console.log("ID중복검사 시작");
			  $.ajax({
	                    type: "get", //전송방식 
	                    url: "${pageContext.request.contextPath}/member/ajaxId",
	                    data: { //전송시 첨부할 파라미터 정보
	                         memberId:inputId	//이름:값
	                    },
	                    dataType:"json",

	               // 통신 완료 시 동작 설정
	               success:function(resp){
	               	 console.log("ID 중복검사 요청 성공. ID : "+resp);
	              	 if(resp == "YYYY") { 
	                     $(message).text("아이디 사용 가능");
	                     $(form).attr('onsubmit', 'e.addEvenetListener();');
	                 } else if(resp =="NNNN") {
	                     $(message).text("아이디가 이미 사용중입니다");
	     		 		 form.querySelector("input[name=memberId]").focus();
	     				 $(form).attr('onsubmit', 'e.preventDefault();');
	                 }
	             },
	                //통신 실패 시 동작 설정
	               error:function(e){ //통신 실패
	                   console.log("ID 중복검사 요청 실패");
	                   console.log(err);
	                }
	          
	         });
	 	};
});	

</script>
<style>

</style>
<div class="container-500 container-center">
   	<div align="center" class="mt-5"><h1>JOIN</h1></div>
	<form method="post" class="form-check">
	<div class='input-group mt-5 mb-2'>
		<input type="text" class="form-control input-id" name="memberId" required placeholder="아이디 입력" aria-label="아이디 입력">
	</div>
	<div class='row id-message'></div>
	<div class='input-group mb-1'>
		<input type="password" class="form-control input-pw" name="memberPw" required placeholder="비밀번호 입력" aria-label="비밀번호 입력" aria-describedby="button-addon-pw">
  		<button class="toggleInputPw btn btn-outline-primary" type="button" id="button-addon-pw">보기</button>
	</div>
	<div class='row pw-message'></div>
	<div class='input-group mb-3'>
		<input type="password" class="form-control reInput-pw" required placeholder="비밀번호 재입력" aria-label="비밀번호 재입력" aria-describedby="button-addon-rePw">
  		<button class="toggleReInputPw btn btn-outline-primary" type="button" id="button-addon-rePw">보기</button>
	</div>
	<div class='input-group mb-3'>
		<input type="text" class="form-control input-nick" name='memberNick' required placeholder="닉네임 입력" aria-label="닉네임 입력">
	</div>
	<div class='row nick-message'></div>
	<div class='input-group mb-3'>
		<input type="text" class="form-control input-name" name='memberName' required placeholder="이름 입력" aria-label="이름 입력">
	</div>
	<div class='row name-message'></div>
	<div class='input-group mb-3'>
		<input type="email" class="form-control input-email" name='memberEmail' required placeholder="이메일 입력" aria-label="이메일 입력">
	</div>
	<div class='row email-message'></div>
	<div class='input-group mb-3'>
		<input type="text" class="form-control input-phone" name='memberPhone' required placeholder="핸드폰 번호 입력 010-0000-0000" aria-label="핸드폰 번호 입력 010-0000-0000">
	</div>
	<div class='row phone-message'></div>
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
	<div class="d-grid gap-2 mb-5">
    	<input class="btn btn-lg btn-primary" type="submit" value="Join">
	</div>
	</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>