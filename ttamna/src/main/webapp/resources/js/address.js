/*
    주소 검색 모듈
    .find-address-btn을 누르면 자동으로 주소검색창이 나옴
    -input[name=postcode]에 우편번호 작성
    -input[name=address] 에 기본주소 작성
    -input[name=detailAddress] 에 커서 이동

    작성자 : 최현준
    작성일 : 2021-12-24
*/

$(function(){
    //.find-address-btn 이 눌리면(태그 종류 무관)무조건 주소 검색창 출력
    $(".address-btn").click(function(e){
        e.preventDefault();//a태그일 경우를 대비
        findAddress();

    });
    function findAddress() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                //(주의) jQuery로 처리하려면 jQuery CDN이 이 코드보다 위에 있어야 한다.

                document.querySelector("input[name=postcode]").value = data.zonecode;
                //$("input[name=postcode]").val(data.zonecode);
                document.querySelector("input[name=address]").value = addr;
                //$("input[name=basicAddress]").val(data.zonecode);
                // 커서를 상세주소 필드로 이동한다.
                document.querySelector("input[name=detailAddress]").focus();
                //$("input[name=extraAddress]").focus();
            }
    }).open();
}
});