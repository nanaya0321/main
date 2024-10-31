package org.zerock.notice.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.notice.service.NoticeService;
import org.zerock.notice.vo.NoticeVO;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/notice")
public class NoticeController {

	@Autowired
	@Qualifier("noticeServiceImpl")
	private NoticeService service;
	
	// 1. 공지사항 리스트
	@GetMapping("/list.do")
	public String list(Model model, HttpServletRequest request) {
		log.info("list.do =====");
		
		// 페이지 처리를 위한 객체 생성
		PageObject pageObject = PageObject.getInstance(request);
		
		pageObject.setPeriod("all");
		
		// 처리된 데이터를 Model에 저장해서 jsp에 넘긴다.
		model.addAttribute("list", service.list(pageObject));
		model.addAttribute("pageObject", pageObject);
		
		return "notice/list";
	}
	
	// 2. 공지사항 글보기
	@GetMapping("/view.do")
	public String view(Model model, Long no) {
		log.info("view.do =====");
		model.addAttribute("vo", service.view(no));
		return "notice/view";
	}
	// 3-1. 공지사항 글쓰기 폼
	@GetMapping("/writeForm.do")
	public String writeForm() {
		log.info("writeform.do ======");
		return "notice/write";
	}
	// 3-2. 공지사항 글쓰기 처리
	@PostMapping("/write.do")
	public String write(NoticeVO vo, RedirectAttributes rttr) {
		log.info("write.do ======");
		service.write(vo);
		rttr.addFlashAttribute("msg", "새로운 공지사항이 등록되었습니다.");
		return "redirect:/notice/list.do";
	}
	// 4-1. 공지사항 글수정 폼
	@GetMapping("/updateForm.do")
	public String updateForm(Model model, Long no) {
		log.info("updateForm.do ======");
		model.addAttribute("vo", service.view(no));
		return "notice/update";
	}
	// 4-2. 공지사항 글수정 처리
	@PostMapping("/update.do")
	public String update(NoticeVO vo, RedirectAttributes rttr) {
		log.info("update.do ======");
		Integer result = service.update(vo);
		
		if (result == 1) {
			rttr.addFlashAttribute("msg", "공지사항이 수정되었습니다.");			
			return "redirect:/notice/list.do";
		}
		else {
			
			rttr.addFlashAttribute("msg", "공지사항이 수정되지 않았습니다.");			
			return "redirect:/notice/view.do?no=" + vo.getNo();
		}
	}
	// 5. 공지사항 글 삭제
	@GetMapping("/delete.do")
	public String delete(Long no, RedirectAttributes rttr) {
		log.info("delete.do ======");
		Integer result = service.delete(no);
		
		if (result == 1) {
			rttr.addFlashAttribute("msg", "공지사항이 삭제되었습니다.");			
			return "redirect:list.do";
		}
		else {
			rttr.addFlashAttribute("msg", "공지사항이 수정되지 않았습니다.");			
			return "redirect:/notice/view.do?no=" + no;
		}
	}
}
