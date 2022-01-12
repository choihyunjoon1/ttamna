<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%-- 페이지에서 사용할 JSTL 변수 --%>
<c:set var="login" value="${uid != null}"></c:set>
<c:set var="admin" value="${grade == '관리자'}"></c:set>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tierheim</title>
    <link rel="stylesheet" type="text/css" href="${root }/resources/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${root }/resources/css/commons.css">
    <link rel="stylesheet" type="text/css" href="${root }/resources/css/layout.css">
    <!-- Bootstrap CSS CDN-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

 	<!-- Bootswatch Skin Minty CDN적용하기-->
    <link rel="stylesheet" type="text/css" href="https://bootswatch.com/5/minty/bootstrap.css">
    
    <!-- three.js -->
    <link rel="stylesheet" href="${root}/resources/css/three.css">
    
    <script type="module" src="${root}/resources/js/three.js" defer></script>
    
    <!-- JQeury CDN -->
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
   
    <!-- Bootstrap JavaScript CDN 번들 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    <style>
     <!-- 메뉴 사이즈 줄어들어어어 ********-->
    	@media(min-width: 992px)
		.navbar-expand-lg .navbar-collapse {
		    display: -ms-flexbox !important;
		    display: flex !important;
		    -ms-flex-preferred-size: auto;
		    flex-basis: auto;
		}
		
		
    	.logo-wrapper {
            width:130px;
        }
        .logo-wrapper > img {
            width:100%;
            height:100%;
        }
        .title-wrapper {
            flex-grow: 1;
        }
    </style>
    <script>
    window.addEventListener("load", function(){
    	//현재까지의 총 누적 기부금액(일시기부 금액 + 정기기부 금액)
	   	 $.ajax({
	   		 url : "${root}/ajax/donation_total",
	   		 type : "get",
	   		 dataType : "json",
	   		success:function(resp){
	   			console.log("총 누적 기부금액 불러오기 성공");
	   			
	   			var totalAmount = resp.toLocaleString('ko-KR');
	   			var today = new Date();   

	   			var year = today.getFullYear(); // 년도
	   			var month = today.getMonth() + 1;  // 월
	   			var date = today.getDate();  // 날짜

	   			$(".date").text( year +"년 "+ month +"월 "+ date +"일" );
	   			$(".total").text( totalAmount +"원");
	   		 },
	   		 error:function(e){
	   		 	console.log("총 누적 기부금액 불러오기 실패", e);
	   		 }
	   	 });
    }); 
    
    var pathname = window.location.pathname.split( '/' );
    var pathlocation=pathname[2];//   /member/ .. 로 나옴
    console.log(pathlocation);
	
    $(function(){
        if(pathlocation=="shop"){
        	$(".nav-item > a").removeClass("active");
        	$(".headShop").addClass("active");
        }else if(pathlocation=="donation"){
        	$(".nav-item > a").removeClass("active");
        	$(".headDonation").addClass("active");
        }else if(pathlocation=="mybaby"){
        	$(".nav-item > a").removeClass("active");
        	$(".headMybaby").addClass("active");
        }else if(pathlocation=="adopt"){
        	$(".nav-item > a").removeClass("active");
        	$(".headAdopt").addClass("active");
        }else if(pathlocation=="member"||pathlocation=="find"){
        	$(".nav-item > a").removeClass("active");
        	$(".headMember").addClass("active");
        }else if(pathlocation=="admin"){
        	$(".nav-item > a").removeClass("active");
        	$(".headAdmin").addClass("active");
        }else{
        	$(".list-group > a").removeClass("active");
        	$(".headHome").addClass("active");
        }
    });

    </script>
</head>
<body>
<!-- 메인 시작 -->
    <main>
        <!-- 헤더 -->
        <header>
            <div class="flex-container">
                <div class="logo-wrapper">
                    <div id="webgl-container" style="width:100px; height:100px"></div>
                
                </div>
                
                <div class="center centerSize">
						<div style="width:600px; float:left;">
                        <a href="${root}">
                            <img src="${root}/resources/img/두줄로고.png" style="width:600px;">
                        </a>
                        </div>
                    <!-- 세션,등급 알아내기 위함 나중에 삭제 -->
<%--                     <h5>uid=${uid}</h5><h5>grade=${grade }</h5> --%>
                </div>
            
            	<!-- 현재까지의 총 기부 누적액을 보여준다 -->
				<div class="badge text-wrap p-2 bg-primary bg-opacity-75" style="width:10rem; height:3rem;">
				   <div><small><strong class="date"></strong></small></div>
				   <div><small>누적 기부 금액</small></div>
				   <div><small><strong class="total"></strong></small></div>
            	</div>
   
			</div>
            	
        </header>
<!-- 메뉴 영역 -->

<div class="container-1000 centainer-center">
<nav class="navbar navbar-expand-lg navbar-dark bg-primary fw-bold">
  <div class="container-fluid">
    <div class="collapse navbar-collapse" id="navbarColor01">
      <ul class="navbar-nav me-auto navbar-right">
          <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle docs-creator headMember" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Info</a>
          <div class="dropdown-menu">
            <a class="dropdown-item docs-creator headMember" href="${root }">Home</a>
            <a class="dropdown-item docs-creator headMember" href="${root}/upgrade">보호소 등급신청 방법</a>
            <a class="dropdown-item docs-creator headMember" href="${root}/support">유기동물 입양 지원 안내</a>
          </div>
        </li>
     </ul>
     <ul class="navbar-nav me-auto navbar-center fs-6" >
        <li class="nav-item ms-1">
          <a class="nav-link docs-creator headShop" href="${root}/shop/"  aria-current="page">후원상품🐾</a>
        </li>
        <li class="nav-item ms-5">
          <a class="nav-link docs-creator headDonation" href="${root}/donation/">기부🐾</a>
        </li>
        <li class="nav-item ms-5">
          <a class="nav-link docs-creator headAdopt" href="${root}/adopt/">입양공고🐾</a>
        </li>
         <li class="nav-item ms-5">
          <a class="nav-link docs-creator headMybaby" href="${root }/mybaby/">내새끼자랑🐾</a>
        </li>
	 </ul>
	 <ul class="navbar-nav navbar-left">
		<c:if test="${!login}">
		 <li class="nav-item">
          <a class="nav-link docs-creator headMember" href="${root}/member/login">LOGIN</a>
         </li>
         <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle docs-creator headMember" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">𓃑𓃑𓃑ʕ •ᴥ•ʔ</a>
          <div class="dropdown-menu">
            <a class="dropdown-item docs-creator headMember" href="${root}/member/join">회원가입ฅ ̳͒•ˑ̫• ̳͒ฅ♡</a>
            <a class="dropdown-item docs-creator headMember" href="${root}/find/findId">아이디 찾기</a>
            <a class="dropdown-item docs-creator headMember" href="${root}/find/findPw">비밀번호 찾기</a>
          </div>
        </li>
        </c:if>
        <c:if test="${login}">
         <li class="nav-item">
          <a class="nav-link active docs-creator headMember" href="${root}/member/mypage/my_info">MY PAGE</a>
         </li>
         	<c:if test="${admin}">
         	  <li class="nav-item">
	           <a class="nav-link active docs-creator headAdmin" href="${root}/admin/main">ADMIN</a>
	          </li>
         	</c:if>
		 <li class="nav-item ms-3">
          <a class="nav-link active docs-creator" href="${root }/member/logout">LOGOUT</a>
         </li>
        </c:if>
      </ul>
     
    </div>
  </div>
</nav>
</div>

        <!-- 섹션(컨텐츠) 영역 -->
        <section>