/**비밀번호 입력값, 재입력값이 일치하는지 검사하는 스크립트
 * 비밀번호 입력창 선택자 : .input-pw
 * 비밀번호 재입력창 선택자 : .reInput-pw
 * 메세지를 보여주기 위한 선택자 : .rePw-message
 * 일치하지 않을 경우 서브밋 이벤트 방지
 */

 window.addEventListener("load", function(){
		var form  = document.querySelector('.form-check');
		 form.querySelector(".reInput-pw").addEventListener("blur", function(){
			var inputPw = form.querySelector(".input-pw").value;
			var reInputPw = form.querySelector(".reInput-pw").value;
			var message = form.querySelector(".rePw-message");
			 if(inputPw != "" && reInputPw != ""){
				 if(inputPw == reInputPw){
					 $(message).text("비밀번호가 일치합니다");
					 console.log("비번 & 재확인비번 일치");	
					 $(form).attr('onsubmit', 'event.addEventListener();');
				 }else if(inputPw != reInputPw){
					 $(message).text("비밀번호가 일치하지 않습니다");
					 console.log("비번 & 재확인비번 불일치");	
					 $(".reInput-pw").focus();
					 $(form).attr('onsubmit', 'event.preventDefault();');
				 }
			 }
	     });
	});