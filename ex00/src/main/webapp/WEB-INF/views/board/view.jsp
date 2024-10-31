<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반 게시판 글보기</title>
<jsp:include page="../jsp/webLib.jsp"></jsp:include>
<style type="text/css">
.dataRow>.card-header{
	background: #e0e0e0;
}
</style>

<!-- 1. 필요한 전역변후 선언: 직접코딩함 -->
<script type="text/javascript">
// 보고있는 일반게시판 글번호
let id = "test1"; // 일시 id 하드코딩 - member table에 등록된 id중에 있는것중 로그인 id
let no = ${vo.no};
let replyPage = 1; // 댓글의 현재페이지
console.log("전역변수 no: " + no);
</script>

<!-- 2. 날짜 및 시간 처리함수 선언 -->
<script type="text/javascript" src="/js/dateTime.js"></script>

<!-- 댓글 페이지네이션 함수 선언 -->
<script type="text/javascript" src="/js/util.js"></script>

<!-- 3. 댓글 객체 (replyService)를 선언: Ajax 처리부분 포함 -->
<!-- 댓글 처리하는 모든 곳에 사용하는 부분을 코딩하는데 사용 -->
<script type="text/javascript" src="/js/reply.js"></script>

<script type="text/javascript">
// replyService.list(1, 10);
// replyService.list(1); // 일반게시판 글번호는 전역변수로 처리
// replyService.list(); 
</script>
<!-- 4. 댓글객체(reply.js에서 선언한 replyService)를 호출하여 처리 + 이벤트처리 -->
<!-- 일반게시판 댓글에 사용되는 부분을 코딩하는데 사용 -->
<script type="text/javascript" src="/js/replyProcess.js"></script>

<script type="text/javascript">
$(function() {
	// 글수정(id="updateBtn") 버튼을 클릭했을때 
	$("#updateBtn").click(function(){
		location = "updateForm.do?no=${vo.no}";
	});
	// 글삭제(id="deleteBtn") 버튼을 클릭했을때 모달창의 pw내용을 지우기
	$("#deleteBtn").click(function(){
		$("#pw").val("");
	});
	// 리스트(id="listBtn") 버튼을 클릭했을때 
/*	$("#listBtn").click(function(){
		if (document.referrer) {
	        location = document.referrer; // 이전 페이지로 리다이렉트
	    } else {
	        location = "list.do"; // 기본 페이지로 리다이렉트
	    }
	});*/
	// 리스트(id="listBtn") 버튼을 클릭했을때 두번째 방법
	// param. 으로 되어있는 값은 url에서 같이 넘어온 값(적혀있는값) - get
	$("#listBtn").click(function(){
		location = "list.do?page=${param.page}" + "&perPageNum=${param.perPageNum}" + "&key=${param.key}"
		+ "&word=${param.word}";
	});
});
</script>
</head>
<body>
	<div class="container">
	  <div class="card">
	    <div class="card-header"><h3>일반 게시판 글보기</h3></div>
	    <div class="card-body">
	     <div class="card dataRow" data-no="${vo.no }">
		    <div class="card-header">
		    	<span class="float-right">조회수 : ${vo.hit }</span>
		    	${vo.no }. ${vo.title }
		    </div>
		    <div class="card-body">
		    	<pre>${vo.content }</pre>
		    </div> 
		    <div class="card-footer">
		    	<span class="float-right">
		    	<fmt:formatDate value="${vo.writeDate }" pattern="yyyy-MM-dd"/>
		    	</span>
		    	${vo.writer }
		    </div>
		  </div>	
	    </div> 
	    <div class="card-footer">
	    	<button class="btn btn-primary" id="updateBtn">수정</button>
	    	<button class="btn btn-danger" id="deleteBtn" data-toggle="modal" data-target="#deleteModal">삭제</button>
	    	<button class="btn btn-success" id="listBtn">목록</button>
	    </div>
	  </div>
	  <!-- 글보기 card가 끝나는 지점 -->
	  
	  <div>
	  	<jsp:include page="boardreply.jsp"></jsp:include>
	  </div>
	  
	  <!-- The Modal -->
	  <div class="modal fade" id="deleteModal">
	    <div class="modal-dialog modal-dialog-centered">
	      <div class="modal-content">
	      
	        <!-- Modal Header -->
	        <div class="modal-header">
	          <h4 class="modal-title">비밀번호 입력 모달창</h4>
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        <!-- delete.do 로 이동시 no, pw 가 필요함 -->
	        <!-- no: hidden으로, pw: 사용자입력으로 세팅 -->
	        <form action="delete.do" method="post">
	        	<input type="hidden" name="no" value="${vo.no }">
		        <!-- Modal body -->
		        <div class="modal-body">
		          <div class="form-group">
		          	<input class="form-control" type="password" name="pw" id="pw">
		          </div>
		        </div>
		        
		        <!-- Modal footer -->
		        <div class="modal-footer">
		          <button class="btn btn-danger">삭제</button>
		          <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
		        </div>
	        </form>	        
	      </div>
	    </div>
	  </div>
	  
	</div>
</body>
</html>