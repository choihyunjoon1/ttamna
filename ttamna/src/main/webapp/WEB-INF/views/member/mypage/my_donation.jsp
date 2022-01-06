<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link ref="stylesheet" type="text/css" href="${root }/resources/css/commons.css">
<script>
	$(function(){
		//정기결제용 ajax
		autopayPaging();
		
		
		function autopayPaging(page,size){
			$.ajax({
				url:"${pageContext.request.contextPath}/member/mypage/my_donation/autopay",
				type:"post",
				data:{
					page:page,
					size:size
				},
				dataType:"json",
				success:function(resp){
					console.log("성공",resp);
					console.log($("table > .result"));
					console.log(resp.length);
					var a="";
					//출력부분
					for(var i=0;i<resp.length;i++){
						a ="<tr class='apmListPaging'>"+
							"<td>정기기부</td>"+
							"<td>"+resp[i].donationNo+"</td>"+
							"<td>"+resp[i].autoTotalAmount+"원</td>"+
							"<td>"+resp[i].firstPaymentDate+"</td>"+
							"<td>"+resp[i].payTimes+"회차</td>"+
							"<td>"+
								"<a href='${pageContext.request.contextPath}/donation/kakao/auto/search?sid="+resp[i].autoSid+"'>조회</a>"+
								"<a href='${pageContext.request.contextPath}/donation/kakao/auto/inactive?sid="+resp[i].autoSid+"'>중지</a>"+
							"</td>"+
						"</tr>";
					$("table > .result").append(a);
					}
				},
				error:function(e){
					console.log("실패",e);
				}
			});
		}
		//단건결제용 ajax
		function donationPaging(page,size){
			$.ajax({
				url:"${pageContext.request.contextPath}/ajax/donation",
				type:"get",
				data:{
					page:page,
					size:size
				},
				dataType:"json",
				success:function(resp){
					console.log("성공",resp);
					
					
				},
				error:function(e){
					console.log("실패",e);
				}
			});
		}
	});
</script>
<div class="container-1000 container-center">
	<div class="container">
		<div class="align-self-center">
			<h1 align="center">DONATION LIST</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<!-- 사이드바 자리 -->
			<jsp:include page="/WEB-INF/views/member/mypage/sidebar.jsp"></jsp:include>
			<div class="col-8" style="width:80%;">
				<!-- 정기결제 영역 -->
				<table class="table table-hover">
					<thead>
						<tr>
							<th>기부유형</th>
							<th>기부중인게시판번호</th>
							<th>기부금액</th>
							<th>최초기부일</th>
							<th>기부회차</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody class="result">
						
					</tbody>
				</table>
				<!-- 페이지네이션 내비게이션 -->
				<nav aria-label="Page navigation example">
			  		<ul class="pagination justify-content-end">
						<!-- 이전 버튼 -->
						<c:choose>
							<c:when test="${paginationVO.isPreviousExist()}">
								<!-- 목록용 링크 -->
								<li class="page-item"><a class="page-link" href="my_donation?page=${paginationVO.getPreviousBlock()}">Prev</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" href="#">Prev</a></li>
							</c:otherwise>
						</c:choose>
						
						<!-- 페이지 네비게이터 -->
						<c:forEach var="i" begin="${paginationVO.getStartBlock()}" end="${paginationVO.getRealLastBlock()}" step="1">
							<!-- 목록용 링크 -->
					    	<li class="page-item"><a class="page-link" href="my_donation?page=${i}">${i}</a></li>
						</c:forEach>
				
						<!-- 다음 -->
						<c:choose>
							<c:when test="${paginationVO.isNextExist()}">
								<!-- 목록용 링크 -->
								<li class="page-item"><a class="page-link" href="my_donation?page=${paginationVO.getNextBlock()}">Next</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" href="#">Next</a></li>
							</c:otherwise>
						</c:choose>
					 </ul>
				</nav>
			</div>
		</div>
	</div>
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>