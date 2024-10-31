<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 리스트</title>
<jsp:include page="../jsp/webLib.jsp"></jsp:include>
<style type="text/css">
.dataRow>.card-header{
	background: #e0e0e0;
}
.dataRow:hover{
	border-color: orange;
	cursor: pointer;
}
</style>
<script type="text/javascript">
$(function() {
	// jquery 이벤트 코드는 이안에 작성한다.
	$(".dataRow").click(function() {
		// tag에 적힌 data-no="${vo.no}"
		let no = $(this).data("no");
// 		alert(no);
		location = "view.do?no=" + no + "&inc=1"
				+ "&${pageObject.pageQuery}";
				// pageObject의 getPageQuery()를 가져와서 page, perPageNum, key, word를 붙인다.
	});
	
	// perPageNum 값이 변경되었을때 이벤트 처리
	$("#perPageNum").change(function() {
		//alert("change perPageNum");
		$("#searchForm").submit();
	});
	
	// 검색 데이터 세팅
	// key 값이 없으면 제목으로 세팅
	$("#key").val('${(empty pageObject.key)?"t":pageObject.key }');
	// perPageNum 세팅
	// perPageNum 이 없으면 기본값은 10으로 세팅
	$("#perPageNum").val('${(empty pageObject.perPageNum)?"10":pageObject.perPageNum}');
	
});
</script>
</head>
<body>
	<div class="container">
		<div class="card">
		    <div class="card-header"><h3>공지사항 리스트</h3></div>
		    <div class="card-body">
		    	<!-- 검색창 및 perPageNum 설정창 -->
		    	<form action="list.do" id="searchForm">
		    		<input type="hidden" name="page" value="1"> <!-- 초기값세팅 -->
					<div class="row">
						<div class="col-md-8">
								<div class="input-group mt-3 mb-3">
							      <div class="input-group-prepend">
							        <select class="form-control" id="key" name="key">
								        <option value="t">제목</option>
								        <option value="c">내용</option>
								        <option value="tc">제목/내용</option>
							   	 	</select>
							      </div>
							      <input type="text" class="form-control" placeholder="검색어 입력" id="word" name="word" value="${pageObject.word }">
							      <div class="input-group-prepend">
								    <button type="submit" class="btn btn-primary" ><i class="fa fa-search"></i></button>
							      </div>
							    </div>
						    </div> <!-- E class="col-md-8" -->
						    <div class="col-md-4">
								<div class="input-group mt-3 mb-3">
								  <div class="input-group-prepend">
								    <span class="input-group-text">Rows/Page</span>
								  </div>
								    <select id="perPageNum" name="perPageNum" class="form-control">
								    	<option>5</option>
								    	<option>10</option>
								    	<option>15</option>
								    	<option>20</option>
								    	<option>25</option>
								    </select>
								  </div>
						    </div> <!-- E class="col-md-4" -->
				    </div> <!-- E class="row" -->
		    	</form>
		    	
		    	<!-- 공지사항 리스트 데이터 -->
		    	<c:forEach items="${list }" var="vo">
			    	<div class="card dataRow" data-no="${vo.no }">
					    <div class="card-header">
					    	${vo.no }. ${vo.title }
					    </div>
					    <div class="card-body">
					    	<span class="float-right">
					    		게시종료일: <fmt:formatDate value="${vo.endDate }" pattern="yyyy-MM-dd"/>
					    	</span>
					    	<span>
					    		게시시작일: <fmt:formatDate value="${vo.startDate }" pattern="yyyy-MM-dd"/>
					    	</span>
					    </div>  
				  	</div>	
		    	</c:forEach>
		    </div> 
		    <div class="card-footer">
		    	<div>
		    		<pageNav:pageNav listURI="list.do" pageObject="${pageObject }"></pageNav:pageNav>
		    	</div>
		    	<a href="writeForm.do" class="btn btn-primary">글등록</a>
		    </div>
		</div>
	</div>
</body>
</html>