package com.kh.ttamna.controller.adopt;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
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

import com.kh.ttamna.entity.adopt.AdoptDto;
import com.kh.ttamna.entity.adopt.AdoptImgDto;
import com.kh.ttamna.repository.adopt.AdoptDao;
import com.kh.ttamna.repository.adopt.AdoptImgDao;
import com.kh.ttamna.service.adopt.AdoptFileService;
import com.kh.ttamna.vo.adopt.AdoptFileVO;

@Controller
@RequestMapping("/adopt")
public class AdoptController {

	@Autowired
	private AdoptDao adoptDao;
	
	@Autowired
	private AdoptImgDao adoptImgDao;
	
	@Autowired
	private AdoptFileService adoptFileService;
	
	//입양공고 전체 목록 페이지
	@RequestMapping("/")
	public String defaultList(
			@RequestParam(required = false) String column,
			@RequestParam(required = false) String keyword, Model m) {
		if(column != null && keyword != null) {
			Map<String, Object> param = new HashMap<>();
			param.put("column", column);
			param.put("keyword", keyword);
			
			m.addAttribute("list", adoptDao.detailOrSearch(param));
			m.addAttribute("column", column);
			m.addAttribute("keyword", keyword);
		}else {
			m.addAttribute("list", adoptDao.list());
		}
		return "adopt/list";
	}
	
	//입양공고 전체 목록
	@RequestMapping("/list")
	public String adopt(			
			@RequestParam(required = false) String column,
			@RequestParam(required = false) String keyword, Model m) {
		if(column != null && keyword != null) {
			Map<String, Object> param = new HashMap<>();
			param.put("column", column);
			param.put("keyword", keyword);
			
			m.addAttribute("list", adoptDao.detailOrSearch(param));
		}else {
			m.addAttribute("list", adoptDao.list());
		}
		return "adopt/list";
	}
	
	//더보기 페이지네이션 목록 ajax
	@PostMapping("/more")
	@ResponseBody
	public List<AdoptDto> more(
			@RequestParam(required =false, defaultValue = "1") int page,
			@RequestParam(required =false, defaultValue = "9") int size,
			@RequestParam(required =false, defaultValue = "") String column,
			@RequestParam(required =false, defaultValue = "") String keyword){
		
		int endRow = page* size;
		int startRow = endRow - (size - 1);
		if(column != null && keyword != null && !column.equals("") && !keyword.equals("")) {
			return adoptDao.searchListByPage(startRow, endRow, column, keyword);
		}else {
			return adoptDao.listByPage(startRow, endRow);
		}
	}
	

	//입양공고 게시글 등록 페이지
	@GetMapping("/write")
	public String write() {
		return "adopt/write";
	}
	
	//입양공고 게시글 등록 처리 + 파일 저장
	@PostMapping("/write")
	public String write(@ModelAttribute AdoptFileVO adoptFileVO, HttpSession session) throws IllegalStateException, IOException {
		String adoptWriter = (String) session.getAttribute("uid");
		System.out.println("adoptController 작성자 : " + adoptWriter);
		adoptFileVO.setAdoptWriter(adoptWriter);
		int adoptNo = adoptFileService.insert(adoptFileVO);
		adoptDao.readUp(adoptNo);
		//등록처리 완료 후 상세 페이지로 이동
		return "redirect: detail?adoptNo=" + adoptNo;
	}
	
	//상세페이지 + 파일
	@RequestMapping("/detail")
	public String detail(@RequestParam int adoptNo, Model m) {
		Map<String, Object> param = new HashMap<>();
		param.put("adoptNo", adoptNo);
		m.addAttribute("adoptDto", adoptDao.detail(adoptNo));
		m.addAttribute("adoptImgList", adoptImgDao.getList(adoptNo));
		return "adopt/detail";
	}
	
	//파일 다운로드 처리(화면에 보여주기)
	@GetMapping("/adoptImg")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> file(@RequestParam int adoptImgNo) throws IOException{
		//이미지 파일 다운로드용 단일 조회
		AdoptImgDto adoptImgDto = adoptImgDao.getFile(adoptImgNo);
		//바이트 형태로 파일 불러오기
		byte[] file = adoptImgDao.load(adoptImgNo);
		//바이트 형태의 파일을 다시 인코딩 처리 
		ByteArrayResource resource = new ByteArrayResource(file);
		String encoding = URLEncoder.encode(String.valueOf(adoptImgNo), "UTF-8");
		encoding = encoding.replace("+", "%20");
		
		return ResponseEntity.ok()
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+encoding+"\"")
				.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
				.contentLength(adoptImgDto.getAdoptImgSize())
				.body(resource);
	}
	
	//게시글 수정시 파일만 삭제
	@GetMapping("/dropImg")
	public String deleteImg(
							@RequestParam int adoptImgNo,
							@RequestParam int adoptNo) {
		//이미지파일 번호 전달해서 삭제
		adoptImgDao.dropImg(adoptImgNo);
		//삭제 완료후 adoptNo를 이용해서 수정페이지로 리다이렉트 처리
		return "redirect: edit?adoptNo=" + adoptNo;
	}
	
	
	//입양공고 수정 페이지 
	@GetMapping("/edit")
	public String edit(@RequestParam int adoptNo, Model m) {
		Map<String, Object> param = new HashMap<>();
		param.put("adoptNo", adoptNo);
		
		List<AdoptDto> adoptDto = adoptDao.detailOrSearch(param);
		m.addAttribute("adoptNo", adoptNo);
		m.addAttribute("list", adoptDto);
		m.addAttribute("adoptImgList", adoptImgDao.getList(adoptNo));
		return "adopt/edit";
	}
	
	//입양공고 수정 처리 + 파일 추가
	@PostMapping("/edit")
	public String edit(@ModelAttribute AdoptFileVO adoptFileVO, @RequestParam int adoptNo) throws IllegalStateException, IOException {
		adoptFileService.updateWithFile(adoptFileVO);
		return "redirect: detail?adoptNo="+adoptFileVO.getAdoptNo()+"&success";
	}
	
	//입양공고 삭제 처리
	@GetMapping("/delete")
	public String delete(HttpSession session, @RequestParam int adoptNo) {
		String uid = (String) session.getAttribute("uid");
		String grade = (String) session.getAttribute("grade");
		AdoptDto adoptDto = adoptDao.detail(adoptNo);
		//권한 확인 : 작성자와 세션의 아이디가 일치하거나 관리자일 경우 삭제 가능
		if(adoptDto.getAdoptWriter().equals(uid) || grade.equals("관리자")) {
			//adoptImgDao.deleteImg(adoptNo); //adoptNo 게시판 번호에 해당하는 이미지 파일을 전부 삭제
			adoptDao.delete(adoptNo);
			//권한이 있으면 삭제처리하고 전체 목록으로 deleteSuccess 파라미터를 붙여서 리다이렉트
			return "redirect: list?deleteSuccess";
			//권한이 없다면 invalid파라미터를 붙여서 상세페이지로 돌려보낸다
		}else return "adopt/detail?adoptNo="+adoptNo+"&invalid";
	}

	//조회수 증가 : 게시글 상세보기를 클릭하면 먼저 readUp으로 들어왔다가 상세로 리다이렉트
	@GetMapping("/readUp")
	public String readUp(@RequestParam int adoptNo) {
		adoptDao.readUp(adoptNo);
		return "redirect: detail?adoptNo="+adoptNo;
	}

	

}
