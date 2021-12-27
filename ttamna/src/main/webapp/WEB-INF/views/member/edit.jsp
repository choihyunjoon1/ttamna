<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>
<link ref="stylesheet" type="text/css" href="${root }/resources/css/commons.css">
<!-- 입력값 정규표현식 검사 -->
<script type='text/javascript' src="${root}/resources/js/input-regex-check.js"></script>

<form method="post" class="form-check">
<div class="container-1000 container-center">
	<div class="container">
		<div class="align-self-center">
			<h1 align="center">EDIT</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<!-- 사이드바 자리 -->
			<jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
			<div class="col-2 center">
				<div class="p-4 border bg-light"><label>아이디</label></div>
				<div class="p-4 border bg-light"><label>닉네임</label></div>
				<div class="p-4 border bg-light"><label>이름</label></div>
				<div class="p-4 border bg-light"><label>등급</label></div>
				<div class="p-4 border bg-light"><label>가입일</label></div>
				<div class="p-4 border bg-light"><label>마지막 접속일</label></div>
				<div class="p-4 border bg-light"><label>핸드폰번호</label></div>
				<div class="p-4 border bg-light"><label>이메일</label></div>
				<div class="p-4 border bg-light"><label>우편번호</label></div>
				<div class="p-4 border bg-light"><label>기본주소</label></div>
				<div class="p-4 border bg-light"><label>상세주소</label></div>
				<br><br>
				<div class="d-grid gap-2">
					<a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/member/edit" role="button">정보수정</a>
				</div>
			</div>
			<div class="col-5 position-relative">
				<div class="p-4 border bg-light">${memberDto.memberId }</div>
				<div class="p-3 border bg-light">
					<input type="text" class="form-control input-nick" name='memberNick' required value="${memberDto.memberNick }">
					<span id = "nick-message"></span>
				</div>
				<div id='nick-message'></div>
				<div class="p-4 border bg-light">${memberDto.memberName }</div>
				<div class="p-4 border bg-light">${memberDto.memberGrade }</div>
				<div class="p-4 border bg-light">${memberDto.memberJoin }</div>
				<div class="p-4 border bg-light">${memberDto.memberLastLog }</div>
				<div class="p-4 border bg-light">
					<input type="text" class="form-control input-phone" name='memberPhone' required placeholder="핸드폰 번호 입력 010-0000-0000" aria-label="핸드폰 번호 입력 010-0000-0000" value="${memberDto.memberPhone }">
				</div>
				<div id='phone-message'></div>
				<div class="p-4 border bg-light">
					<input type="email" class="form-control input-email" name='memberEmail' required placeholder="이메일 입력" aria-label="이메일 입력" value="${memberDto.memberEamil }">
				</div>
				<div id='email-message'></div>
				<div class="p-4 border bg-light">${memberDto.postcode }</div>
				<div class="p-4 border bg-light">${memberDto.address }</div>
				<div class="p-4 border bg-light">${memberDto.detailAddress }</div>
				<div class="position-absolute bottom-0 end-0">
					<a href ="${pageContext.request.contextPath}/member/quit" type="button" class="btn btn-outline-danger right">회원탈퇴</a>
				</div>
			</div>
		</div>
	</div>
</div>
</form>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>