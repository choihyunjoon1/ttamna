package com.kh.ttamna.service.pagination;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ttamna.entity.donation.AutoPayMentDto;
import com.kh.ttamna.entity.donation.DonationReplyDto;
import com.kh.ttamna.entity.member.MemberDto;
import com.kh.ttamna.entity.payment.PaymentDto;
import com.kh.ttamna.repository.donation.AutoDonationDao;
import com.kh.ttamna.repository.donation.DonationReplyDao;
import com.kh.ttamna.repository.member.MemberDao;
import com.kh.ttamna.repository.payment.PaymentDao;
import com.kh.ttamna.vo.board.BoardVO;
import com.kh.ttamna.vo.pagination.PaginationVO;

@Service
public class PaginationServiceImpl implements PaginationService{

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private AutoDonationDao autoDao;
	
	@Autowired 
	private DonationReplyDao donationReplyDao;
	
	@Autowired
	private PaymentDao payDao;
	
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
	
	//정기 결제 내역 목록 + 페이지네이션
	@Override
	public PaginationVO apmListPaging(PaginationVO paginationVO,String memberId) throws Exception {
		int count = autoDao.count(memberId);
		paginationVO.setPageSize(1);
		paginationVO.setBlockSize(10);
		paginationVO.setCount(count);
		paginationVO.calculator();
		List<AutoPayMentDto> list = autoDao.listPaging(memberId ,paginationVO.getStartRow(), paginationVO.getEndRow());
		paginationVO.setListOfAutopay(list);
	
		return paginationVO;
	}
	//단건 기부 내역 목록 + 페이지네이션
	@Override
	public PaginationVO shortListPaging(PaginationVO paginationVO,String memberId) throws Exception {
		int count = payDao.count(memberId);
		paginationVO.setPageSize(1);
		paginationVO.setBlockSize(10);
		paginationVO.setCount(count);
		paginationVO.calculator();
		List<PaymentDto> list = payDao.listPaging(memberId ,paginationVO.getStartRow(), paginationVO.getEndRow());
		paginationVO.setListOfShortPay(list);
	
		return paginationVO;
	}

	//기부 댓글 페이지네이션
	@Override
	public PaginationVO donationReplyPaging(PaginationVO paginationVO, int donationNo) throws Exception {

		int count = donationReplyDao.count(donationNo);
		paginationVO.setPageSize(1);
		paginationVO.setBlockSize(10);
		paginationVO.setCount(count);
		paginationVO.calculator();
		List<DonationReplyDto> list = donationReplyDao.listByPage(paginationVO.getStartRow(), paginationVO.getEndRow(), donationNo);
		paginationVO.setListOfDonaReply(list);
		
		return paginationVO;
		
	}
	//내게시글보기 내역 목록 + 페이지네이션
	@Override
	public PaginationVO myBoardPaging(PaginationVO paginationVO,String memberId) throws Exception {
		int count = memberDao.countBoard(memberId);
		
		paginationVO.setPageSize(15);
		paginationVO.setBlockSize(10);
		paginationVO.setCount(count);
		paginationVO.calculator();
		List<BoardVO> list = memberDao.boardListPaging(memberId ,paginationVO.getStartRow(), paginationVO.getEndRow());
		paginationVO.setListOfMyBoard(list);
	
		return paginationVO;
	}

}
