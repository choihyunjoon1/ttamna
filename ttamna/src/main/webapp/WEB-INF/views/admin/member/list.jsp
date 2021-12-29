<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>

</script>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<div class="container-700 bg-white container-center" align="center">
	<div class="mt-4 mb-5"><h3>Member List</h3></div>
	<div class="mt-4 mb-5"><h6>라인 클릭시 해당 회원의 정보 조회</h6></div>
		<table class="table table-hover border">
		  <thead class="table-dark">
		    <tr>
		      <th scope="col">ID</th>
		      <th scope="col">e-mail</th>
		      <th scope="col">Join Date</th>
		    </tr>
		  </thead>
		  <tbody class="list-row">
			<c:forEach var="memberDto" items="${list}">
			<tr onClick="location.href='${root}/admin/member/detail?memberId=${memberDto.memberId}' ">
				<td>${memberDto.memberId }</td>
				<td>${memberDto.memberEmail }</td>
				<td>${memberDto.memberJoin }</td>
			</tr>
			</c:forEach>
		  </tbody>
		</table>
		<div class="d-grid gap-2 d-md-flex justify-content-md-end mt-5 mb-5">
			<button type="button" class="btn btn-outline-primary me-md-1 view-more">view more</button>
		</div>
		

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>