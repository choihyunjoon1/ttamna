<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-700 container-center">
<form method="post">
  <fieldset style="width:80%;" class="mx-auto">
  	 <!-- 위에 헤더 부분 -->
    <legend>문의하기</legend>
    <div class="form-group row">
       <input type="hidden" name="memberId" value="${sessionScope.uid}">
    </div>
    <!-- 제목작성부분 -->
    <div class="form-group">
      <label for="questionTitle" class="form-label mt-4">제목 입력</label>
      <input type="text" class="form-control" id="questionTitle"  placeholder="제목 작성" name="questionTitle" autocomplete="off">
    </div>
    <!-- 내용 작성부분 -->
    <div class="form-group">
      <label for="questionContent" class="form-label mt-4">내용 입력</label>
      <textarea class="form-control" id="questionContent" rows="3" name="questionContent"></textarea>
    </div>
    
    <div class="form-group">
   		<br><br>
	    <button type="submit" class="btn btn-outline-primary" value="글쓰기">글쓰기</button>
	 	<a href = "${root }/question/"><button type="button" class="btn btn-outline-secondary">취소</button></a> 
    </div>
  </fieldset>
</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>