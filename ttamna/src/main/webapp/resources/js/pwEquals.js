/**비밀번호 입력값, 재입력값이 일치하는지 검사하는 스크립트
 * 
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