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
	
}
