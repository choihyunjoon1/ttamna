<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<%-- 페이지에서 사용할 JSTL 변수 --%>
<c:set var="login" value="${uid != null}"></c:set>
<c:set var="admin" value="${grade == '관리자'}"></c:set>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!-- JQeury CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>


<script>
//삭제 버튼을 누르면 알림창 띄우기
$(function(){
	
	$(".delete-btn").click(function(){
		var choice = window.confirm("${noticeDto.noticeNo}번 ${noticeDto.noticeTitle}. 게시글을 삭제 하시겠습니까?");
		if(choice){//확인을 누르면 삭제 처리
			location.href="${root}/notice/delete?noticeNo=${noticeDto.noticeNo}";
			
		}else{ //취소를 누르면 현재페이지 리로드
			location.reload();
		}
	});
	
});
</script>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-900 container-center">

	<div class="mt-3 mb-5"><h3>입양전 필독</h3></div>
	<c:if test="${param.success != null}">
		<div class=" mb-3"><h6>입양전 필독 수정 완료</h6></div>
	</c:if>
	<c:if test="${param.invalid != null}">
		<div class=" mb-3"><h6>수정 권한이 없습니다</h6></div>
	</c:if>	
	<div class="container-800 container-center">
		<div class="card mb-5">
		  <div class="card-header d-grid gap-2 justify-content-center mt-2">	
		    <h3 class="title"><strong> ${noticeDto.noticeTitle}</strong></h3>
		  </div>
		  <div class="card-body d-grid gap-2 justify-content-md-end">
		    <h6 class="card-subtitle text-muted">
		    ${noticeDto.noticeTime} 
		    	<i class="bi bi-pencil">
		    		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
  					<path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
					</svg>
					${noticeDto.noticeWriter}
				</i>
		    <i class="bi bi-pencil">
		      조회수 ${noticeDto.noticeRead}
			</i>
		    </h6>
		  </div>
		 <c:if test="${noticeImgList != null}">
			<div class="card-body d-grid gap-2">
				<c:forEach var="noticeImgDto" items="${noticeImgList}">
					<img class="mx-auto" src="noticeImg?noticeImgNo=${noticeImgDto.noticeImgNo}&noticeNo=${noticeDto.noticeNo}" style="width:80%;">
				</c:forEach>
			</div>
		  </c:if>
		  <div class="card-body">
		    <p class="card-text">${noticeDto.noticeContent}</p>
		  </div>
		  <div class="card-footer text-muted">
			<div class="d-grid gap-2 d-md-flex justify-content-md-end">
			<a type="button" href="${root}/notice/" class="btn btn-outline-primary">목록</a>
			
			<!-- 관리자에게만 수정 삭제 버튼 보여주기 -->
			<c:set var="valid" value="${grade == '관리자' or uid == noticeDto.noticeWriter}"></c:set>
			<c:if test="${valid}">
				<a href="${root}/notice/edit?noticeNo=${noticeDto.noticeNo}" type="button" class="edit-btn btn btn-outline-warning">수정</a>
				<button type="button" class="btn btn-outline-secondary delete-btn">삭제</button>
			</c:if>	
			</div>
		  </div>
		</div>
	</div>

	

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>