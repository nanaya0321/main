package org.zerock.boardreply.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BoardReplyVO {

	private Long rno; // 댓글의 글번호 
	private Long no; // 일반게시판 글번호
	private String content; // 댓글 내용
	private String id; // 글작성자 id
	private String name; // 글작성자 이름
	private Date writeDate; // 댓글작성일
}
