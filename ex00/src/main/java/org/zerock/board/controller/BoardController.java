package org.zerock.board.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.board.service.BoardService;
import org.zerock.board.vo.BoardVO;
import org.zerock.util.page.PageObject;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import oracle.jdbc.proxy.annotation.Post;

@Controller
@RequestMapping("/board")
@Log4j
public class BoardController {
	
	// 자동 DI
//	@Setter(onMethod_ = @Autowired) // @Qualifier 사용시 Setter 사용하면 오류 발생함
	@Autowired // 그래서 @Setter(onMethod_ = @Autowired) 대신 이거사용함
	@Qualifier("boardServiceImpl")
	private BoardService service;
	
	@GetMapping("/list.do")
		// 1. HttpServletRequest 에 자료를 담아서 넘긴다.
//		public String list(HttpServletRequest request) {
		// 2. Model(Spring에서 제공) 을 이용하여 자료넘기기
		public String list(Model model, HttpServletRequest request) {
		// 3. ModelAndView 를 활용
//		public ModelAndView list(Model model) {
		log.info("list() =====");
		
		// 페이지 처리를 위한 객체 생성
		PageObject pageObject = PageObject.getInstance(request);
		//1.
//		request.setAttribute("list", service.list());
		// 2. 처리에 데이터를 model 저장해서 넘긴다.
		// model에 담으면 request에 자동으로 담긴다.
		model.addAttribute("list", service.list(pageObject));
		model.addAttribute("pageObject", pageObject);
		return "board/list";
		// 3. ModelAndView 를 활용하여 데이터를 담고 페이지이동한다.
//		ModelAndView mav = new ModelAndView();
//		mav.addObject("list", service.list());
//		mav.setViewName("board/list");
//		
//		return mav;
	}
	
	// 2. 일반게시판 글보기
	@GetMapping("/view.do")
	// uri에 있는 key값과 동일한 이름의 변수에 값이 담긴다.(no, inc)
	public String view(Model model, Long no, int inc) {
		log.info("view() =====");
		model.addAttribute("vo", service.view(no, inc));
		return "board/view";
	}
	
	
	// 3-1. 일반게시판 글쓰기 폼
	// class에 있는 mapping주소 + 메서드 mapping 주소로 접근하게된다.
	// @RequestMapping("/board") + @GetMapping("/writeForm.do")
	@GetMapping("/writeForm.do")
	public String writeForm() {
		log.info("writeForm() ======");
		return "board/write";
	}
	// 3-2. 일반게시판 글쓰기처리
	@PostMapping("/write.do")
	public String write(BoardVO vo, RedirectAttributes rttr) {
		log.info("write() =====");
		service.write(vo);
		
		// RedirectAttributes - 한번만 담고 사라짐
		// 글등록 처리에 대한 메시지
		rttr.addFlashAttribute("msg", "일반게시판 글등록 완료");
		
		return "redirect:list.do";
	}
	
	// 4-1. 일반게시판 글수정 폼
	@GetMapping("/updateForm.do")
	// no는 url에 적힌 no 값을 가져옴.(글정보를 가져오기위한 글번호)
	// model은 글번호로 받은 데이터를 update.jsp(글쓰기폼)로 넘길때 사용함
	public String updateForm(Model model, Long no) {
		log.info("updateForm() =====");
		model.addAttribute("vo", service.view(no, 0));
		return "board/update";
	}
	
	// 4-2. 일반게시판 글수정 처리
	@PostMapping("/update.do")
	public String update(BoardVO vo, RedirectAttributes rttr) {
		log.info("update() =====");
		log.info(vo);
		if (service.update(vo) == 1) {
			// return 이 1 이면 수정이 잘 되었다는 의미입니다.
			rttr.addFlashAttribute("msg", "일반게시판 " + vo.getNo() + "번 글수정 완료");
		}
		else {
			// 글수정이 안되었을때
			rttr.addFlashAttribute("msg", "글수정 오류" + "비밀번호가 맞지 않습니다." + "다시 확인하시고 시도해 주세요.");
			return "redirect:updateForm.do?no=" + vo.getNo();
		}
		// 글수정 후 글보기로 돌아갑니다. 조회수는 증가하지 않습니다.
		return "redirect:view.do?no=" + vo.getNo() + "&inc=0";
	}
	@PostMapping("/delete.do")
	public String delete(BoardVO vo, RedirectAttributes rttr) {
		log.info("delete() =====");
		if (service.delete(vo) == 1) {
			// 삭제가 잘 되었을때
			rttr.addFlashAttribute("msg", "일반게시판 " + vo.getNo() + "번글이 삭제되었습니다.");
		}
		else {
			// 삭제가 안되었을때
			rttr.addFlashAttribute("msg", "글삭제 오류" + "비밀번호를 확인하시고 다시 시도해 주세요.");
			return "redirect:view.do?no=" + vo.getNo() + "&inc=0";
		}
		return "redirect:list.do";
	}
}
