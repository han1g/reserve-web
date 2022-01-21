package com.example.demo.domain.roominfo;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.example.demo.domain.base.BuildingDTO;
import com.example.demo.domain.base.BuildingEntity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;



@Data
public class RoominfoDTO extends BuildingDTO {
	
    private Long no;
    //성능문제, 구현이 복잡해지므로 pk는 웬만하면 Long 타입의 auto-increment로 해놓고 unique키를 추가하는 것을 추천함

    private String roomnum;
    
    private String roomtitle;
    
    private String explanation;
    
    private String maxpeople;

    private Long adultcost;
    
    private Long childcost;
    
    private String images;
    
    private String colorcd;
    
    public List<String> getImagesList() {
    	if(images == null)
    		return null;
    	StringTokenizer tok = new StringTokenizer(images, ";");
    	List<String> ret = new ArrayList<String>();
    	while(tok.hasMoreTokens()) {
    		ret.add(tok.nextToken());
    	}
    	return ret;
    } //readonly
    
    public String getThumb() {
		return images == null ? "/resources/img/logo_icon.png" : new StringTokenizer(images, ";").nextToken();
    } //readonly

    @Builder
    public RoominfoDTO(Long no,String deleteFlg, String buildcd,Date createdAt,Date updatedAt, String roomnum, String roomtitle, String explanation,
			String maxpeople, Long adultcost,Long childcost, String images, String colorcd) {
		super(deleteFlg,createdAt,updatedAt, buildcd);
		this.no = no;
		this.roomnum = roomnum;
		this.roomtitle = roomtitle;
		this.explanation = explanation;
		this.maxpeople = maxpeople;
		this.adultcost = adultcost;
		this.childcost = childcost;
		this.images = images;
		this.colorcd = colorcd;
	}
    
    

}
