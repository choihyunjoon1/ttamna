<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<div class="container-600 bg-white container-center" align="center">
		<table class="table border mt-5">
		  <thead class="table">
		  	<tr>
		  	  <th colspan="2"><h3>Member Info</h3></th>
		  	</tr>
		  </thead>
		  <tbody>
			  <tr>
	   			<th>ID</th>
	   			<td>${memberDto.memberId}</td>
			  </tr>
			  <tr>
	   			<th>Nick</th>
	   			<td>${memberDto.memberNick}</td>
			  </tr>
			  <tr>
	   			<th>Name</th>
	   			<td>${memberDto.memberName}</td>
			  </tr>
			  <tr>
	   			<th>E-mail</th>
	   			<td>${memberDto.memberEmail}</td>
			  </tr>
			  <tr>
	   			<th>Phone</th>
	   			<td>${memberDto.memberPhone}</td>
			  </tr>
			  <tr>
	   			<th>Join Date</th>
	   			<td>${memberDto.memberJoin}</td>
			  </tr>
			  <tr>
	   			<th>Last Log</th>
	   			<td>${memberDto.memberLastLog}</td>
			  </tr>
			  <tr>
	   			<th>Address</th>
	   			<td>${memberDto.postcode} ${memberDto.address} ${memberDto.detailAddress}</td>
			  </tr>
		  </tbody>
		</table>
		<div class="d-grid gap-2 d-md-flex justify-content-md-end mt-5 mb-5">
			<a type="button" class="btn btn-outline-primary" href="${root}/admin/member/list">Back to List</a>
			<a type="button" class="btn btn-outline-primary" href="${root}/admin/main">Back to Admin Menu</a>
		</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>