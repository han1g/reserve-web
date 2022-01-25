package com.example.demo.domain.etc;

import java.lang.reflect.Field;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RoomSearchCriteria extends Criteria{
	private Long maxpeople_min;
	private Long adultcost_min;
	private Long childcost_min;
	
	private Long maxpeople_max;
	private Long adultcost_max;
	private Long childcost_max;
	
	public RoomSearchCriteria() {
		super();
		maxpeople_min = 0L;
		adultcost_min = 0L;
		childcost_min = 0L;
		
		maxpeople_max = 100L;
		adultcost_max = 100000L;
		childcost_max = 100000L;
	}
	
	
	@Override
	public String getListLink() {
		String ret = super.getListLink();
		Criteria suber = new Criteria();
		suber.setAmount(getAmount());
		suber.setKeyword(getKeyword());
		suber.setPageNum(getPageNum());
		suber.setType(getType());
	
		Class<? extends Criteria> superClass = suber.getClass();
		Field[] fields  = superClass.getDeclaredFields();
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("");
		for(Field field : fields) {
			try {
				field.setAccessible(true);
				builder.queryParam(field.getName(), field.get(this));
			} catch (IllegalArgumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		return ret + builder.toUriString().replace('?', '&');
	}
}
