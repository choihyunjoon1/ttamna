<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>  
<script src = "https://code.jquery.com/jquery-3.6.0.js"></script>
<style>
	.errorMsg{
		color:red;
	}
	.container-height-700{
	 	height: 700px;
	}
</style>
<!-- 비밀번호 토글 스크립트 -->
<script type='text/javascript' src="${root}/resources/js/togglePw.js"></script>

<script>
window.addEventListener("load", function(){
    var form  = document.querySelector('.form-check');

		//비밀번호 정규표현식 검사
		form.querySelector(".input-pw").addEventListener("input", function(e){
	        var regex = /^(?=[a-z].*)[a-z0-9_?!@#$%]{4,20}$/;
	        var inputPw = form.querySelector(".input-pw").value;	
	        var message = form.querySelector(".pw-message");
	        if(inputPw != ""){
	           if(regex.test(inputPw)){
	                console.log("비밀번호 정규표현식 검사 통과");
	                message.textContent = "";
	            }else{
	                console.log("비밀번호 정규표현식 검사 실패");
	                message.textContent = "영문 소문자, 숫자, 특수문자_!?@#$% 4~20자 이내로 입력해주세요. ";
					$(form).attr('onsubmit', 'e.preventDefault();');
	            }
	        }
   	 });
		
		//변경 비번 재입력값 일치여부 검사
		 form.querySelector(".reInput-pw").addEventListener("blur", function(){
				var inputPw = form.querySelector(".input-pw").value;
				var reInputPw = form.querySelector(".reInput-pw").value;
				var message = form.querySelector(".rePw-message");
				 if(inputPw != "" && reInputPw != ""){
					 if(inputPw == reInputPw){
						 message.textContent = "비밀번호가 일치합니다";
						 console.log("비번 & 재확인비번 일치");	
						 $(".edit-btn").prop('disabled', false);
					 }else if(inputPw != reInputPw){
						 $(".edit-btn").prop('disabled', true);
						 $(".reInput-pw").focus();
						 message.textContent = "비밀번호가 일치하지 않습니다";
						 console.log("비번 & 재확인비번 불일치");	
					 }
				 }
		     });	
});
</script>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<div class="container-600 bg-white container-center container-height-700" >
	<div class="card">
		<div class="card-body">
			<div class="mt-5 mb-5"><h5>>${param.memberEmail} 님의 비밀번호를 재설정 합니다</h5></div>
			<form method="post" id="login-form" class="form-check">
<%-- 			<input type="hidden" name=memberEmail value="${param.memberEmail}"> --%>
				<div class="input-group mt-5 mb-3 col">
					<div class="col">
						<input type="text" name="memberId" required class="form-control" placeholder="아이디 입력" aria-label="아이디 입력" aria-describedby="button-addon2" autocomplete="off">
					</div>
				</div>
				<div class='input-group mb-1'>
					<input type="password" class="form-control input-pw" name="resetPw" required placeholder="비밀번호 입력" aria-label="비밀번호 입력" aria-describedby="button-addon-pw">
			  		<button class="toggleInputPw btn btn-outline-primary" type="button" id="button-addon-pw">보기</button>
				</div>
				<div class='row pw-message'></div>
				<div class='input-group mb-3'>
					<input type="password" class="form-control reInput-pw" required placeholder="비밀번호 재입력" aria-label="비밀번호 재입력" aria-describedby="button-addon-rePw">
			  		<button class="toggleReInputPw btn btn-outline-primary" type="button" id="button-addon-rePw">보기</button>
				</div>
				<div class='row rePw-message'></div>
				<div class="row mt-3 mb-5">
					<div class="d-grid gap-2">
						<button type="submit" class="btn btn-primary edit-btn">재설정</button>
					</div>
				<div class="row mt-2">
					<c:if test="${param.error != null }">
						<div class="errorMsg">아이디가 일치하지 않습니다</div>
					</c:if>
				</div>
					<div class="d-grid gap-2 d-md-flex justify-content-md-end mt-5 mb-5">
						<a href="${root}" type="button" class="btn btn-outline-secondary me-md-1">취소</a>
						<a type="button" href="${root}/find/findId" class="btn btn-outline-primary">아이디 찾기</a>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>