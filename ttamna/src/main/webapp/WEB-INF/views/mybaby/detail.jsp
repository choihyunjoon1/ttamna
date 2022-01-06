<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- 댓글 -->
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
			var mybabyNo = $("#mybabyNo"+number).val();
			
			$.ajax({
				url : "${pageContext.request.contextPath}/mybaby/reply/edit", 
				type : "post",
				data : {
					replyNo : replyNo ,
					replyContent : replyContent,
					mybabyNo : mybabyNo
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
<!-- 댓글 끝 -->


<div class="container-600 bg-white container-center" align="center">
	<div class="row">
		<div class="col">
			<h5>제목</h5>
		</div>
	</div>
	<div class="row">
		<h5>
			작성자 : ${mybaby.mybabyWriter}
			|
			작성일 : ${mybaby.mybabyTimeString()}
			|
			조회수 : ${mybaby.mybabyRead }
			|
			댓글수 : ${mybaby.mybabyReply }
		</h5>
	</div>
	<div class="row">
		<div class="col-8 container-center">
			<c:if test="${mybabyImgDtoList != null}">
				<c:forEach var="mybabyImgDto" items="${mybabyImgDtoList}">
					<img src="mybabyImg?mybabyImgNo=${mybabyImgDto.mybabyImgNo}&mybabyNo=${mybaby.mybabyNo}" style="width:100%;">
				</c:forEach>
			</c:if>
			<span class="row">${mybaby.mybabyContent}</span>
		</div>
	</div>
	<div class="row">
		<div class="col-5 container-right">
			<a href="${root }/mybaby/list">목록으로</a>
			<c:if test="${uid eq mybaby.mybabyWriter}">
				<a href="edit?mybabyNo=${mybaby.mybabyNo }">수정</a>
				<a href="delete?mybabyNo=${mybaby.mybabyNo}">삭제</a>
			</c:if>
		</div> 
	</div>
	
	
	<!-- 댓글 자리 -->
	<div class="col-12">
        <form action="reply/edit" method="post">
            <c:forEach var="replyDto" items="${replyDto}">
                <div class="replyDto"><h4>
                ${replyDto.mybabyReplyNo}
                    | ${replyDto.memberId} | <span id="content${replyDto.mybabyReplyNo}">${replyDto.mybabyReplyContent}</span>
                   | ${replyDto.mybabyReplyTime}
                </h4>
                </div>
                    <c:if test="${sessionScope.uid == replyDto.memberId}">
					<div class="edit" style="margin-top:15px;">
						<input type="hidden" value="${replyDto.mybabyNo}" id="mybabyNo${replyDto.mybabyReplyNo}">
						<input type="hidden" value="${replyDto.mybabyReplyNo}" id="replyNo${replyDto.mybabyReplyNo}">
						<textarea class="form-control"  row="3" name="mybabyReplyContent"id="replyContent${replyDto.mybabyReplyNo}">${replyDto.mybabyReplyContent}</textarea> 
            
					</div>
                            <a href="#" class="reply content-change btn btn-primary">수정</a>
                            <a href="#" class="reply content-change-real btn btn-primary" data-data="${replyDto.mybabyReplyNo}">수정하기</a>
                            <a href="#" class="reply change-cancel btn btn-primary">취소</a> 
                            <a href="reply/delete?mybabyReplyNo=${replyDto.mybabyReplyNo}&mybabyNo=${replyDto.mybabyNo}" class="reply btn btn-secondary">삭제하기</a>

                    </c:if>
               
            </c:forEach>
        </form>
    </div>
    <div class="col-12">
        <form action="${root}/reply_mybaby/insert" method="post">
           <input type="hidden" name="mybabyNo" value="${mybaby.mybabyNo}">
           <input type="hidden" name="memberId" value="${sessionScope.uid}">
            
            댓글 쓰기
            <textarea class="form-control" row="3" name="mybabyReplyContent"></textarea> 
            
            <div class="right">
            <input type="submit" class="reply btn btn-primary" value="등록">
        </div>
</form>
</div>



</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>