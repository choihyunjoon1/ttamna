package com.kh.ttamna.service.pagination;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ttamna.entity.member.MemberDto;
import com.kh.ttamna.repository.member.MemberDao;
import com.kh.ttamna.vo.pagination.PaginationVO;

@Service
public class PaginationServiceImpl implements PaginationService{

	@Autowired
	private MemberDao memberDao;
	
	//전체 목록 + 검색 목록 + 페이지네이션 처리
	@Override
	public PaginationVO memberListPaging(PaginationVO paginationVO) throws Exception {
		
		int count = memberDao.count(paginationVO.getColumn(), paginationVO.getKeyword());
		paginationVO.setPageSize(15);
		paginationVO.setBlockSize(10);
		paginationVO.setCount(count);
		paginationVO.calculator();
		List<MemberDto> list = memberDao.listPaging(paginationVO.getColumn(), paginationVO.getKeyword() ,paginationVO.getStartRow(), paginationVO.getEndRow());
		paginationVO.setListOfMember(list);
	
		return paginationVO;
	}

}
