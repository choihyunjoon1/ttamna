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

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
 window.addEventListener("load", function(e){
	e.preventDefault(); //기본 이벤트 먼저 방지
	
	//회원가입 form에 form-check 클래스 부여
	var form  = document.querySelector('.form-check');

	var url = "${pageContext.request.contextPath}";

 	//아이디 정규표현식 검사
	form.querySelector(".input-id").addEventListener("blur", function(e){
	     var regex = /^(?=[a-z].*)[a-z0-9_]{4,20}$/;
	     var inputId = form.querySelector(".input-id").value;	
	     var message = form.querySelector(".id-message");
	     if(inputId != ""){
	        if(regex.test(inputId)){
	             console.log("아이디 정규표현식 검사 통과");
	             //정규식 검사 통과 후 중복검사 진행
	             $.ajax({
					url : url + "/ajax/ajaxId",
					type : "get",
					data : {
						inputId : inputId,
					},
					dataType : "text",
					success:function(resp){
						console.log("아이디 중복검사 요청 성공", resp);
						//아이디 입력값이 빈값이 아닐 경우에만 중복검사 결과를 보여주기
						if(resp == "NNNN"){
							console.log("아이디 중복. 사용 불가능");
							message.textContent = "아이디 중복. 다시 입력해 주세요";
							$(".join-btn").prop('disabled', true);
							$(".input-id").focus();
						}else if(resp == "YYYY"){
							console.log("아이디 사용 가능");
							message.textContent = "아이디 사용 가능";
	    					$(".join-btn").prop('disabled', false);
						}
					},
					error:function(e){
						console.log("아이디 중복검사 요청 실패", e);
					}
				});
	         }else{
	             console.log("아이디 정규표현식 검사 실패");
	             $(".input-id").focus();
	             message.textContent = "영문 소문자, 숫자, 특수문자_ 4~20자 이내로 입력해주세요. ";
	         }
	     }
	 });
	   
	//비밀번호 정규표현식 검사
	form.querySelector(".input-pw").addEventListener("blur", function(e){
	     var regex = /^(?=[a-z].*)[a-z0-9_?!@#$%]{4,20}$/;
	     var inputPw = form.querySelector(".input-pw").value;	
	     var message = form.querySelector(".pw-message");
	     if(inputPw != ""){
	        if(regex.test(inputPw)){
	             console.log("비밀번호 정규표현식 검사 통과");
	             message.textContent = "";
	             $(".join-btn").prop('disabled', false);
	        }else{
	             console.log("비밀번호 정규표현식 검사 실패");
	             $(".join-btn").prop('disabled', true);
	             $(".input-pw").focus();
	             message.textContent = "영문 소문자, 숫자, 특수문자_!?@#$% 4~20자 이내로 입력해주세요. ";
	         }
	     }
	  });
	
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
	    					$(".join-btn").prop('disabled', true);
	    					$(".input-nick").focus();
	    				}else if(resp == "YYYY"){
	    					console.log("닉네임 사용 가능");
	    					message.textContent = "닉네임 사용 가능";
	    					$(".join-btn").prop('disabled', false);
	    				}
	    			},
	    			error:function(e){
	    				console.log("닉네임 중복검사 요청 실패", e);
	    			}
	    		});
	         }else{
	             console.log("닉네임 정규표현식 검사 실패");
	             $(".join-btn").prop('disabled', true);
	             $(".input-nick").focus();
	             message.textContent = "한글 2~15자 이내로 입력해주세요. ";
	         }
	     }
	  });
	
	  //이름 정규표현식 검사
	  form.querySelector(".input-name").addEventListener("blur", function(e){
	     var regex = /^[가-힣]{2,7}$/;
	     var inputName = form.querySelector(".input-name").value;	
	     var message = form.querySelector(".name-message");
	     if(inputName != ""){
	        if(regex.test(inputName)){
	             console.log("이름 정규표현식 검사 통과");
	             message.textContent = "";
	             $(".join-btn").prop('disabled', false);
	         }else{
	             console.log("이름 정규표현식 검사 실패");
	             $(".join-btn").prop('disabled', true);
	             $(".input-name").focus();
	             message.textContent = "한글 2~7자 이내로 입력해주세요. ";
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
	     					$(".join-btn").prop('disabled', true);
	     					$(".input-email").focus();
	     				}else if(resp == "YYYY"){
	     					console.log("이메일 사용 가능");
	     					message.textContent = "이메일 사용 가능";
	     					$(".join-btn").prop('disabled', false);
	     				}
	     			},
	     			error:function(e){
	     				console.log("이메일 중복검사 요청 실패", e);
	     			}
	     		});
	         }else{
	             $(".join-btn").prop('disabled', true);
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
	             $(".join-btn").prop('disabled', false);
	         }else{
	             console.log("폰번호 정규표현식 검사 실패");
	             $(".join-btn").prop('disabled', true);
	             $(".input-phone").focus();
	             message.textContent = "010-0000-0000 형식으로 입력해 주세요. ";
	         }
	     }
	  });

	  //비번 재입력값 일치여부 검사
	  form.querySelector(".reInput-pw").addEventListener("blur", function(){
		 var inputPw = form.querySelector(".input-pw").value;
		 var reInputPw = form.querySelector(".reInput-pw").value;
		 var message = form.querySelector(".rePw-message");
			if(inputPw != "" && reInputPw != ""){
				 if(inputPw == reInputPw){
					 message.textContent = "비밀번호가 일치합니다";
					 console.log("비번 & 재확인비번 일치");	
					 $(".join-btn").prop('disabled', false);
				}else if(inputPw != reInputPw){
					 $(".join-btn").prop('disabled', true);
					 $(".reInput-pw").focus();
					 message.textContent = "비밀번호가 일치하지 않습니다";
					 console.log("비번 & 재확인비번 불일치");	
				 }
			 }
	    });
	  
 });
</script>
<style>

</style>
<div class="container-500 container-center">
   	<div align="center" class="mt-5"><h1>JOIN</h1></div>
	<form method="post" class="form-check">
	<div >
		<h3 class="center"><span>회원가입 이용약관 동의</span></h3>
			<br><br>
				<div class="app-agreement" style="overflow:scroll;height:18rem;width:100%">
				 <div class="app-agreement-title">
				     <em style="color:red">*</em>
				     <span>서비스 이용약관 (필수)</span>
				    </div>
				<div class="app-agreement-body ">
			    	<p><b>제1조 목적</b></p>
			
			<p>1. 이 이용약관(이하 "본 약관"이라 합니다)은 "Tierheim(동물의 집)"(www.Tierheim(동물의 집).co.kr)에서 제공하는 인터넷 사이트 "Tierheim(동물의 집)" 서비스(이하 "서비스"라 합니다)를 이용함에 있어 "Tierheim(동물의 집)"와 회원 간의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.</p>
			
			<p>2. 회원이 되고자 하는 자가 "Tierheim(동물의 집)"에서 정한 소정의 절차를 거쳐서 "약관동의" 단추를 누르면 본 약관에 동의하는 것으로 간주합니다. 본 약관에 정하는 이외의 회원과 "Tierheim(동물의 집)"의 권리, 의무 및 책임사항에 관해서는 전기통신사업법 기타 대한민국의 관련 법령과 상관습에 의합니다.</p>
			
			<p>&nbsp;</p>
			
			<p><strong>제2조 용어 정의</strong></p>
			
			<p>1. 회원: "Tierheim(동물의 집)"에 접속하여 본 약관에 따라 "Tierheim(동물의 집)" 회원으로 가입하여 "Tierheim(동물의 집)"에서 제공하는 서비스를 받는 자를 말합니다.</p>
			
			<p>2. 기타 약관에서 정하지 아니한 용어는 관계 법령 및 일반 관례에 따릅니다.</p>
			
			<p>&nbsp;</p>
			
			<p><strong>제3조 이용약관의 효력 및 변경</strong></p>
			
			<p>1. 이 약관은 서비스를 이용하고자 하는 모든 회원에 대하여 그 효력을 발생합니다.</p>
			
			<p>2. 이 약관의 내용은 회원이 이에 동의하여 서비스에 가입함으로써 효력이 발생합니다.</p>
			
			<p>3. 약관에 대한 동의는 이용 신청시 화면 상의 '회원 가입 약관' - '위의 내용을 모두 읽었으며 동의합니다.' 항목에 체크를 함으로써 이루어지는 것으로 간주합니다. 기존 가입 회원의 동의 여부는 제4항에 의합니다.</p>
			
			<p>4. 회원은 변경된 약관에 대하여 동의하지 않을 경우 서비스 이용을 중단하고 이용 계약을 해지(회원 탈퇴)할 수 있으며, 만약 변경된 약관의 적용 이후에도 서비스를 계속 이용하는 경우에는 약관의 변경 사항에 동의한 것으로 간주합니다.</p>
			
			<p>5. "Tierheim(동물의 집)"는 필요한 사유가 발생할 경우 관련 법령에 위배되지 않는 범위 안에서 약관을 개정할 수 있습니다. 개정 사실은 공지를 통해 고지되며 개정된 약관은 게시된 지 7일 후부터 효력을 발휘합니다.</p>
			
			<p>&nbsp;</p>
			
			<p><strong>제4조 회원 가입</strong></p>
			
			<p>1. 회원이 되고자 하는 자는 "Tierheim(동물의 집)"에서 정한 가입 양식에 따라 회원정보를 기입하고 "등록" 버튼을 누르는 방법으로 회원 가입을 신청합니다.</p>
			
			<p>2. "Tierheim(동물의 집)"는 제1항과 같이 회원으로 가입할 것을 신청한 자가 다음 각 호에 해당하지 않는 한 신청한 자를 회원으로 인정합니다.</p>
			
			<p>① 등록 내용에 허위, 기재누락, 오기가 있는 경우</p>
			
			<p>② 다중 계정을 이용 할 경우</p>
			
			<p>③ 법률 또는 약관 위반, 기타 회원의 귀책사유, 제7조 제2항에 의하여 회원 자격의 정지 및 회원 자격의 상실 경험이 있는 회원이 다시 신청하는 경우</p>
			
			<p>④ 기타 회원으로 등록하는 것이 "Tierheim(동물의 집)"의 서비스 운영에 현저히 지장이 있다고 판단되는 경우</p>
			
			<p>3. 회원가입계약의 성립시기는 "Tierheim(동물의 집)"의 회원 등록완료한 시점으로 합니다.</p>
			
			<p>4. 회원가입계약이 성립된 이후라도 제2항 각 호에 따른 사유 발견시 이용 승낙을 철회할 수 있으며 해당 회원은 서비스 이용과 관련하여 아무런 권리를 주장할 수 없습니다.</p>
			
			<p>&nbsp;</p>
			
			<p><strong>제5조 서비스의 제공 및 변경</strong></p>
			
			<p>1. "Tierheim(동물의 집)"는 회원에게 아래와 같은 서비스를 제공합니다.</p>
			
			<p>① 사이트 내의 컨텐츠와 이메일 정보 제공</p>
			
			<p>② 기타 "Tierheim(동물의 집)"에서 자체 개발하거나 다른 회사와의 협력계약 등을 통해 회원들에게 제공할 일체의 서비스</p>
			
			<p>2. "Tierheim(동물의 집)"는 그 변경될 서비스의 내용 및 제공일자를 제8조에서 정한 방법으로 회원에게 통지할 수 있습니다.</p>
			
			<p>&nbsp;</p>
			
			<p><b>제6조 서비스의 중단</b></p>
			
			<p>1. "Tierheim(동물의 집)"는 컴퓨터 등 정보통신설비의 보수점검·교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있고, 새로운 서비스로의 교체나 기타 "Tierheim(동물의 집)"가 적절하다고 판단하는 사유에 기하여 현재 제공되는 서비스를 완전히 중단할 수 있습니다.&nbsp;</p>
			
			<p>2. 제1항에 의한 서비스 중단의 경우에는 "Tierheim(동물의 집)"는 제8조 제2항에서 정한 방법으로 회원에게 통지합니다. 다만, "Tierheim(동물의 집)"에서 통제할 수 없는 사유로 인한 서비스의 중단(시스템 관리자의 고의, 과실이 없는 디스크 장애, 시스템 다운 등)으로 인하여 사전 통지가 불가능한 경우에는 그러하지 아니합니다.&nbsp;</p>
			
			<p>&nbsp;</p>
			
			<p><b>제7조 회원 탈퇴 및 자격 상실 등</b></p>
			
			<p>1. 회원은 "Tierheim(동물의 집)"에 언제든지 자신의 회원 등록을 말소해 줄 것(회원 탈퇴)을 요청할 수 있으며 "Tierheim(동물의 집)"는 개인정보취급방침에 따라 해당 회원의 회원 등록 말소를 위한 절차를 밟습니다.&nbsp;</p>
			
			<p>2. 회원이 다음 각 호의 사유에 해당하는 경우, "Tierheim(동물의 집)"는 회원의 회원자격을 적절한 방법으로 제한 및 정지 또는 상실시킬 수 있습니다.&nbsp;</p>
			
			<p>① 공지사항 또는 각 게시판 공지사항에 위반하는 활동을 하는 경우</p>
			
			<p>② 가입 신청 시에 허위 내용을 등록한 경우&nbsp;</p>
			
			<p>③ 다른 사람의 "서비스" 이용을 방해하거나 그 정보를 도용하는 등 "서비스"상 위협에 해당하는 행동의 경우</p>
			
			<p>&nbsp;④ 법령과 본 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우&nbsp;</p>
			
			<p>3. "Tierheim(동물의 집)"는 회원의 회원자격을 상실시키기로 결정한 경우에는 회원등록을 말소합니다.</p>
			
			<p>4. 회원 탈퇴가 이루어진 경우 게시판에 등록된 게시글 및 댓글은 삭제되지 않으며, 작성한 게시물 등의 삭제를 원하시는 경우에는 반드시 직접 삭제하신 후, 탈퇴해 주시기 바랍니다.</p>
			
			<p>5. 작성한 게시글 및 댓글에 남아있는 개인정보 침해 사유 내용은, 탈퇴 이후라도 작성자 본인임을 확인할 수 있는 증명자료, 관련 사유, 첨부 자료를 개인정보취급방침 상 개인정보보호 담당부서에 요청하면 심의 후 개별적으로 삭제될 수 있습니다.</p>
			
			<p>6. 회원이 본 약관에 의해서 회원 가입 후 서비스를 이용하는 도중, 연속하여 1년 동안 서비스를 이용하기 위한 로그인 기록이 없는 경우, 휴면계정으로 취급 될 수 있으며, "Tierheim(동물의 집)"는 회원의 회원자격을 상실시킬 수 있습니다.</p>
			
			<p>&nbsp;</p>
			
			<p><b>제8조 회원에 대한 통지</b></p>
			
			<p>1. "Tierheim(동물의 집)"는 특정 회원에게 대한 통지를 하는 경우 "Tierheim(동물의 집)"의 회원정보에 기재된 E-mail 및 공지사항 게시판 또는 관련 게시판 및 쪽지로 통지 할 수 있습니다.</p>
			
			<p>2. "Tierheim(동물의 집)"는 불특정다수 회원에 대한 통지를 하는 경우 "Tierheim(동물의 집)"의 공지사항 게시판 및 관련 게시판에 게시함으로써 개별 통지에 갈음할 수 있습니다.&nbsp;</p>
			
			<p>&nbsp;</p>
			
			<p><b>제9조 회원의 개인정보보호</b></p>
			
			<p>1. "Tierheim(동물의 집)"는 관련법령이 정하는 바에 따라서 회원 등록정보를 포함한 회원의 개인정보를 보호하기 위하여 노력합니다.</p>
			
			<p>2. 회원의 개인정보보호에 관해서는 관련법령 및 "Tierheim(동물의 집)"에서 정하는 "개인정보취급방침"에 정한 바에 의합니다.&nbsp;</p>
			
			<p>&nbsp;</p>
			
			<p><b>제10조 "Tierheim(동물의 집)"의 의무</b></p>
			
			<p>1. "Tierheim(동물의 집)"는 법령과 본 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 본 약관이 정하는 바에 따라 지속적이고, 안정적으로 서비스를 제공하기 위해서 노력합니다.&nbsp;</p>
			
			<p>2. "Tierheim(동물의 집)"는 회원이 원하지 않는 영리목적의 광고성 전자우편을 발송하지 않습니다.&nbsp;</p>
			
			<p>&nbsp;</p>
			
			<p><b>제11조 회원의 ID 및 비밀번호에 대한 의무</b></p>
			
			<p>1. "Tierheim(동물의 집)"는 관계법령, "개인정보취급방침"에 의해서 그 책임을 지는 경우를 제외하고, 자신의 ID와 비밀번호에 관한 관리책임은 각 회원에게 있습니다.&nbsp;</p>
			
			<p>2. 회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.&nbsp;</p>
			
			<p>3. 회원은 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 "Tierheim(동물의 집)"에 통보하고 "Tierheim(동물의 집)"의 안내가 있는 경우에는 그에 따라야 합니다.&nbsp;</p>
			
			<p>&nbsp;</p>
			
			<p><b>제12조 회원의 의무</b></p>
			
			<p>회원은 다음 각 호의 행위를 하여서는 안됩니다.&nbsp;</p>
			
			<p>1. "Tierheim(동물의 집)"에서 제공하는 서비스에 정한 약관 기타 서비스 이용에 관한 규정을 위반하는 행위</p>
			
			<p>&nbsp;2. "Tierheim(동물의 집)" 공지사항 또는 각 게시판 공지사항에 위반하는 행위</p>
			
			<p>3. "Tierheim(동물의 집)" 기타 제3자의 인격권 또는 지적재산권을 침해하거나 업무를 방해하는 행위</p>
			
			<p>&nbsp;4. 다른 회원의 ID를 도용하는 행위&nbsp;</p>
			
			<p>5. 정크메일(junk mail), 스팸메일(spam mail), 행운의 편지(chain letters), 피라미드 조직에 가입할 것을 권유하는 메일, 외설 또는 폭력적인 메시지 ·화상·음성 등이 담긴 메일을 보내거나 기타 공서양속에 반하는 정보를 공개 또는게시하는 행위.</p>
			
			<p>&nbsp;6. 관련 법령에 의하여 그 전송 또는 게시가 금지되는 정보(컴퓨터 프로그램 등)의 전송 또는 게시하는 행위</p>
			
			<p>7. "Tierheim(동물의 집)"의 직원이나 "Tierheim(동물의 집)" 서비스의 관리자를 가장하거나 사칭하여 또는 타인의 명의를 모용하여 글을 게시하거나 메일을 발송하는 행위</p>
			
			<p>8. 컴퓨터 소프트웨어, 하드웨어, 전기통신 장비의 정상적인 가동을 방해, 파괴할 목적으로 고안된 소프트웨어 바이러스, 기타 다른 컴퓨터 코드, 파일, 프로그램을 포함하고 있는 자료를 게시하거나 전자우편으로 발송하는 행위</p>
			
			<p>&nbsp;9. 스토킹(stalking) 등 다른 회원을 괴롭히는 행위</p>
			
			<p>10. 다른 회원에 대한 개인정보를 그 동의 없이 수집,저장,공개하는 행위</p>
			
			<p>11. 불특정 다수의 자를 대상으로 하여 광고 또는 선전을 게시하거나 스팸메일을 전송하는 등의 방법으로 "Tierheim(동물의 집)"의 서비스를 이용하여 영리목적의 활동을 하는 행위</p>
			
			<p>12. 서버나 회선에 무리를 줄 수 있는 행위</p>
			
			<p>위의 각 호에 해당하는 행위를 한 회원이 있을 경우 "Tierheim(동물의 집)"는 회원의 회원자격을 적절한 방법으로 제한 및 정지, 상실시킬 수 있으며,회원은 그 귀책사유로 인하여 "Tierheim(동물의 집)"나 다른 회원이 입은 손해를 배상할 책임이 있습니다.</p>
			
			<p>&nbsp;</p>
			
			<p><b>제13조 게시물 관련 사항</b></p>
			
			<p>1. "Tierheim(동물의 집)"는 게시물(게시글/댓글) 및 내용물에 관한 세부 이용지침(공지사항)을 별도로 정하여 운영할 수 있으며 회원은 그 지침에 따라 내용을 등록하여야 합니다.</p>
			
			<p>2. "Tierheim(동물의 집)"는 공개게시물의 내용이 다음 각 호에 해당하는 경우 회원에게 사전 통지 없이 해당 공개게시물을 임시 차단 조치 또는 삭제나 이동할 수 있고, 해당 회원의 회원 자격을 제한, 정지 또는 상실시킬 수 있습니다.</p>
			
			<p>&nbsp;① "Tierheim(동물의 집)"에서 제공하는 서비스에 정한 약관 기타 서비스 이용에 관한 규정을 위반하는 행위&nbsp;</p>
			
			<p>② "Tierheim(동물의 집)" 공지사항 또는 각 게시판 공지사항에 위반하는 내용</p>
			
			<p>③ 다른 회원 또는 제3자를 비방하거나 중상 모략으로 명예를 손상시키는 내용</p>
			
			<p>④ 제3자의 저작권 등 권리를 침해하는 내용</p>
			
			<p>⑤ 범죄행위와 관련이 있다고 판단되는 내용</p>
			
			<p>⑥ 기타 관계 법령에 위배된다고 판단되는 내용</p>
			
			<p>3. "Tierheim(동물의 집)"는 회원의 게시물 등에 대하여 다른 회원 혹은 제3자의 법률상 권리 침해를 근거로 게시 중단 요청을 받은 경우 게시물을 게시 중단할 수 있으며, 게시 중단 요청자와 게시물 등록 회원 간의 합의 또는 법적 조치의 결과 등이 "Tierheim(동물의 집)"에 접수되면 그에 따릅니다.</p>
			
			<p>&nbsp;</p>
			
			<p><b>제14조 저작권의 귀속 및 이용제한</b></p>
			
			<p>1. "Tierheim(동물의 집)"가 작성한 저작물에 대한 저작권 기타 지적재산권은 "Tierheim(동물의 집)"에 귀속합니다.</p>
			
			<p>2. 회원은 "Tierheim(동물의 집)"를 이용함으로써 얻은 정보를 "Tierheim(동물의 집)"의 사전승낙 없이 복제, 전송, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다.&nbsp;</p>
			
			<p>3. 회원이 서비스 내에 게시한 게시물의 저작권은 게시한 회원에게 귀속됩니다. 단, "Tierheim(동물의 집)"는 서비스의 운영, 전시, 전송, 배포, 홍보의 목적으로 회원의 별도의 허락 없이 무상으로 저작권법에 규정하는 공정한 관행에 합치되게 합리적인 범위 내에서 다음과 같이 회원이 등록한 게시물을 사용할 수 있습니다.&nbsp;</p>
			
			<p>① 서비스 내에서 회원 게시물의 복제, 수정, 개조, 전시, 전송, 배포 및 저작물성을 해치지 않는 범위 내에서의 편집 저작물 작성&nbsp;</p>
			
			<p>② 게시물 검색 서비스 등 향상된 서비스 제공을 위하여 관련 제휴사에게 필요한 자료(게시물 제목 및 내용, 게시일, 조회수 등)를 복제, 전송하는 것. 단, 이 경우 "Tierheim(동물의 집)"는 별도의 동의 없이 회원의 개인정보를 제공하지 않습니다.&nbsp;</p>
			
			<p>③ 미디어, 통신사 등 서비스 제휴사에게 회원의 게시물 내용을 제공, 전시 혹은 홍보하게 하는 것. 단, 이 경우 "Tierheim(동물의 집)"는 별도의 동의 없이 회원의 개인정보를 제공하지 않습니다.&nbsp;</p>
			
			<p>4. "Tierheim(동물의 집)"는 전항 이외의 방법으로 회원의 게시물을 이용하고자 하는 경우, 이메일 또는 기타 방식으로 회원의 사전 동의를 얻어야 합니다.</p>
			
			<p>5. 작성한 게시물로 인해 발생되는 문제에 대해서는 해당 게시물을 게시한 게시자에게 책임이 있으며, 타인의 권리를 침해한 게시물은 침해 당사자 또는 권한 대리인의 요청에 의해 삭제될 수 있습니다.</p>
			
			<p>6. 작성한 게시물로 인해 타인 및 저작물의 저작권을 침해하는 경우 이에 대한 민.형사상의 책임은 글 게시자에게 있습니다. 만일 이를 이유로 "Tierheim(동물의 집)"가 타인에게 손해배상청구 등 이의 제기를 받은 경우 해당 게시자는 그로 인해 발생되는 모든 손해를 부담해야 합니다.</p>
			
			<p>&nbsp;</p>
			
			<p><b>제15조 광고 게재 및 정보의 제공</b></p>
			
			<p>1. "Tierheim(동물의 집)"는 서비스 이용에 필요가 있다고 인정되는 각종 정보 또는 광고를 서비스 화면에 게재할 수 있습니다. 회원은 회원이 등록한 게시물의 내용을 활용한 광고게재 및 기타 서비스상에 노출되는 광고게재에 대해 동의합니다.&nbsp;</p>
			
			<p>2. "Tierheim(동물의 집)"는 서비스상에 게재되어 있거나 서비스를 통한 광고주의 판촉활동에 회원이 참여하거나 교신 또는 거래를 함으로써 발생하는 손실과 손해에 대해 책임을 지지 않습니다</p>
			
			<p>&nbsp;</p>
			
			<p><b>제16조 재판관할</b></p>
			
			<p>"Tierheim(동물의 집)"와회원간에 발생한 서비스 이용에 관한 분쟁에 대하여는 대한민국 법을 적용하며, 본 분쟁으로 인한 소는 민사소송법상의 관할을 가지는 대한민국의 법원에 제기합니다.</p>
			
			<p>&nbsp;</p>
			
			<p><b>부칙</b></p>
			
			<p>본 약관은 2021년 4월 3일부터 시행합니다.</p>
			
			</div>
			
			        </div>
			<div class="confirm">
			  <input type="checkbox" value="Y" id="accept_agreement_1" class="app-input-checkbox" required>
			  <label for="accept_agreement_1">위의 내용을 모두 읽었으며 동의합니다.</label>
			</div>
			<br><br>
				<div class="app-agreement" style="overflow:scroll;height:18rem;width:100%;">
			          
			          <div class="app-agreement-title">
			            <em style="color:red">*</em>            
			            	<span>개인정보 수집 및 이용 동의 (필수)</span>
			          </div>
			          <div class="app-agreement-body">
			            <p><b>1. 개인정보 처리방침</b></p>
			
			<p>"Tierheim(동물의 집)"는 이용자의 동의를 받아 개인정보를 수집, 이용 및 제공하고 있으며, ‘이용자의 권리 (개인정보 자기결정권)를 적극적으로 보장’ 합니다.&nbsp;또한 이용자에게 다양한 서비스를 제공함에 있어 아래 기준을 준수합니다."Tierheim(동물의 집)"는 정보통신서비스제공자가 준수하여야 하는 대한민국의 관계 법령 및 개인정보보호 규정, 가이드라인을 준수하고 있습니다. “개인정보처리방침”이란 이용자의 소중한 개인정보를 보호함으로써 이용자가 안심하고 서비스를 이용할 수 있도록 "Tierheim(동물의 집)"가 준수해야 할 지침을 의미합니다.&nbsp;</p>
			
			<p>&nbsp;</p>
			
			<p><b>2. 개인정보 수집</b></p>
			
			<p>모든 이용자는 "Tierheim(동물의 집)"가 제공하는 서비스를 이용할 수 있고, 회원가입과 구독 신청을 통해 더욱 다양한 서비스를 제공받을 수 있습니다. "Tierheim(동물의 집)"는 다음의 원칙 하에&nbsp; 이용자의 개인정보를 수집하고 있으며, 이용자의 개인정보를 수집하는 경우에는 반드시 사전에 이용자에게 해당 사실을 알리고 동의를 구하도록 하겠습니다.&nbsp; 수집방법에는 서비스 이용, 메일 구독 신청, 이벤트 응모, 전화 등이 있으며, 아래의 원칙을 준수하고 있습니다.&nbsp;&nbsp; &nbsp;</p>
			
			<p>1.&nbsp; 서비스 제공에 필요한 최소한의 개인정보를 수집합니다.&nbsp; &nbsp; &nbsp;</p>
			
			<p>- 개인정보 수집 항목 : 아이디, 비밀번호, 이메일, 닉네임, 이름</p>
			
			<p>2.서비스 이용과정에서 아래와 같은 정보들이 자동으로 생성되어 수집될 수 있습니다.&nbsp;</p>
			
			<p>-&nbsp; IP 주소, 쿠키, 방문 일시, 서비스 이용 기록, 불량 이용 기록</p>
			
			<p>3. "Tierheim(동물의 집)"는 민감 정보를 수집하지 않습니다.&nbsp; &nbsp; &nbsp;</p>
			
			<p>민감정보란는 이용자의 소중한 인권을 침해할 우려가 있는 정보입니다.(인종, 사상 및 신조, 정치적 성향이나 범죄기록, 의료정보 등)&nbsp; &nbsp; &nbsp;</p>
			
			<p>단, 법령에서 민감 정보의 처리를 요구하거나 허용하는 경우에는 반드시 사전에 이용자에게 해당 사실을 알리고 동의를 구하도록 하겠습니다.&nbsp;</p>
			
			<p>&nbsp;</p>
			
			<p><b>3. 개인정보 이용</b></p>
			
			<p>이용자의 개인정보를 다음과 같은 목적으로만 이용하며, 목적이 변경 될 경우에는 사전에 이용자에게 동의를 구하도록 하겠습니다.&nbsp;&nbsp; &nbsp;</p>
			
			<p>- 이용자 식별, 가입의사 및 연령 확인, 불량회원 부정이용 방지</p>
			
			<p>&nbsp;- 다양한 서비스 제공, 문의사항 또는 불만 처리, 공지사항 전달&nbsp; &nbsp;</p>
			
			<p>- 이용자와 약속한 서비스 제공, 유료 서비스 구매 및 이용 시 요금 정산&nbsp; &nbsp;</p>
			
			<p>- 신규 서비스 개발, 이벤트 행사 시 정보 전달, 마케팅 및 광고 등에 활용&nbsp; &nbsp;</p>
			
			<p>- 서비스 이용 기록과 접속 빈도 분석, 서비스 이용에 대한 통계, 맞춤형 서비스 제공, 서비스 개선에 활용</p>
			
			<p>&nbsp;"Tierheim(동물의 집)"는 이용자의 개인정보를 수집 및 이용 목적, 이용 기간에만 제한적으로 이용하고 있으며, 탈퇴를 요청하거나 동의를 철회하는 경우 지체 없이 파기합니다.&nbsp;</p>
			
			<p><b>4. 개인정보의 취급위탁</b></p>
			
			<p>&nbsp;"Tierheim(동물의 집)"는 서비스 유지와 향상을 위해 아래와 같이 개인정보를 위탁하고 있습니다. 또한 관계 법령에 따라 개인정보가 안전하게 관리될 수 있도록 필요한 사항을 규정하고 있습니다. 위탁 업무의 내용이나 수탁자가 변경될 경우에는 지체없이 본 개인정보 처리방침을 통해 공개하도록 하겠습니다.</p>
			
			<p>- 수탁업체 : Amazon Web Services Inc, (주)슬로워크(스티비)</p>
			
			<p>&nbsp;-위탁 업무 내용 : 개인정보가 저장된 국내 클라우드 서버 운영 및 관리 (Amazon Web Services Inc)</p>
			
			<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;광고 등 이메일 마케팅 컨텐츠 발송 ((주)슬로워크)</p>
			
			<p>개인정보의 보유 및 이용기간 :&nbsp; 회원탈퇴시 혹은 위탁계약 종료시까지</p>
			
			<p>&nbsp;</p>
			
			<p><b>5. 개인정보 파기</b></p>
			
			<p>이용자의 개인정보에 대해 개인정보의 수집·이용 목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 다만, 관계법령에 의해 보관해야 하는 정보는 법령이 정한 기간 동안 보관한 후 파기하며, 이용약관 15조 2항에 의해 ID가 정지 된 회원의 재가입을 막기 위해 본인확인값을 보관합니다.</p>
			
			<p>&nbsp;</p>
			
			<p><b>6. 기타사항</b></p>
			
			<p>&nbsp;- 언제든지 자신의 개인정보를 조회하고 수정할 수 있습니다.&nbsp;</p>
			
			<p>- 언제든지 개인정보 제공에 관한 동의철회/회원가입해지를 요청할 수 있습니다.&nbsp;</p>
			
			<p>&nbsp;- 정확한 개인정보의 이용 및 제공을 위해 수정이 완료될 때까지 이용자의 개인정보는 이용되거나 제공되지 않습니다.&nbsp;</p>
			
			<p>- 이미 제3자에게 제공된 경우에는 지체 없이 제공받은 자에게 사실을 알려 수정이 이루어질 수 있도록 하겠습니다.&nbsp; &nbsp;</p>
			
			<p>- 쿠키Cooie를 설치, 운영하고 있고 이용자는 이를 거부할 수 있습니다.&nbsp; &nbsp;</p>
			
			<p>- 쿠키는 이용자에게 보다 빠르고 편리한 웹사이트 사용을 지원하고 맞춤형 서비스를 제공하기 위해 사용됩니다.</p>
			
			<p>&nbsp;개인정보보호 책임자책임자 :&nbsp; Tierheim(동물의 집)운영팀(team"Tierheim(동물의 집)"@<a href="http://gmail.com/" rev="en_rl_none">gmail.com</a>)&nbsp;또한 개인정보가 침해되어 이에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하셔서 도움을 받으실 수 있습니다.&nbsp;&nbsp;</p>
			
			<p>- 개인정보침해신고센터 (<a href="http://privacy.kisa.or.kr/" rev="en_rl_none">http://privacy.kisa.or.kr</a>&nbsp;/ 국번없이 118)</p>
			
			<p>&nbsp;- 대검찰청 사이버수사과 (<a href="http://www.spo.go.kr/" rev="en_rl_none">http://www.spo.go.kr</a>&nbsp;/ 국번없이 1301)</p>
			
			<p>&nbsp;- 경찰청 사이버안전국 (<a href="http://cyberbureau.police.go.kr/" rev="en_rl_none">http://cyberbureau.police.go.kr</a>&nbsp;/ 국번없이 182)</p>
			
			<p>&nbsp;</p>
			
			<p><b>7. 부칙</b></p>
			
			<p>-&nbsp; 개인정보처리방침 시행일자 : 2021년 4월 3일</p>
			</div>
			
			
			
			        </div>  
			<div class="confirm">
			  <input type="checkbox" value="Y" id="accept_agreement_2" class="app-input-checkbox" required>
			  <label for="accept_agreement_2">위의 내용을 모두 읽었으며 동의합니다.</label>
			</div>
	</div>
	<br><br>
	<div>
		<h3 class="center"><span>회원가입 정보 입력</span></h3>
	</div>
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