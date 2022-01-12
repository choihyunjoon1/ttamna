<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%-- 페이지에서 사용할 JSTL 변수 --%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>   

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>	
<div class="container-600 container-center">
<div class="mt-5 mb-5"><h3><strong>동물 보호소 입증을 위해 필요한 서류</strong></h3></div>
<ul class="list-unstyled">
  <li><h5><strong>필요한 내용</strong></h5>
    <ul>
      <li>- 동물보호센터 이름</li>
      <li>- 동물보호센터 지정일자</li>
      <li>- 동물보호센터의 주소</li>
      <li>- 동물보호센터의 전화번호</li>
    </ul>
  </li>
  <li><p><strong>위 내용을 이메일에 작성해 주시고</strong></p></li>
  <li><p><strong>법인 등록증을 첨부해 주시기 바랍니다</strong></p></li>
<li><p class="1h-base">위 서류를 <strong>testmin88@gmail.com</strong>으로 제출해주세요.
제출 후 7일 이내로 확인절차 진행 후 보호소 등급으로 설정됩니다.
제출해 주신 내용을 바탕으로 동물보호관리시스템(https://www.animal.go.kr)
사이트내의 동물보호센터 등록여부를 확인합니다.
관리자가 확인 후 서류를 전송한 이메일로
결과를 고지하는 메일을 보내드립니다. </p></li>
</ul>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>