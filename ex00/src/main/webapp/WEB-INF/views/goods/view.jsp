<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 정보</title>
<style type="text/css">
	#smallImageDiv img{
		width: 80px;
		height: 80px;
	}
	#smallImageDiv img:hover {
		opacity: 70%;
		cursor: pointer;
	}
	#goodsDetailDiv> div{
		padding: 10px;
		border-bottom: 1px solid #777;
	}	
</style>
<script type="text/javascript">
$(function(){
	$("#smallImageDiv img").click(function(){
// 		alert("이미지 클릭"); // 확인완료
		$("#bigImageDiv img").attr("src", $(this).attr("src"));		
	});
	
	$("#listBtn").click(function(){
// 		alert("리스트 클릭"); // 확인완료
		location="list.do?page=${param.page}" + "&perPageNum=${param.perPageNum}" + "&${goodsSearchVO.searchQuery}";
	});
	$("#updateBtn").click(function() {
// 		alert("수정 클릭"); // 확인완료
		location="updateForm.do?goods_no=${vo.goods_no}&page=${param.page}" + "&perPageNum=${param.perPageNum}" + "&${goodsSearchVO.searchQuery}";
	});
});
</script>
</head>
<body>
<div class="container">
	<div class="card">
  		<div class="card-header"><h3>상품 정보</h3></div>
  		<div class="card-body">
			<div class="row">
				<div class="col-md-6">
					<div id="smallImageDiv" >
						<c:if test="${!empty imageList }">
							<c:forEach items="${imageList }" var="imageVO">
								<img src="${imageVO.image_name }" class="img-thumbnail">									
							</c:forEach>
						</c:if>
					</div>
					<div id="bigImageDiv" class="img-thumbnail">
						<img src="${vo.image_name }" style= "width: 100%;">
					</div>
				</div>
				<div class="col-md-6" id="goodsDetailDiv">							
					<div><i class="fa fa-caret-right"></i>분류명 : ${vo.cate_name }</div>
					<div><i class="fa fa-caret-right"></i>상품 번호 : ${vo.goods_no }</div>
					<div><i class="fa fa-caret-right"></i>상품명 : ${vo.goods_name }</div>
					<div><i class="fa fa-caret-right"></i>정가 : ${vo.price }</div>
					<div><i class="fa fa-caret-right"></i>할인가 : ${vo.sale_price }</div>
					<div><i class="fa fa-caret-right"></i>배송료 : ${vo.delivery_charge }</div>
					<div><i class="fa fa-caret-right"></i>적립률 : ${vo.saved_rate }</div>
					
					<div class="input-group mb-3">
					    <div class="input-group-prepend">
					      <span class="input-group-text">사이즈</span>
					  <select class="form-control" id="size_name">
					    <option>== 사이즈 선택 ==</option>
					    <c:forEach items="${sizeList }" var="sizeVO">
						    <option>${sizeVO.size_name }</option>
					    </c:forEach>
					  </select>					    
					    </div>
					</div>
					<div class="input-group mb-3">
					    <div class="input-group-prepend">
					      <span class="input-group-text">색상</span>
						  <select class="form-control" id="color_name">
						    <option>== 색상 선택 ==</option>
						    <c:forEach items="${colorList }" var="colorVO">
							    <option>${colorVO.color_name }</option>
						    </c:forEach>
						  </select>				    
					    </div>
					</div>														
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<pre>${vo.content }</pre>
				</div>			
			</div>
		</div>
  		<div class="card-footer">
			<button class="btn btn-primary" id="listBtn">리스트</button>
			<button class="btn btn-success" id="updateBtn">수정</button>
		</div>
	</div>
</div>
</body>
</html>