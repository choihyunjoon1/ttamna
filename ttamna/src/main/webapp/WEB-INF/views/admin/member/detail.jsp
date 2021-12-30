<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<div class="container-600 bg-white container-center" align="center">
		<table class="table border mt-5">
		  <thead class="table">
		  	<tr>
		  	  <th colspan="3"><h3>Member Info</h3></th>
		  	</tr>
		  	<c:if test="${param.success != null}">
		  	<tr>
		  		<th colspan="3">
		  			<h5>등급이 ${memberDto.memberGrade}(으)로 수정되었습니다</h5>			
		  		</th>
		  	</tr>
		  	</c:if>
		  </thead>
		  <tbody>
			  <tr>
	   			<th>ID</th>
	   			<td colspan="2">${memberDto.memberId}</td>
			  </tr>
			  <tr>
	   			<th>Nick</th>
	   			<td colspan="2">${memberDto.memberNick}</td>
			  </tr>
			  <tr>
	   			<th>Name</th>
	   			<td colspan="2">${memberDto.memberName}</td>
			  </tr>
			  <tr>
	   			<th>E-mail</th>
	   			<td colspan="2">${memberDto.memberEmail}</td>
			  </tr>
			  <tr>
	   			<th>Phone</th>
	   			<td colspan="2">${memberDto.memberPhone}</td>
			  </tr>
			   <tr>
	   			<th>Grade</th>
	   			<td colspan="2">${memberDto.memberGrade}
		   			<form method="post" action="${root}/admin/member/edit_grade?memberId=${memberDto.memberId}">
					   	<div class="input-group justify-content-end ms-5" style="width:20rem">
							<select name="memberGrade" class="form-select form-select-sm ms-5" required>
								<option value="">등급선택</option>
								<option value="일반회원">일반회원</option>
								<option value="보호소">보호소</option>
								<option value="관리자">관리자</option>
							</select>
							<div class="input-group input-group-sm" style="width:30%">
								<input type="submit" value="edit" class="btn btn-dark btn-sm">
							</div>
						</div>			
		   			</form>
	   			</td>
			  </tr>
			  <tr>
	   			<th>Join Date</th>
	   			<td colspan="2">${memberDto.memberJoin}</td>
			  </tr>
			  <tr>
	   			<th>Last Log</th>
	   			<td colspan="2">${memberDto.memberLastLog}</td>
			  </tr>
			  <tr>
	   			<th>Address</th>
	   			<td colspan="2">${memberDto.postcode} ${memberDto.address} ${memberDto.detailAddress}</td>
			  </tr>
		  </tbody>
		</table>
		<div class="d-grid gap-2 d-md-flex justify-content-md-end mt-5 mb-5">
			<a type="button" class="btn btn-outline-primary" href="${root}/admin/member/list">Back to List</a>
			<a type="button" class="btn btn-outline-primary" href="${root}/admin/main">Back to Admin Menu</a>
		</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>