<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${root}/resources/js/address.js"></script>
<link ref="stylesheet" type="text/css" href="${root }/resources/css/commons.css">
<script src= "http://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){
		$("input[type=submit]").click(function(e){
			e.preventDefault();
			var defaultPw = $(".input-pw").val();
			var newPw = $(".input-newPw").val();
			var newRePw = $(".input-newRePw").val();
			console.log(defaultPw);
			console.log(newPw);
			console.log(newRePw);
			
			//defaultPw != newPw && newPw == newRePw;이어야 한다.
			var isCheckPw = defaultPw != newPw && newPw == newRePw;
			console.log(isCheckPw);
			if(isCheckPw){
				$(".form-check").submit();
			}else{
				$(".checkPwMessage").text("비밀번호가 다릅니다. 확인해주세요");
			}
			
		});
	});
</script>

<form method="post" class="form-check">
<div class="container-1000 container-center">
	<div class="container">
		<div class="align-self-center">
			<h1 align="center">CHANGE PASSWORD</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<!-- 사이드바 자리 -->
			<jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
			<div class="col-3 center">
				<div class="p-4 border bg-light"><label>현재 비밀번호</label></div>
				<div class="p-4 border bg-light"><label>새 비밀번호</label></div>
				<div class="p-4 border bg-light"><label>새 비밀번호 확인</label></div>
				<br><br>
				<div class="d-grid gap-2">
					<input type="submit" class="btn btn-outline-primary" value="수정">
				</div>
			</div>
			<div class="col-5 position-relative">
				<div class="p-3 border bg-light">
					<input type="password" class="form-control input-pw" name='memberPw' required  placeholder="현재비밀번호 입력" aria-label="현재비밀번호 입력" aria-describedby="button-addon-pw" data-regex="^[a-z]{8,15}$">
				</div>
				<div class="p-3 border bg-light">
					<input type="password" class="form-control input-newPw" name="memberNewPw" required placeholder="새비밀번호 입력" aria-label="새비밀번호 입력" aria-describedby="button-addon-pw" data-regex="^[a-z]{8,15}$">
				</div>
				<div class="p-3 border bg-light">
					<input type="password" class="form-control input-newRePw" name="memberNewPwCheck" required placeholder="새비밀번호 확인 입력" aria-label="새비밀번호 확인 입력" aria-describedby="button-addon-pw" data-regex="^[a-z]{8,15}$">
				</div>
				<span class="checkPwMessage"></span>
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