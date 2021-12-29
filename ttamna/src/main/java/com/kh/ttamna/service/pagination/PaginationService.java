package com.kh.ttamna.service.pagination;

import com.kh.ttamna.vo.pagination.PaginationVO;

public interface PaginationService {

	PaginationVO listPaging(PaginationVO paginationVO) throws Exception;
}
