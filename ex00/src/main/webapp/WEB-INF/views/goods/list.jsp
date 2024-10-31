<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!-- 데이터는 DispatcherServlet에 담겨있다.(request 객체에) -->   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품 리스트</title>
<!-- 4. 우리가 만든 라이브러리 등록 --> 	
<style type="text/css">
	.imageDiv{
		background: black;
	}
</style>	
<!-- 2. 라이브러리 등록확인 -->
	<script type="text/javascript">
		$(function(){
			console.log("jquery loading.......");
			
			// 제목과 내용부분의 제일 높은 것을 기준으로 모두 맞추기
			let titleHeights = [];
			
			$(".title").each(function(idx, title){
				console.log($(title).height());
				titleHeights.push($(title).height());
			});
			
			let maxTitleHeight = Math.max.apply(null, titleHeights);
			console.log("maxTitleHeight= " + maxTitleHeight);
			
			$(".title").height(maxTitleHeight);
			
			// 첫번째 이미지로 가로세로를 구하기 (5:4)
			let imgWidth= $(".imageDiv:first").width();
			let imgHeight= $(".imageDiv:first").height();
			console.log("image width= " + imgWidth + ",height= " + imgHeight);
			
			// 가로size는 현재 동일하니 그 기준으로 세로 size를 정해줌
			let height = imgWidth / 5 * 4;
			
			// 전체 imageDiv 높이를 조정
			$(".imageDiv").height(height);
				//$(".imageDiv > img").height(height);
			$(".imageDiv > img").each(function(idx, image){
				if($(image).height() > height){
					let image_width = $(image).width();
					let image_height = $(image).height();
					let width = height / image_height * image_width;
					
					// 이미지 높이를 줄이고
					$(image).height(height);
					// 이미지 너비를 줄임
					$(image).width(width);
				}
			});
			// 이벤트 처리 - 리스트에서 상품을 클릭했을때 
		 	$(".dataRow").click(function(){
		 		// 자료수집 - goods_no
				let goods_no = $(this).find(".goods_no").data("goods_no");
				// alert("goods_no= " + goods_no);
				// 여기선 ""안에 공백이 있어서는 안됨 있으면 그것도 다 불러옴
				location="view.do?goods_no=" + goods_no + "&${pageObject.pageQuery}" + "&${goodsSearchVO.searchQuery}";
			});
			
			
			$("#perPageNum").change(function() {
				$("#searchForm").submit();
			});
			
			// 검색데이터 세팅
			$("#key").val("${(empty pageObject.key)?'t':pageObject.key}");
			$("#perPageNum").val("${(empty pageObject.perPageNum)?'10':pageObject.perPageNum}");  
			
			// 대분류 리스트 변경
			$("#cate_code1").change(function(){
				//alert("대분류 리스트 변경");
				let cate_code1 = $(this).val();
				//alert("cate_code1 = " + cate_code1);
				

				$.ajax({
					type: "get",
					url: "/goods/getCategory.do?cate_code1=" + cate_code1,
					//dataType: "json",
					success: function(result, status, xhr) {
						//alert("중분류 가져오기 성공함수");
						console.log("==== 중분류데이터 ====");
						console.log("result : " + JSON.stringify(result));
						console.log("status : " + status);
						console.log("xhr : " + xhr);

						let str = '<option value="0">==중분류==</option>';
						
						result.forEach(function(item){
							console.log(item.cate_name);
							str += '<option value="' + item.cate_code2 + '">';
							str += item.cate_name + '</option>\n';
						});
						
						console.log(str);
						
						$("#cate_code2").html(str);
					},
					error: function(xhr, status, err) {
						console.log("중분류 가져오기 오류 *************");
						console.log("xhr : " + xhr);
						console.log("status : " + status);
						console.log("err : " + err);
					}
				});			
			});	
			// 대분류 리스트 변경 끝
			
		});
	</script>
</head>
<body>

<div class="container">
	<h1><a href="/index.html" style="color: inherit;"><i class="fa fa-list-alt"></i></a> 상품 리스트</h1>
	<form action="list.do" id="searchForm">
		<input type="hidden" name="page" value="${pageObject.page }">
		<!-- 상품검색 시작 -->
		<div class="row">
			<div class="col-md-12">
				<div class="input-group mb-3">
					<div class="input-group-prepend">
					<select class="form-control" id="cate_code1" name="cate_code1">
					 <option value="0">==대분류==</option>
					 <c:forEach items="${listBig }" var="vo">
					  	<option value="${vo.cate_code1 }"
					  	<c:if test="${goodsSearchVO.cate_code1 == vo.cate_code1 }">
					  		selected
					  	</c:if>
					  	>${vo.cate_name }</option>
					 </c:forEach>
					 </select>
					 <select class="form-control" id="cate_code2" name="cate_code2">
				  	<option value="0">==중분류==</option>
				  	<c:forEach items="${listMid }" var="vo">
				  		<option value="${vo.cate_code2 }"
				  		<c:if test="${goodsSearchVO.cate_code2 == vo.cate_code2 }">
					  		selected
					  	</c:if>
				  		>${vo.cate_name }</option>
				  	</c:forEach>
				  	</select>
				  	</div>
				  	 <input type="text" class="form-control" placeholder="상품명 검색" id="goods_name" name="goods_name" 
				  	 value="${goodsSearchVO.goods_name }">
				  	 <input type="text" class="form-control" placeholder="최저가격입력" id="min_price" name="min_price" 
				  	 value="${goodsSearchVO.min_price }">
				  	 <input type="text" class="form-control" placeholder="최고가격입력" id="max_price" name="max_price" 
				  	 value="${goodsSearchVO.max_price }">
	 				 <div class="input-group-prepend">
					    <button type="submit" class="btn btn-primary" ><i class="fa fa-search"></i></button>
				     </div>
	 			</div>				
			</div>
		</div>
		<!-- 상품검색 끝 -->
		<div class="row">			
			    <div class="col-md-4">
					<div class="input-group mt-3 mb-3">
					  <div class="input-group-prepend">
					    <span class="input-group-text">Rows/Page</span>
					  </div>
					    <select id="perPageNum" name="perPageNum" class="form-control">
					    	<option>4</option>
					    	<option>8</option>
					    	<option>12</option>
					    	<option>16</option>
					    </select>
					 </div>
			    </div> <!-- E class="col-md-4" -->
	    </div> <!-- E class="row" -->
 	</form>
	    <c:if test="${empty list }">
	    	<h4>데이터가 존재하지 않습니다.</h4>
	    </c:if>
	    <c:if test="${!empty list }">
		   	<div class="row">
		   		<!-- 이미지의 list의 데이터가 있는 만큼 표시 -->
		   		<c:forEach items="${list }" var="vo" varStatus="vs">
		   			<!-- 4개를 표시하면 줄바꿈처리를 하기 위한거 -->
		   			<c:if test="${(vs.index != 0) && (vs.index%4==0) }">
		   				${"</div>" }
		   				${"<div class='row'>" }
		   			</c:if>
		   			<!-- 데이터 표시 시작 -->
		   			<div class="col-md-3 dataRow">
				      	<div class="card" style="width:100%">
				      		<div class="imageDiv align-content-center text-center" >
						 	 <img class="card-img-top" src="${vo.image_name }" alt="Card image">
				      		</div>	
				      		 <div class="card-body title">						
							  <p class="card-text">
							  	<div class="goods_no" data-goods_no="${vo.goods_no }">
									상품번호 : ${vo.goods_no }
							  	</div>
							  	<div>
							 	 	상품명 : ${vo.goods_name } 
							  	</div>
							  	<div>
								  	정가 : <fmt:formatNumber value= "${vo.price }" />  원
							  	</div>
							  	<div>
							 	 	할인가 : <fmt:formatNumber value= "${vo.sale_price }" /> 원
							  	</div>
							  	<div>
							  		적립율 : ${vo.saved_rate }
							  	</div>
							  </p>
							</div>
						</div> <!-- E card -->
				     </div>
				     <!-- 데이터 표시 끝 -->
		   		</c:forEach>
		   		<!-- 이미지 데이터 반복 표시 끝 -->	   
			</div>
		  	<div>
		  		<pageNav:pageNav listURI="list.do" pageObject="${pageObject}"></pageNav:pageNav>
		  	</div>
   		 </c:if> <!-- 데이터 존재했을때 처리 끝 -->
  	
<%-- 	<c:if test="${!empty login }"><!-- 로그인이 되어있으면 등록버튼이 보이게 처리 --> --%>
  	<div>
  		<a href="writeForm.do?perPageNum=${pageObject.perPageNum}" class="btn btn-primary">등록</a>
  	</div>
<%-- 	</c:if> --%>
  	
</div>
</body>
</html>