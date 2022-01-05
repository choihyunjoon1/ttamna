<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-600 bg-white container-center" align="center">
	<div class="row">
		<div class="col">
			<h5>제목</h5>
		</div>
	</div>
	<div class="row">
		<h5>
			작성자 : ${mybaby.mybabyWriter}
			|
			작성일 : ${mybaby.mybabyTimeString()}
			|
			조회수 : ${mybaby.mybabyRead }
			|
			댓글수 : ${mybaby.mybabyReply }
		</h5>
	</div>
	<div class="row">
		<div class="col-8 container-center">
			<c:if test="${mybabyImgDtoList != null}">
				<c:forEach var="mybabyImgDto" items="${mybabyImgDtoList}">
					<img src="mybabyImg?mybabyImgNo=${mybabyImgDto.mybabyImgNo}&mybabyNo=${mybaby.mybabyNo}" style="width:100%;">
				</c:forEach>
			</c:if>
			<span class="row">${mybaby.mybabyContent}</span>
		</div>
	</div>
	<div class="row">
		<div class="col-5 container-right">
			<a href="${root }/mybaby/list">목록으로</a>
			<c:if test="${uid eq mybaby.mybabyWriter}">
				<a href="edit?mybabyNo=${mybaby.mybabyNo }">수정</a>
				<a href="delete?mybabyNo=${mybaby.mybabyNo}">삭제</a>
			</c:if>
		</div> 
	</div>
	<!-- 댓글 자리 -->
	<div class="row">
		<h5>댓글</h5>
	</div>



</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>