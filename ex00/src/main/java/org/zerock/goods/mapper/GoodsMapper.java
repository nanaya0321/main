package org.zerock.goods.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.zerock.category.vo.CategoryVO;
import org.zerock.goods.vo.GoodsColorVO;
import org.zerock.goods.vo.GoodsImageVO;
import org.zerock.goods.vo.GoodsPriceVO;
import org.zerock.goods.vo.GoodsSearchVO;
import org.zerock.goods.vo.GoodsSizeVO;
import org.zerock.goods.vo.GoodsVO;
import org.zerock.util.page.PageObject;

@Repository
public interface GoodsMapper {

	// 상품 리스트
	// byBatis는 한개의 객체만 전달할 수 있다. 그래서 2개 이상의 객체를 전달하고 싶을때는 @Param 어노테이션을 사용한다.
	// @Param 어노테이션을 사용하면 Map으로 묶여서 전달이 된다.
	public List<GoodsVO> list(@Param("pageObject") PageObject pageObject, @Param("goodsSearchVO") GoodsSearchVO goodsSearchVO);
	// 상품 리스트 개수
	public Long getTotalRow(@Param("pageObject") PageObject pageObject, @Param("goodsSearchVO") GoodsSearchVO goodsSearchVO);
	
	// 대분류/중분류 리스트 가져오기
	public List<CategoryVO> getCategory(@Param("cate_code1") Integer cate_code1);
	
	// 상품 상세보기
	public GoodsVO view(@Param("goods_no")Long goods_no);
	// 상품 사이즈 리스트
	public List<GoodsSizeVO> sizeList(@Param("goods_no")Long goods_no);
	// 상품 컬러 리스트
	public List<GoodsColorVO> colorList(@Param("goods_no")Long goods_no);
	// 상품 이미지 리스트
	public List<GoodsImageVO> imageList(@Param("goods_no")Long goods_no);
	// 상품등록
	// 1. goods 테이블에 상품등록 (필수) *순서는 이게 제일 먼저 나머지는 상관없음
	public Integer write(GoodsVO vo);
	// goods_price 테이블에 가격정보 등록 (필수)
	public Integer writePrice(GoodsVO vo);
	// goods_image 테이블에 등록 (선택: imageFileName에 자료가 있으면)
	public Integer writeImage(GoodsImageVO vo);
	// goods_size 테이블에 등록 (선택: size_names에 자료가 있으면)
	public Integer writeSize(GoodsSizeVO vo);
	// goods_color 테이블에 등록 (선택: color_names에 자료가 있으면)
//	public Integer writeColor(GoodsColorVO vo);
	public Integer writeColor(List<GoodsColorVO> list);
	
	// 상품 정보 수정
	public Integer update(GoodsVO vo);
	// 상품 가격 수정
	public Integer updatePrice(GoodsVO vo);
	// 상품 사이즈 삭제
	public Integer deleteSize(Long goods_no);
	// 상품 컬러 삭제
	public Integer deleteColor(Long goods_no);
	// 상품 이미지 삭제
	public Integer deleteImage(String image_name);
	
	
}
 