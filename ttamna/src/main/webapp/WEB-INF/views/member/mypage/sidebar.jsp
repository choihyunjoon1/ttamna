<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>    
    
    <script>
    var pathName=location.pathname;
	var index = 22;//ttamna/member/mypage고정
    var locaMenu = pathName.substring(index);
	console.log(locaMenu);
	
    $(function(){
        if(locaMenu=="my_info"){
        	$(".list-group > a").removeClass("active");
        	$(".myInfo").addClass("active");
        }else if(locaMenu=="edit"){
        	$(".list-group > a").removeClass("active");
        	$(".edit").addClass("active");
        }else if(locaMenu=="change_pw"){
        	$(".list-group > a").removeClass("active");
        	$(".changePw").addClass("active");
        }else if(locaMenu=="my_board"){
        	$(".list-group > a").removeClass("active");
        	$(".myBoard").addClass("active");
        }else if(locaMenu=="my_donation"){
        	$(".list-group > a").removeClass("active");
        	$(".myDonation").addClass("active");
        }else if(locaMenu=="my_order"){
        	$(".list-group > a").removeClass("active");
        	$(".myOrder").addClass("active");
        }else if(locaMenu=="quit"){
        	$(".list-group > a").removeClass("active");
        	$(".quit").addClass("active");
        }else{
        	$(".list-group > a").removeClass("active");
        	$(".myBasket").addClass("active");
        }
    });

</script>


<div class="col-2">
	<div class="list-group" style="text-align:center;">
	<!-- 클릭할 때 해당 메뉴 class에 active 붙이기 -->
		<a href = "${root }/member/mypage/my_info" class="list-group-item list-group-item-action myInfo" >내 정보</a>
		<a href = "${root }/member/mypage/edit" class="list-group-item list-group-item-action edit">정보 수정</a>
		<a href = "${root }/member/mypage/change_pw" class="list-group-item list-group-item-action  changePw">비밀번호 변경</a>
		<a href = "${root }/member/mypage/my_board" class="list-group-item list-group-item-action  myBoard">내 게시글 보기</a>
		<a href = "${root }/member/mypage/my_donation" class="list-group-item list-group-item-action  myDonation">기부 목록</a>
		<a href = "${root }/member/mypage/my_order" class="list-group-item list-group-item-action  myOrder">주문 내역</a>
		<a href = "${root }/member/mypage/my_basket" class="list-group-item list-group-item-action  myBasket">장바구니</a>
		<a href = "${root }/member/mypage/quit" class="list-group-item list-group-item-action  quit">회원탈퇴</a>
	</div>
</div>
	
