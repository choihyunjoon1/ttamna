<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-700 container-center">
<form method="post" enctype="multipart/form-data">
  <fieldset style="width:80%;" class="mx-auto">
  	 <!-- 위에 헤더 부분 -->
    <legend>자랑글 쓰기</legend>
    <div class="form-group row">
       <input type="hidden" name="mybabyWriter" value="${sessionScope.uid}">
    </div>
    <!-- 제목작성부분 -->
    <div class="form-group">
      <label for="mybabyTitle" class="form-label mt-4">제목 입력</label>
      <input type="text" class="form-control" id="mybabyTitle"  placeholder="제목 작성" name="mybabyTitle" autocomplete="off" value="${mybaby.mybabyTitle }">
    </div>
    <!-- 내용 작성부분 -->
    <div class="form-group">
      <label for="mybabyContent" class="form-label mt-4">내용 입력</label>
      <textarea class="form-control" id="mybabyContent" rows="3" name="mybabyContent">${mybaby.mybabyContent }</textarea>
    </div>
    <!-- 파일 부분 -->
    <div class="form-group">
      <label for="attach" class="form-label mt-4">이미지 파일 선택 : </label>
      <label class="form-label mt-4">파일이 추가될 경우 이전 파일이 삭제됩니다.</label>
      <input class="form-control" type="file" id="attach" name="attach" multiple>
    </div>
    <c:if test="${mybabyDtoList != null}">
			<c:forEach var="mybabyImgList" items="${mybabyDtoList}">
				<img src="mybabyImg?mybabyImgNo=${mybabyImgList.mybabyImgNo}&mybabyNo=${mybabyImgList.mybabyNo}" style="width:30%;">
				<a href="dropImg?mybabyImgNo=${mybabyImgList.mybabyImgNo}&mybabyNo=${mybabyImgList.mybabyNo}" class="btn btn-outline-info" type="button">삭제</a>
			</c:forEach>
		 </c:if>
    <div class="form-group">
   		<br><br>
	    <button type="submit" class="btn btn-outline-primary" value="수정하기">수정하기</button>
	 	<a href = "${root }/mybaby/detail?mybabyNo=${mybaby.mybabyNo}"><button type="button" class="btn btn-outline-secondary">취소</button></a> 
    </div>
  </fieldset>
</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>