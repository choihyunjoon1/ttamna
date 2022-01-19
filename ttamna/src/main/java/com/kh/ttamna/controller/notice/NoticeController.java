package com.kh.ttamna.controller.notice;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.ttamna.entity.notice.NoticeDto;
import com.kh.ttamna.entity.notice.NoticeImgDto;
import com.kh.ttamna.repository.notice.NoticeDao;
import com.kh.ttamna.repository.notice.NoticeImgDao;
import com.kh.ttamna.service.notice.NoticeFileService;
import com.kh.ttamna.vo.notice.NoticeFileVO;

@Controller
@RequestMapping("/notice")
public class NoticeController {

	@Autowired 
	private NoticeDao noticeDao;
	
	@Autowired 
	private NoticeImgDao noticeImgDao;
	
	@Autowired
	private NoticeFileService noticeFileService;
	
	//전체 목록 페이지
	@RequestMapping("/")
	public String defaultList(
			@RequestParam(required = false) String column,
			@RequestParam(required = false) String keyword, Model m) {
		if(column != null && keyword != null) {
			Map<String, Object> param = new HashMap<>();
			param.put("column", column);
			param.put("keyword", keyword);
			
			m.addAttribute("list", noticeDao.detailOrSearch(param));
			m.addAttribute("column", column);
			m.addAttribute("keyword", keyword);
		}else {
			m.addAttribute("list", noticeDao.list());
		}
		return "notice/list";
	}
	
	//검색 목록 
	@RequestMapping("/list")
	public String notice(			
			@RequestParam(required = false) String column,
			@RequestParam(required = false) String keyword, Model m) {
		if(column != null && keyword != null) {
			Map<String, Object> param = new HashMap<>();
			param.put("column", column);
			param.put("keyword", keyword);
				
			m.addAttribute("list", noticeDao.detailOrSearch(param));
		}else {
			m.addAttribute("list", noticeDao.list());
		}
		return "notice/list";
	}
		
	//더보기 페이지네이션 목록 ajax
	@PostMapping("/more")
	@ResponseBody
	public List<NoticeDto> more(
			@RequestParam(required =false, defaultValue = "1") int page,
			@RequestParam(required =false, defaultValue = "10") int size,
			@RequestParam(required =false, defaultValue = "") String column,
			@RequestParam(required =false, defaultValue = "") String keyword){
		
		int endRow = page* size;
		int startRow = endRow - (size - 1);
		if(column != null && keyword != null && !column.equals("") && !keyword.equals("")) {
			return noticeDao.searchListByPage(startRow, endRow, column, keyword);
		}else {
			return noticeDao.listByPage(startRow, endRow);
		}
	}
	
	//입양전 필독 상세조회
	@GetMapping("/detail")
	public String detail(@RequestParam int noticeNo, Model m) {
		Map<String, Object> param = new HashMap<>();
		param.put("noticeNo", noticeNo);
		m.addAttribute("noticeDto", noticeDao.detail(noticeNo));
		m.addAttribute("noticeImgList", noticeImgDao.getList(noticeNo));
		return "notice/detail";
	}
	
	//입양전 필독 작성 페이지
    @GetMapping("/write")
    public String write() {
    	return "notice/write";
    }

    //입양전 필독 작성 처리 + 파일
    @PostMapping("/write")
    public String write(@ModelAttribute NoticeFileVO noticeFileVO) throws IllegalStateException, IOException {
		int noticeNo = noticeFileService.insert(noticeFileVO);
		noticeDao.readUp(noticeNo);
		//등록처리 완료 후 상세 페이지로 이동
		return "redirect: detail?noticeNo=" + noticeNo;
	}

	//파일 다운로드 처리(화면에 보여주기)
	@GetMapping("/noticeImg")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> file(@RequestParam int noticeImgNo) throws IOException{
		//이미지 파일 다운로드용 단일 조회
		NoticeImgDto noticeImgDto = noticeImgDao.getFile(noticeImgNo);
		//바이트 형태로 파일 불러오기
		byte[] file = noticeImgDao.load(noticeImgNo);
		//바이트 형태의 파일을 다시 인코딩 처리 
		ByteArrayResource resource = new ByteArrayResource(file);
		String encoding = URLEncoder.encode(String.valueOf(noticeImgNo), "UTF-8");
		encoding = encoding.replace("+", "%20");
		
		return ResponseEntity.ok()
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+encoding+"\"")
				.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
				.contentLength(noticeImgDto.getNoticeImgSize())
				.body(resource);
	}
	
	//수정 페이지 
	@GetMapping("/edit")
	public String edit(@RequestParam int noticeNo, Model m) {
		Map<String, Object> param = new HashMap<>();
		param.put("noticeNo", noticeNo);
			
		List<NoticeDto> noticeDto = noticeDao.detailOrSearch(param);
		m.addAttribute("noticeNo", noticeNo);
		m.addAttribute("list", noticeDto);
		m.addAttribute("noticeImgList", noticeImgDao.getList(noticeNo));
		return "notice/edit";
	}
		
	//게시글 수정시 파일만 삭제
	@GetMapping("/dropImg")
	public String deleteImg(
							@RequestParam int noticeImgNo,
							@RequestParam int noticeNo) {
		//이미지파일 번호 전달해서 삭제
		noticeImgDao.dropImg(noticeImgNo);
		//삭제 완료후 noticeNo를 이용해서 수정페이지로 리다이렉트 처리
		return "redirect: edit?noticeNo=" + noticeNo;
	}
	
	//수정 처리 + 파일 추가
	@PostMapping("/edit")
	public String edit(@ModelAttribute NoticeFileVO noticeFileVO, @RequestParam int noticeNo) throws IllegalStateException, IOException {
		noticeFileService.updateWithFile(noticeFileVO);
		return "redirect: detail?noticeNo="+noticeFileVO.getNoticeNo()+"&success";
	}
		
	//삭제 처리
	@GetMapping("/delete")
	public String delete(HttpSession session, @RequestParam int noticeNo) {
		String uid = (String) session.getAttribute("uid");
		String grade = (String) session.getAttribute("grade");
		NoticeDto noticeDto = noticeDao.detail(noticeNo);
		//권한 확인 : 작성자와 세션의 아이디가 일치하거나 관리자일 경우 삭제 가능
		if(noticeDto.getNoticeWriter().equals(uid) || grade.equals("관리자")) {
			//게시글 삭제+DB파일삭제+실제 경로에 저장된 이미지 삭제 처리
			noticeFileService.deleteAll(noticeNo);
			//권한이 있으면 삭제처리하고 전체 목록으로 deleteSuccess 파라미터를 붙여서 리다이렉트
			return "redirect: list?deleteSuccess";
			//권한이 없다면 invalid파라미터를 붙여서 상세페이지로 돌려보낸다
		}else return "notice/detail?noticeNo="+noticeNo+"&invalid";
	}

	//조회수 증가 : 게시글 상세보기를 클릭하면 먼저 readUp으로 들어왔다가 상세로 리다이렉트
	@GetMapping("/readUp")
	public String readUp(@RequestParam int noticeNo) {
		noticeDao.readUp(noticeNo);
		return "redirect: detail?noticeNo="+noticeNo;
	}

	
	
	
}
