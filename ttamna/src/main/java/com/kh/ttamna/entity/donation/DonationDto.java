package com.kh.ttamna.entity.donation;

import java.sql.Date;

import lombok.Data;

@Data
public class DonationDto {

	private int donationNo;
	private int donationImgNo;
	private String donationWriter;
	private int donationPrice;
	private String donationTitle;
	private String donationContent;
	private Date donationTime;
	private int donationRead;
	
	
	
}
