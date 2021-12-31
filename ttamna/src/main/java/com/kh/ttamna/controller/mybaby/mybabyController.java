package com.kh.ttamna.controller.mybaby;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.ttamna.entity.mybaby.MybabyDto;
import com.kh.ttamna.repository.mybaby.MybabyDao;
import com.kh.ttamna.repository.mybaby.MybabyImgDao;
import com.kh.ttamna.service.mybaby.MybabyFileService;
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
		
		return "mybaby/detail";
	}
	
	
	@RequestMapping("/")//목록페이지
	public String defaultList() {
		return "mybaby/list";
	}
	
	@RequestMapping("/list")//목록페이지
	public String list(Model model) {
		model.addAttribute("list", mybabyDao.list());
		
		return "mybaby/list";
	}
	//게시글 삭제
	@GetMapping("/delete")
	public String delete(@RequestParam int mybabyNo) {
		mybabyDao.delete(mybabyNo);
		return "redirect:/mybaby/list";
	}
	//게시글 수정
	@GetMapping("/edit")
	public String edit(@RequestParam int mybabyNo,Model model) {
		MybabyDto mybabyDto = mybabyDao.detail(mybabyNo);
		model.addAttribute("mybaby",mybabyDto);
		return "mybaby/edit";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute MybabyDto mybabyDto) {
		mybabyDao.edit(mybabyDto);
		return "redirect:/mybaby/detail?mybabyNo="+mybabyDto.getMybabyNo();
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
		int endRow = page* size;
		int startRow = endRow - (size - 1);
		if(column != null && keyword != null && !column.equals("") && !keyword.equals("")) {
			return mybabyDao.listBySearchPage(startRow, endRow, column, keyword);
		} else {
			return mybabyDao.listByPage(startRow, endRow);
		}
		
	}
	
}
