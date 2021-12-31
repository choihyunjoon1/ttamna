<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>
 <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link ref="stylesheet" type="text/css" href="${root }/resources/css/commons.css">

<div class="container-1000 container-center">
	<div class="container">
		<div class="align-self-center">
			<h1 align="center">MY INFO</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<!-- 사이드바 자리 -->
			<jsp:include page="/WEB-INF/views/member/mypage/sidebar.jsp"></jsp:include>
			<div class="col-2 center"  style="width:20%;">
				<div class="p-3 border bg-light"><label>아이디</label></div>
				<div class="p-3 border bg-light"><label>닉네임</label></div>
				<div class="p-3 border bg-light"><label>이름</label></div>
				<div class="p-3 border bg-light"><label>등급</label></div>
				<div class="p-3 border bg-light"><label>가입일</label></div>
				<div class="p-3 border bg-light"><label>마지막 접속일</label></div>
				<div class="p-3 border bg-light"><label>핸드폰번호</label></div>
				<div class="p-3 border bg-light"><label>이메일</label></div>
				<div class="p-3 border bg-light"><label>우편번호</label></div>
				<div class="p-3 border bg-light"><label>기본주소</label></div>
				<div class="p-3 border bg-light"><label>상세주소</label></div>
				<br><br>
				<div class="d-grid gap-2">
					<a class="btn btn-outline-primary" href="${root}/member/mypage/edit" role="button">정보수정</a>
				</div>
			</div>
			<div class="col-6 position-relative"  style="width:60%;">
				<div class="p-3 border bg-light">${memberDto.memberId}</div>
				<div class="p-3 border bg-light">${memberDto.memberNick }</div>
				<div class="p-3 border bg-light">${memberDto.memberName }</div>
				<div class="p-3 border bg-light">${memberDto.memberGrade }</div>
				<div class="p-3 border bg-light">${memberDto.memberJoin }</div>
				<div class="p-3 border bg-light">${memberDto.memberLastLog }</div>
				<div class="p-3 border bg-light">${memberDto.memberPhone }</div>
				<div class="p-3 border bg-light">${memberDto.memberEmail }</div>
				<div class="p-3 border bg-light">${memberDto.postcode }</div>
				<div class="p-3 border bg-light">${memberDto.address }</div>
				<div class="p-3 border bg-light">${memberDto.detailAddress }</div>
				<div class="position-absolute bottom-0 end-0">
					<a href ="${pageContext.request.contextPath}/member/mypage/quit" type="button" class="btn btn-outline-danger right">회원탈퇴</a>
				</div>
			</div>
			
		</div>
	</div>
</div>








<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>