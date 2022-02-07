package com.example.demo.domain.etc;


import java.lang.reflect.Field;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReserveSearchCriteria extends Criteria{
	private String roomtitle;
	private String name;
	private String phone;
	private String cancelflg;
	private String paymentflg;
	private String deleteflg;
	
	public void emptyToNull() {
		Class<?> thisClass = this.getClass();
		Field[] fields  = thisClass.getDeclaredFields();
		for(Field field : fields) {
			try {
				field.setAccessible(true);
				Class<?> stringType = String.class;
				if(field.getType().isAssignableFrom(stringType)) {// check if field is String or not
					String value = (String) field.get(this);// get field of this (String)
					if(value == null || value.equals("")) {
						field.set(this,null); // set field of this to null
					}
				}
			} catch (IllegalArgumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	}
	//String인 필드가 ""이면  null로 바꿈
	
}