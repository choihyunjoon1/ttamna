/** 입력값 정규표현식 검사 스크립트 모듈
 * form태그에 class=form-check를 부여하고 form안의 입력값들을 검사
 * 회원정보 수정 시에도 적용할 수 있음
 * 각 입력값에 대한 메세지를 보여줄 태그에 입력창별로 클래스를 부여
 * .id-message / .pw-message / .nick-message / .name-message / .phone-message / .email-message
 * 아이디 정규표현식 검사
 * 비밀번호 정규표현식 검사
 * 닉네임 정규표현식 검사
 * 이름 정규표현식 검사
 * 이메일 정규표현식 검사
 * 폰번호 정규표현식 검사
 */

//ex
//function regexCheck(inputList){
//	var total = inputList.length;
//	var success = 0, fail = 0;
//	for(var i=0; i < inputList.length; i++){
//		console.log(inputList[i].dataset.regex);
//		var regex = new RegExp(inputList[i].dataset.regex);
//		var value = inputList[i].value;
//		
//		if(regex.test(value)){
//			console.log("성공");
//			success++;
//		}
//		else{
//			console.log("실패");
//			fail++;
//		}
//	}
//	console.log("총", total, "성공", success, "실패", fail);
//	
//	return total === success;
//}


    window.addEventListener("load", function(){
      var form  = document.querySelector('.form-check');
		
      
		
  		//비밀번호 정규표현식 검사
  		form.querySelector("input[name=memberPw]").addEventListener("input", function(e){
  	        var regex = /^(?=[a-z].*)[a-z0-9_?!@#$%]{4,20}$/;
  	        var inputPw = form.querySelector("input[name=memberPw]").value;	
  	        var message = form.querySelector(".pw-message");
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