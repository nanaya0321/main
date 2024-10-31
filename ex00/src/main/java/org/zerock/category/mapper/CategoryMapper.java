package org.zerock.category.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.zerock.category.vo.CategoryVO;

@Repository
public interface CategoryMapper {

	// 1. 카테고리 리스트
	public List<CategoryVO> list(@Param("cate_code1") Integer cate_code1);
	// 2. 카테고리 등록
	// 2-1. 대분류 등록
	public Integer writeBig(CategoryVO vo);
	// 2-2. 증분류 등록
	public Integer writeMid(CategoryVO vo);
	// 3. 카테고리 수정
	public Integer update(CategoryVO vo);
	// 4. 카테고리 삭제
	public Integer delete(CategoryVO vo);
}
