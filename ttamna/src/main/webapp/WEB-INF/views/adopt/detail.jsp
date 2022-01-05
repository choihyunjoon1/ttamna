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
	
	<div class="mt-5 mb-5">
		<div>제목 :  ${adoptDto.adoptTitle}</div>
		<div>조회수 :  ${adoptDto.adoptRead}</div>
		<div>작성자 :  ${adoptDto.adoptWriter}</div>
		<div>작성시간 :  ${adoptDto.adoptTime}</div>
		<div>공고기간 :  ${adoptDto.adoptStart} ~ ${adoptDto.adoptEnd}</div>
		<c:if test="${adoptImgList != null}">
		<div>파일
			<c:forEach var="adoptImgDto" items="${adoptImgList}">
				<img src="adoptImg?adoptImgNo=${adoptImgDto.adoptImgNo}&adoptNo=${adoptDto.adoptNo}" style="width:30%;">
			</c:forEach>
		</div>
		</c:if>
		<div>품종 :  ${adoptDto.adoptKind}</div>
		<div>구조장소 :  ${adoptDto.adoptPlace}</div>
		<div>내용 :  ${adoptDto.adoptContent}</div>
	</div>
	
	<!-- 작성자 또는 관리자에게만 수정 삭제 버튼 보여주기 -->
	<c:set var="valid" value="${grade == '관리자' or uid == adoptDto.adoptWriter}"></c:set>
	
	<div class="d-grid gap-2 d-md-flex justify-content-md-end mb-5">
	<a type="button" href="${root}/adopt/" class="btn btn-outline-primary">목록</a>
	<c:if test="${valid}">
		<a href="${root}/adopt/edit?adoptNo=${adoptDto.adoptNo}" type="button" class="btn btn-outline-primary">수정</a>
		<button type="button" class="btn btn-outline-secondary delete-btn">삭제</button>
	</c:if>	
	</div>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>