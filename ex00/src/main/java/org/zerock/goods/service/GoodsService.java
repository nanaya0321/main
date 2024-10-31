package org.zerock.goods.service;

import java.util.List;

import org.zerock.category.vo.CategoryVO;
import org.zerock.goods.vo.GoodsColorVO;
import org.zerock.goods.vo.GoodsImageVO;
import org.zerock.goods.vo.GoodsSearchVO;
import org.zerock.goods.vo.GoodsSizeVO;
import org.zerock.goods.vo.GoodsVO;
import org.zerock.util.page.PageObject;

public interface GoodsService {

	// 상품 리스트
	public List<GoodsVO> list(PageObject pageObject, GoodsSearchVO goodsSearchVO);
	
	// 대분류/중분류 리스트 가져오기
	public List<CategoryVO> listCategory (Integer cate_code1);
	
	// 상품 정보 보기
	public GoodsVO view(Long goods_no);
	// 상품 사이즈 리스트
	public List<GoodsSizeVO> sizeList(Long goods_no);
	// 상품컬러 리스트
	public List<GoodsColorVO> colorList(Long goods_no);
	
	// 상품이미지 리스트
	public List<GoodsImageVO> imageList(Long goods_no);
	
	// 상품 등록
	public Integer write(GoodsVO vo, List<String> imageFileNames, List<String> size_names, List<String> color_names);
	// 상품 수정
	public Integer update(GoodsVO vo, List<String> size_names, List<String> color_names);
	// 상품 삭제
	public Integer delete(GoodsVO vo);
	
	// 상품 이미지 추가
	// 상품 이미지 변경
	// 상품 이미지 삭제
	
	// 상품 사이즈 추가
	// 상품 사이즈 변경
	// 상품 사이즈 삭제
	
	// 상품 색상 추가
	// 상품 색상 변경
	// 상품 색상 삭제
	
	// 상품 현재 가격 + 기간 변경
	// 상품 예정 가격 추가
}
