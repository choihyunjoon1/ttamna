<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 페이지에서 사용할 JSTL 변수 --%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<style>
.img-fit {
	width: 80%;
	object-fit: cover;
}
.no-line{
text-decoration : none;
}
#main-img {
	text-align: center;
}
</style>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container-800 container-center mb-5" style="height: 700px;">
	<div id="main-img mx-auto" class="mt-5 mb-5">
		<div id="carouselExampleIndicators"
			class="carousel slide container-800 container-center"
			data-bs-ride="carousel">
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#carouselExampleIndicators"
					data-bs-slide-to="0" class="active" aria-current="true"
					aria-label="Slide 1"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators"
					data-bs-slide-to="1" aria-label="Slide 2"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators"
					data-bs-slide-to="2" aria-label="Slide 3"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators"
					data-bs-slide-to="3" aria-label="Slide 4"></button>
			</div>
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="${root}/resources/img/메인소개.png"
						style="height: 700px; width: 800px" class="d-block w-60 mx-auto">
				</div>
				<div class="carousel-item">
					<img src="${root }/resources/img/img1.jpg"
						style="height: 700px; width: 800px" class="d-block w-100 mx-auto">
				</div>
				<div class="carousel-item">
					<img src="${root }/resources/img/wolf.png"
						style="height: 700px; width: 800px" class="d-block w-60 mx-auto">
				</div>
				<div class="carousel-item">
					<img src="${root }/resources/img/ruby.png"
						style="height: 700px; width: 800px" class="d-block w-100 mx-auto">
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
	</div>
</div>
<h3 class="left">
	<a class="no-line"  style="color: gray"href="${root}/donation/list"> 최근 기부 신청</a>
</h3>
<div class="container">
	<div class="row">
		<%-- 기부 게시글 자리 --%>
		<c:forEach var="donationDto" items="${donationList}">
			<div class="page card text-gray bg-light mb-5 ms-2 col-3 mt-3"
				style="width: 18rem;">
				<a
					href="${root}/donation/detail?donationNo=${donationDto.donationNo}">
					<c:choose>
						<c:when test="${donationDto eq null}">
							<img
								src="${pageContext.request.contextPath}/resources/img/nonimage.png"
								style="width: 100%; height: 15rem" class="icon">
						</c:when>
						<c:otherwise>
							<img
								src="${root}/donation/donaimg?donationImgNo=${donationDto.donationImgNo}"
								style="width: 100%; height: 15rem" class="card-img-top">
						</c:otherwise>
					</c:choose>
				</a>
				<div class="card-body">
					<h5 class="card-title">${donationDto.donationTitle}</h5>
					<div class="card-text">${donationDto.donationWriter}</div>
					<div class="card-text">
						<span>현재 기부 금액 : </span>${donationDto.donationNowFund}원</div>
					<div class="card-text">
						<span>목표 기부 금액 : </span>${donationDto.donationTotalFund}원</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
<h3 class="left">
	<a class="no-line"  style="color: gray"href="${root}/adopt/list"> 최근 입양 요청</a>
</h3>
<div class="container">
	<div class="row">
		<%-- 입양 게시글 자리 --%>
		<c:forEach var="adoptDto" items="${adoptList}">
			<div class="page card text-gray bg-light mb-5 ms-2 col-3 mt-3"
				style="width: 18rem;">
				<a href="${root}/adopt/detail?adoptNo=${adoptDto.adoptNo}"> <c:choose>
						<c:when test="${adoptDto.adoptImgNo eq null}">
							<img
								src="${pageContext.request.contextPath}/resources/img/nonimage.png"
								style="width: 100%; height: 15rem" class="icon">
						</c:when>
						<c:otherwise>
							<img
								src="${root}/adopt/adoptImg?adoptImgNo=${adoptDto.adoptImgNo}"
								style="width: 100%; height: 15rem" class="card-img-top">
						</c:otherwise>
					</c:choose>
				</a>
				<div class="card-body">
					<h5 class="card-title">${adoptDto.adoptTitle}</h5>
					<div class="card-text">입양동물 : ${adoptDto.adoptKind}</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
<h3 class="left">
	<a class="no-line"  style="color: gray"href="${root}/shop/list"> 최근 후원상품 판매</a>
</h3>
<div class="container">
	<div class="row">
		<%-- 상품 게시글 자리 --%>
		<c:forEach var="shopDto" items="${shopList}">
			<div class="page card text-gray bg-light mb-5 ms-2 col-3 mt-3"
				style="width: 18rem;">
				<a href="${root}/shop/detail?shopNo=${shopDto.shopNo}"> <c:choose>
						<c:when test="${shopDto.shopImgNo eq null}">
							<img
								src="${pageContext.request.contextPath}/resources/img/nonimage.png"
								style="width: 100%; height: 15rem" class="icon">
						</c:when>
						<c:otherwise>
							<img src="${root}/shop/img?shopImgNo=${shopDto.shopImgNo}"
								style="width: 100%; height: 15rem" class="card-img-top">
						</c:otherwise>
					</c:choose>
				</a>
				<div class="card-body">
					<h5 class="card-title">${shopDto.shopGoods}</h5>
					<div class="card-text">${shopDto.shopTitle}</div>
					<div class="card-text">${shopDto.shopPrice}원</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
<h3 class="left">
	<a class="no-line"  style="color: gray"href="${root}/mybaby/list"> 최근 내새끼 자랑</a>
</h3>
<div class="container">
	<div class="row">
		<%-- 자랑 게시글 자리 --%>
		<c:forEach var="mybabyDto" items="${mybabyList}">
			<div class="page card text-gray bg-light mb-5 ms-2 col-3 mt-3"
				style="width: 18rem;">
				<a href="${root}/mybaby/detail?mybabyNo=${mybabyDto.mybabyNo}">
					<c:choose>
						<c:when test="${mybabyDto.mybabyImgNo eq null}">
							<img
								src="${pageContext.request.contextPath}/resources/img/nonimage.png"
								style="width: 100%; height: 15rem" class="icon">
						</c:when>
						<c:otherwise>
							<img
								src="${root}/mybaby/mybabyImg?mybabyImgNo=${mybabyDto.mybabyImgNo}"
								style="width: 100%; height: 15rem" class="card-img-top">
						</c:otherwise>
					</c:choose>
				</a>
				<div class="card-body">
					<h5 class="card-title">${mybabyDto.mybabyTitle}</h5>
					<div class="card-text">${mybabyDto.mybabyWriter}</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>