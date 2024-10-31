package org.zerock.sample;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.Setter;


// @Controller, @Service, @Repository, @Component, @RestController, @~Advice 6가지 사용되는데 외우기
@Component
@Data
public class Restaurent {
	
	//자동 DI
	// lombok and Spring : @Setter(onWethod_ = @Autowired)
	// Spring : @Autowired
	// JAVA : @Inject
	@Setter(onMethod_ = @Autowired)
	private Chef chef;

}
