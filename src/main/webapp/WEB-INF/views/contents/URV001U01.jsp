<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/lib/summernote-0.8.18-dist/summernote-lite.css">
<script src="/resources/lib/summernote-0.8.18-dist/summernote-lite.js"></script>
<title>Home</title>
</head>
	<body>
		<article>
			<div class="container" role="main">
				<div class="h2">
					<h2 class="write-h2">예약 수정</h2>
				</div>
				<div class="background-white">
					<form action="/reserve/register" name="form" id="form" role="form" method="post">
						<jsp:include page="/WEB-INF/views/includes/commons/criteria.jsp"/>
						<input type="hidden" name="roomno" id="roomno" value="${param.roomno}">
						<div class="mb-3">
							<label for="name">Name.</label> 
							<input type="text"
								class="form-control required" name="name" id="name"
								placeholder="예약자 성명을 입력해 주세요" required>
						</div>
						<div class="mb-3">
							<label for="phone">Phone Number.</label> 
							<input type="text"
								class="form-control required" name="phone" id="phone"
								placeholder="전화번호를 입력해 주세요( '-' 제외)" required>
						</div>
						<div class="mb-3">
							<label for="adult">Adult.</label>
							<div class="input-group w-25"> 
								<input type="number"
									class="form-control w-25 required" name="adult" id="adult" min="0" value="" max="9"
									placeholder="어른 인원 수를 입력해주세요" required onchange="updateCost()">
								<span class="input-group-text">人</span>
							</div>
						</div>
						<div class="mb-3">
							<label for="child">Child.</label> 
							<div class="input-group w-25"> 
								<input type="number"
									class="form-control required" name="child" id="child" min="0"  value="" max="9"
									placeholder="아동 인원 수를 입력해주세요" required onchange="updateCost()">
								<span class="input-group-text">人</span>
							</div>
						</div>
						
						<div class="mb-3">
							<label for="child">Date.</label> 
							<div class="input-group w-50"> 
								<input type="text"
									class="form-control required" name="startdate" id="startdate"
									placeholder="" readonly="readonly">
								<span class="input-group-text">~</span>
								<input type="text"
									class="form-control required" name="enddate" id="enddate"
									placeholder="" readonly="readonly">
							</div>
						</div>
						<script type="text/javascript">
						//script for datepicker
						  $( function() {
						    var dateFormat = "yy-mm-dd",
						      from = $( "#startdate" )
						        .datepicker({
						          dateFormat : "yy-mm-dd",
						          minDate: 0,
						          maxDate: "+3Y",
						          defaultDate: "+1w",
						          changeMonth: true,
						          changeYear: true,
						          showOn: "both",
						          buttonImage: "/resources/img/calendar.png",
						          buttonImageOnly: true,
						          buttonText: "Select date"
						        })
						        .on( "change", function() {
						          console.log("from change " + getDate( this ) );
						          to.datepicker( "option", "minDate", getDate( this ) );
						          updateCost();
						        }),
						      to = $( "#enddate" ).datepicker({
						    	  dateFormat : "yy-mm-dd",
						    	  minDate: 0,
						          maxDate: "+3Y",
						        defaultDate: "+1w",
						        changeMonth: true,
						        changeYear: true,
						        showOn: "both",
						          buttonImage: "/resources/img/calendar.png",
						          buttonImageOnly: true,
						          buttonText: "Select date"
						      })
						      .on( "change", function() {
						    	  console.log("to change");
						        from.datepicker( "option", "maxDate", getDate( this ) );
						        updateCost();
						      });
						 
						    function getDate( element ) {
						      var date;
						      try {
						        date = $.datepicker.parseDate( dateFormat, element.value );
						      } catch( error ) {
						        date = null;
						      }
						 
						      return date;
						    }
						  } );
						</script>
						
						<div class="mb-3">
							<div class="card">
							  <div class="card-header">
							    	결제 메뉴.
							  </div>
							  <div class="card-body">
								<div class="mb-3">
									<label for="bankbranchcd">Bank.</label> 
									<div class="input-group w-25">
										<input type="hidden" class="required" name="bankname" id="bankname" value="">
										<select name="bankbranchcd" id="bankbranchcd" class="form-select" aria-label="Default select example">
										  <option value="" selected>은행 선택</option>
										  <option value="001">한국은행</option>
										  <option value="002">산업은행</option>
										  <option value="003">기업은행</option>
										  <option value="004">국민은행</option>
										  <option value="005">하나은행</option>
										  <option value="010">농협은행</option>
										  <option value="020">우리은행</option>
										  <option value="021">신한은행</option>
										  <option value="090">카카오뱅크</option>
										</select>
									</div>
									
								</div>
								<div class="mb-3">
									<label for="bankbranchcd">계좌번호.</label>
									<input type="text" class="form-control w-25 required" name="bankno" id="bankno" value="">
								</div>
								<script>
									//script for bankname and branch
								</script>
								
								<div class="mb-3">
									<label for="totalcost">Cost.</label> 
									<div class="input-group w-25"> 
										<span class="input-group-text">￥</span>
										<input type="number"
											class="form-control required" name="totalcost" id="totalcost" min="0"  value="" max="999999999"
											placeholder="인원수,날짜를 확인하세요" required readonly="readonly" style="font-size:12pt; color:#ff0000; font-weight:bold;">
									</div>
									<input type="hidden" name="paymentflg" id="paymentflg" value="0">
								</div>
								<div class="mb-3">
									<button id="backToListBtn" class="btn btn-danger" onclick="backToList(event);">돌아가기</button>
									<button id="paymentBtn" class="btn btn-success" onclick="pay(event);">결제하기</button>
									<button id="registerBtn" class="btn btn-secondary" onclick="reigster(event);">나중에 결제하기</button>
								</div>
								<!-- script for payment -->
								<script type="text/javascript"> 
									function updateCost() {
										try {
											var cost;
											var adult = parseInt($("#adult").val());
											var child = parseInt($("#child").val());
											var adultCost = ${roominfo.adultcost};
											var childCost = ${roominfo.childcost};
											if(isNaN(adult) || isNaN(child)) {
												throw 'error';
											}
											var startdate = new Date($('#startdate').val()).getTime()/86400000;
											var enddate = new Date($('#enddate').val()).getTime()/86400000;
											cost = (enddate - startdate + 1) * (adult*adultCost + child*childCost);
											console.log('cost :' + cost);
											
											if(isNaN(cost) || cost < 0 || cost > 999999999) {
												throw 'error';
											}
											
											$("#totalcost").val("" + cost);
											
										} catch(error) {
											console.log("error");
											$("#totalcost").val("");
										}
									}
									function pay(event) {
										event.preventDefault();
										console.log("bankbranch : " + $("#bankbranchcd").val());
										if($("#bankbranchcd").val() === "" || $("#bankno").val() === "" ) {
											alert("계좌정보를 확인하세요");
											return;
										}
										if($("#totalcost").val() === "") {
											alert("인원수, 날짜를 확인하세요");
											return;
										}
										
										if($("#paymentflg").val() === "0") {
											$("#adult").attr("readonly","readonly");
											$("#child").attr("readonly","readonly");
											$( "#startdate" ).datepicker( "option", "disabled", true );
											$( "#enddate" ).datepicker( "option", "disabled", true );
											$("#paymentflg").val("1");
											$("#paymentBtn").toggleClass("btn-success",false);
											$("#paymentBtn").toggleClass("btn-danger",true);
											$("#paymentBtn").text("결제취소");
											register(event);
											alert("결제 완료");
										} else {
											$("#adult").removeAttr("readonly");
											$("#child").removeAttr("readonly");
											$( "#startdate" ).datepicker( "option", "disabled", false );
											$( "#enddate" ).datepicker( "option", "disabled", false );
											$("#paymentflg").val("0");
											$("#paymentBtn").toggleClass("btn-success",true);
											$("#paymentBtn").toggleClass("btn-danger",false);
											$("#paymentBtn").text("결제하기");
											alert("결제 취소 완료");
										}
									}
									function register(event) {
										event.preventDefault();
										
										if($("#totalcost").val() === "") {
											alert("인원수, 날짜를 확인하세요");
											return;
										}
										
										form.submit();
									}
								</script>
						      </div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</article>
	</body>
	
</html>