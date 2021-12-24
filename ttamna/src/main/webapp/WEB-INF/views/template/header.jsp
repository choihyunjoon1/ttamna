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
            </div>

        </header>

<!-- 메뉴 영역 -->
<div class="container-1000 centainer-center">
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container">
    <div class="collapse navbar-collapse" id="navbarColor01">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link active docs-creator" href="${root }">Home
            <span class="visually-hidden">(current)</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link docs-creator" href="${pageContext.request.contextPath}/donation/">기부</a>
        </li>
        <li class="nav-item">
          <a class="nav-link docs-creator" href="#">입양</a>
        </li>
        <li class="nav-item">
          <a class="nav-link docs-creator" href="#">내새끼사랑</a>
        </li>
         <li class="nav-item">
          <a class="nav-link docs-creator" href="${pageContext.request.contextPath}/shop/">상품구매</a>
        </li>
<!--         <li class="nav-item dropdown"> -->
<!--           <a class="nav-link dropdown-toggle docs-creator" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Dropdown</a> -->
<!--           <div class="dropdown-menu"> -->
<!--             <a class="dropdown-item docs-creator" href="#">Action</a> -->
<!--             <a class="dropdown-item docs-creator" href="#">Another action</a> -->
<!--             <a class="dropdown-item docs-creator" href="#">Something else here</a> -->
<!--             <div class="dropdown-divider"></div> -->
<!--             <a class="dropdown-item docs-creator" href="#">Separated link</a> -->
<!--           </div> -->
<!--         </li> -->
		<c:if test="${!login}">
		 <li class="nav-item">
          <a class="nav-link docs-creator" href="${root}/member/login">로그인</a>
         </li>
         <li class="nav-item">
          <a class="nav-link docs-creator" href="${root}/member/join">회원가입</a>
         </li>
        </c:if>
        <c:if test="${login}">
		 <li class="nav-item">
          <a class="nav-link docs-creator" href="${root }/member/logout">로그아웃</a>
         </li>
         <li class="nav-item">
          <a class="nav-link docs-creator" href="${root}/member/mypage">마이페이지</a>
         </li>
        </c:if>
      </ul>
     
    </div>
  </div>
</nav>
</div>
        <!-- 섹션(컨텐츠) 영역 -->
        <section>

