<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>    
    
    <script>
    var pathName=location.pathname;
	var index = 15;//ttamna/member/고정
    var locaMenu = pathName.substring(index);
	console.log(locaMenu);
	
    $(function(){
        if(locaMenu=="mypage"){
        	$(".list-group > a").removeClass("active");
        	$(".mypage").addClass("active");
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
        }else{
        	$(".list-group > a").removeClass("active");
        	$(".myBasket").addClass("active");
        }
    });

</script>


<div class="col-3">
	<div class="list-group">
	<!-- 클릭할 때 해당 메뉴 class에 active 붙이기 -->
		<a href = "${root }/member/mypage" class="list-group-item list-group-item-action mypage" >내 정보</a>
		<a href = "${root }/member/edit" class="list-group-item list-group-item-action edit">정보 수정</a>
		<a href = "${root }/member/change_pw" class="list-group-item list-group-item-action  changePw">비밀번호 변경</a>
		<a href = "${root }/member/my_board" class="list-group-item list-group-item-action  myBoard">내 게시글 보기</a>
		<a href = "${root }/member/my_donation" class="list-group-item list-group-item-action  myDonation">기부 목록</a>
		<a href = "${root }/member/my_order" class="list-group-item list-group-item-action  myOrder">주문 내역</a>
		<a href = "${root }/member/my_basket" class="list-group-item list-group-item-action  myBasket">장바구니</a>
		<a href = "${root }/member/logout" class="list-group-item list-group-item-action  logout">로그아웃</a>
	</div>
</div>
	
