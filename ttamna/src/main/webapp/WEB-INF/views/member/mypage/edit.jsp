<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link ref="stylesheet" type="text/css" href="${root }/resources/css/commons.css">
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>
<script src = "https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${root}/resources/js/address.js"></script>

<script>
window.addEventListener("load", function(e){
	e.preventDefault(); //기본 이벤트 먼저 방지
	
	//입력값 검사 : 검사실패할 경우 수정 버튼(.edit-btn)비활성화(disabled를 true로 설정). 성공시 활성화(disabled를 false로 설정)
	
	//form에 form-check 클래스 부여
	var form  = document.querySelector('.form-check');

	var url = "${pageContext.request.contextPath}";

	  //닉네임 정규표현식 검사
	  form.querySelector(".input-nick").addEventListener("blur", function(e){
	     var regex = /^[가-힣]{2,15}$/;
	     var inputNick = form.querySelector(".input-nick").value;	
	     var message = form.querySelector(".nick-message");
	     if(inputNick != ""){
	        if(regex.test(inputNick)){
	             console.log("닉네임 정규표현식 검사 통과");
	             //정규식 검사 통과 후 중복검사 진행
	         	$.ajax({
	    			url : url + "/ajax/ajaxNick",
	    			type : "get",
	    			data : {
	    				inputNick : inputNick,
	    			},
	    			dataType : "text",
	    			success:function(resp){
	    				console.log("닉네임 중복검사 요청 성공", resp);
	    				if(resp == "NNNN"){
	    					console.log("닉네임 중복. 사용 불가능");
	    					message.textContent = "닉네임 중복. 다시 입력해 주세요";
	    					$(".edit-btn").prop('disabled', true);
	    					$(".input-nick").focus();
	    				}else if(resp == "YYYY"){
	    					console.log("닉네임 사용 가능");
	    					message.textContent = "닉네임 사용 가능";
	    					$(".edit-btn").prop('disabled', false);
	    				}
	    			},
	    			error:function(e){
	    				console.log("닉네임 중복검사 요청 실패", e);
	    			}
	    		});
	         }else{
	             console.log("닉네임 정규표현식 검사 실패");
	             $(".edit-btn").prop('disabled', true);
	             $(".input-nick").focus();
	             message.textContent = "한글 2~15자 이내로 입력해주세요. ";
	         }
	     }
	  });
	     
	  //이메일 정규표현식 검사
	  form.querySelector(".input-email").addEventListener("blur", function(e){
	     var regex = /^[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*@[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*\.([a-zA-Z])+$/;
	     var inputEmail = form.querySelector(".input-email").value;	
	     var message = form.querySelector(".email-message");
	     if(inputEmail != ""){
	        if(regex.test(inputEmail)){
	             console.log("이메일 정규표현식 검사 통과");
	             //정규식 검사 통과 후 중복검사 진행
	             $.ajax({
	     			url : url + "/ajax/ajaxEmail",
	     			type : "get",
	     			data : {
	     				inputEmail : inputEmail,
	     			},
	     			dataType : "text",
	     			success:function(resp){
	     				console.log("이메일 중복검사 요청 성공", resp);
	     				if(resp == "NNNN"){
	     					console.log("이메일 중복. 사용 불가능");
	     					message.textContent = "이메일 중복. 다시 입력해 주세요";
	     					$(".edit-btn").prop('disabled', true);
	     					$(".input-email").focus();
	     				}else if(resp == "YYYY"){
	     					console.log("이메일 사용 가능");
	     					message.textContent = "이메일 사용 가능";
	     					$(".edit-btn").prop('disabled', false);
	     				}
	     			},
	     			error:function(e){
	     				console.log("이메일 중복검사 요청 실패", e);
	     			}
	     		});
	         }else{
	             $(".edit-btn").prop('disabled', true);
	             $(".input-email").focus();
	             console.log("이메일 정규표현식 검사 실패");
	             message.textContent = "이메일 형식에 맞지 않습니다. ";
	         }
	     }
	  });
	
	  //폰번호 정규표현식 검사
	  form.querySelector(".input-phone").addEventListener("blur", function(e){
	     var regex = /^010-[0-9]{4}-[0-9]{4}$/;
	     var inputPhone = form.querySelector(".input-phone").value;	
	     var message = form.querySelector(".phone-message");
	     if(inputPhone != ""){
	        if(regex.test(inputPhone)){
	             console.log("폰번호 정규표현식 검사 통과");
	             message.textContent = "";
	             $(".edit-btn").prop('disabled', false);
	         }else{
	             console.log("폰번호 정규표현식 검사 실패");
	             $(".edit-btn").prop('disabled', true);
	             $(".input-phone").focus();
	             message.textContent = "010-0000-0000 형식으로 입력해 주세요. ";
	         }
	     }
	  });

 });

</script>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-1000 container-center">
	<div class="container-900 container-center">
		<div class="align-self-center">
			<h1 align="center">EDIT</h1>
		</div>
	</div>
<form method="post" class="form-check">
	<div class="container" style="width:100%;">
		<div class="row">
			<!-- 사이드바 자리 -->
			<jsp:include page="/WEB-INF/views/member/mypage/sidebar.jsp"></jsp:include>
			<div class="col-3 center" style="width:20%;">
				<div class="p-3 border bg-light"><label>아이디</label></div>
				<div class="p-4 border bg-light"><label>닉네임</label></div>
				<div class="p-4 border bg-light"><label>비밀번호 확인</label></div>
				<div class="p-3 border bg-light"><label>이름</label></div>
				<div class="p-4 border bg-light"><label>핸드폰번호</label></div>
				<div class="p-4 border bg-light"><label>이메일</label></div>
				<div class="p-4 border bg-light"><label>우편번호</label></div>
				<div class="p-4 border bg-light"><label>기본주소</label></div>
				<div class="p-4 border bg-light"><label>상세주소</label></div>
				<br><br>
				<div class="d-grid gap-2">
					<input type="submit" class="btn btn-outline-primary edit-btn" value="수정">
				</div>
			</div>
			<div class="col-6 position-relative" style="width:55%;">
				<div class="p-3 border bg-light">${memberDto.memberId }</div>
				<div class="p-3 border bg-light">
					<input type="text" class="form-control input-nick" name='memberNick' required value="${memberDto.memberNick }">
				</div>
				<div class='nick-message'></div>
				<div class="p-3 border bg-light">
					<input type="password" class="form-control input-pw" name="memberPw" required placeholder="비밀번호 입력" aria-label="비밀번호 입력" aria-describedby="button-addon-pw">
				</div>
				<div class="p-3 border bg-light">${memberDto.memberName }</div>
				<div class="p-3 border bg-light">
					<input type="text" class="form-control input-phone" name='memberPhone' required value="${memberDto.memberPhone }">
				</div>
				<div class='phone-message'></div>
				<div class="p-3 border bg-light">
					<input type="email" class="form-control input-email" name='memberEmail' required value="${memberDto.memberEmail }">
				</div>
				<div class='email-message'></div>
				<div class="p-3 border bg-light">
				<div class="row">
					<div class="col-5">
						<input type="text" class="form-control input-phone"  name="postcode" aria-describedby="button-addon-postcode" value="${memberDto.postcode}">
					</div>
					<div class="col-5">
						<button class="address-btn btn btn-outline-primary" type="button" id="button-addon-postcode">우편번호 찾기</button>
					</div>
				</div>
				</div>
				<div class="p-3 border bg-light">
					<input type="text" class="form-control" name="address" value="${memberDto.address }">
				</div>
				<div class="p-3 border bg-light">
					<input type="text" class="form-control" name="detailAddress"  value="${memberDto.detailAddress}">
				</div>
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