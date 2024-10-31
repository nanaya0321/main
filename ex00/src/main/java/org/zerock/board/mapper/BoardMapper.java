package org.zerock.board.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.zerock.board.vo.BoardVO;
import org.zerock.util.page.PageObject;

@Repository
public interface BoardMapper {
	
	// 1. 일반게시판 리스트
	// 일반게시판 리스트 페이지 처리를 위한 전체 데이터 개수를 가져온다.
	public Long getTotalRow(PageObject pageObject);
	// 리스트 가져오는 쿼리 실행
	public List<BoardVO> list(PageObject pageObject);
	// 1. 드라이버확인
	// 2. DB연결
	// 3. SQL 작성
	// 4. 실행객체에 데이터세팅
	// 5. 쿼리 실행
	// 6. 데이터 담기
	// 7. DB닫기
	// 위의 7단계를 mybatis가 대신 처리해준다.
	
	// 2. 일반게시판 글보기
	// 조회수 증가
	public Integer increase(Long no);
	// 글보기(글정보)
	public BoardVO view(Long no);
	
	// 3. 일반게시판 글쓰기
	public Integer write(BoardVO vo);
	// 글등록의 트랜젝션 처리 테스트를 위한 메서드
//	public Integer writeTx(BoardVO vo); - 트랜젝션 테스트용
	
	// 4. 일반게시판 글수정
	public Integer update(BoardVO vo);
	
	// 5. 일반게시판 글삭제
	public Integer delete(BoardVO vo);
	
}
