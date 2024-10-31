package org.zerock.board.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.board.mapper.BoardMapper;
import org.zerock.board.vo.BoardVO;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

// @Comtroller, RestController - uri 관련된거
// @Service, @Repository, @Component, @~~~Advice
@Service
@Log4j
@Qualifier("boardServiceImpl")
public class BoardServiceImpl implements BoardService{

	// 자동 DI @Setter+ spring, @Autowired (spring), @Inject (라이브러리)
	@Inject
	private BoardMapper mapper;
	
	// 1. 일반게시판 리스트
	@Override
	public List<BoardVO> list(PageObject pageObject) {
		log.info("list() 실행 =====");
		// 전체 데이터 개수 구해서(startRow와 endRow가 세팅된다) controller에 넘긴다.
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}
	
	// 2. 일반게시판 글보기
	@Override
	public BoardVO view(Long no, int inc) {
		log.info("view() 실행 =====");
		// 조회수 증가
		if (inc == 1) mapper.increase(no);
		// 글정보 가져오기
		return mapper.view(no);
	}
	
	// 3. 일반게시판 글등록
	// 트랜젝션 테스트를 위한 어노테이션 추가
//	@Transactional - 트랜젝션 테스트용
	@Override
	public Integer write(BoardVO vo) {
		Integer result = mapper.write(vo); // 시퀀스에서 글번호 받아서 처리
		log.info("write() 실행 =====");
//		vo.setNo(10000L); - 트랜젝션 테스트용
//		mapper.writeTx(vo); // 위에서 사용한 글번호(PK) 재사용 -> PK 예외 발생할 예정 - 트랜젝션 테스트용
		return result;
	}
	
	// 4. 일반게시판 글수정
	@Override
	public Integer update(BoardVO vo) {
		log.info("update() 실행 =====");
		return mapper.update(vo);
	}
	// 5. 일반게시판 글삭제
	@Override
	public Integer delete(BoardVO vo) {
		log.info("delete() 실행 =====");
		return mapper.delete(vo);
	}
}
