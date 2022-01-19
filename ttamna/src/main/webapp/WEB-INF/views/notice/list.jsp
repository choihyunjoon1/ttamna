<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 페이지에서 사용할 JSTL 변수 --%>
<c:set var="login" value="${uid != null}"></c:set>
<c:set var="admin" value="${grade == '관리자'}"></c:set>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<c:set var="noticeDto" value="${list}"></c:set>

<!-- JQeury CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!-- JavaScript 날짜 포맷 CDN -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script>

$(function(){
	
	var page = 1;	
	var size = 10;
	

	//더보기 버튼 클릭시 이벤트 발생
	$(".more-btn").click(function(){
		var column = $("#column option:selected").val();
		var keyword = $("input[name=keyword]").val();
		loadList(page, size, column, keyword);
		page++;
	});
	
	//강제 1회 클릭
	$(".more-btn").click();
	
	function loadList(pageValue, sizeValue, column, keyword){
		$.ajax({
			url : "${root}/notice/more?column="+column+"&keyword="+keyword,	
			type : "post",
			data : {
				page : pageValue,
				size : sizeValue,
			},
			dataType : "json",
			success:function(resp){
				console.log("더보기 성공", resp);
				
				//데이터가 sizeValue보다 적은 개수가 왔다면 더보기 버튼을 삭제
				if(resp.length < size){
					$(".more-btn").remove();
				}
				
				//데이터 출력
				for(var i=0 ; i < resp.length ; i++){
					
					//이미지 파일 없는 경우 undefined 꼴보기 시르미 
					var imgLocation = "";
					if(!resp[i].noticeImgNo){
						imgLocation =  "<img src='${root}/resources/img/nonimage.png' class='icon'>";
					}else {
						imgLocation =  "<img src='noticeImg?noticeImgNo="+ resp[i].noticeImgNo +"'class='rounded px-0 pt-1' alt=' "+resp[i].noticeImgUpload+"' style='width:100%;height:9rem'>";
					}
					
					
					//탈퇴한 회원일 경우 null대신 탈퇴한 회원 표시해주기                                   
					var noticeWriter = resp[i].noticeWriter;
					if(noticeWriter == null){
						noticeWriter = "탈퇴한 회원입니다";
					}
					
					
					var divCol = "<div class='card border-secondary text-dark mb-2 ms-2' style='max-width:420px;height:10rem'>"
								  + "<a style='text-decoration-line:none;' href='readUp?noticeNo= "+resp[i].noticeNo+"'>"
								  + "<div class='row g-0'>"
								  + "<div class='col-md-6 mx-auto'>" + imgLocation + "</div>"
								  + "<div class='col-md-6'>"
								  + "<div class='card-body text-muted'>"
								  + "<h6 class='card-title'><strong class='title text-dark'>"+ resp[i].noticeTitle +"</strong></h6>"
								  + "<div class='card-text mt-3'>"
								  + "<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-eye ' viewBox='0 0 16 16'>"
								  + "<path d='M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z'/>"
								  + "<path d='M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z'/>"
								  + "</svg>" + resp[i].noticeRead
								  + "</div>"
								  + "<div class='card-text'>"
								  + resp[i].noticeWriter + "( 관리자 )" 
								  +"</div>"
								  + "</div></div>"
								  + "</div></a></div>";
						
					$(".result").append(divCol);
				}
				
			},
			error:function(e){
				console.log("더보기 실패", e);
			}
		});
	}
});
</script>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-900 container-center mt-5 mb-5">

	<div class="mt-5 mb-2"><h3>입양전 필독</h3>
	<div class="mt-2 mb-5"><h5><strong>입양을 위한 정보와 유기동물 관련 정보를 확인해 보세요</strong></h5></div>
	<c:if test="${param.deleteSuccess != null}">
		<div class="valid-feedback mb-3"><h6>입양전 필독 삭제 완료</h6></div>
	</c:if>
	<c:if test="${admin}">
	<div class="d-grid gap-1 d-md-flex justify-content-md-end">
		<a href="${root}/notice/write" class="btn btn-outline-secondary">입양전 필독 등록</a>
	</div>
	</c:if>
	</div>

	
	<!-- 게시물 표시 위치 -->		
	<div class="row mt-3 mb-3 result ms-3">
	</div>
	
	<div class="row mt-3 mb-5">
		<div class="col mt-3 mb-2">
			<button type="button" class="justify-content-md btn btn-primary more-btn">더보기</button>
		</div>
	</div>
	
	<!-- 검색창 -->
	<div class="container-900">
			<form method="post">
				<div class="input-group justify-content-md-center">
					<div class="col-2">
						<select name="column" class="form-select form-select-sm" required id="column">
						<c:choose>
							<c:when test="${column == 'notice_title'}">
								<option value="">선택안함</option>
								<option value="notice_title" selected>제목</option>
								<option value="notice_content">내용</option>
								<option value="notice_writer">작성자</option>
							</c:when>
							<c:when test="${column == 'notice_content'}">
								<option value="">선택안함</option>
								<option value="notice_title">제목</option>
								<option value="notice_content" selected>내용</option>
								<option value="notice_writer">작성자</option>
							</c:when>
							<c:when test="${column == 'notice_writer'}">
								<option value="">선택안함</option>
								<option value="notice_title">제목</option>
								<option value="notice_content">내용</option>
								<option value="notice_writer" selected>작성자</option>
							</c:when>
					     	<c:otherwise>
								<option value="">선택안함</option>
								<option value="notice_title">제목</option>
								<option value="notice_content">내용</option>
								<option value="notice_writer">작성자</option>
							</c:otherwise>
						</c:choose>
						</select>
					</div>
					<div class="input-group input-group-sm mb-3" style="width:30%">
						<input type="text" name="keyword" required class="form-control" value="${keyword}">
						<input type="submit" value="search" id="search" class="btn btn-dark btn-sm">
					</div>
				</div>			
			</form>
	</div>	
	
	<!-- 검색 목록일 경우 전체 목록으로 돌아가기 버튼 보여주기 -->
	<c:if test="${param.column != null }">
	<div class="row mt-3 mb-5">
		<div class="col mt-3">
			<a href="${root}/notice/" type="button" class="justify-content-md btn btn-outline-secondary">Back To List</a>
		</div>
	</div>
	</c:if>
	
	
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>