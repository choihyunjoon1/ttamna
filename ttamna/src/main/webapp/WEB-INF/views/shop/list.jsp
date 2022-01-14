<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<style>
	.icon{
		width: 230px;
		height: 200px;
	}
</style>
<script>
$(function(){
	var page = 1;
	var size = 12;
	
	$(".more-btn").click(function(){
		var keyword = $("input[name=keyword]").val();

		
		loadData(page, size, keyword);
		page++;
	});
	
	//여러가지 방법이 있다
	//여기선 더보기 버튼을 강제1회 클릭(트리거)
	$(".more-btn").click();
	
	//이렇게 캡슐화를 하는데 이걸 중첩클래스라고한다
	function loadData(page, size, keyword){
		$.ajax({
			url : "${pageContext.request.contextPath}/shop/more?keyword"+keyword,
			type : "get",
			data : {
				page : page,
				size : size
			},
			dataType : "json",
			success:function(resp){
				console.log("성공", resp);
	
				//데이터가 sizeValue보다 적은 개수가 왔다면 더보기 버튼을 삭제
				if(resp.length < size){
					$(".more-btn").remove();
				}
				
				//데이터 출력
				for(var i=0; i < resp.length; i++){
					
						var image = "";
						if(!resp[i].shopImgNo){
							image = "<a href=detail?shopNo="+resp[i].shopNo+"><img src=${pageContext.request.contextPath}/resources/img/mollu.jpg class=icon>";
						}else{
							image = "<a href=detail?shopNo="+resp[i].shopNo+"><img src=img?shopImgNo="+resp[i].shopImgNo+" class='card-img-top' alt=' "+resp[i].shopImgNo+" ' style='width:100%;height:15rem;'></a>";
						}
						
					
					var divCol = "<div class='card border-primary text-dark bg-light bg-opacity-1 mb-5 ms-2 ' style='width: 18rem;'>"
						 + image
						 + "<div class='card-body'>"
						  + "<h5 class='card-title'><strong>"+ resp[i].shopGoods +"</strong></h5>"
						  + "<div class='card-text'>"
						  + "<small>"+resp[i].shopTitle+"</small>"
						  + "</div>"
						  + "<div class='card-text'>"
						  + "<small>판매가 : "+resp[i].shopPrice+"원</small>"
						  + "</div>"
	
						  +"<div class='card-text d-grid gap-1 justify-content-md-end'>"
						  + "<a href='detail?shopNo= "+resp[i].shopNo+"' class='btn btn-primary px-2 mt-2 ms-2'>" + "보기"
						  + "</a></div>"
						  + "</div></div>";
						
						
						
					$(".result").append(divCol);
					$(".page").addClass("col-3 mt-3");
				}
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	}
});
</script>






 <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
<div class="container-900 container-center mt-5 mb-5">

	<div class="mt-5 mb-3"><h3>상품 게시판</h3>
	<span>수익의 일부가 후원금으로 사용됩니다</span>
	<!-- 상품등록은 관리자만 가능 -->
	<c:if test="${sessionScope.grade eq '관리자'}">
		<div class="d-grid gap-1 d-md-flex justify-content-md-end">
			<a href="write" class="btn btn-outline-primary">상품등록</a>
		</div>
	</c:if>
	</div>

	<!-- 글 목록이 찍히는 영역 -->
	<div class="row mt-3 mb-5 result">		
	</div>
	
	<div class="row mt-3 mb-5">
		<div class="col mt-3">
			<button type="button" class="justify-content-md btn btn-primary more-btn">더보기</button>
		</div>
	</div>
		
	
	
</div>
    
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>