package com.kh.ttamna.vo.chart;

import java.util.List;

import lombok.Data;

@Data
public class TotalChartVO {

	private String title;
	private String label;
	private List<VisitChartVO> dataset;
	private List<DonationChartVO> donationDataset;
	private List<ShopChartVO> shopDataset;
	private List<SearchChartVO> searchDataset;
	
}
