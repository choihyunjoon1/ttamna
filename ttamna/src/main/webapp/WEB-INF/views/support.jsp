<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%-- 페이지에서 사용할 JSTL 변수 --%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>   

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>	

<div class="container-700 container-center mt-5 mb-5">
	<div class="mt-5 mb-5">
		<h3><strong>정부지원 유기동물 입양비 지원 사업 안내</strong></h3>
	</div>
	<div class="mb-5">
		<p>안녕하세요. 동물의 집 Tierheim 입니다.</p>
		<p>유실·유기동물 입양시 정부에서 지원하는 입양비 지원 신청방법을 공유드립니다.</p>
		<p>매년 유기동물의 수는 증가하고 있지만 그런 유기 동물들을 입양하는 비율은</p>
		<p>증가하지 않아 안타깝게도 많은 동물들이 안락사로 생을 마감하고 있습니다.</p>
		<p>이를 해결하기 위해 농림축산식품부에서는 동물의 생명을 존중하는 마음과</p>
		<p>올바른 반려동물 입양문화를 확산시키기 위해 유기 동물 입양시 소요되는 비용의</p>
		<p>일부를 지원해 입양을 독려하고 활성화하기 위한 정책을 마련하여 시행 중 입니다.</p>
		<p>저희 동물의 집을 이용해 주시는 따뜻한 분들께도 도움이 되고자</p>
		<p>해당 사항에 대해 안내 드립니다.</p>
		<div class="mt-3 text-info">
			<strong><small>
			단, 동물보호단체로 등록되지 않은 기관 혹은 개인에게 입양했을 경우에는 지원하지 않습니다.
			</small></strong>
		</div>
	</div>
	<div class="container-700 container-center border border-info px-5 pt-5 pb-3">
		<div class="list-group">
		    <div class="d-flex w-100 justify-content-between">
		      <h5 class="mb-2">유기동물 입양비 지원 대상, 조건</h5>
		    </div>
		    <div class="mb-5">
		    	<div>유기동물(유기견, 유기묘 등)을 각 지방자치단체장이 지정한 동물보호센터에서</div>
		    	<div>보호중인 동물을 입양하는 사람이 지원 대상입니다.</div>
		   		 <div>동물보호법 시행령 5조에 따라 동물보호 단체가 입양할 경우와 해당 동물을</div>
		   		 <div>반려 목적으로 입양하는 자에 한하여 지원이 가능합니다.</div>
		    </div>
		    
		    <div class="d-flex w-100 justify-content-between">
		      <h5 class="mb-2">유기동물 입양비 신청기간</h5>
		    </div>
		    <div class="mb-5">
		         <div>유기동물을 입양할 경우 6개월 이내에 신청해 입양비를 지원받을 수 있습니다.</div>
		    </div>
		    
		    <div class="d-flex w-100 justify-content-between">
		      <h5 class="mb-2">유기동물 입양비 지원 내용</h5>
		    </div>
		    <div class="mb-5">
		       	<div>내장형 동물등록비, 질병진단비, 예방접종비, 미용비, 치료비, 중성화 수술비를</div> 
		       	<div>지원합니다.</div> 
		    </div>
		    
		    <div class="d-flex w-100 justify-content-between">
		      <h5 class="mb-2">유기동물 입양비 지원 비용</h5>
		    </div>
			<div class="mb-5">
		    	<div>최대 10만원을 지원합니다.</div>
		        <div> - 치료비 등이 20만원 이상일 경우에는 10만원을 지원</div>
		       	<div> - 치료비 등이 20만원 미만일 경우에는 사용한 비용의 50%를 지원</div>
		       <div class="mt-2">
		       	  <small>단, 해당 지자체마다 지원금액, 조건이 상이할 수 있으니 해당 지자체에 문의 바랍니다.</small>
		       </div>
		    </div>
		    
		    <div class="d-flex w-100 justify-content-between">
		      <h5 class="mb-2">유기동물 입양비 신청 필요 서류</h5>
		    </div>
			<div class="mb-5">
		    	<div><strong>[ 개인 입양자 신청 시 필요 서류 ]</strong></div>
		    	<div class="mb-1"> - 지원신청서 
		    		<br>- 분양확인서
		    		<br>- 진료비 등 영수증
		    		<br>- 입금통장 사본
		    		<br>- 신분증 사본
		    		<br>- 동물등록증
		    	</div>
		    	<div class="mb-3"><small>단, 입양비 지원 신청자와 각 서류의 이름이 동일해야 합니다.</small></div>
		    	<div><strong>[ 동물보호단체 신청 시 필요 서류 ]</strong></div>
		    	<div>- 분양확인서
		    		<br>- 동물등록증
		    		<br>- 단체등록(허가)증 사본
		    		<br>- 해당 단체 통장 사본
		    	</div>
		    </div>
		    
		    <div class="d-flex w-100 justify-content-between">
		      <h5 class="mb-2">유기동물 입양비 신청절차</h5>
		    </div>
			<div class="mb-5">
		    	<div>각 지방자치단체에서 정한 동물보호센터 및 동물보호단체에서 상담 및 교육을 통해</div>
		    	<div>분양확인서를 발급받은 후에</div>
		    	<div>동물등록, 병원치료(내장칩 동물등록, 중성화 수술, 질병치료, 예방접종, 미용)등을</div>
		    	<div>완료하여 동물보호센터에 방문 접수하거나 동물보호단체가 있는 해당 지자체</div>
		    	<div>담당부서에 방문, FAX, 이메일로 접수 가능합니다.</div>
		    </div>
		    
 			<div class="d-flex w-100 justify-content-between">
		      <div class="mb-3"><small>아래 링크 클릭시 해당 사이트로 이동합니다.</small></div>
		    </div>
			<div class="mb-1">
				<div><strong>유실·유기동물 입양비 지원 관련 정보 참고 사이트</strong></div> 
				<div><a href="https://kimjeje.tistory.com/461" class="text-danger docs-creator">
						https://kimjeje.tistory.com/461
				</a></div>
			</div>
			<div class="mb-3">
				<div><strong>정부24 유실·유기동물 입양비 지원 관련 공지</strong></div>
				<div><a href="https://www.gov.kr/portal/service/serviceInfo/154300000389" class="text-danger docs-creator">
						https://www.gov.kr/portal/service/serviceInfo/154300000389
				</a></div>
			</div>

		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>