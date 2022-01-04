<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	
	$(function(){
		
		var page = 1;
		var size = 12;
		var donationNo = $("#donationNo").val();
		console.log(donationNo);
		$(".more-btn").click(function(){
			loadData(page, size, donationNo);
			page++;
		});
		
		//여러가지 방법이 있다
		//여기선 더보기 버튼을 강제1회 클릭(트리거)
		$(".more-btn").click();
		
		//이렇게 캡슐화를 하는데 이걸 중첩클래스라고한다
		function loadData(page, size){
			$.ajax({
				url : "${pageContext.request.contextPath}/donation/more",
				type : "get",
				data : {
					donationNo : donationNo,
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
						var memberId = resp[i].mybabyWriter;
						
						if(memberId == null){
							memberId = "탈퇴한 회원";
						}
						
						var divCol = "<div class=page>"+
						"<span><a href=detail?mybabyNo="+resp[i].mybabyNo+">"+imglocation+
							"<br>"+
							"<span>"+memberId+"</span>" +
							"<br>"+
							"<span><a href=detail?mybabyNo="+resp[i].mybabyNo+">"+resp[i].mybabyTitle+"</a></span>" +
							"<br>"+
							"<span>"+resp[i].mybabyContent+"</span>" +
							"<br>"
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
		
		$(".edit").hide();
		$(".change-cancel").hide();
		$(".content-change-real").hide();
		$(".content-change").click(function(e){
			e.preventDefault();
			$(this).prev().show();
			$(this).next().next().show();
			$(this).prev().prev().hide();
			$(this).next().show();
			$(this).hide();
		});
		$(".change-cancel").click(function(e){
			e.preventDefault();
			$(".content-change").show();
			$(".edit").hide();
			$(".replyDto").show();
			$(".change-cancel").hide();
			$(".content-change-real").hide();
		});
		
		$(".content-change-real").click(function(e){
			e.preventDefault();
			var number = $(this).attr("data-data")
			
			var replyNo = $("#replyNo"+number).val();
			var replyContent = $("#replyContent"+number).val();
			var donationNo = $("#donationNo"+number).val();
			
			$.ajax({
				url : "${pageContext.request.contextPath}/donation/reply/edit", 
				type : "post",
				data : {
					replyNo : replyNo ,
					replyContent : replyContent,
					donationNo : donationNo
				},
				success:function(resp){
					$("#content"+replyNo).text("");
					$("#content"+replyNo).text(resp[0]);
					$(".change-cancel").click();
				},
				error:function(e){
					console.log("실패했어용");
				}
			});
		});
	});
	

	
</script>
<style>
		.reply{
		margin-top:10px;
		margin-bottom:5px;
		}
</style>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
	<div class="row">
		<div class="col">
			<c:forEach var="donationDto" items='${donationDto}'>
				<div class="row">
					<div class="col-5">
					<c:if test="${donationImgDtoList ne null}">
						<c:forEach var="donationImgDto" items="${donationImgDtoList}">
							<img src="donaimg?donationImgNo=${donationImgDto.donationImgNo}&donationNo=${donationDto.donationNo}" style="width:100%;">
						</c:forEach>
					</c:if>
					</div>
				</div>
				<div class="cols-12 mt-3">
				<p>
					${donationDto.donationContent}
				</p>
				</div>
				<div class="col-12 mt-3">
				현재후원금액 : ${donationDto.donationNowFund}원
				</div>
				<div class="col-12 mt-3">
				목표후원금액 : ${donationDto.donationTotalFund}원
				</div>
				<div class="col-8 mt-3">
				<c:if test="${sessionScope.uid eq donationDto.donationWriter}">
					<a href="edit?donationNo=${donationDto.donationNo}" class="btn btn-primary">수정</a>
					<a href="delete?donationNo=${donationDto.donationNo}&donationWriter=${sessionScope.uid}" class="btn btn-primary">삭제</a>
				</c:if>
				</div>
			</c:forEach>
		</div>
		<div class="col-12 mt-5">
			<form action="kakao/fund" method="post">
				<c:forEach var="donationDto" items="${donationDto}">
				<input type="hidden" name="donationNo" value="${donationDto.donationNo}"  id="donationNo">
				<input type="hidden" name="partner_user_id" value="${sessionScope.uid}">
				<input type="number" name="total_amount" class="form-control" min="1000" max="${donationDto.donationTotalFund - donationDto.donationNowFund}">
				<input type="submit" value="기부하기" class="btn btn-primary">
				</c:forEach>
			</form>
		</div>
		<div class="col-12 mt-5">
			<form action="kakao/autofund" method="post" id="auto">
				<c:forEach var="donationDto" items="${donationDto}">
				<input type="hidden" name="donationNo" value="${donationDto.donationNo}">
				<input type="hidden" name="partner_user_id" value="${sessionScope.uid}">
				<input type="number" name="total_amount" class="form-control" min="1000" max="${donationDto.donationTotalFund*0.3}">
				<input type="submit" value="정기기부하기" class="btn btn-primary">
				</c:forEach>
			</form>
		</div>
		

<div class="col-12">
        <form action="reply/edit" method="post">
            <c:forEach var="replyDto" items="${replyDto}">
                <div class="replyDto"><h4>
                ${replyDto.donationReplyNo}
                    | ${replyDto.memberId} | <span id="content${replyDto.donationReplyNo}">${replyDto.donationReplyContent}</span>
                   | ${replyDto.donationReplyTime}
                </h4>
                </div>
                    <c:if test="${sessionScope.uid == replyDto.memberId}">
					<div class="edit" style="margin-top:15px;">
						<input type="hidden" value="${replyDto.donationNo}" id="donationNo${replyDto.donationReplyNo}">
						<input type="hidden" value="${replyDto.donationReplyNo}" id="replyNo${replyDto.donationReplyNo}">
						<textarea class="form-control" " row="3" name="donationReplyContent"id="replyContent${replyDto.donationReplyNo}">${replyDto.donationReplyContent}</textarea> 
            
					</div>
                            <a href="#" class="reply content-change btn btn-primary">수정</a>
                            <a href="#" class="reply content-change-real btn btn-primary" data-data="${replyDto.donationReplyNo}">수정하기</a>
                            <a href="#" class="reply change-cancel btn btn-primary">취소</a> 
                            <a href="reply/delete?donationReplyNo=${replyDto.donationReplyNo}&donationNo=${replyDto.donationNo}" class="reply btn btn-secondary">삭제하기</a>

                    </c:if>
               
            </c:forEach>
        </form>
    </div>

    <div class="col-12">
        <form action="reply/insert" method="post">
            <c:forEach var="donationDto" items="${donationDto}">
                <input type="hidden" name="donationNo"
                    value="${donationDto.donationNo}">
           <input type="hidden" name="memberId" value="${sessionScope.uid}">
            </c:forEach>
            
            댓글 쓰기
            <textarea class="form-control" " row="3" name="donationReplyContent"></textarea> 
            
            <div class="right">
            <input type="submit" class="reply btn btn-primary" value="등록">
        </div>
</form>
</div>
<div class="row mt-3">
		<div class="col mt-3">
			<button type="button" class="btn btn-link disabled">더보기</button>
		</div>
	</div>
</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>