<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 페이지에서 사용할 JSTL 변수 --%>
<c:set var="login" value="${uid != null}"></c:set>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<c:set var="adoptDto" value="${list}"></c:set>

<!-- JQeury CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!-- JavaScript 날짜 포맷 CDN -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script>

$(function(){
	
	var page = 1;	
	var size = 9;
	

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
			url : "${root}/adopt/more?column="+column+"&keyword="+keyword,	
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
				
				//moment(바꾸고 싶은 값).format("YYYY-MM-DD HH:mm:ss");				
				//데이터 출력
				for(var i=0 ; i < resp.length ; i++){
					
					//이미지 파일 없는 경우 undefined 꼴보기 시르미 
					var imgLocation = "";
					if(!resp[i].adoptImgNo){
						imgLocation =  "<a href='readUp?adoptNo= "+resp[i].adoptNo+"'><img src=${pageContext.request.contextPath}/resources/img/nonimage.png class=icon></a>";
					}else {
						imgLocation =  "<a href='readUp?adoptNo= "+resp[i].adoptNo+"'><img src='adoptImg?adoptImgNo="+ resp[i].adoptImgNo +"'class='card-img-top' alt=' "+resp[i].adoptImgUpload+"' style='width:100%;height:15rem;'></a>";
					}
					
					//입양공고 종료일이 되면 제목옆에 공고기간 종료 표시하기
					 if (new Date() > new Date(resp[i].adoptEnd)) {        
				     	resp[i].adoptTitle = resp[i].adoptTitle + "[입양공고 종료]";
				     }
					
					//탈퇴한 회원일 경우 null대신 탈퇴한 회원 표시해주기                                   
					var adoptWriter = resp[i].adoptWriter;
					if(adoptWriter == null){
						adoptWriter = "탈퇴한 회원입니다";
					}
					var divCol = "<div class='card border-primary text-dark bg-primary bg-opacity-10 mb-5 ms-2 ' style='width: 18rem;'>"
								  + imgLocation
								  + "<div class='card-body'>"
								  + "<h6 class='card-title'><strong class='title'>"+ resp[i].adoptTitle +"</strong></h6>"
								  + "<div class='card-text'>"
								  + "<small>공고 기간</small> "
								  + "</div>"
								  + "<div class='card-text'><small>"
								  + moment(resp[i].adoptStart).format("YYYY-MM-DD") 
								  + " ~ " 
								  + moment(resp[i].adoptEnd).format("YYYY-MM-DD") 
								  +"</small></div>"
								  + "<div class='card-text'><small>"
								  + "입양 동물 : " + resp[i].adoptKind
								  +"</small></div>"
								  + "<div class='card-text d-grid gap-1 justify-content-md-end'>"
								  + "<a href='readUp?adoptNo= "+resp[i].adoptNo+"' class='btn btn-primary px-2 mt-2 ms-2'>" + "Read"
								  + "</a></div>"
								  + "</div></div>";
						
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

	<div class="mt-5 mb-3"><h3>입양공고</h3>
	<c:if test="${param.deleteSuccess != null}">
		<div class=" mb-3"><h6>입양공고 삭제 완료</h6></div>
	</c:if>
	<div class="d-grid gap-1 d-md-flex justify-content-md-end">
		<a href="${root}/adopt/write" class="btn btn-outline-primary">입양공고 등록</a>
	</div>
	</div>

	
	<!-- 게시물 표시 위치 -->		
	<div class="row mt-3 mb-3 result">
	</div>
	
	<div class="row mt-3 mb-5">
		<div class="col mt-3">
			<button type="button" class="justify-content-md btn btn-primary more-btn">더보기</button>
		</div>
	</div>
	
	<!-- 검색창 -->
	<div class="container">
			<form method="post">
				<div class="input-group justify-content-end">
					<div class="col-2">
						<select name="column" class="form-select form-select-sm" required id="column">
						<c:choose>
							<c:when test="${column == 'adopt_title'}">
								<option value="">선택안함</option>
								<option value="adopt_title" selected>제목</option>
								<option value="adopt_content">내용</option>
								<option value="adopt_writer">작성자</option>
								<option value="adopt_kind">입양동물 종류</option>
							</c:when>
							<c:when test="${column == 'adopt_content'}">
								<option value="">선택안함</option>
								<option value="adopt_title">제목</option>
								<option value="adopt_content" selected>내용</option>
								<option value="adopt_writer">작성자</option>
								<option value="adopt_kind">입양동물 종류</option>
							</c:when>
							<c:when test="${column == 'adopt_writer'}">
								<option value="">선택안함</option>
								<option value="adopt_title">제목</option>
								<option value="adopt_content">내용</option>
								<option value="adopt_writer" selected>작성자</option>
								<option value="adopt_kind">입양동물 종류</option>
							</c:when>
							<c:when test="${column == 'adopt_kind'}">
								<option value="">선택안함</option>
								<option value="adopt_title">제목</option>
								<option value="adopt_content">내용</option>
								<option value="adopt_writer">작성자</option>
								<option value="adopt_kind" selected>입양동물 종류</option>
							</c:when>
							<c:otherwise>
								<option value="">선택안함</option>
								<option value="adopt_title">제목</option>
								<option value="adopt_content">내용</option>
								<option value="adopt_writer">작성자</option>
								<option value="adopt_kind">입양동물 종류</option>
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
			<a href="${root}/adopt/" type="button" class="justify-content-md btn btn-primary">Back To List</a>
		</div>
	</div>
	</c:if>
	
	
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>