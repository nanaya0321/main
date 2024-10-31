package org.zerock.boardreply.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.zerock.boardreply.vo.BoardReplyVO;
import org.zerock.util.page.PageObject;

@Repository
public interface BoardReplyMapper {
	// 1-1 getTotalRow
	// mybatic데이터 베이스 처리로 파라메터를 넘기는 개수는 1개입니다.
	// 2개의 자료형을 넘기고 싶을 때 하나로 만드는 작업이 필요합니다.
	// 그때 사용하는 어노테이션은 @Param 입니다.
	// @Param 은 자료형을 map(key, value)으로 만들어 줍니다.
	public Long getTotalRow(@Param("pageObject") PageObject pageObject, @Param("no") Long no);
	// 1-2. list
	public List<BoardReplyVO> list( @Param("pageObject") PageObject pageObject, @Param("no") Long no);
	// 2. write
	public Integer write(BoardReplyVO vo); // no, content, id 가 넘어감
	// 3. update
	public Integer update(BoardReplyVO vo); // rno, content, id 가 넘어감
	// 4. delete
	public Integer delete(BoardReplyVO vo); // rno, id 가 넘어감
}
