package org.zerock.category.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.category.service.CategoryService;
import org.zerock.category.vo.CategoryVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/category")
public class CategoryController {

	@Autowired
	@Qualifier("categoryServiceImpl")
	private CategoryService service;
	
	// 1. 카테고리 리스트
	@GetMapping("/list.do")
	public String list(@RequestParam(defaultValue = "0") Integer cate_code1, Model model) {
		
		log.info("cate_code1" + cate_code1);
		// 대분류 가져오기
		List<CategoryVO> listBig = service.list(0);
		
		// 중분류 가져오기
		// cate_code1 이 없으면 cate_code1 중 제일 작은 것을 가져와서 처리
		if (cate_code1 == 0 && (listBig != null && listBig.size() != 0)) {
			// listBig을 DB에서 가져올때 cate_code1을 Asc를 했기 때문에 첫번째가 cate_code1 가장 작은 값이다. 
			cate_code1 = listBig.get(0).getCate_code1();
		}
		List<CategoryVO> listMid = service.list(cate_code1);
		
		// 처리된 값을 model에 담아서 넘긴다.
		model.addAttribute("listBig", listBig);
		model.addAttribute("listMid", listMid);
		
		log.info("cate_code1 = " + cate_code1 ); 
		
		model.addAttribute("cate_code1", cate_code1);
		return "category/list";
	}
	
	// 2. 카테고리 등록
	// 2-1. 카테고리 등록 폼 대신 등록항목이 분류명밖에 없어서 리스트에 모달창으로 처리함
	// 2-2. 카테고리 등록 처리
	@PostMapping("/write.do")
	public String write(CategoryVO vo, RedirectAttributes rttr) {
		service.write(vo);
		// 카테고리 등록 후 메시지 표출
		rttr.addFlashAttribute("msg", "카테고리가 등록 되었습니다.");
		
		return "redirect:list.do?cate_code1=" + vo.getCate_code1();
	}
	// 3. 카테고리 수정
	// 3-1. 카테고리 수정 폼 - 리스트 모달창 이용
	// 3-2. 카테고리 수정 처리
	@PostMapping("/update.do")
	public String update(CategoryVO vo, RedirectAttributes rttr) {
		
		Integer result = service.update(vo);
		if(result == 1) {
			rttr.addFlashAttribute("msg", "카테고리가 수정되었습니당.");
		}
		else {
			rttr.addFlashAttribute("msg", "카테고리가 수정되지 않았습니다.");			
		}
		return "redirect:list.do?cate_code1=" + vo.getCate_code1();
	}
	
	// 카테고리 삭제 처리
	@PostMapping("/delete.do")
	public String delete(CategoryVO vo, RedirectAttributes rttr) {
		
		Integer result = service.delete(vo);
		if(result >= 1) {
			// 대분류가 삭제될때는 중분류도 같이 삭제가 되어서 처리결과가 1 이상의 값이 리턴된다.
			rttr.addFlashAttribute("msg", "카테고리가 삭제되었습니당.");
		}
		else {
			rttr.addFlashAttribute("msg", "카테고리가 삭제되지 않았습니다.");			
		}
		return "redirect:list.do?cate_code1=" + vo.getCate_code1();
	}
}
