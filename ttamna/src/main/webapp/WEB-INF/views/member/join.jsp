<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<!-- 비밀번호 일치여부 판별 스크립트 -->
<script type='text/javascript' src="${root}/resources/js/pwEquals.js"></script>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
 window.addEventListener("load", function(){
	
	var form  = document.querySelector('.form-check');
	var idMessage = form.querySelector(".id-message");
	var url = "${pageContext.request.contextPath}";
    
	//아이디 중복검사
	form.querySelector(".input-id").addEventListener("blur", function(){
	    var inputId = form.querySelector(".input-id").value;	
	    if(inputId != ""){
			ajaxId(inputId);
	    }
	});
	function ajaxId(inputId){
		$.ajax({
			url : url + "/ajax/ajaxId",
			type : "get",
			data : {
				inputId : inputId,
			},
			dataType : "text",
			success:function(resp){
				console.log("중복검사 요청 성공", resp);
				if(resp == "NNNN"){
					console.log("아이디 중복. 사용 불가능");
					$(idMessage).text("아이디 중복. 다시 입력해 주세요");
					$(".input-id").focus();
					$(form).attr('onsubmit', 'event.preventDefault();');
					console.log("event.preventDefault()");
				}else if(resp == "YYYY"){
					console.log("아이디 사용 가능");
					$(idMessage).text("아이디 사용 가능");
					$(form).attr('onsubmit', 'event.addEvenetListener();');
				}
			},
			error:function(e){
				console.log("중복검사 요청 실패", e);
			}
		});
	}
		
	//닉네임 중복검사
	var nickMessage = form.querySelector(".nick-message");
	form.querySelector(".input-nick").addEventListener("blur", function(){
	    var inputNick = form.querySelector(".input-nick").value;	
	    if(inputNick != ""){
			ajaxNick(inputNick);
	    }
	});
	function ajaxNick(inputNick){
		$.ajax({
			url : url + "/ajax/ajaxNick",
			type : "get",
			data : {
				inputNick : inputNick,
			},
			dataType : "text",
			success:function(resp){
				console.log("중복검사 요청 성공", resp);
			
				if(resp == "NNNN"){
					console.log("닉네임 중복. 사용 불가능");
					$(nickMessage).append("닉네임 중복. 다시 입력해 주세요");
					$(".input-nick").focus();
					$(form).attr('onsubmit', 'event.preventDefault();');
					console.log("event.preventDefault()");
				}else if(resp == "YYYY"){
					console.log("닉네임 사용 가능");
					$(nickMessage).text("닉네임 사용 가능");
					$(form).attr('onsubmit', 'event.addEvenetListener();');
				}
			},
			error:function(e){
				console.log("중복검사 요청 실패", e);
			}
		});
	}
	
	//이메일 중복검사
	var emailMessage = form.querySelector(".email-message");
	form.querySelector(".input-email").addEventListener("blur", function(){
	    var inputEmail = form.querySelector(".input-email").value;	
	    if(inputEmail != ""){
			ajaxEmail(inputEmail);
	    }
	});
	function ajaxEmail(inputEmail){
		$.ajax({
			url : url + "/ajax/ajaxEmail",
			type : "get",
			data : {
				inputEmail : inputEmail,
			},
			dataType : "text",
			success:function(resp){
				console.log("중복검사 요청 성공", resp);
			
				if(resp == "NNNN"){
					console.log("이메일 중복. 사용 불가능");
					$(emailMessage).text("이메일 중복. 다시 입력해 주세요");
					$(".input-email").focus();
					$(form).attr('onsubmit', 'event.preventDefault();');
					console.log("event.preventDefault()");
				}else if(resp == "YYYY"){
					console.log("이메일 사용 가능");
					$(emailMessage).text("이메일 사용 가능");
					$(form).attr('onsubmit', 'event.addEvenetListener();');
				}
			},
			error:function(e){
				console.log("중복검사 요청 실패", e);
			}
		});
	}
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
	<div class='row rePw-message'></div>
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