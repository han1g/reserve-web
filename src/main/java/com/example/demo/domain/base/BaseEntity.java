package com.example.demo.domain.base;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;

import lombok.Getter;
import lombok.NoArgsConstructor;



@Getter//entity에는 setter를 만들지 않고 값 변경이 필요한 상황에 필요한 메소드를 추가한다
@NoArgsConstructor
@MappedSuperclass
public abstract class BaseEntity {
	
    @Column(length = 1, nullable = true)
    private String deleteflg;
    
    @Column(nullable = true)
    private LocalDateTime createdat;
    @Column(nullable = true)
    private LocalDateTime updatedat;
    //column annotation이 없어도 컬럼이 되지만 기본 설정만 사용가능하다.
    
    
    public BaseEntity(String deleteflg) {
		this.deleteflg = deleteflg;
	}
    
    public void delete() {
    	deleteflg = "1";
    }
    public void restore() {
    	deleteflg = "0";
    }

	@PrePersist
    public void createdAt() {
        this.createdat = LocalDateTime.now();
        this.updatedat = LocalDateTime.now();
    }
    
    @PreUpdate
    public void updatedAt() {
        this.updatedat = LocalDateTime.now();
    }
}