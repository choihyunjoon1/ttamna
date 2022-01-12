<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%-- 페이지에서 사용할 JSTL 변수 --%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>   

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>	
<div class="container-600 container-center">
	<div class="card mb-5">
		<div class="card-header d-grid gap-2 justify-content-center mt-2">
			<h3>동물 보호소 입증을 위해 필요한 서류</h3>
		</div>

		<div class="card-body">
			<p class="card-text">(1) 동물 보호센터 이름</p>
			<p class="card-text">(2) 동물 보호센터 지정일자</p>
			<p class="card-text">(3) 동물 보호센터 주소</p>
			<p class="card-text">(4) 동물 보호센터 전화번호</p>
			<p class="card-text"><strong>위 내용을 이메일에 작성해 주시고 법인 등록증을 첨부해 주시기 바랍니다</strong></p>
		</div>
		<div class="card-footer text-muted">
			<p><small>
				위 서류를 <strong>testmin88@gmail.com</strong>으로 제출해주세요.
제출 후 7일 이내로 확인절차 진행 후 보호소 등급으로 설정됩니다.
제출해 주신 내용을 바탕으로 동물보호관리시스템(https://www.animal.go.kr) 
사이트내의 동물보호센터 등록여부를 확인합니다.
관리자가 확인 후 서류를 전송한 이메일로 
결과를 고지하는 메일을 보내드립니다. 
			</small></p>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>