<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${root}/resources/js/address.js"></script>
<link ref="stylesheet" type="text/css" href="${root }/resources/css/commons.css">

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
				<div class="p-3 border bg-light"><label>아이디</label></div>
				<div class="p-4 border bg-light"><label>닉네임</label></div>
				<div class="p-4 border bg-light"><label>비밀번호</label></div>
				<div class="p-3 border bg-light"><label>이름</label></div>
				<div class="p-4 border bg-light"><label>핸드폰번호</label></div>
				<div class="p-4 border bg-light"><label>이메일</label></div>
				<div class="p-4 border bg-light"><label>우편번호</label></div>
				<div class="p-4 border bg-light"><label>기본주소</label></div>
				<div class="p-4 border bg-light"><label>상세주소</label></div>
				<br><br>
				<div class="d-grid gap-2">
					<input type="submit" class="btn btn-outline-primary" value="수정">
				</div>
			</div>
			<div class="col-5 position-relative">
				<div class="p-3 border bg-light">${memberDto.memberId }</div>
				<div class="p-3 border bg-light">
					<input type="text" class="form-control input-nick" name='memberNick' required value="${memberDto.memberNick }">
				</div>
				<div id='nick-message'></div>
				<div class="p-3 border bg-light">
					<input type="password" class="form-control input-pw" name="memberPw" required placeholder="비밀번호 입력" aria-label="비밀번호 입력" aria-describedby="button-addon-pw">
				</div>
				<div class="p-3 border bg-light">${memberDto.memberName }</div>
				<div class="p-3 border bg-light">
					<input type="text" class="form-control input-phone" name='memberPhone' required value="${memberDto.memberPhone }">
				</div>
				<div id='phone-message'></div>
				<div class="p-3 border bg-light">
					<input type="email" class="form-control input-email" name='memberEmail' required value="${memberDto.memberEmail }">
				</div>
				<div id='email-message'></div>
				<div class="p-3 border bg-light">
				<div class="row">
					<div class="col-5">
						<input type="text" class="form-control input-phone"  name="postcode" aria-describedby="button-addon-postcode" value="${memberDto.postcode}">
					</div>
					<div class="col-5">
						<button class="address-btn btn btn-outline-primary" type="button" id="button-addon-postcode">우편번호 찾기</button>
					</div>
				</div>
				</div>
				<div class="p-3 border bg-light">
					<input type="text" class="form-control" name="address" value="${memberDto.address }">
				</div>
				<div class="p-3 border bg-light">
					<input type="text" class="form-control" name="detailAddress"  value="${memberDto.detailAddress}">
				</div>
				<c:if test="${param.error !=null }">
					<span>정보가 올바르지 않습니다. 다시 확인해주세요!</span>
				</c:if>
				<div class="position-absolute bottom-0 end-0">
					<a href ="${pageContext.request.contextPath}/member/mypage" type="button" class="btn btn-outline-danger">취소</a>
				</div>
			</div>
		</div>
	</div>
</div>
</form>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>