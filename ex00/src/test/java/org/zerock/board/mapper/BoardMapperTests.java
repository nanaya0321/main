package org.zerock.board.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.board.vo.BoardVO;
import org.zerock.util.page.PageObject;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

// Mapper 메서드 단위 동작 테스트(쿼리테스트)
// Test를 위해 사용되는 메서드
@RunWith(SpringJUnit4ClassRunner.class)
// 설정파일지정
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
// 로그객체생성
@Log4j
public class BoardMapperTests {

	// 자동 DI
	// 1. Lombok의 setter와 spring의 autowired 이용
	// 2. spring의 autowired
	// 3. inject 이용
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	// 일반게시판 list() 테스트 - OK
//	@Test
	public void testList() {
		log.info("[일반게시판 리스트 (list()) 테스트 =================");
		
		// 필요한 데이터(파라매타로 넘겨지는 데이터)는 하드코딩(강제세팅)한다.
		// pageObject 생성
		PageObject pageObject = new PageObject();
		log.info(mapper.list(pageObject));
	}
	// 일반게시판 getTotalRow() 테스트 - OK
//	@Test
	public void testGetTotalRow() {
		log.info("[일반게시판 리스트 총개수 (getTotalRow()) 테스트]============");
		PageObject pageObject = new PageObject();
		log.info(mapper.getTotalRow(pageObject));
	}
	
	// 일반게시판 글보기
	// increase  - OK
//	@Test
	public void testIncrease() {
		log.info("[일반게시판 글보기 조회수 1증가(increase()) 테스트]============");
		// 필요한 파라매터는 하드코딩 no = 46번
		Long no = 46L;
		log.info(mapper.increase(no));
	}
	// view
//	@Test - OK
	public void testView() {
		log.info("[일반게시판 글보기 (view()) 테스트]============");
		Long no = 46L;
		log.info(mapper.view(no));
	}
	// 일반게시판 글등록 테스트 - OK
//	@Test
	public void testWrite() {
		log.info("[일반게시판 글쓰기 처리 (write()) 테스트]============]");
		// 글쓰기에 BoardVO 필요함으로 하드코딩함
		BoardVO vo = new BoardVO();
		vo.setTitle("글등록 테스트 JUint");
		vo.setContent("글등록 테스트 내용");
		vo.setWriter("정이나");
		vo.setPw("1111");
		log.info(mapper.write(vo));
	}
	// 일반게시판 글수정 테스트
//	@Test
	public void testUpdate() {
		log.info("[일반게시판 글수정 처리 (update()) 테스트]============]");
		// 글수정에 BoardVO 필요 - 하드코딩
		BoardVO vo = new BoardVO();
		vo.setNo(46L);
		vo.setPw("1111");
		vo.setTitle("junit 글수정 테스트");
		vo.setContent("글수정 테스트 하드코딩중");
		vo.setWriter("정이나");
		log.info(mapper.update(vo));				
	}
	// 일반게시판 글삭제 테스트 - OK
//	@Test
	public void testdelete() {
		log.info("[일반게시판 글삭제 처리 (delete()) 테스트]============]");
		BoardVO vo = new BoardVO();
		vo.setNo(325L); // 실제로 있는 번호와 비밀번호를 써야함
		vo.setPw("1111");
		log.info(mapper.delete(vo));				
	}
}
