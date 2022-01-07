package com.kh.ttamna.vo.chart;

import java.util.List;

import lombok.Data;

@Data
public class VisitTotalChartVO {

	private String title;
	private String label;
	private List<VisitChartVO> dataset;
	
}
