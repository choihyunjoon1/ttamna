package com.kh.ttamna.entity.shop;

import java.sql.Date;

import lombok.Data;

@Data
public class ShopReplyDto {
	private int shopReplyNo;
	private String memberId;
	private int shopNo;
	private String shopReplyContent;
	private Date shopReplyTime;

}
