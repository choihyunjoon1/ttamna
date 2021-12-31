package com.kh.ttamna.vo.kakaopay;

import java.util.Date;

import lombok.Data;
@Data
public class KaKaoPayAutoPayMentSearchResponseVo {

	private boolean available;
	private String cid;
	private String sid;
	private String status;
	private String payment_method_type;
	private String item_name;
	private Date created_at;
	private Date last_approve_at;
	private Date inactivated_at;
}
