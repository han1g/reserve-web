<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
					<form action="/reserve/modify" name="form" id="form" role="form" method="post">
						<input type="hidden" name="no" id="no" value="${reserve.no}">
						<input type="hidden" name="roomno" id="roomno" value="${reserve.roomno}">
						<div class="mb-3">
							<label for="name">Name.</label> 
							<input type="text"
								class="form-control required" name="name" id="name" value="${reserve.name}"
								placeholder="예약자 성명을 입력해 주세요" required>
						</div>
						<div class="mb-3">
							<label for="phone">Phone Number.</label> 
							<input type="text"
								class="form-control required" name="phone" id="phone" value="${reserve.phone }"
								placeholder="전화번호를 입력해 주세요( '-' 제외)" required>
						</div>
						<div class="mb-3">
							<label for="adult">Adult.</label>
							<div class="input-group w-25"> 
								<input type="number"
									class="form-control w-25 required" name="adult" id="adult" min="0" value="${reserve.adult}" max="9"
									placeholder="어른 인원 수를 입력해주세요" required onchange="updateCost()">
								<span class="input-group-text">人</span>
							</div>
						</div>
						<div class="mb-3">
							<label for="child">Child.</label> 
							<div class="input-group w-25"> 
								<input type="number"
									class="form-control required" name="child" id="child" min="0"  value="${reserve.child}" max="9"
									placeholder="아동 인원 수를 입력해주세요" required onchange="updateCost()">
								<span class="input-group-text">人</span>
							</div>
						</div>
						
						<div class="mb-3">
							<label>Date.</label>
							<div class="input-group w-50"> 
								<input type="text"
									class="form-control required" name="startdate" id="startdate" value=""
									placeholder="" readonly="readonly">
								<img class="input-group-text"  src="/resources/img/calendar.png" 
								style="cursor:pointer;" onclick="$( '#startdate' ).datepicker('show');"/>
								<span class="input-group-text">~</span>
								<input type="text"
									class="form-control required" name="enddate" id="enddate" value=""
									placeholder="" readonly="readonly">
								<img class="input-group-text"  src="/resources/img/calendar.png" 
								style="cursor:pointer;" onclick="$( '#enddate' ).datepicker('show');"/>
								<input type="button" class="btn btn-sm btn-warning" onclick="event.preventDefault();resett(true);" value="reset date">
							</div>
						</div>
						<jsp:include page="/WEB-INF/views/includes/URV/datepicker.jsp">
							<jsp:param value="01" name="U"/>
						</jsp:include>
						<script>
						
						</script>
						
						<div class="mb-3">
							<div class="card">
							  <div class="card-header">
							    	Options.
							  </div>
							  <div class="card-body">
								<div class="mb-3">
									<input type="hidden" name="options" id="options" value="${reserve.options}">
									<c:forEach var="option" items="${options}" varStatus="status">
										<span>
											<input class="form-check-input options" type="checkbox" value="${option.cost}" id="option-${status.index}" onchange="updateCost()" 
											${reserve.optionSelected(option.no)}>
											<label class="form-check-label" for="option-${status.index}">
											    ${option.item}&nbsp;(￥ ${option.cost})&nbsp;
											</label>
											<input class="optionNo" type="hidden" value="${option.no}">
										</span>
									</c:forEach>
								</div>
								<div id="optionsHelp" class="mb-3">
									* 인원수,날짜를 입력하세요
								</div>
								<!-- script for options -->
							  </div>
							</div>
						</div>
						
						<div class="mb-3">
							<div class="card">
							  <div class="card-header">
							    	결제 메뉴.
							  </div>
							  <div class="card-body">
								<div class="mb-3">
									<label for="bankbranchcd">Bank.</label> 
									<div class="input-group w-25">
										<input type="hidden" class="required" name="bankname" id="bankname" value="${reserve.bankname}">
										<select name="bankbranchcd" id="bankbranchcd" class="form-select" aria-label="Default select example">
										  <option value="" ${empty reserve.bankbranchcd ? 'selected' : ''}>은행 선택</option>
										  <option value="001" ${reserve.bankbranchcd eq '001' ? 'selected' : ''}>한국은행</option>
										  <option value="002" ${reserve.bankbranchcd eq '002' ? 'selected' : ''}>산업은행</option>
										  <option value="003" ${reserve.bankbranchcd eq '003' ? 'selected' : ''}>기업은행</option>
										  <option value="004" ${reserve.bankbranchcd eq '004' ? 'selected' : ''}>국민은행</option>
										  <option value="005" ${reserve.bankbranchcd eq '005' ? 'selected' : ''}>하나은행</option>
										  <option value="010" ${reserve.bankbranchcd eq '010' ? 'selected' : ''}>농협은행</option>
										  <option value="020" ${reserve.bankbranchcd eq '020' ? 'selected' : ''}>우리은행</option>
										  <option value="021" ${reserve.bankbranchcd eq '021' ? 'selected' : ''}>신한은행</option>
										  <option value="090" ${reserve.bankbranchcd eq '090' ? 'selected' : ''}>카카오뱅크</option>
										</select>
									</div>
									
								</div>
								<div class="mb-3">
									<label for="bankbranchcd">계좌번호.</label>
									<input type="text" class="form-control w-25 required" name="bankno" id="bankno" value="${reserve.bankno}">
								</div>
								<script>
									//script for bankname and branch
								</script>
								
								<div class="mb-3">
									<label for="totalcost">Cost.</label> 
									<div class="input-group w-25"> 
										<span class="input-group-text">￥</span>
										<input type="number"
											class="form-control required" name="totalcost" id="totalcost" min="0"  value="${reserve.totalcost}" max="999999999"
											placeholder="인원수,날짜를 확인하세요" required readonly="readonly" style="font-size:12pt; color:#ff0000; font-weight:bold;">
									</div>
									<input type="hidden" name="paymentflg" id="paymentflg" value="${reserve.paymentflg}">
									<input type="hidden" name="cancelflg" id="cancelflg" value="${reserve.cancelflg}">
								</div>
								<div class="mb-3">
									<button id="backToListBtn" class="btn btn-danger" onclick="backToList(event);">돌아가기</button>
									<c:if test="${reserve.paymentflg eq '0'}"> 
										<button id="paymentBtn" class="btn btn-success" onclick="pay(event);">결제하기</button>
									</c:if>
									<button id="cancelBtn" class="btn btn-secondary" onclick="cancel(event);">예약취소</button>
									<c:if test="${reserve.paymentflg eq '0'}"> 
										<button id="registerBtn" class="btn btn-warning" onclick="reigster(event);">수정하기</button>
									</c:if>
								</div>
								<!-- script for payment -->
								<script type="text/javascript"> 
									function updateCost() {
										console.log("updateCost");
										try {
											var cost;
											var adult = parseInt($("#adult").val());
											var child = parseInt($("#child").val());
											var adultCost = ${empty reserve.roominfo.adultcost ? 'null' : reserve.roominfo.adultcost};
											var childCost = ${empty reserve.roominfo.childcost ? 'null' : reserve.roominfo.childcost};
											
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
											
											$('.options').each(function(index) {
												console.log( index + ": " + $( this ).val());
												$(this).removeAttr("disabled");
												if($(this).prop("checked")) {
													if(!isNaN(parseInt($(this).val()))) {
														cost += parseInt($(this).val());
													}
												}
											});
											
											$("#totalcost").val("" + cost);
											$("#optionsHelp").text("");
											
										} catch(error) {
											console.log("error");
											$("#totalcost").val("");
											$('.options').each(function(index) {
												console.log( index + ": " + $( this ).val());
												$(this).attr("disabled","disabled");
											});
											$("#optionsHelp").text("* 인원수,날짜를 확인하세요");
										}
									}
									function pay(event) {
										event.preventDefault();
										
										if(!confirm("결제 완료 시 이후 예약을 수정 할 수 없습니다.\n 결제 후 변경사항이 있으실 경우 예약 취소 후 다시 등록해야합니다.\n 진행하시겠습니까?")) {
											return;
										}
										
										console.log("bankbranch : " + $("#bankbranchcd").val());
										if($("#bankbranchcd").val() === "" || $("#bankno").val() === "" ) {
											alert("계좌정보를 확인하세요");
											return;
										}
										if($("#totalcost").val() === "") {
											alert("인원수, 날짜를 확인하세요");
											return;
										}
										$("#paymentflg").val("1");
										register(event);
									}
									
									function cancel() {
										event.preventDefault();
										
										if(!confirm("예약을 취소합니다.\n결제를 마치신 경우 입력하신 계좌로 수 일 내에 환불됩니다.\n진행하시겠습니까?")) {
											return;
										}
										
										console.log("bankbranch : " + $("#bankbranchcd").val());
										if($("#bankbranchcd").val() === "" || $("#bankno").val() === "" ) {
											alert("계좌정보를 확인하세요");
											return;
										}
										if($("#totalcost").val() === "") {
											alert("인원수, 날짜를 확인하세요");
											return;
										}
										$("#paymentflg").val("0");
										$("#cancelflg").val("1");
										register(event);
									}
									
									function register(event) {
										event.preventDefault();
										
										
										
										if($("#form #name").val() === "") {
											alert("이름을 확인하세요");
											return;
										}
										
										if($("#form #phone").val() === "") {
											alert("전화번호를 확인하세요");
											return;
										}
										
										if($("#totalcost").val() === "") {
											alert("인원수, 날짜를 확인하세요");
											return;
										}
										
										var options = "";
										$('.options').each(function(index) {
											console.log( index + ": " + $( this ).val());
											if($(this).prop("checked") && !$(this).prop("disabled")) {
													options += $(this).siblings("input.optionNo").val().trim();
													options += ";";
											}
										});
										if(options !== "") {
											options = options.substring(0,options.length - 1);
										}
										$("#options").val(options);
										console.log(options);
										
										alert("submit");
										form.submit();
									}
									
									function backToList(event) {
										event.preventDefault();
										
										if(!confirm("변경을 취소하고 목록으로 돌아갑니다\n진행하시겠습니까?")) {
											return;
										}
										
										var backForm = $('#backToList');
										var adminURL = "${admin eq 'admin' ? '/admin' : '' }";
										
										console.log(adminURL);
										//alert(adminURL);
										
										backForm.attr("action",adminURL + "/roominfo/get");
										backForm.attr("method","get");
										
										backForm.submit();
									}//돌아가기 클릭
								</script>
						      </div>
							</div>
						</div>
					</form>
					<form id="backToList" action="" method="get" >
						<input type="hidden" name="name" id="name" value="${reserve.name}">
						<input type="hidden" name="phone" id="phone" value="${reserve.phone}">
					</form>
				</div>
			</div>
		</article>
		<jsp:include page="/WEB-INF/views/includes/commons/ListPage/modal.jsp"/>
		
	</body>
	
</html>