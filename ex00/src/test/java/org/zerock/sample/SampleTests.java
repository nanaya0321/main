package org.zerock.sample;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

// test에 사용되는 클래스
@RunWith(SpringJUnit4ClassRunner.class)
// 설정 파일 지정하기 -> 서버와 상관이 없음 : root-context.xml
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
// 로그객체생성 -> lombok에서 log 이름으로 처리
@Log4j
public class SampleTests {

	// Restaurent의 자동생성과 DI를 하기위해 객체를 전달함 : 자동DI
	@Setter(onMethod_ = @Autowired) // 어노테이션이 두개이상일때는 {}안에 ,로 구분하여 사용한다. 하나일때는 생략가능해서 이렇게씀
	private Restaurent restaurent;
	
	// junit에서 테스트를 할 때 @Test 붙인것만 테스트 진행한다.
	// 테스트 매서드는 여러개 사용가능하고 @Test 붙은것은 전부 테스트한다.
	@Test
	public void testExist() {
		// not null 확인 메서드
		// not null이 아니면(null이면) 예외발생하면 프로그램이 중단됨
		assertNotNull(restaurent);
		
		// 출력해서 확인하기
		// log4j.xml 에 설정에 따라서
		// info -> info, warn, error 모두 출력
		// warn -> warn, error 일때만 출력
		// error -> error 만 출력
		// log.info(), log.wran(), log.error()
		log.info("---------------------");
		log.info(restaurent);
		log.info(restaurent.getChef());
	}
}
