package com.example.demo.domain.base;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter//entity에는 setter를 만들지 않고 값 변경이 필요한 상황에 필요한 메소드를 추가한다
@NoArgsConstructor
@MappedSuperclass
public abstract class BuildingEntity extends BaseEntity{
	@Column(length = 1,nullable = false)
	private String buildcd;
	
	public BuildingEntity(String deleteFlg,String buildcd) {
		super(deleteFlg);
		this.buildcd = buildcd;
	}
}
