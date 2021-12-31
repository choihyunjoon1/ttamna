package com.kh.ttamna.vo.chart;

import lombok.Data;

@Data
public class VisitChartVO {
	
	private String date; //날짜
	private int count; //방문자수
	
	private String thisMonthDate; //이번달 날짜
	private int thisMonthDailyCount; //이번달 일별 방문자수
	
	private String thisMonth; //이번달
	private int thisMonthCount; //이번달 누적
	
	private String monthly; //이번달 부터 6개월전까지의 월
	private int monthlyCount; ////이번달 부터 6개월전까지의 월별 누적 방문자수
	
	private String moy; //최근 12개월간의 월
	private int moyCount; //최근 12개월간의 월별 방문자수
	
}
