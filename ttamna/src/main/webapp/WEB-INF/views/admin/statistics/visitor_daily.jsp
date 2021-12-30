<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%-- 페이지에서 사용할 JSTL 변수 --%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>   
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.6.2/chart.js" integrity="sha512-7Fh4YXugCSzbfLXgGvD/4mUJQty68IFFwB65VQwdAf1vnJSG02RjjSCslDPK0TnGRthFI8/bSecJl6vlUHklaw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- <script> -->

// //방문자 일별 통계 - 7일 단위(일/요일표시하기)
// $(function(){ // 화면이 시작될때 통계자료를 불러오도록 해야 한다
	
// 	$.ajax({
// 		url : "${root}/admin/statistics/visitor_daily",
// 		type : "get",
// 		dataType : "json",
// 		success:function(resp){
// 			console.log("방문자 일별 통계 불러오기 성공");
// 			//데이터를 가져오는데 성공하면 차트를 생성하는 함수부르기
// 			draw("#visitor-daily", resp);
// 		},
// 		eroor:function(e){
// 			console.log("방문자 일별 통계 불러오기 실패", e);
// 		}
		
// 	});
	
// });

// //selector : 선택자, data : JSON(ChartVO)
// function draw(selecor, data){
	
// 	//고정 변수인 ctx는 canvas에 그림을 그리기 위한 펜 객체
// 	var ctx = $(selector)[0].getContext("2d");
// 	var textArray = []; //text용 배열
// 	var countArray = []; //count용 배열
// 	for(var i=0 ; i < data.dataset.length ; i++){
		
// 	}
// }
<!-- </script> -->

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<div class="container-700 container-center">
	 
	 <div class="mt-5 mb-3"><h3>VISITOR DAILY</h3></div>

	<canvas id="visitor-daily" width="400" height="400"></canvas>

</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>