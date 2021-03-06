<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="member" value="${member !=null }"></c:set>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	
	$(function(){//목표금액에 도달하면 기부 버튼 비활성화
		if(parseInt($(".now-fund").text()) >= parseInt($(".total-fund").text())){
			console.log("목표치 도달")
			$(".payment").attr("disabled", "disabled");
			$(".autopayment").attr("disabled", "disabled");
		}
		
		$(".delete-btn").click(function(e){
			var choice = confirm("게시글을 정말 삭제하시겠습니까?");
			if(choice){//확인을 누르면 삭제처리
				return true;
			}else{//취소를 누르면 return false
				return false;
			}
		});
		
		$(".payment").click(function(){
			if(!$(".payment-total-amount").val()){
				alert("기부 금액을 입력해주세요.");
				return false;
			} else {
				return true;
			}
		});
		
		$(".agree").click(function(){
			var isAgree = confirm("*정기기부 안내* 정기기부는 시작 날짜에 관계없이 매달 10일 자동결제가 진행됩니다 이점 유의하시기 바랍니다.");
			if(isAgree){
				if(!$(".autopay-total-amount").val()){
					alert("기부 금액을 입력해주세요.");
					return false;
				}
				return true;
			}else{
				return false;
			}
		});
		
	
		//댓글 목록 더보기 ajax
		var uid = "${sessionScope.uid}";
		var grade="${sessionScope.grade}";
		var page = 1;	
		var size = 12;
		var donationNo = parseInt($("input[name=donationNo]").val());
		console.log(donationNo, typeof(donationNo));
		//더보기 버튼 클릭시 이벤트 발생
		$(".more-btn").click(function(){
			loadList(page, size);
			page++;
		});
		
		//강제 1회 클릭
		$(".more-btn").click();
		
		function loadList(pageValue, sizeValue){
			$.ajax({
				url : "${pageContext.request.contextPath}/donation_reply/more",	
				type : "post",
				data : {
					page : pageValue,
					size : sizeValue,
					donationNo : donationNo
				},
				dataType : "json",
				success:function(resp){
					console.log("댓글 더보기 성공", resp);
					
					//데이터가 sizeValue보다 적은 개수가 왔다면 더보기 버튼을 삭제
					if(resp.length < size){
						$(".more-btn").remove();
					}
				
					for(var i=0 ; i < resp.length ; i++){
					
					//삭제 버튼을 작성자만 볼 수 있도록 처리
					var deleteBtn;
					if(uid == resp[i].memberId || grade=='관리자'){
						deleteBtn = "<div class='right'>"+"<a href='${pageContext.request.contextPath}/donation_reply/delete?donationReplyNo="+resp[i].donationReplyNo+"&donationNo="+resp[i].donationNo+"' class='delete-button reply btn btn-secondary'>삭제하기</a>"+"</div>";
					}else{
						deleteBtn = "";	
					}
					
					if(resp[i].memberId == null){
						resp[i].memberId = "탈퇴한 회원입니다";
					}
							//시간형식 포멧 
							var date = new Date(resp[i].donationReplyTime);
					
							var divCol = "<div class='card border-primary mb-3' style='width: 966px; padding: 0px;'>" 
								+"<div class='card-header id-font'>"+ resp[i].memberId
								+"<div class='right' style='font-size:13px;'>"+date.getFullYear()+"년"+date.getMonth()+1+"월"+date.getDate()+"일"+date.getHours()+"시"+date.getMinutes()+"분" +"</div>"
								+"</div>"
								+"<div class='card-body'>"
								+"<p class='card-text'>"+ resp[i].donationReplyContent+"</p>"
								+ "</div>"
								+deleteBtn
								+ "</div>";
							
							
						$(".result").append(divCol);
						
					}
				},
				error:function(e){
					console.log("댓글 더보기 실패", e);
				}
			});
		}
	});
	

	
</script>
<script>
	$(function(){
		var slideCard = $(".carousel-inner").children();
		console.log(slideCard);
		$(slideCard[0]).addClass("active");
	});
</script>
<style>
		.reply{
		margin-top:10px;
		margin-bottom:5px;
		}
		
		.id-font{
		font-size: medium;
		font-weight: bold;
		}
		
		.delete-button{
		margin:8px;
		width: 92px;
		}
		
		
</style>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<c:forEach var="donationDto" items="${donationDto}">
<div class="container-500 container-center">
	<div class="card mb-5">
		<%-- 제목 영역 --%>
		<div class="card-header d-grid gap-2 justify-content-center mt-2">
			<h3>${donationDto.donationTitle}</h3>
		</div>
		<%-- 제목 아래 작성시간과 작성자 영역 --%>
		<div class="card-body d-grid gap-2 justify-content-md-end">
			<h6 class="card-subtitle text-muted">
			${donationDto.donationTime} 신청자 : ${donationDto.donationWriter}
			</h6>
		</div>
		<%-- 이미지가 찍히는 영역 --%>
		<c:if test="${donationImgDtoList ne null}">
		
		<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
		  <div class="carousel-inner">
		  	<c:forEach var="donationImgDto" items="${donationImgDtoList}" >
		    <div class="carousel-item">
				<img src="donaimg?donationImgNo=${donationImgDto.donationImgNo}&donationNo=${donationDto.donationNo}"  class="d-block w-100" alt="..." style="width:100%; height:15rem;">
			</div>
			</c:forEach>
		  </div>
		  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Previous</span>
		  </button>
		  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Next</span>
		  </button>
		</div>
			<input type="hidden" name="donationNo" value="${donationDto.donationNo}"  id="donationNo">
		</c:if>
		<%-- 글 내용이 찍히는 영역 --%>
		<div class="card-body">
			<p class="card-text">
			<textarea readonly class="form-control" aria-label="With textarea" 
			 style="min-height:1100px; resize:none;">${donationDto.donationContent}</textarea>
			</p>
		</div>
		<%-- 각종 정보가 줄 단위로 찍히는 영역 --%>
		<ul class="list-group list-group-flush">
			<li class="list-group-item text-muted">현재 기부 금액 : <span class="now-fund">${donationDto.donationNowFund}</span>원</li>
			<li class="list-group-item text-muted">목표 기부 금액 : <span class="total-fund">${donationDto.donationTotalFund}</span>원</li>
			<c:choose>
				<c:when test="${uid ne null}">
					<li class="list-group-item text-muted">
						<%-- 단건 기부시 정보가 필요하므로 폼태그로 감싸넣었다 --%>
						<form action="kakao/fund" method="post">
							<input type="hidden" name="donationNo" value="${donationDto.donationNo}"  id="donationNo">
							<input type="hidden" name="partner_user_id" value="${sessionScope.uid}">
							<%-- 텍스트박스와 버튼을 한 줄로 나열하기 위해 div태그를 또 넣었다. --%>
							<div class="row">
								<div class="col-8">
									<input type="number" name="total_amount" class="form-control payment-total-amount" min="1000" max="${donationDto.donationTotalFund - donationDto.donationNowFund}">
								</div>
								<div class="col-4">
									<input type="submit" value="1회 기부 하기" class="btn btn-primary payment">
								</div>
							</div>
						</form>
					</li>
					<li class="list-group-item text-muted">
						<%-- 정기 기부도 마찬가지 --%>
						<form action="kakao/autofund" method="post" id="auto">
							<input type="hidden" name="donationNo" value="${donationDto.donationNo}">
							<input type="hidden" name="partner_user_id" value="${sessionScope.uid}">
							<%-- 텍스트박스와 버튼을 한 줄로 나열하기 위해 div태그를 또 넣었다. --%>
							<div class="row">
								<div class="col-8">
									<input type="number" name="total_amount" class="form-control autopay-total-amount" min="1000" max="${donationDto.donationTotalFund*0.3}">
								</div>
								<div class="col-4">
									<input type="submit" value="정기 기부 신청" class="btn btn-primary agree autopayment">
								</div>
							</div>
						</form>
					</li>
				</c:when>
				<c:otherwise>
					<li class="list-group-item text-muted">
						<span>기부는 로그인 후 가능합니다.</span>
					</li>
				</c:otherwise>
			</c:choose>
		</ul>
		<div class="card-footer text-muted">
			<%-- 작성자 또는 관리자만 수정 삭제 버튼 보여주기 --%>
			<div class="d-grid gap-2 d-md-flex justify-content-md-end">
			<a type="button" href="${root}/ttamna/donation/" class="btn btn-outline-primary">목록</a>
			<c:if test="${uid eq donationDto.donationWriter or grade == '관리자'}">
				<a href="${root}/ttamna/donation/edit?donationNo=${donationDto.donationNo}" type="button" class="btn btn-outline-warning">수정</a>
				<a href="${root}/ttamna/donation/delete?donationNo=${donationDto.donationNo}" class="btn btn-outline-secondary delete-btn">삭제</a>
			</c:if>
			</div>
		</div>
	</div>
</div>



	<!-- 댓글목록 표시 위치 -->		
	<div class="row mt-3 mb-5 result"></div>
 
	<!-- 댓글 입력창 -->
	<c:if test="${member }">    
	    <div class="col-12">
	        <form action="${pageContext.request.contextPath}/donation_reply/insert" method="post">
	           <input type="hidden" name="memberId" value="${sessionScope.uid}">
	 			<input type="hidden" name="donationNo" class="donation-no" value="${donationDto.donationNo}">
	 		<i class="bi bi-chat-left-text"> 
	 			댓글 쓰기
		 		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-left-text" viewBox="0 0 16 16">
				  <path d="M14 1a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H4.414A2 2 0 0 0 3 11.586l-2 2V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12.793a.5.5 0 0 0 .854.353l2.853-2.853A1 1 0 0 1 4.414 12H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
				  <path d="M3 3.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zM3 6a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9A.5.5 0 0 1 3 6zm0 2.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
				</svg>
	 		</i>
	            <textarea class="form-control" name="donationReplyContent"></textarea> 
	            
	        <div class="right">
	            <input type="submit" class="reply btn btn-primary" value="등록">
	        </div>
		</form>
	          
	  </div>
 </c:if>

</c:forEach>



	<!-- 댓글 더보기 버튼 -->
	<div class="row mt-3 mb-5">
		<div class="col mt-3">
			<button type="button" class="justify-content-md btn btn-primary more-btn">더보기</button>
		</div>
	</div>
	






<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>