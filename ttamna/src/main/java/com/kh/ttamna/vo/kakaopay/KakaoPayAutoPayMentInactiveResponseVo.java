package com.kh.ttamna.vo.kakaopay;

import java.util.Date;

import lombok.Data;

@Data
public class KakaoPayAutoPayMentInactiveResponseVo {

	private String cid;
	private String sid;
	private String status;
	private Date created_at;
	private Date last_approved_at;
	private Date inactivated_at;
}
