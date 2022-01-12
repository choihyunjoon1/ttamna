package com.kh.ttamna.vo.shop;

import lombok.Data;

@Data
public class ShopOrderVO {
	private int shopNo;
	private int quantity;
	private String memberName;
	private String memberPhone;
	private String postcode;
	private String address;
	private String detailAddress;
}
