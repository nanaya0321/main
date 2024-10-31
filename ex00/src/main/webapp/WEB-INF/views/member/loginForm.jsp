<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 폼</title>
</head>
<body>
<div class="container">
	<h3>로그인 폼</h3>
	<form action="login.do" method="post">
		<div class="form-group">
			<label for="id">ID</label>
			<input type="text" class="form-control" name="id" id="id" placeholder="ID입력" required>
		</div>
		<div class="form-group">
			<label for="pw">Password</label>
			<input type="password" class="form-control" name="pw" id="pw" placeholder="password 입력" required>
		</div>
		<button class="btn btn-primary">로그인</button>
	</form>
</div>
</body>
</html>