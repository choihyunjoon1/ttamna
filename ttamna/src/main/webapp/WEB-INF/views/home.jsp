<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%-- 페이지에서 사용할 JSTL 변수 --%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>   

<style>
.img-fit {
	width: 80%;
  	object-fit: cover;
}
#main-img{
	text-align: center;
}
</style>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container-1000 container-center">
	<div id="main-img mx-auto">
		<div id="carouselExampleIndicators" class="carousel slide container-800 container-center" data-bs-ride="carousel">
		  <div class="carousel-indicators">
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
		  </div>
		  <div class="carousel-inner">
		    <div class="carousel-item active">
		      <img src="${root }/resources/img/img1.jpg" class="d-block w-100" >
		    </div>
		    <div class="carousel-item">
		      <img src="${root }/resources/img/wolf.png" class="d-block w-100">
		    </div>
		    <div class="carousel-item">
		      <img src="${root }/resources/img/ruby.png" class="d-block w-100">
		    </div>
		    <div class="carousel-item">
		      <img src="${root}/resources/img/어바웃.png" class="d-block w-100" style="width:50%;">
			</div>		    
		  </div>
		  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Previous</span>
		  </button>
		  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Next</span>
		  </button>
		</div>
	</div>
</div>
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>