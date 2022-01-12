<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>


</script>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-1000 bg-white container-center">
	<div align="center">
	<div class="mt-5 mb-4"><h3>Member List</h3></div>
	<div class="mb-3"><h6>라인 클릭시 해당 회원의 정보 조회</h6></div>
	</div>
	<div class="container">
		<div class="row">
		<!-- 사이드바 -->
		<jsp:include page="/WEB-INF/views/admin/sidebar.jsp"></jsp:include>
		<!-- 검색창 -->
		<div class="col-8 ms-1 mb-5">
			<form method="get">
				<div class="input-group justify-content-end">
					<div class="col-2">
						<select name="column" class="form-select form-select-sm" required id="column">
						<c:choose>
							<c:when test="${paginationVO.columnIs('member_id')}">
								<option value="member_id" selected>아이디</option>
								<option value="member_email">이메일</option>
								<option value="member_grade">등급</option>
							</c:when>
							
							<c:when test="${paginationVO.columnIs('member_email')}">
								<option value="member_id">아이디</option>
								<option value="member_email" selected>이메일</option>
								<option value="member_grade">등급</option>
							</c:when>
							<c:when test="${paginationVO.columnIs('member_grade')}">
								<option value="member_id">아이디</option>
								<option value="member_email">이메일</option>
								<option value="member_grade" selected>등급</option>
							</c:when>
							<c:otherwise>
								<option value="">select</option>
								<option value="member_id">아이디</option>
								<option value="member_email">이메일</option>
								<option value="member_grade">등급</option>
							</c:otherwise>
						</c:choose>
						</select>
					</div>
					<div class="input-group input-group-sm mb-3" style="width:30%">
						<input type="text" name="keyword" required class="form-control" value="${keyword}">
						<input type="submit" value="search" id="search" class="btn btn-dark btn-sm">
					</div>
				</div>			
			</form>
			
		
	
	<!-- 회원 목록 -->
	<table class="table table-hover border">
	  <thead class="table-dark">
	    <tr>
	      <th scope="col">ID</th>
	      <th scope="col">e-mail</th>
	      <th scope="col">Join Date</th>
	    </tr>
	  </thead>
	  <tbody>
	  <c:set var="list" value="${paginationVO.listOfMember}"></c:set>
	  <c:forEach var="memberDto" items="${list}">
		<tr onClick="location.href='${root}/admin/member/detail?memberId=${memberDto.memberId}' ">
			<td>${memberDto.memberId }</td>
			<td>${memberDto.memberEmail }</td>
			<td>${memberDto.memberJoin }</td>
		</tr>
	  </c:forEach>
	  </tbody>
	</table>

	<nav aria-label="Page navigation example">
  		<ul class="pagination justify-content-end">
			<!-- 이전 버튼 -->
			<c:choose>
				<c:when test="${paginationVO.isPreviousExist()}">
					<c:choose>
						<c:when test="${paginationVO.isSearch()}">
							<!-- 검색용 링크 -->
							<li class="page-item"><a class="page-link" href="list?column=${paginationVO.column}&keyword=${paginationVO.keyword}&page=${paginationVO.getPreviousBlock()}">Prev</a></li>
						</c:when>
						<c:otherwise>
							<!-- 목록용 링크 -->
							<li class="page-item"><a class="page-link" href="list?page=${paginationVO.getPreviousBlock()}">Prev</a></li>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link" href="#">Prev</a></li>
				</c:otherwise>
			</c:choose>
			
			<!-- 페이지 네비게이터 -->
			<c:forEach var="i" begin="${paginationVO.getStartBlock()}" end="${paginationVO.getRealLastBlock()}" step="1">
				<c:choose>
					<c:when test="${paginationVO.isSearch()}">
						<!-- 검색용 링크 -->
						<li class="page-item"><a class="page-link" href="list?column=${paginationVO.column}&keyword=${paginationVO.keyword}&page=${i}">${i}</a></li>
					</c:when>
					<c:otherwise>
						<!-- 목록용 링크 -->
				    	<li class="page-item"><a class="page-link" href="list?page=${i}">${i}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
	
			<!-- 다음 -->
			<c:choose>
				<c:when test="${paginationVO.isNextExist()}">
					<c:choose>
						<c:when test="${paginationVO.isSearch()}">
							<!-- 검색용 링크 -->
							<li class="page-item"><a class="page-link" href="list?column=${paginationVO.column}&keyword=${paginationVO.keyword}&page=${paginationVO.getNextBlock()}">Next</a></li>
						</c:when>
						<c:otherwise>
							<!-- 목록용 링크 -->
							<li class="page-item"><a class="page-link" href="list?page=${paginationVO.getNextBlock()}">Next</a></li>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link" href="#">Next</a></li>
				</c:otherwise>
			</c:choose>
		 </ul>
		<a type="button" class="btn btn-outline-dark" href="${root}/admin/main">Back to Admin Menu</a>
	</nav>
</div>
</div>
</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>