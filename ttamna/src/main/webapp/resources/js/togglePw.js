/**비밀번호 토글
 * type이 password면 text로 바꾸고 text면 password로 바꾼다
 * 헤더에 로그인용 form이 있을 수도 있으니 회원가입form에 id=join-form을 부여
 * <CLASS>
 * .toggleInputPw : 비밀번호 입력시 보기/숨김 토글 클래스
 * .input-pw : 비밀번호 입력창 지정 클래스
 * .toggleReInputPw : 비밀번호 확인 입력시 보기/숨김 토글 클래스
 * .reInput-pw : 비밀번호 확인 입력창 지정 클래스
 */

	window.addEventListener("load", function(){
		var form = document.querySelector("#join-form");
        form.querySelector(".toggleInputPw").addEventListener("click", function(){
            var inputPw = form.querySelector(".input-pw");
            if (inputPw.type == "password") {
                inputPw.type = "text";
            } else {
                inputPw.type = "password";
            }
        });
       form.querySelector(".toggleReInputPw").addEventListener("click", function(){
            var reInputPw = form.querySelector(".reInput-pw");
            if (reInputPw.type == "password") {
                reInputPw.type = "text";
            } else {
                reInputPw.type = "password";
            }
       });
   });