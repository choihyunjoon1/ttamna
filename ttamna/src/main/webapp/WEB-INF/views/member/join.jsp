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
<%-- <script type='text/javascript' src="${root}/resources/js/input-regex-check.js"></script> --%>
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
	
	
 

// var form  = document.querySelector('.form-check');
   


 var success = 0;
 var fail = 0;

 //아이디 정규표현식 검사
		form.querySelector(".input-id").addEventListener("input", function(e){
     var regex = /^(?=[a-z].*)[a-z0-9_]{4,20}$/;
     var inputId = form.querySelector(".input-id").value;	
     var message = form.querySelector(".id-message");
     if(inputId != ""){
        if(regex.test(inputId)){
             console.log("아이디 정규표현식 검사 통과");
             message.textContent = "";
             success++;
         }else{
             console.log("아이디 정규표현식 검사 실패");
             message.textContent = "영문 소문자, 숫자, 특수문자_ 4~20자 이내로 입력해주세요. ";
             fail++;
         }
     }
 });

   
 //비밀번호 정규표현식 검사
form.querySelector(".input-pw").addEventListener("input", function(e){

     var regex = /^(?=[a-z].*)[a-z0-9_?!@#$%]{4,20}$/;
     var inputPw = form.querySelector(".input-pw").value;	
     var message = form.querySelector(".pw-message");
     if(inputPw != ""){
        if(regex.test(inputPw)){
             console.log("비밀번호 정규표현식 검사 통과");
             message.textContent = "";
             success++;
         }else{
             console.log("비밀번호 정규표현식 검사 실패");
             message.textContent = "영문 소문자, 숫자, 특수문자_!?@#$% 4~20자 이내로 입력해주세요. ";
             fail++;
         }
     }
  });

     
  //닉네임 정규표현식 검사
	form.querySelector(".input-nick").addEventListener("input", function(e){
     var regex = /^[가-힣]{2,15}$/;
     var inputNick = form.querySelector(".input-nick").value;	
     var message = form.querySelector(".nick-message");
     if(inputNick != ""){
        if(regex.test(inputNick)){
             console.log("닉네임 정규표현식 검사 통과");
             message.textContent = "";
             success++;
         }else{
             console.log("닉네임 정규표현식 검사 실패");
             message.textContent = "한글 2~15자 이내로 입력해주세요. ";
             fail++;
         }
     }
 });

     
 //이름 정규표현식 검사
		form.querySelector(".input-name").addEventListener("input", function(e){
     var regex = /^[가-힣]{2,7}$/;
     var inputName = form.querySelector(".input-name").value;	
     var message = form.querySelector(".name-message");
     if(inputName != ""){
        if(regex.test(inputName)){
             console.log("이름 정규표현식 검사 통과");
             message.textContent = "";
             success++;
         }else{
             console.log("이름 정규표현식 검사 실패");
             message.textContent = "한글 2~7자 이내로 입력해주세요. ";
             fail++;
         }
     }
 });

     
 //이메일 정규표현식 검사
form.querySelector(".input-email").addEventListener("input", function(e){
     var regex = /^[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*@[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*\.([a-zA-Z])+$/;
     var inputEmail = form.querySelector(".input-email").value;	
     var message = form.querySelector(".email-message");
     if(inputEmail != ""){
        if(regex.test(inputEmail)){
             console.log("이메일 정규표현식 검사 통과");
             message.textContent = "";
             success++;
         }else{
             $(".input-email").focus();
             console.log("이메일 정규표현식 검사 실패");
             message.textContent = "이메일 형식에 맞지 않습니다. ";
            fail++;     
         }
     }
 });

  //폰번호 정규표현식 검사
form.querySelector(".input-phone").addEventListener("input", function(e){
     var regex = /^010-[0-9]{4}-[0-9]{4}$/;
     var inputPhone = form.querySelector(".input-phone").value;	
     var message = form.querySelector(".phone-message");
     if(inputPhone != ""){
        if(regex.test(inputPhone)){
             console.log("폰번호 정규표현식 검사 통과");
             message.textContent = "";
             success++;
         }else{
             console.log("폰번호 정규표현식 검사 실패");
             message.textContent = "010-0000-0000 형식으로 입력해 주세요. ";
             fail++;
         }
     }
  });


//회원가입용 form의 join버튼을 누르면 이벤트 발생
form.querySelector(".join-btn").addEventListener("click", function(e){
 //일단 서브밋 방지
 e.preventDefault();
         
     console.log(fail);
     console.log(success);
	 if(fail > 0){
		   $(form).attr('onsubmit', 'e.preventDefault();');
		   console.log(" 검사실패 ");
	 }else{
	     $(form).attr('onsubmit', 'e.addEventListener();');
		   console.log(" 검사성공 ");
	 }

});


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
  		<button class="toggleInputPw btn btn-outline-primary" type="button" id="button-addon-pw">
	  		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
			  <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
			  <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
			</svg>
  		</button>
	</div>
	<div class='row pw-message'></div>
	<div class='input-group mb-3'>
		<input type="password" class="form-control reInput-pw" required placeholder="비밀번호 재입력" aria-label="비밀번호 재입력" aria-describedby="button-addon-rePw">
  		<button class="toggleReInputPw btn btn-outline-primary" type="button" id="button-addon-rePw">
  			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
		  		<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
		  		<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
			</svg>
  		</button>
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
    	<input class="btn btn-lg btn-primary join-btn" type="submit" value="Join">
	</div>
	</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>