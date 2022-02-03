package com.example.demo.domain.reserve;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;

import com.example.demo.domain.base.BuildingDTO;
import com.example.demo.domain.reserve.Reserve.ReserveBuilder;
import com.example.demo.domain.roominfo.Roominfo;

import lombok.Builder;
import lombok.Data;

@Data
public class ReserveDTO extends BuildingDTO{
	    private Long no;

	    private Long roomno;
	    
	    private Roominfo roominfo;
	    
	    private String name;
	    
	    private String phone;
	    
	    private String adult;

	    private String child;
	    
	    private String startdate;
	    
	    private String enddate;
	    
	    private String options;
	    
	    private String paymentflg;

	    private Long totalcost;
	    
	    private String cancelflg;
	    
	    private String bankname;
	    
	    private String bankbranchcd;
	    
	    private String bankno;
	    
	    @Builder
		public ReserveDTO(String deleteFlg, String buildcd,Date createdAt,Date updatedAt, Long roomno, String name, String phone,
				String adult, String child, String startdate, String enddate, String options, String paymentflg,
				Long totalcost, String cancelflg, String bankname, String bankbranchcd, String bankno) {
	    	
			super(deleteFlg,createdAt,updatedAt, buildcd);
			this.name = name;
			this.roomno = roomno;
			this.phone = phone;
			this.adult = adult;
			this.child = child;
			this.startdate = startdate;
			this.enddate = enddate;
			this.options = options;
			this.paymentflg = paymentflg;
			this.totalcost = totalcost;
			this.cancelflg = cancelflg;
			this.bankname = bankname;
			this.bankbranchcd = bankbranchcd;
			this.bankno = bankno;
		}
	
}
