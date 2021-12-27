/**
 * 
 */
window.addEventListener("load", () => {
	
	var form  = document.querySelector('.form-check');
	form.querySelector("input[name=memberId]").blur(function(){
        
        var inputId = form.querySelector("input[name=memberId]").value;	
        var message = form.querySelector(".id-message");

        if(inputId != ""){
                    
                //아이디 중복검사(Ajax)  
                console.log("중복검사 시작");
                var url = sysurl +"/users/register_id_check.nogari";
                console.log("[Ajax 검사]");
                console.log("inputId: " + inputId);
                console.log("url: " + url);
                    
                // Ajax 설정 (1) 패러미터 설정
                var params = {
                    type: "get", //전송방식 post로도 가능
                    url: "${pageContext.request.contextPath}/member/ajaxId",
                    data: {
                        memberId:inputId	//이름:값
                    },
                    dataType : "text"
                };

                // Ajax 설정 (2) 통신 완료 시 동작 설정
                params.success = (resp) => {
                    console.log("ID 중복검사 요청 성공. ID : "+resp);
                    if(resp == "YYYY") { //사용가능한 아이디
                        $(message).text("아이디 사용 가능");
                    	$(form).attr('onsubmit', 'event.addEvenetListener();');
                    } else if(resp =="NNNN") { //아이디가 중복
                        $(message).text("아이디가 이미 사용중입니다");
						form.querySelector("input[name=memberId]").focus();
						$(form).attr('onsubmit', 'event.preventDefault();');
						
                    }
               }
                    
                // Ajax 설정 (3) 통신 실패 시 동작 설정
                params.error = (err) => { //통신 실패
                    console.log("ID 중복검사 요청 실패");
                    console.log(err);
                }
                    
                // Ajax 처리
                $.ajax(params);
                    
            }
    });

});