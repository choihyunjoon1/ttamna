<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%-- 기부게시판 더보기 에이잭스 js --%>
<script>

$(function(){
	var page = 1;
	var size = 12;
	
	
	
	$(".more-btn").click(function(){
		var column = $("#column option:selected").val();
		var keyword = $("input[name=keyword]").val();
		loadData(page, size, column, keyword);
		page++;
	});
	
	//여러가지 방법이 있다
	//여기선 더보기 버튼을 강제1회 클릭(트리거)
	$(".more-btn").click();
	
	//이렇게 캡슐화를 하는데 이걸 중첩클래스라고한다
	function loadData(page, size, column, keyword){
		
		$.ajax({
			url : "${pageContext.request.contextPath}/donation/more?column="+column+"&keyword="+keyword,
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
					var donationWriter = resp[i].donationWriter;
					var imgLocation= "";
					var progress = (resp[i].donationNowFund/resp[i].donationTotalFund) *100;
					var graph = "";
					var number = Math.round(progress);
					
					if(progress <=0){
						progress = 1;
					} else if(progress < 100){
						graph= "success";
					} else if(progress >= 100){
						graph = "danger";
					}
					if(!resp[i].donationImgNo){
						imgLocation =  "<img src=${pageContext.request.contextPath}/resources/img/nonimage.png class=icon></a></span>";
					}else{
						imgLocation =  "<img src='donaimg?donationImgNo="+ resp[i].donationImgNo +"' class='card-img-top'>";
					}
					
					if(donationWriter == null){
						donationWriter = "탈퇴한 회원입니다";
					}
					var divCol = "<div class='page card text-gray bg-light mb-5 ms-2' style='width:18rem;'><a href='./detail?donationNo="+resp[i].donationNo+"'>"+
						imgLocation +"</a>"+ 
						"<div class='card-body'>" +
						"<h5 class='card-title'>"+resp[i].donationTitle+"</h5>" +
						"<div class='card-text'>"+donationWriter+"</div>"+
						"<div class='card-text'><span>현재 기부 금액 : </span>"+resp[i].donationNowFund+"원</div>"+
						"<div class='card-text'><span>목표 기부 금액 : </span>"+resp[i].donationTotalFund+"원</div>"+
						"<div class='progress'>"+
						"<div class='progress-bar progress-bar-striped progress-bar-animated bg-"+graph+"' role='progressbar' aria-valuenow='"+resp[i].donationNowFund+"' aria-valuemin='1' aria-valuemax='"+resp[i].donationTotalFund+"' style='width:"+progress+"%;'></div></div>"+
						"<div class='card-text'>"+number+"%</div>"
					+"</div>"
					+"</div>";
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


<div class="container">
	<div class="row mt-3">
	<c:if test="${grade eq '관리자' or '보호소'}">
		<div class="col">
			<a href="insert" class="btn btn-primary">기부신청</a>
		</div>
	</c:if>
	</div>
	<div class="row mt-3 result">
			
	</div>
	<div class="row mt-3">
		<div class="col mt-3">
			<button type="button" class="btn btn-primary more-btn">더보기</button>
		</div>
	</div>
	
	<form method="post" >
		<div class="input-group">
			<div class="col-3 offset-2">
				<select name="column" class="form-select" required id="column">
				<c:choose>
					<c:when test="${column eq 'donation_title'}">
						<option value="">선택안함</option>
						<option value="donation_title" selected>제목</option>
						<option value="donation_writer">작성자</option>
						<option value="donation_content">내용</option>
					</c:when>
					<c:when test="${column eq 'donation_writer'}">
						<option value="">선택안함</option>
						<option value="donation_title">제목</option>
						<option value="donation_writer" selected>작성자</option>
						<option value="donation_content">내용</option>
					</c:when>
					<c:when test="${column eq 'donation_content'}">
						<option value="">선택안함</option>
						<option value="donation_title">제목</option>
						<option value="donation_writer">작성자</option>
						<option value="donation_content" selected>내용</option>
					</c:when>
					<c:otherwise>
						<option value="">선택안함</option>
						<option value="donation_title">제목</option>
						<option value="donation_writer">작성자</option>
						<option value="donation_content">내용</option>
					</c:otherwise>
				</c:choose>
				</select>
			</div>
			<div class="col-3">
				<input type="text" name="keyword" required class="form-control" value="${keyword}">
			</div>
			<div class="col-2">
				<input type="submit" value="검색" id="search" class="btn btn-primary">
			</div>
		</div>
	</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>