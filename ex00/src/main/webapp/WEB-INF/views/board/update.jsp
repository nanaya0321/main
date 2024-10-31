<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반 게시판 글수정</title>
<jsp:include page="../jsp/webLib.jsp"></jsp:include>
</head>
<body>
<div class="container">
	<h2>일반 게시판 글수정</h2>
	<form action="update.do" method="post">
		<div class="form-group">
			<label for="no">글번호</label>
			<!-- name값은 vo객체의 변수이름과 동일하게 사용한다. -->
			<input class="form-control" name="no" id="no" value="${vo.no }" readonly>
			<!-- readonly를 사용하고 이미 값이 있어서 required를 적용하지 않음(적용해도 상관없음) -->
		</div>
		<div class="form-group">
			<label for="title">제목</label>
			<!-- name값은 vo객체의 변수이름과 동일하게 사용한다. -->
			<input class="form-control" name="title" id="title" value="${vo.title }" required>
		</div>
		<div class="form-group">
			<label for="content">내용</label>
			<!-- name값은 vo객체의 변수이름과 동일하게 사용한다. -->
			<textarea class="form-control" name="content" id="content"
			 rows="7" required>${vo.content }</textarea>
		</div>
		<div class="form-group">
			<label for="writer">작성자</label>
			<!-- name값은 vo객체의 변수이름과 동일하게 사용한다. -->
			<input class="form-control" name="writer" id="writer" value="${vo.writer }" required>
		</div>
		<div class="form-group">
			<label for="pw">비밀번호 확인</label>
			<!-- name값은 vo객체의 변수이름과 동일하게 사용한다. -->
			<input class="form-control" name="pw" id="pw" type="password" required>
		</div>
		<!-- form tag에서 <button>에 type이 없으면 submit -->
		<button class="btn btn-primary">수정완료</button>
		<button type="reset" class="btn btn-warning">새로입력</button>
		<button type="button" class="btn btn-success">취소</button>
	</form>
</div>
</body>
</html>