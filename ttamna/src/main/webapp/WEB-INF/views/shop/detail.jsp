<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--부트스트랩 cdn-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    
<!--부트JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>    
    
<script src="https://code.jquery.com/jquery-3.6.0.js">
</script>
<script>
$(function(){
	$("#add-cart").click(function(e){
		if(window.confirm('장바구니로 이동하시겠습니까?')){
			return true;
		} else{
			var shopNo = $("#shopNo").val();
			var memberId = $("input[name=memberId]").val();
			var shopGoods = $("input[name=shopGoods]").val();
			var shopPrice = $("input[name=shopPrice]").val();
			var shopImgNo = $("input[name=shopImgNo]").val();
			
			$.ajax({
				url : "${pageContext.request.contextPath}/shop/detail/addcart",
				type : "post", 
				data : {
					shopNo : shopNo,
					memberId : memberId,
					shopGoods : shopGoods,
					shopPrice : shopPrice,
					shopImgNo : shopImgNo
				},
				success:function(resp){
					console.log("성공");
				},
				error:function(e){
					console.log("실패");
				}
			});
			return false;
		}
	});
});
</script>
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
			var shopNo = $("#shopNo"+number).val();
			
			$.ajax({
				url : "${pageContext.request.contextPath}/shop/reply/edit", 
				type : "post",
				data : {
					replyNo : replyNo ,
					replyContent : replyContent,
					shopNo : shopNo
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



<div class="row form">
	<span>${detail.shopTitle}</span>
</div>
<div class="row">
	<span>상품명 : ${detail.shopGoods}</span>
</div>
<div class="row">
	<span>판매가 : ${detail.shopPrice}원</span>
</div>
<div class="row">
	<span>남은 수량 : ${detail.shopCount}</span>
</div>
<div class="row">
	<span>조회수 : ${detail.shopRead}</span>
</div>

<form action="order/multibuy" method="post">
	<div class="row mt-3">
		<input type="hidden" name="shopNo" value="${detail.shopNo}">
<!-- 	<input type="hidden" name="partner_user_id" value="${sessionScope.uid}"> -->	
		<input type="hidden" name="item_name" value="${detail.shopGoods}">
		<input type="hidden" name="total_amount" value="${detail.shopPrice}">
		<input type="submit" value="구매하기" class="btn btn-primary">
	</div>
</form>
<form action="detail/addcart" method="post" >
	<div class="row mt-3">
	<input type="hidden" name="shopNo" value="${detail.shopNo}" id="shopNo">
		<input type="hidden" name="memberId" value="${sessionScope.uid}">
		<input type="hidden" name="shopGoods" value="${detail.shopGoods}">
		<input type="hidden" name="shopPrice" value="${detail.shopPrice}">
		<input type="hidden" name="shopImgNo" value="${shopImgDto.shopImgNo}">
		<input type="submit" value="장바구니에 담기" class="btn btn-secondary"  id="add-cart">
	</div>
</form>
<div>
</div>
<div class="row">
	<c:choose>
		<c:when test="${shopImgDto == null}">
		<div>
			<img src="https://cdn.discordapp.com/attachments/565845740543410197/925011110959124551/211586d6bf04ce85.jpg">
		</div>
			<span>${detail.shopContent}</span>
		</c:when>
		<c:otherwise>
				<img src="img?shopImgNo=${shopImgDto.shopImgNo}">
			<br><br>
			<span>${detail.shopContent}</span>
		</c:otherwise>
	</c:choose>
</div>
<a href="edit?shopNo=${detail.shopNo}" class="btn btn-info">수정</a>
<a href="delete?shopNo=${detail.shopNo}"  class="btn btn-danger">삭제</a>
<a href="list" class="btn btn-outline-dark">목록으로</a>


<div class="col-12">
        <form action="reply/edit" method="post">
            <c:forEach var="replyDto" items="${replyDto}">
                <div class="replyDto"><h4>
                ${replyDto.shopReplyNo}
                    | ${replyDto.memberId} | <span id="content${replyDto.shopReplyNo}">${replyDto.shopReplyContent}</span>
                   | ${replyDto.shopReplyTime}
                </h4>
                </div>
                    <c:if test="${sessionScope.uid == replyDto.memberId}">
					<div class="edit" style="margin-top:15px;">
						<input type="hidden" value="${replyDto.shopNo}" id="shopNo${replyDto.shopReplyNo}">
						<input type="hidden" value="${replyDto.shopReplyNo}" id="replyNo${replyDto.shopReplyNo}">
						<textarea class="form-control" " row="3" name="shopReplyContent"id="replyContent${replyDto.shopReplyNo}">${replyDto.shopReplyContent}</textarea> 
            
					</div>
                            <a href="#" class="reply content-change btn btn-primary">수정</a>
                            <a href="#" class="reply content-change-real btn btn-primary" data-data="${replyDto.shopReplyNo}">수정하기</a>
                            <a href="#" class="reply change-cancel btn btn-primary">취소</a> 
                            <a href="reply/delete?shopReplyNo=${replyDto.shopReplyNo}&shopNo=${replyDto.shopNo}" class="reply btn btn-secondary">삭제하기</a>

                    </c:if>
               
            </c:forEach>
        </form>
    </div>

    <div class="col-12">
        <form action="reply/insert" method="post">
            <c:forEach var="shopDto" items="${shopDto}">
                <input type="hidden" name="shopNo"
                    value="${shopDto.shopNo}">
           <input type="hidden" name="memberId" value="${sessionScope.uid}">
            </c:forEach>
            
            댓글 쓰기
            <textarea class="form-control" " row="3" name="shopReplyContent"></textarea> 
            
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



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>