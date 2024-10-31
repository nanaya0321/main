<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="row" style="margin : 40px -15px 0 -15px">
	<div class="col-lg-12">
		<!-- card -->
		<div class="card">
			<!-- 댓글 제목 -->
			<div class="card-header" style="background: #e0e0e0">
				<i class="fa fa-comments fa-fw"></i> 댓글
				<!-- Button to Open the Modal -->
				<button type="button" class="btn btn-primary btn-sm pull-right" data-toggle="modal" data-target="#replyModal" id="newReplyBtn">
			    	새로운 댓글
				</button>
			</div>
			
			<!-- 댓글 리스트 데이터 출력 -->
			<div class="card-body">
				<ul class="chat">
					<!-- 데이터 한개당 li 태그를 만든다. for 또는 foreach 사용해야함 -->
					<!-- 하드코딩 -->
					<li class="left clearfix" data-rno="1">
						<div>
							<div class="header">
								<strong class="primary-font">홍길동(test1)</strong>
								<small class="pull-right text-muted">2024-01-01</small>
							</div>
							<p><pre>Good job!!</pre></p>
						</div>
					</li>
				</ul>
			</div> <!-- card-body -->
			<div class="card-footer">
				<ul class="pagination pagination-sm">
				  <li class="page-item"><a class="page-link" href="#">Previous</a></li>
				  <li class="page-item"><a class="page-link" href="#">1</a></li>
				  <li class="page-item"><a class="page-link" href="#">2</a></li>
				  <li class="page-item"><a class="page-link" href="#">3</a></li>
				  <li class="page-item"><a class="page-link" href="#">Next</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>

<!-- The Modal -->
	<!-- id와 Modal여는 버튼의 data-target의 이름을 같게 해야합니다. -->
  <div class="modal fade" id="replyModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">댓글 등록</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        	<input type="hidden" id="replyRno"> <!-- 댓글 수정에 사용하기 위해 rno 보관 -->
          <textarea rows="4" class="form-control" id="replyContent"></textarea>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
        	<button class="btn btn-primary" id="replyWriteBtn">등록</button>
        	<button class="btn btn-success" id="replyUpdateBtn">수정</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        </div>
        
      </div>
    </div>
  </div>