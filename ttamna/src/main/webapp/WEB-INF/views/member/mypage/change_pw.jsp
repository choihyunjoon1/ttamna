<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>
<script src = "https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${root}/resources/js/address.js"></script>
<!-- 비밀번호 토글 스크립트 -->
<script type='text/javascript' src="${root}/resources/js/togglePw.js"></script>

<script>
window.addEventListener("load", function(e){
	e.preventDefault(); //기본 이벤트 먼저 방지
	
	//입력값 검사 : 검사실패할 경우 수정 버튼(.edit-btn)비활성화(disabled를 true로 설정). 성공시 활성화(disabled를 false로 설정)
	
	//form에 form-check 클래스 부여
	var form  = document.querySelector('.form-check');
	   
	//비밀번호 정규표현식 검사
	form.querySelector(".input-pw").addEventListener("blur", function(e){
	     var regex = /^(?=[a-z].*)[a-z0-9_?!@#$%]{4,20}$/;
	     var inputPw = form.querySelector(".input-pw").value;	
	     var message = form.querySelector(".pw-message");
	     if(inputPw != ""){
	        if(regex.test(inputPw)){
	             console.log("비밀번호 정규표현식 검사 통과");
	             message.textContent = "";
	             $(".edit-btn").prop('disabled', false);
	        }else{
	             console.log("비밀번호 정규표현식 검사 실패");
	             $(".edit-btn").prop('disabled', true);
	             $(".input-pw").focus();
	             message.textContent = "영문 소문자, 숫자, 특수문자_!?@#$% 4~20자 이내로 입력해주세요. ";
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

<div class="container-1000 container-center">
	<div class="container">
		<div class="align-self-center">
			<h1 align="center">CHANGE PASSWORD</h1>
		</div>
	</div>
<form method="post" class="form-check">
	<div class="container">
		<div class="row">
			<!-- 사이드바 자리 -->
			<jsp:include page="/WEB-INF/views/member/mypage/sidebar.jsp"></jsp:include>
			<div class="col-3 center" style="width:25%;">
				<div class="p-4 border bg-light"><label>현재 비밀번호</label></div>
				<div class="p-4 border bg-light"><label>새 비밀번호</label></div>
				<div class="p-4 border bg-light"><label>새 비밀번호 확인</label></div>
				<br><br>
				<div class="d-grid gap-2">
					<input type="submit" class="btn btn-outline-primary edit-btn" value="수정">
				</div>
			</div>
			<div class="col-5 position-relative"  style="width:50%;">
				<div class="p-3 border bg-light">
					<input type="password" class="form-control" name="memberPw" required  placeholder="현재비밀번호 입력" aria-label="현재비밀번호 입력" aria-describedby="button-addon-pw" data-regex="^[a-z]{8,15}$">
				</div>
				<div class="p-3 border bg-light input-group ">
					<input type="password" class="form-control input-pw" name="memberNewPw" required placeholder="새비밀번호 입력" aria-label="새비밀번호 입력" aria-describedby="button-addon-pw" data-regex="^[a-z]{8,15}$">
					<button class="toggleInputPw btn btn-outline-primary" type="button" id="button-addon-pw">
			  		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
					  <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
					  <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
					</svg>
		  		</button>
				</div>
				<div class="p-3 border bg-light input-group ">
					<input type="password" class="form-control reInput-pw" name="memberNewPwCheck" required placeholder="새비밀번호 확인 입력" aria-label="새비밀번호 확인 입력" aria-describedby="button-addon-pw" data-regex="^[a-z]{8,15}$">
					<button class="toggleReInputPw btn btn-outline-primary" type="button" id="button-addon-rePw">
			  			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
					  		<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
					  		<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
						</svg>
			  		</button>
				</div>
				<span class="pw-message"></span>
				<span class="rePw-message"></span>
				<c:if test="${param.error !=null }">
					<span>정보가 올바르지 않습니다. 다시 확인해주세요!</span>
				</c:if>
				<div class="position-absolute bottom-0 end-0">
					<a href ="${pageContext.request.contextPath}/member/mypage" type="button" class="btn btn-outline-danger">취소</a>
				</div>
			</div>
		</div>
	</div>
</form>
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>