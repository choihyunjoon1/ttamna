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
		var choice = window.confirm("${adoptDto.adoptNo}번 ${adoptDto.adoptTitle}. 게시글을 삭제 하시겠습니까?");
		if(choice){//확인을 누르면 삭제 처리
			location.href="${root}/adopt/delete?adoptNo=${adoptDto.adoptNo}";
			
		}else{ //취소를 누르면 현재페이지 리로드
			location.reload();
		}
	});
	
	//입양공고 종료일이 되면
	//1. 제목옆에 공고기간 종료 표시하기
	//2. 수정 삭제 버튼을 비활성화 혹은 안보이도록 처리하고 조회만 가능하도록 설정
	 if (new Date() > new Date('${adoptDto.adoptEnd}')) {        
     	$(".title").append("[공고기간 종료]");
     	$(".edit-btn").remove();
     	$(".delete-btn").remove();
     }
	
	
});
</script>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-700 container-center">

	<div class="mt-5 mb-5"><h3>입양공고 상세</h3></div>
	<c:if test="${param.success != null}">
		<div class=" mb-3"><h6>입양공고 수정 완료</h6></div>
	</c:if>
	<c:if test="${param.invalid != null}">
		<div class=" mb-3"><h6>수정 권한이 없습니다</h6></div>
	</c:if>	
	
	<div class="container-500 container-center">
		<div class="card mb-5">
		  <div class="card-header d-grid gap-2 justify-content-center mt-2">	
		    <h3 class="title"> ${adoptDto.adoptTitle}</h3>
		  </div>
		  <div class="card-body d-grid gap-2 justify-content-md-end">
		    <h6 class="card-subtitle text-muted">
		    ${adoptDto.adoptTime}  작성자 : ${adoptDto.adoptWriter}   조회수 : ${adoptDto.adoptRead}
		    </h6>
		  </div>
		 <c:if test="${adoptImgList != null}">
			<div class="card-body d-grid gap-2">
				<c:forEach var="adoptImgDto" items="${adoptImgList}">
					<img class="mx-auto" src="adoptImg?adoptImgNo=${adoptImgDto.adoptImgNo}&adoptNo=${adoptDto.adoptNo}" style="width:60%;">
				</c:forEach>
			</div>
		  </c:if>
		  <ul class="list-group list-group-flush">
		    <li class="list-group-item text-muted">공고기간 :  ${adoptDto.adoptStart} ~ ${adoptDto.adoptEnd}</li>
		    <li class="list-group-item text-muted">구조장소 :  ${adoptDto.adoptPlace}</li>
		    <li class="list-group-item text-muted">입양동물 :  ${adoptDto.adoptKind}</li>
		  </ul>
		  <div class="card-body">
		    <p class="card-text">${adoptDto.adoptContent}</p>
		  </div>
		  <div class="card-footer text-muted">
			<div class="d-grid gap-2 d-md-flex justify-content-md-end">
			<a type="button" href="${root}/adopt/" class="btn btn-outline-primary">목록</a>
			
			<!-- 작성자 또는 관리자에게만 수정 삭제 버튼 보여주기 -->
			<c:set var="valid" value="${grade == '관리자' or uid == adoptDto.adoptWriter}"></c:set>
			<c:if test="${valid}">
				<a href="${root}/adopt/edit?adoptNo=${adoptDto.adoptNo}" type="button" class="edit-btn btn btn-outline-warning">수정</a>
				<button type="button" class="btn btn-outline-secondary delete-btn">삭제</button>
				<form method="post" action="${root}/adopt/edit_title" class="edit-title-form">
					<input type="hidden" name="adoptNo" value="${adoptDto.adoptNo}" class="adopt-no">
					<input type="hidden" name="adoptTitle" value="${adoptDto.adoptTitle}[입양완료]">
					<input type="submit" class="btn btn-outline-secondary finish-btn" value="입양완료">
				</form>
			</c:if>	
			</div>
		  </div>
		</div>
	</div>

	

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>