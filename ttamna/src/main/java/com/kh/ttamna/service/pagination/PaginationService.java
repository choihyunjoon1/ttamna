package com.kh.ttamna.service.pagination;

import com.kh.ttamna.vo.pagination.PaginationVO;

public interface PaginationService {

	//회원목록 
	PaginationVO memberListPaging(PaginationVO paginationVO) throws Exception;
	
	//정기기부 목록
	PaginationVO apmListPaging(PaginationVO paginationVO,String MemberId) throws Exception;

	//기부 댓글 목록
	PaginationVO donationReplyPaging(PaginationVO paginationVO, int donationNo) throws Exception;

	//단건기부 목록
	PaginationVO shortListPaging(PaginationVO paginationVO, String memberId) throws Exception;

	PaginationVO myBoardPaging(PaginationVO paginationVO, String memberId) throws Exception;


}
