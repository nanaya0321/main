<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 글수정</title>
<jsp:include page="../jsp/webLib.jsp"></jsp:include>

<script type="text/javascript">
$(function() {
	
	// 리스트(id="listBtn") 버튼을 클릭했을때 
	$("#listBtn").click(function(){
		if (document.referrer) {
	        location = document.referrer; // 이전 페이지로 리다이렉트
	    } else {
	        location = "list.do"; // 기본 페이지로 리다이렉트
	    }
	});
	
});
</script>

<script type="text/javascript">
$(function() {
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
	
});

</script>
</head>
<body>
<div class="container">
	<h2>공지사항 글수정</h2>
	<form action="update.do" method="post">
		<div class="form-group">
			<label for="no">글번호</label>
			<!-- name값은 vo객체의 변수이름과 동일하게 사용한다. -->
			<input class="form-control" value="${vo.no}" name="no" id="no" readonly>
		</div>
		<div class="form-group">
			<label for="title">제목</label>
			<!-- name값은 vo객체의 변수이름과 동일하게 사용한다. -->
			<input class="form-control" value="${vo.title}" name="title" id="title" required autocomplete="off">
		</div>
		<div class="form-group">
			<label for="content">내용</label>
			<!-- name값은 vo객체의 변수이름과 동일하게 사용한다. -->
			<textarea class="form-control" name="content" id="content"
			 rows="7" required>${vo.content}</textarea>
		</div>
		<div class="form-group">
			<label for="startDate">게시시작일</label>
			<!-- name값은 vo객체의 변수이름과 동일하게 사용한다. -->
			<input class="form-control datepicker" value="${vo.startDate}" name="startDate" id="startDate" required autocomplete="off">
		</div>
		<div class="form-group">
			<label for="endDate">게시종료일</label>
			<!-- name값은 vo객체의 변수이름과 동일하게 사용한다. -->
			<input class="form-control datepicker" value="${vo.endDate}" name="endDate" id="endDate" required autocomplete="off">
		</div>
		<!-- form tag에서 <button>에 type이 없으면 submit -->
		<button class="btn btn-primary">수정</button>
		<button type="reset" class="btn btn-warning">새로입력</button>
		<button type="button" class="btn btn-success" id="listBtn">취소</button>
	</form>
</div>
</body>
</html>