package org.zerock.goods.vo;

import lombok.Data;

@Data
public class GoodsSearchVO {

	private Integer cate_code1; // 대분류
	private Integer cate_code2; // 중분류
	private String goods_name; // 상품이름
	private Integer min_price; // 최저가격
	private Integer max_price; // 최대가격
	
	
	// URL에다 붙일때 사용
	// 변수가 null이면 null이라는 문자열이 붙게 됩니다. => 처리해줘야한다.
	public String getSearchQuery() {
		return ""
			+ "cate_code1=" + toStr(cate_code1)
			+ "&cate_code2=" + toStr(cate_code2)
			+ "&goods_name=" + toStr(goods_name)
			+ "&min_price=" + toStr(min_price)
			+ "&max_price=" + toStr(max_price)
			;
	}
	
	// 객체가 null일때 ""(비어있는 문자열)로 변경해주는 함수
	public String toStr (Object obj) {
		return ((obj==null)?"":obj.toString());
	}
}
