<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<c:if test="${requestScope['javax.servlet.error.status_code'] == 400}">
		<p>잘못 된 요청입니다.</p>    
	</c:if>	
	
	<c:if test="${requestScope['javax.servlet.error.status_code'] == 401}">
		<p>로그인 후 이용해 주세요</p>    
	</c:if>
	
	<c:if test="${requestScope['javax.servlet.error.status_code'] == 403}">
		<p>접근 권한이 없습니다.</p>    
	</c:if>
	
	<c:if test="${requestScope['javax.servlet.error.status_code'] == 404}">
		<p>요청하신 페이지를 찾을 수 없습니다.</p>    
	</c:if>
	
	<c:if test="${requestScope['javax.servlet.error.status_code'] == 405}">
		<p>요청된 메소드가 허용되지 않습니다.</p>    
	</c:if>
	
	<c:if test="${requestScope['javax.servlet.error.status_code'] == 500}">
		<p>서버에 오류가 발생하여 요청을 수행할 수 없습니다.</p>
	</c:if>
	
	<c:if test="${requestScope['javax.servlet.error.status_code'] == 503}">
		<p>서비스를 사용할 수 없습니다.</p>
	</c:if>
	
	<a href="${root}/ttamna/">HOME</a>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>