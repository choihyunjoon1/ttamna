<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	
	$(function(){
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
				<a href="edit?donationNo=${donationDto.donationNo}" class="btn btn-primary">수정</a>
				<!-- 추후에 얼럿 창을 한번 띄워서 확인을 누르면 삭제가 되게끔 코드 -->
				<a href="delete?donationNo=${donationDto.donationNo}" class="btn btn-primary">삭제</a>
				</div>
			</c:forEach>
		</div>
		<div class="col-12 mt-5">
			<form action="kakao/fund" method="post">
				<c:forEach var="donationDto" items="${donationDto}">
				<input type="hidden" name="donationNo" value="${donationDto.donationNo}">
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
					<div class="edit">
						<input type="hidden" value="${replyDto.donationNo}" id="donationNo${replyDto.donationReplyNo}">
						<input type="hidden" value="${replyDto.donationReplyNo}" id="replyNo${replyDto.donationReplyNo}">
						<textarea id="replyContent${replyDto.donationReplyNo}">${replyDto.donationReplyContent}</textarea>
					</div>
                            <a href="#" class="content-change btn btn-primary">수정</a>
                            <a href="#" class="content-change-real btn btn-primary" data-data="${replyDto.donationReplyNo}">수정하기</a>
                            <a href="#" class="change-cancel btn btn-primary">취소</a> 
                            <a href="reply/delete?donationReplyNo=${replyDto.donationReplyNo}&donationNo=${replyDto.donationNo}" class="btn btn-primary">삭제하기</a>

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
            댓글 쓰기<input type="text" name="donationReplyContent"> <input
                type="submit" value="등록">
        </form>
    </div>
    
	</div>
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>