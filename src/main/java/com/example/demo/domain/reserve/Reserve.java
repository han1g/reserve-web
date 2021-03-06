package com.example.demo.domain.reserve;

import java.sql.Date;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.example.demo.domain.base.BuildingEntity;
import com.example.demo.domain.roominfo.Roominfo;
import com.example.demo.domain.roominfo.RoominfoDTO;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;


@DynamicInsert//null인 경우 삽입할 때 insert문에서 빼버림
@DynamicUpdate//null인 경우 업데이트할 때 update문에서 빼버림
@Getter//entity에는 setter를 만들지 않고 값 변경이 필요한 상황에 필요한 메소드를 추가한다
@NoArgsConstructor
@Entity//jpa annotation DB의 테이블로 매핑됨
public class Reserve extends BuildingEntity{
    @Id// 이 필드가 pk임을 나타냄
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "RESERVE_SEQ_GENERATOR") //pk 생성 규칙 (identity -> auto increment)
    @SequenceGenerator(sequenceName = "RESERVE_SEQ", name = "RESERVE_SEQ_GENERATOR", allocationSize = 1)
    private Long no;
    //성능문제, 구현이 복잡해지므로 pk는 웬만하면 Long 타입의 auto-increment로 해놓고 unique키를 추가하는 것을 추천함

    @Column(nullable = false)
    private Long roomno;
    
    @ManyToOne
    @NotFound(action = NotFoundAction.IGNORE)//연결된 roominfo가 존재하지 않을경우 null
    @JoinColumn(name="roomno",insertable = false,updatable = false)
    private Roominfo roominfo;
    
    @Column(length = 20,nullable = false)
    private String name;
    
    @Column(length = 11,nullable = false)
    private String phone;
    
    @Column(length = 1,nullable = false)
    private String adult;
    
    @Column(length = 1,nullable = false)
    private String child;
    
    @Column(length = 10,nullable = false)
    private String startdate;
    
    @Column(length = 10,nullable = false)
    private String enddate;
    
    @Column(length = 20,nullable = true)
    private String options;
    
    @Column(length = 1,nullable = true)
    private String paymentflg;
    
    @Column(nullable = false)
    private Long totalcost;
    
    @Column(length = 1,nullable = true)
    private String cancelflg;
    
    @Column(length = 100,nullable = true)
    private String bankname;
    
    @Column(length = 3,nullable = true)
    private String bankbranchcd;
    
    @Column(length = 1,nullable = true)
    private String bankno;
    
    @Builder
	public Reserve(String deleteFlg, String buildcd,Long roomno, String name, String phone,
			String adult, String child, String startdate, String enddate, String options, String paymentflg,
			Long totalcost, String cancelflg, String bankname, String bankbranchcd, String bankno) {
		super(deleteFlg, buildcd);
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
    
    public ReserveDTO toDTO() {
		return new ReserveDTO(getDeleteflg(), "4",
    			new Date(Timestamp.valueOf(getCreatedat()).getTime()),
    			new Date(Timestamp.valueOf(getUpdatedat()).getTime()),
				no,roomno,roominfo, name, phone, adult, child, startdate, enddate, options, paymentflg, totalcost, cancelflg, bankname, bankbranchcd, bankno);
    	
    }
    
    public void update(ReserveDTO dto) {

    	this.bankname = dto.getBankname();
		this.bankbranchcd = dto.getBankbranchcd();
		this.bankno = dto.getBankno();
		
    	this.name = dto.getName();
		this.roomno = dto.getRoomno();
		this.phone = dto.getPhone();
		this.adult = dto.getAdult();
		this.child = dto.getChild();
		this.startdate = dto.getStartdate();
		this.enddate = dto.getEnddate();
		this.options = dto.getOptions();
		this.paymentflg = dto.getPaymentflg();
		this.totalcost = dto.getTotalcost();
		this.cancelflg = dto.getCancelflg();
		
    }
    public void cancel() {
    	this.cancelflg = "1";
    	this.paymentflg = "0";
    }
    public void revertCancel() {
    	this.cancelflg ="0";
    	this.restore();
    }
    
    @Override
    public void delete() {
    	super.delete();
    	cancel();
    }
    
    
    
 }
