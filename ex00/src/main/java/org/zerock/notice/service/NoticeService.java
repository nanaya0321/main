package org.zerock.notice.service;

import java.util.List;

import org.zerock.notice.vo.NoticeVO;
import org.zerock.util.page.PageObject;

public interface NoticeService {

	// 1. 공지사항 리스트
	public List<NoticeVO> list(PageObject pageObject);
	// 2. 공지사항 글보기
	public NoticeVO view(Long no);
	// 3. 공지사항 글쓰기
	public Integer write(NoticeVO vo);
	// 4. 공지사항 글수정
	public Integer update(NoticeVO vo);
	// 5. 공지사항 글삭제
	public Integer delete(Long no);
}
