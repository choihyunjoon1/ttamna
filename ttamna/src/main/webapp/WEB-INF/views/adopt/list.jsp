<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<%-- 페이지에서 사용할 JSTL 변수 --%>
<c:set var="login" value="${uid != null}"></c:set>
<c:set var="insertGrade" value="${grade == '관리자' or '보호소'}"></c:set>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<script>

$(function(){
	var page = 1;	
	var size = 12;
	
	//더보기 버튼 클릭시 이벤트 발생
	$(".more-btn").click(function(){
		var column = $("#column option:selected").val();
		var keyword = $("input[name=keyword]").val();
		loadList(page, size, column, keyword);
		page++;
	});
	
	//강제 1회 클릭
	$(".more-btn").click();
	
	function loadList(page, size, column, keyword){
		
		$.ajax({
			url : "${pageContext.request.contextPath}/adopt/more?column="+column+"&keyword="+keyword,	
			type : "get",
			type : {
				page : page,
				sizs : size
			},
			dataType : "json",
			success:function(resp){
				consol.log("더보기 성공");
				
				//데이터가 sizeValue보다 적은 개수가 왔다면 더보기 버튼을 삭제
				if(resp.length < size){
					$(".more-btn").remove();
				}
				
				//데이터 출력
				for(var i=0 ; i < resp.length ; i++){
					//탈퇴한 회원일 경우 null대신 탈퇴한 회원 표시해주기
					var adoptWriter = resp[i].adoptWriter;
					if(adoptWriter == null){
						adoptWriter = "탈퇴한 회원입니다";
					}

				  var divCol = "<div class=page>"+
					"<span>"+adoptWriter+"</span>" +
					"<br>"+
					"<span><a href=detail?adoptNo="+resp[i].adoptNo+">"+resp[i].adoptTitle+"</a></span>" +
					"<br>"+
					"<br>"+
					"<span>"+resp[i].adoptStart+"~"+resp[i].adoptEnd+"</span>" +
					"<span>"+resp[i].adoptKind+"</span>" +
					"<br>"+
					"<span>"+resp[i].adoptPlace+"</span>"
				+"</div>";
				$(".result").append(divCol);
				$(".page").addClass("col-3 mt-3");
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

<div class="container-800 container-center mt-5 mb-5">
	
	<div class="mt-5 mb-5"><h3>입양공고</h3>
	<c:if test="${insertGrade}">
		<div class="d-grid gap-2 d-md-flex justify-content-md-end">
			<a href="${root}/adopt/write" class="btn btn-outline-primary">입양공고 등록</a>
		</div>
	</c:if>
	</div>
	<div class="container">
	
	<!-- 입양공고 등록버튼은 관리자와 보호소 등급만 사용할 수 있다 -->
			<form method="get">
				<div class="input-group justify-content-end">
					<div class="col-2">
						<select name="column" class="form-select form-select-sm" required id="column">
						<c:choose>
							<c:when test="${column == adoptTitle}">
								<option value="">선택안함</option>
								<option value="adoptTile" selected>제목</option>
								<option value="adoptContent">내용</option>
								<option value="adoptWriter">작성자</option>
								<option value="adoptType">입양동물 종류</option>
							</c:when>
							<c:when test="${column == adoptContent}">
								<option value="">선택안함</option>
								<option value="adoptTile">제목</option>
								<option value="adoptContent" selected>내용</option>
								<option value="adoptWriter">작성자</option>
								<option value="adoptType">입양동물 종류</option>
							</c:when>
							<c:when test="${column == adoptWriter}">
								<option value="">선택안함</option>
								<option value="adoptTile">제목</option>
								<option value="adoptContent">내용</option>
								<option value="adoptWriter" selected>작성자</option>
								<option value="adoptType">입양동물 종류</option>
							</c:when>
							<c:when test="${column == adoptType}">
								<option value="">선택안함</option>
								<option value="adoptTile">제목</option>
								<option value="adoptContent">내용</option>
								<option value="adoptWriter">작성자</option>
								<option value="adoptType" selected>입양동물 종류</option>
							</c:when>
							<c:otherwise>
								<option value="" selected>선택안함</option>
								<option value="adoptTile">제목</option>
								<option value="adoptContent">내용</option>
								<option value="adoptWriter">작성자</option>
								<option value="adoptType">입양동물 종류</option>
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
	
	<!-- 게시물 표시 위치 -->		
	<div class="row mt-3 mb-5 result">
	</div>
	<c:forEach var="adoptDto" items="${list}">
	<div class="card" style="width: 18rem;">
  		<img src="..." class="card-img-top" alt="...">
	 	 <div class="card-body">
		    <h5 class="card-title">${adoptDto.adoptTitle}</h5>
		    <p class="card-text">
		    	공고기간 : ${adoptDto.adoptStart}~${adoptDto.adoptEnd}
		    	입양동물 : ${adoptDto.adoptType}
		    	구조장소 : ${adoptDto.adoptPlace}
		    </p>
		    <a href="${root}/adopt/detail/adoptNo=${adoptDto.adoptNo}" class="btn btn-primary">보기</a>
	  </div>
	</div>
	</c:forEach>
	
	<div class="row mt-3 mb-5">
		<div class="col mt-3">
			<button type="button" class="btn btn-primary more-btn">더보기</button>
		</div>
	</div>
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>