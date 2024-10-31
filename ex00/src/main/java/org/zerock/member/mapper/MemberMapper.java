package org.zerock.member.mapper;

import org.springframework.stereotype.Repository;
import org.zerock.member.vo.LoginVO;

@Repository
public interface MemberMapper {

	//login
	public LoginVO login(LoginVO vo);
}
