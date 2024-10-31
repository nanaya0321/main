package org.zerock.goods.vo;

import java.util.Date;

import lombok.Data;

@Data
public class GoodsPriceVO {

	private Long goods_price_no;
	private Integer price;
	private Integer discount;
	private Integer discount_rate;
	private Integer sale_price;
	private Integer saved_rate;
	private Integer delivery_charge;
	private Date sale_start_date;
	private Date sale_end_date;
	private Long goods_no;
	
	
	// 실제 판매가 getter 만들기 -> jsp ${vo.sale_price}
	// getter에서 일반메서드로 변경 (DB테이블에 sale_price칼럼 추가)
	// DB에 Insert전에 => vo.setSale_price(vo.sale_price()); 
	public Integer sale_price() {
		// 할인가가 있는 경우 처리 : 정가 - 할인가
		if (discount != 0) {
			return price - discount;
		}
		// 할인율이 있는 경우 처리: 정가 - (정가 * 할인율 / 100)
		// + 할인율이 없으면 정가로 리턴한다.
		// 100원 미만 절삭 처리는 가격에서 100을 나누고 100을 다시 곱하면 됨.
		return (price - (price * discount_rate / 100)) / 100 * 100;
	}
	
}
