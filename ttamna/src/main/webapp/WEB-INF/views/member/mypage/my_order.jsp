<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link ref="stylesheet" type="text/css" href="${root }/resources/css/commons.css">

<div class="container-1000 container-center">
	<div class="container">
		<div class="align-self-center">
			<h1 align="center">ORDER</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<!-- 사이드바 자리 -->
			<jsp:include page="/WEB-INF/views/member/mypage/sidebar.jsp"></jsp:include>
			
			<div class="col-9" style="width: 80%">
				<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col">주문번호</th>
						<th scope="col">상품명</th>
						<th scope="col">구매일</th>
					</tr>
				</thead>
				<tbody >
					<c:forEach begin="1" end="10"  var="i">
					<tr>
						<th scope="row">${i }</th>
						<td>제목[댓글수]</td>
						<td>작성일</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			</div>
		</div>
	</div>
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>