package com.kh.ttamna.controller.mybaby;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.kh.ttamna.entity.mybaby.MybabyDto;
import com.kh.ttamna.entity.mybaby.MybabyImgDto;
import com.kh.ttamna.repository.mybaby.MybabyDao;
import com.kh.ttamna.repository.mybaby.MybabyImgDao;
import com.kh.ttamna.service.mybaby.MybabyFileService;
import com.kh.ttamna.vo.mybaby.MybabyDownVO;
import com.kh.ttamna.vo.mybaby.MybabyFileVO;


@Controller
@RequestMapping("/mybaby")
public class mybabyController {

	
	@Autowired
	private MybabyDao mybabyDao;
	
	@Autowired
	private MybabyImgDao mybabyImgDao;
	
	@Autowired
	private MybabyFileService mybabyService;
	
	
	//게시글 등록
	@GetMapping("/write")
	public String write() {
		return "mybaby/write";
	}
//	@PostMapping("/write")
//	public String write(@ModelAttribute MybabyDto mybabyDto,HttpSession session) {
//		String memberId = (String)session.getAttribute("uid");
//		mybabyDto.setMybabyWriter(memberId);
//		int mybabyNo = mybabyDao.write(mybabyDto);
//		return "redirect:/mybaby/detail?mybabyNo="+mybabyNo;
//	}
	@PostMapping("/write")
	public String write(@ModelAttribute MybabyFileVO mybabyFileVO) throws IllegalStateException, IOException {
		int mybabyNo = mybabyService.write(mybabyFileVO);
		return "redirect:/mybaby/detail?mybabyNo="+mybabyNo;
	}
	//상세페이지
	@GetMapping("/detail")
	public String detail(@RequestParam int mybabyNo,Model model) {
//		Map<String,Object> param = new HashMap<>();
//		param.put("mybabyNo",mybabyNo);
//		model.addAttribute("mybaby",mybabyDao.detailOrSearch(param));
		MybabyDto mybabyDto = mybabyDao.detail(mybabyNo);
		model.addAttribute("mybaby",mybabyDto);
		List<MybabyImgDto> list = mybabyImgDao.getList(mybabyNo);
		model.addAttribute("mybabyImgDtoList",list);
		model.addAttribute("mybabyNo", mybabyNo);
		
		
		return "mybaby/detail";
	}
	
	
	@RequestMapping("/")//목록페이지
	public String defaultList(
											@RequestParam(required = false) String column,
											@RequestParam(required = false) String keyword,
											Model model) {
		if(column !=null && keyword != null) {
			System.out.println("검색실행1");
			Map<String, Object> param = new HashMap<>();
			param.put("column",column);
			param.put("keyword",keyword);
			List<MybabyDownVO> list = mybabyDao.searchPlusImg(param);
			model.addAttribute("list", list);
			System.out.println("list = "+param.toString());
			model.addAttribute("column", column);
			model.addAttribute("keyword", keyword);
		}else {
			List<MybabyDto> list = mybabyDao.list();
			model.addAttribute("list",list);
		}
		return "mybaby/list";
	}
	
	@RequestMapping("/list")
	public String list(@RequestParam(required = false) String column,
								@RequestParam(required = false) String keyword,
								Model model) {
		if(column !=null && keyword != null) {
			Map<String, Object> param = new HashMap<>();
			param.put("column",column);
			param.put("keyword",keyword);
			
			model.addAttribute("list", mybabyDao.searchPlusImg(param));
//			model.addAttribute("column", column);
//			model.addAttribute("keyword", keyword);
		}else {
			List<MybabyDto> list = mybabyDao.list();
			model.addAttribute("list",list);
		}
		return "mybaby/list";
	}
	//게시글 삭제
	@GetMapping("/delete")
	public String delete(@RequestParam int mybabyNo) {
		mybabyService.delete(mybabyNo);
		mybabyDao.delete(mybabyNo);
		return "redirect:/mybaby/list";
	}
	//게시글 수정
	@GetMapping("/edit")
	public String edit(@RequestParam int mybabyNo,Model model) {
		MybabyDto mybabyDto = mybabyDao.detail(mybabyNo);
		model.addAttribute("mybaby",mybabyDto);
		model.addAttribute("mybabyDtoList",mybabyImgDao.getList(mybabyNo));
		
		return "mybaby/edit";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute MybabyFileVO mybabyFileVO) throws IllegalStateException, IOException {
//		mybabyDao.edit(mybabyDto);
		
		mybabyService.update(mybabyFileVO);
		return "redirect:/mybaby/detail?mybabyNo="+mybabyFileVO.getMybabyNo();
	}
	@GetMapping("/dropImg")
	public String deleteImg(
							@RequestParam int mybabyImgNo,
							@RequestParam int mybabyNo) {
		//이미지파일 번호 전달해서 삭제
		mybabyImgDao.dropImg(mybabyImgNo);
		//삭제 완료후 adoptNo를 이용해서 수정페이지로 리다이렉트 처리
		return "redirect: edit?mybabyNo=" + mybabyNo;
	}
	
	
	//더보기 페이지네이션 기능 처리
	@GetMapping("/more")
	@ResponseBody
	public List<MybabyDto> more(
				@RequestParam(required =false, defaultValue = "1") int page,
				@RequestParam(required =false, defaultValue = "12") int size,
				@RequestParam(required =false, defaultValue = "") String column,
				@RequestParam(required =false, defaultValue = "") String keyword
			){
		System.out.println("more에서의 column = " + column);
		int endRow = page* size;
		int startRow = endRow - (size - 1);
		if(column != null && keyword != null && !column.equals("") && !keyword.equals("")) {
			System.out.println("더보기검색페이지진입");
			return mybabyDao.listBySearchPage(startRow, endRow, column, keyword);
		} else {
			return mybabyDao.listByPage(startRow, endRow);
		}
		
	}
	// 이미지 다운로드
	@GetMapping("/mybabyImg")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> img(
														@RequestParam int mybabyImgNo
									) throws IOException {
		// 게시판 번호로 DTO 불러오기
		MybabyImgDto mybabyImgDto = mybabyImgDao.get(mybabyImgNo);
		
		
		// 파일정보 불러오기
		byte[] data = mybabyImgDao.load(mybabyImgNo);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		String encodeName = URLEncoder.encode(mybabyImgDto.getMybabyImgUpload(), "UTF-8");
		encodeName = encodeName.replace("+", "%20");
		
		return ResponseEntity.ok()
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+encodeName+"\"")
				.header("Content-Encoding", "UTF-8")
				.contentLength(mybabyImgDto.getMybabyImgSize())
				
				.body(resource);
	}
	

	

}









