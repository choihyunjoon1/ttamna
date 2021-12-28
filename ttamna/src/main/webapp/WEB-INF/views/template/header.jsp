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
    
    <!-- JQeury CDN -->
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
   
    <!-- Bootstrap JavaScript CDN 번들 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    <style>
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
    //오늘 방문자수를 찍기 위한 ajax. 페이지가 load 되자마자 실행되야 한다
    window.addEventListener("load", function(){
    		
    	$.ajax({
    		url : "${root}/ajax/dayLog",
    		type : "get",
    		dataType : "text",
    		success:function(resp){
    			console.log("방문자수 조회 성공", resp);
    			//dayLog 클래스가 부여된 창에 조회된 방문자 수를 찍어준다
    			$(".dayLog").text(resp+"명");
    		},
    		error:function(e){
    			console.log("실패", e);
    		}
    	});
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
                   <!-- 이미지로고자리 -->
                </div>
                <div class="title-wrapper center">
                    <h1>Tierheim(동물의 집)</h1>
                    <!-- 세션,등급 알아내기 위함 나중에 삭제 -->
                    <h5>uid=${uid}</h5><h5>grade=${grade }</h5>
                </div>
            
	            <!-- 오늘 방문자 수를 찍어 주는 영역 -->
	           <div class="card" style="width:10rem; height:4.5rem;" align="center">
				  <div class="card-body">
				    <h6 class="card-title mb-1">오늘의 방문자</h6>
				    <div class="card-text dayLog mb-2"></div>
				  </div>
				</div>
				
            </div>

        </header>

<!-- 메뉴 영역 -->
<div class="container-1000 centainer-center">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary fw-bold">
  <div class="container">
    <div class="collapse navbar-collapse" id="navbarColor01">
      <ul class="navbar-nav me-auto navbar-right">
        <li class="nav-item">
          <a class="nav-link active docs-creator" href="${root }">Home
            <span class="visually-hidden">(current)</span>
          </a>
        </li>
     </ul>
     <ul class="navbar-nav me-auto navbar-center fs-6">
        <li class="nav-item ms-1">
          <a class="nav-link active docs-creator" href="${root}/shop/">후원상품</a>
        </li>
        <li class="nav-item ms-5">
          <a class="nav-link active docs-creator" href="${root}/donation/">기부</a>
        </li>
        <li class="nav-item ms-5">
          <a class="nav-link active docs-creator" href="#">입양공고</a>
        </li>
         <li class="nav-item ms-5">
          <a class="nav-link active docs-creator" href="#">내새끼자랑</a>
        </li>
	 </ul>
	 <ul class="navbar-nav navbar-left">
		<c:if test="${!login}">
		 <li class="nav-item">
          <a class="nav-link active docs-creator" href="${root}/member/login">LOGIN</a>
         </li>
         <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle docs-creator" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">메뉴</a>
          <div class="dropdown-menu">
            <a class="dropdown-item docs-creator" href="${root}/member/join">회원가입</a>
            <a class="dropdown-item docs-creator" href="${root}/find/findId">아이디 찾기</a>
            <a class="dropdown-item docs-creator" href="${root}/find/findPw">비밀번호 찾기</a>
          </div>
        </li>
        </c:if>
        <c:if test="${login}">
         <li class="nav-item">
          <a class="nav-link active docs-creator" href="${root}/member/mypage">MY PAGE</a>
         </li>
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

