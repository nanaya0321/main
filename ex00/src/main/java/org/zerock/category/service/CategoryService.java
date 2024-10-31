package org.zerock.category.service;

import java.util.List;

import org.zerock.category.vo.CategoryVO;

public interface CategoryService {

	// 1. 리스트
	public List<CategoryVO> list(Integer cate_code1);
	// 2. 등록
	// cate_code1 이 없으면 대분류, 있으면 중분류
	public Integer write(CategoryVO vo);
	// 3. 수정
	public Integer update(CategoryVO vo);
	// 4. 삭제
	public Integer delete(CategoryVO vo);
}
