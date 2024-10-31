package org.zerock.member.vo;

import lombok.Data;

@Data
public class LoginVO {

	// member table
	private String id;
	private String pw;
	private String name;
	private String photo;
	private Long newMsgCont;
	private Integer gradeNo;
	// grade table
	private String gradeName; 
}
