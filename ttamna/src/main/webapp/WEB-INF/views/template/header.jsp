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
    <title>땀나홈페이지</title>
    <link rel="stylesheet" type="text/css" href="${root}/resources/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${root}/resources/css/commons.css">
    <link rel="stylesheet" type="text/css" href="${root}/resources/css/layout.css">
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
                    <h1>땀부홈페이지</h1>
                    <!-- 세션,등급 알아내기 위함 나중에 삭제 -->
                    <h5>uid=${uid}</h5><h5>grade=${grade }</h5>
                </div>
            </div>

        </header>

        <!-- 메뉴 영역 -->
        <nav>
        	 <ul class="slide-menu">
            	<c:choose>
            		<c:when test="${login}">
            			<li><a href="${root}">홈으로</a></li>
		            	<li><a href="${root}/board/list">게시판</a></li>
		            	<li class="flex-right">
		            		<a href="#">회원메뉴</a>
		            		<!-- 슬라이드안되서 잠시 주석처리 -->
<!-- 		            		<ul> -->
		            			<c:choose>
		            				<c:when test="${admin}">
		            					<li><a href="${root}/admin/home">관리메뉴</a></li>
		            				</c:when>
		            				<c:otherwise>
		            					<li><a href="${root}/point/charge">포인트 충전</a></li>
				            			<li><a href="${root}/member/mypage">내정보</a></li>
		            				</c:otherwise>
		            			</c:choose>
				            	<li><a href="${root}/member/logout">로그아웃</a></li>
<!-- 		            		</ul> -->
		            	</li>
            		</c:when>
            		<c:otherwise>
	            		<li><a href="${root}">홈으로</a></li>
		            	<li><a href="${root}/?">게시판</a></li>
		            	<li class="flex-right">
		            		<li><a href="${root}/member/login">로그인</a></li>
		            		<li><a href="${root}/member/join">회원가입</a></li>
		            	</li>
            		</c:otherwise>
            	</c:choose>
            
            </ul>
        </nav>

        <!-- 섹션(컨텐츠) 영역 -->
        <section>

