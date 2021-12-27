<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
	<div class="row mt-3">
	<div class="col">
		<a href="${pageContenxt.request.contextPath}/ttamna/donation/list" class="btn btn-primary">기부가 완료되었습니다! 감사합니다!</a>
	</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>