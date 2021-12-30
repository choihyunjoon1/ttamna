<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>    
    <style>
    	.list-group > .list-group-item{
    		font-size:14px;
    	}
    </style>
    <script>
    var pathname = window.location.pathname.split( '/' );
    var pathlocation=pathname[3];//   /member/ .. 로 나옴
    console.log(pathlocation);
	
    $(function(){
        if(pathlocation=="member"){
        	$(".list-group > a").removeClass("active");
        	$(".memberAdmin").addClass("active");
        }else if(pathlocation=="shop"){
        	$(".list-group > a").removeClass("active");
        	$(".shopAdmin").addClass("active");
        }else if(pathlocation=="donation"){
        	$(".list-group > a").removeClass("active");
        	$(".donationAdmin").addClass("active");
        }else if(pathlocation=="mybaby"){
        	$(".list-group > a").removeClass("active");
        	$(".mybabyAdmin").addClass("active");
        }else if(pathlocation=="adopt"){
        	$(".list-group > a").removeClass("active");
        	$(".adoptAdmin").addClass("active");
        }else{
        	$(".list-group > a").removeClass("active");
        	$(".statisticsAdmin").addClass("active");
        }
    });

</script>


<div class="col-2">
	<div class="list-group">
	<!-- 클릭할 때 해당 메뉴 class에 active 붙이기 -->
		<a href = "${root }/admin/member/list" class="list-group-item list-group-item-action memberAdmin" >회원 목록</a>
		<a href = "${root }/admin/shop/" class="list-group-item list-group-item-action shopAdmin">후원상품 목록</a>
		<a href = "${root }/admin/donation/" class="list-group-item list-group-item-action  donationAdmin">기부게시판 목록</a>
		<a href = "${root }/admin/mybaby/" class="list-group-item list-group-item-action  mybabyAdmin">내새끼자랑 목록</a>
		<a href = "${root }/admin/adopt/" class="list-group-item list-group-item-action  adoptAdmin">입양 공고 목록</a>
		<a href = "${root}/admin/statistics/menu" class="list-group-item list-group-item-action  statisticsAdmin">방문자 통계</a>
	</div>
</div>
	

	