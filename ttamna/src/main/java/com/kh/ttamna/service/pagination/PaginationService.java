package com.kh.ttamna.service.pagination;

import com.kh.ttamna.vo.pagination.PaginationVO;

public interface PaginationService {

	PaginationVO memberListPaging(PaginationVO paginationVO) throws Exception;
	PaginationVO apmListPaging(PaginationVO paginationVO,String MemberId) throws Exception;
}
