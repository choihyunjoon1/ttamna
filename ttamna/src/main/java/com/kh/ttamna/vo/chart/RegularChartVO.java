package com.kh.ttamna.vo.chart;

import lombok.Data;

//정기 기부
@Data
public class RegularChartVO {

	private String thisMonthDate; //이번달의 모든 날짜
	private long thisMonthDailyAmount; //이번달 정기 기부금액
	
	private String thisMonth; //이번달 
	private long thisMonthAmount; //이번달 누적 기부금액
	
	private String moy; //12개월간의 월
	private long moyAmount; //월별 누적 기부금액
	
	private String date; //날짜
	private long dailyAmount; //일별 기부금액
}
