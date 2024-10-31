<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<script type="text/javascript">
$(function(){
	// 이벤트 처리
	let now = new Date();
	let startYear = now.getFullYear();
	let yearRange = (startYear - 10) + ":" + (startYear + 10);
	
	// 날짜 입력설정
	$(".datepicker").datepicker({
		// 입력란의 데이터 포맷
		dateFormat : "yy-mm-dd",
		// 월 선택추가
		changeMonth: true,
		// 년 선택 추가
		changeYear: true,
		// 월 선택 입력(기본 영어인데 한글로 변경)
		monthNamesShort: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
		// 달력의 요일 표시 (기본 영어인데 한글로 변경)
		dayNamesMin: ["일","월","화","수","목","금","토"],
		// 선택할 수 있는 년도의 범위
		yearRange : yearRange
	});	
	
	// 생산일은 현재날짜 이전만 입력가능하게 설정
	$("#product_date").datepicker("option", {"maxDate" : new Date()});
	// 판매시작일과 종료일은 현재날짜 이후만 입력가능하게 설정
	$("#sale_start_date, #sale_end_date").datepicker("option", {"minDate" : new Date()});
	// 판매시작일이 판매종료일보다 앞에있도록 설정
	$("#sale_start_date").change(function() {
		$("#sale_end_date").datepicker("option", "minDate", $(this).val());
	});
	// 판매종료일이 판매시작일보다 뒤에있도록 설정
	$("#sale_end_date").change(function() {
		$("#sale_start_date").datepicker("option", "maxDate", $(this).val());
	});
	
	
	
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

				let str = "";
				
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
	// coler 추가 삭제 
	let colorTagCnt =1;
	
	$("#appendColorBtn").click(function() {
		// alert("add color button"); // 확인완료
		
		if(colorTagCnt >= 5) return;
		
		let addColorTag = "";
		addColorTag += '<div class="input-group mb-3">';
		addColorTag +=  	'<input type="text" class="form-control" name="color_names">';
		addColorTag += 	'<div class="input-group-append">';
		addColorTag +=    '<button class="btn btn-danger removeColorBtn" type="button">';
		addColorTag +=    	'<i class="fa fa-close"></i>';
		addColorTag +=    '</button>';
		addColorTag +=  '</div>';
		addColorTag += '</div>';
		
		$(".colorForm").append(addColorTag);
		colorTagCnt++;
	});
	
	$(".colorForm").on("click", ".removeColorBtn", function(){
		//alert("remove coler button");
		$(this).closest(".input-group").remove();
		colorTagCnt--;
	});
	
	
	// size 추가 삭제 
	let sizeTagCnt =1;
	
	$("#appendSizeBtn").click(function() {
		//alert("add size button"); // 확인완료
		
		if(sizeTagCnt >= 5) return;
		
		let addSizeTag = "";
		addSizeTag += '<div class="input-group mb-3">';
		addSizeTag +=  	'<input type="text" class="form-control" name="size_names">';
		addSizeTag += 	'<div class="input-group-append">';
		addSizeTag +=    '<button class="btn btn-danger removeSizeBtn" type="button">';
		addSizeTag +=    	'<i class="fa fa-close"></i>';
		addSizeTag +=    '</button>';
		addSizeTag +=  '</div>';
		addSizeTag += '</div>';
		
		$(".sizeForm").append(addSizeTag);
		sizeTagCnt++;
	});
	
	$(".sizeForm").on("click", ".removeSizeBtn", function(){
		//alert("remove size button");
		$(this).closest(".input-group").remove();
		sizeTagCnt--;
	});
	
	// image 추가 삭제
	let imageTagCnt =1;
	
	$("#appendImageBtn").click(function() {
		//alert("add image button"); // 확인완료
		
		if(imageTagCnt >= 5) return;
		
		let addImageTag = "";
		addImageTag += '<div class="input-group mb-3">';
		addImageTag +=  	'<input type="file" class="form-control" name="imageFiles">';
		addImageTag += 	'<div class="input-group-append">';
		addImageTag +=    '<button class="btn btn-danger removeImageBtn" type="button">';
		addImageTag +=    	'<i class="fa fa-close"></i>';
		addImageTag +=    '</button>';
		addImageTag +=  '</div>';
		addImageTag += '</div>';
		
		$(".imageForm").append(addImageTag);
		imageTagCnt++;
	});
	
	$(".imageForm").on("click", ".removeImageBtn", function(){
		//alert("remove image button");
		$(this).closest(".input-group").remove();
		imageTagCnt--;
	});
});


</script>
</head>
<body>
<div class="container">
	<div class="card">
  		<div class="card-header"><h3>상품 등록</h3></div>
  		<form action="write.do" method="post" enctype="multipart/form-data">
	  		<div class="card-body">
	  		<!-- 대분류, 중분류, java 구현 후 작성할 예정 -->			
	  			<div class="form-group">
				  <label for="cate_code1">대분류</label>
				  <select class="form-control" id="cate_code1" name="cate_code1">
				  <c:forEach items="${listBig }" var="vo">
				  	<option value="${vo.cate_code1 }">${vo.cate_name }</option>
				  </c:forEach>
				  </select>
				</div>
	  			<div class="form-group">
				  <label for="cate_code2">중분류</label>
				  <select class="form-control" id="cate_code2" name="cate_code2">
				  <c:forEach items="${listMid }" var="vo">
				  	<option value="${vo.cate_code2 }">${vo.cate_name }</option>
				  </c:forEach>
				  </select>
				</div>
	  			
				<div class="form-group">
					<label for="goods_name">상품명</label>
					<input class="form-control" id="goods_name" name="goods_name" required>
				</div>
				<div class="form-group">
					<!-- 파일로 넘어가는 데이터는 GoodsVO객체의 이름과 다른이름을 사용해야한다. -->
					<label for="imageMain">대표이미지</label>
					<input type="file" class="form-control" id="imageMain" name="imageMain" required>
				</div>
				<div class="form-group">
					<label for="content">상품설명</label>
					<textarea rows="10" class="form-control" id="content" name="content"></textarea>
				</div>
				<div class="form-group">
					<label for="company">제조사</label>
					<input class="form-control" id="company" name="company" required>
				</div>
				<div class="form-group">
					<label for="product_date">생산일</label>
					<input class="form-control datepicker" id="product_date" name="product_date" readonly>
				</div>
				<div class="form-group">
					<label for="price">정가</label>
					<input class="form-control" id="price" name="price" required>
				</div>
				<div class="form-group">
					<label for="discount">할인금액</label>
					<input class="form-control" id="discount" name="discount" value="0">
				</div>
				<div class="form-group">
					<label for="discount_rate">할인율</label>
					<input class="form-control" id="discount_rate" name="discount_rate" value="0">
				</div>
				<div class="form-group">
					<label for="saved_rate">적립률</label>
					<input class="form-control" id="saved_rate" name="saved_rate" value="0">
				</div>
				<div class="form-group">
					<label for="delivery_charge">배송료</label>
					<input class="form-control" id="delivery_charge" name="delivery_charge" value="0">
				</div>
				<div class="form-group">
					<label for="sale_start_date">판매시작일</label>
					<input class="form-control datepicker" id="sale_start_date" name="sale_start_date" readonly required>
				</div>
				<div class="form-group">
					<label for="sale_end_date">판매종료일</label>
					<input class="form-control datepicker" id="sale_end_date" name="sale_end_date" readonly required>
				</div>
				<fieldset class="border p-4">
					<legend class="w-auto px-2">
						<b style="font-size: 14px">[Option]</b>
					</legend>
				<fieldset class="border p-4 colorForm">
					<legend class="w-auto px-2">
						<b style="font-size: 14px">[Color]</b>
						<button class="btn btn-primary btn-sm" id="appendColorBtn" type="button">
							addColor
						</button>
					</legend>
					<div class="input-group mb-3">
					  <input type="text" class="form-control" name="color_names">				
					</div>
				</fieldset>
				<fieldset class="border p-4 sizeForm">
					<legend class="w-auto px-2">
						<b style="font-size: 14px">[size]</b>
						<button class="btn btn-primary btn-sm" id="appendSizeBtn" type="button">
							addSize
						</button>
					</legend>					
					<div class="input-group mb-3">
					  <input type="text" class="form-control" name="size_names">				
					</div>
				</fieldset>
				</fieldset>
				<fieldset class="border p-4 imageForm">
					<legend class="w-auto px-2">
						<b style="font-size: 14px">[추가이미지]</b>
						<button class="btn btn-primary btn-sm" id="appendImageBtn" type="button">
							addImage
						</button>
					</legend>
					<div class="input-group mb-3">
					  <input type="file" class="form-control" name="imageFiles">				
					</div>
				</fieldset>								
			</div>
	  		<div class="card-footer">
	  			<button class="btn btn-primary">등록</button>
			</div>
  		</form>
	</div>
</div>
</body>
</html>