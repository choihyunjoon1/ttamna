<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%-- 페이지에서 사용할 JSTL 변수 --%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>   
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.6.0/chart.js" integrity="sha512-CWVDkca3f3uAWgDNVzW+W4XJbiC3CH84P2aWZXj+DqI6PNbTzXbl1dIzEHeNJpYSn4B6U8miSZb/hCws7FnUZA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

 <script> 

//방문자 일별 통계 - 7일 단위(일/요일표시하기)
 $(function(){// 화면이 시작될때 통계자료를 불러오도록 해야 한다

	 $.ajax({
 		url : "${root}/admin/statistics/visitor_daily",
 		type : "get",
 		dataType : "json",
		success:function(resp){
			console.log("방문자 일별 통계 불러오기 성공");
			//데이터를 가져오는데 성공하면 차트를 생성하는 함수부르기
 			dailyOfvisitor("#daily", resp);
 		},
 		eroor:function(e){
 			console.log("방문자 일별 통계 불러오기 실패", e);
 		}
		
 	});
	
 });

 //selector : 선택자, data : JSON(ChartVO)
 function dailyOfvisitor(selector, data){
	
 	//고정 변수인 ctx는 canvas에 그림을 그리기 위한 펜 객체
 	var ctx = $(selector)[0].getContext("2d");
 	var dateArray = [];//날짜(문자열)만 모아둘 배열
	var countArray = [];//방문자수만 모아둘 배열
	
	//VisitChartVO에서 가져온 데이터를 각 배열에 넣어준다
	for(var i=0; i < data.dataset.length; i++){
		dateArray.push(data.dataset[i].date);
		countArray.push(data.dataset[i].count);
	}
 	
 	//var chart = new Chart(펜객체, 차트옵션);
 	var daily = new Chart(ctx, {
 		type: 'bar', //차트 유형
 		data: { //차트에 들어가는 데이터
 			labels: dateArray,
 			datasets: [{
 				label: data.label,
 				data: countArray,
 				backgroundColor: [
 				    'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	                'rgba(75, 192, 192, 0.2)',
	                'rgba(153, 102, 255, 0.2)',
	                'rgba(255, 159, 64, 0.2)',
 				    'rgba(255, 99, 132, 0.2)'
 				],
 				borderColor: [
 					'rgba(255, 99, 132, 1)',
 		            'rgba(54, 162, 235, 1)',
 		            'rgba(255, 206, 86, 1)',
 		            'rgba(75, 192, 192, 1)',
 		            'rgba(153, 102, 255, 1)',
 		            'rgba(255, 159, 64, 1)',		
 					'rgba(255, 99, 132, 1)'
 				],
 				borderWidth: 1
 			}]
 		},
	    options: {
	    	responsive: true,
	  		plugins: {
				legend: {
					position: 'top',
				},
	          	title: {
	            	display: true,
	            	text: data.title
	          	}
			}
     	 }
 	
 	});
 }
</script>


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-700 container-center">
	 
	 <div class="mt-5 mb-3"><h3>VISITOR DAILY</h3></div>

	<canvas id="daily" width="400" height="400"></canvas>

</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>