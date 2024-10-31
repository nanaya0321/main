package org.zerock.goods.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.category.vo.CategoryVO;
import org.zerock.goods.mapper.GoodsMapper;
import org.zerock.goods.vo.GoodsColorVO;
import org.zerock.goods.vo.GoodsImageVO;
import org.zerock.goods.vo.GoodsPriceVO;
import org.zerock.goods.vo.GoodsSearchVO;
import org.zerock.goods.vo.GoodsSizeVO;
import org.zerock.goods.vo.GoodsVO;
import org.zerock.util.page.PageObject;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("goodsServiceImpl")
public class GoodsServiceImpl implements GoodsService {

	@Setter(onMethod_ = @Autowired)
	private GoodsMapper mapper;
	@Override
	public List<GoodsVO> list(PageObject pageObject, GoodsSearchVO goodsSearchVO) {
		// TODO Auto-generated method stub
		pageObject.setTotalRow(mapper.getTotalRow(pageObject, goodsSearchVO));
		return mapper.list(pageObject, goodsSearchVO);
	}
	// 상품 정보 보기
	@Override
	public GoodsVO view(Long goods_no) {
		// TODO Auto-generated method stub
		return mapper.view(goods_no);
	}
	// 상품 사이즈 리스트
	@Override
	public List<GoodsSizeVO> sizeList(Long goods_no) {
		// TODO Auto-generated method stub
		return mapper.sizeList(goods_no);
	}
	// 상품 컬러 리스트
	@Override
	public List<GoodsColorVO> colorList(Long goods_no) {
		// TODO Auto-generated method stub
		return mapper.colorList(goods_no);
	}
	// 상품 이미지 리스트
	@Override
	public List<GoodsImageVO> imageList(Long goods_no) {
		// TODO Auto-generated method stub
		return mapper.imageList(goods_no);
	}
	
	@Override
	@Transactional // 쿼리중 하나라도 문제가 생기거나 처리되지 않으면 자동 Rollback 되는 기능
	public Integer write(GoodsVO vo, List<String> imageFileNames, List<String> size_names, List<String> color_names) {
		// TODO Auto-generated method stub
		// 1. goods 테이블에 상품등록 (필수) 순서는 이게 제일 먼저 나머지는 상관없음
		log.info("+++++쿼리 실행전 goodsVO.goods_no: " + vo.getGoods_no());
		mapper.write(vo);
		log.info("+++++쿼리 실행후 goodsVO.goods_no: " + vo.getGoods_no());
		// 2. 등록한 goods테이블의 goods_no를 가져온다.
		// <selectkey>로 goods_no를 세팅하면 보내지는 vo객체에 goods_no가 저장된다. 저장된 vo객체에서 goods_no를 꺼내온다.
		Long goods_no = vo.getGoods_no();
		// goods_price 테이블에 가격정보 등록 (필수)
		// vo.setGoods_no(goods_no);
				
		mapper.writePrice(vo);
		// goods_image 테이블에 등록 (선택: imageFileName에 자료가 있으면)
		for (String imageName : imageFileNames) {
			GoodsImageVO imageVO = new GoodsImageVO();
			imageVO.setGoods_no(goods_no);
			imageVO.setImage_name(imageName);
			mapper.writeImage(imageVO);
		}
		// goods_size 테이블에 등록 (선택: size_names에 자료가 있으면)
		for (String sizeName : size_names) {
			GoodsSizeVO sizeVO = new GoodsSizeVO();
			sizeVO.setGoods_no(goods_no);
			sizeVO.setSize_name(sizeName);
			mapper.writeSize(sizeVO);
		}
		// goods_color 테이블에 등록 (선택: color_names에 자료가 있으면)
		List<GoodsColorVO> colorList = null;
		for (String colorName : color_names) {
			if (colorList == null) colorList = new ArrayList<>();	
			GoodsColorVO colorVO = new GoodsColorVO();
			colorVO.setGoods_no(goods_no);
			colorVO.setColor_name(colorName);
			
			colorList.add(colorVO);
		}
		if (colorList != null) mapper.writeColor(colorList);
		return 1;
	}

	@Override
	@Transactional
	public Integer update(GoodsVO vo, List<String> size_names, List<String> color_names) {
		// TODO Auto-generated method stub
		Integer result = mapper.update(vo);
		result = mapper.updatePrice(vo);
		// 사이즈 리스트 삭제 및 등록
		Long goods_no = vo.getGoods_no();
		mapper.deleteSize(goods_no);
		for (String sizeName : size_names) {
			GoodsSizeVO sizeVO = new GoodsSizeVO();
			sizeVO.setGoods_no(goods_no);
			sizeVO.setSize_name(sizeName);
			mapper.writeSize(sizeVO);
		}
		// 컬러 리스트 삭제 및 등록
		mapper.deleteColor(goods_no);
		List<GoodsColorVO> colorList = null;
		for (String colorName : color_names) {
			if (colorList == null) colorList = new ArrayList<>();	
			GoodsColorVO colorVO = new GoodsColorVO();
			colorVO.setGoods_no(goods_no);
			colorVO.setColor_name(colorName);
			
			colorList.add(colorVO);
		}
		
		return result;
	}

	@Override
	public Integer delete(GoodsVO vo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<CategoryVO> listCategory(Integer cate_code1) {
		// TODO Auto-generated method stub
		return mapper.getCategory(cate_code1);
	}

	





}
