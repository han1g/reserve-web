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
					<h2 class="write-h2">予約修正</h2>
				</div>
				<div class="background-white">
					<form action="/admin/reserve/modify" name="form" id="form" role="form" method="post">
						
						<input type="hidden" name="no" id="no" value="${reserve.no}">
						<input type="hidden" name="roomno" id="roomno" value="${reserve.roomno}">
						<div class="mb-3">
							<label>部屋名</label> 
							<input type="text"
								class="form-control" value="${reserve.roominfo.roomtitle}" readonly>
						</div>
						<div class="mb-3">
							<label for="name">姓名</label> 
							<input type="text"
								class="form-control required" name="name" id="name" value="${reserve.name}"
								placeholder="예약자 성명을 입력해 주세요" required>
						</div>
						<div class="mb-3">
							<label for="phone">電話番号</label> 
							<input type="text"
								class="form-control required" name="phone" id="phone" value="${reserve.phone }"
								placeholder="電話番号( '-' 無し)" required>
						</div>
						<div class="mb-3">
							<label for="adult">大人</label>
							<div class="input-group w-25"> 
								<input type="number"
									class="form-control w-25 required" name="adult" id="adult" min="0" value="${reserve.adult}" max="9"
									placeholder="大人人数 (0 - 9)" required onchange="updateCost()">
								<span class="input-group-text">人</span>
							</div>
						</div>
						<div class="mb-3">
							<label for="child">小人</label> 
							<div class="input-group w-25"> 
								<input type="number"
									class="form-control required" name="child" id="child" min="0"  value="${reserve.child}" max="9"
									placeholder="小人人数(0 - 9)" required onchange="updateCost()">
								<span class="input-group-text">人</span>
							</div>
						</div>
						
						<div class="mb-3">
							<label>日付</label>
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
							<jsp:param value="admin" name="admin"/>
							<jsp:param value="01" name="U"/>
						</jsp:include>
						
						<div class="mb-3">
							<div class="card">
							  <div class="card-header">
							    	オプション。
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
									* 人数、日付を確認してください。
								</div>
								<!-- script for options -->
							  </div>
							</div>
						</div>
						
						<div class="mb-3">
							<div class="card">
							  <div class="card-header">
							    	支払いメニュー
							  </div>
							  <div class="card-body">
								<div class="mb-3">
									<label for="bankbranchcd">Bank.</label> 
									<div class="input-group w-25">
										<input type="hidden" class="required" name="bankname" id="bankname" value="${reserve.bankname}">
										<select name="bankbranchcd" id="bankbranchcd" class="form-select" aria-label="Default select example" onchange="bankSelect(event);">
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
									<label for="bankbranchcd">口座番号</label>
									<input type="text" class="form-control w-25 required" name="bankno" id="bankno" value="${reserve.bankno}">
								</div>
								<script>
									//script for bankname and branch
									function bankSelect() {
										$('#bankbranchcd > option').each(function() {
											if($(this).prop("selected")) {
												if($(this).val() === "") {
													$("#bankname").val("");
												} else {
													$("#bankname").val($(this).text());
												}
											}
										});
										console.log("bankname : " + $("#bankname").val());
									}
								</script>
								
								<div class="mb-3">
									<label for="totalcost">料金。</label> 
									<div class="input-group w-25"> 
										<span class="input-group-text">￥</span>
										<input type="number"
											class="form-control required" name="totalcost" id="totalcost" min="0"  value="${reserve.totalcost}" max="999999999"
											placeholder="인원수,날짜를 확인하세요" required style="font-size:12pt; color:#ff0000; font-weight:bold;">
									</div>
								</div>
								<div class="mb-3">
									<label>Paymentflg.</label> 
									<div class="input-group-text w-25" style="user-select: auto;">
								 		<input id="paid" class="form-check-input mt-0" type="radio" name="paymentflg" value="1" ${reserve.paymentflg eq '1' ? 'checked' : ''}>
								 		<label for="paid">&nbsp; 1</label>
								 		&nbsp;
								 		<input id="not-paid" class="form-check-input mt-0" type="radio" name="paymentflg" value="0" ${reserve.paymentflg eq '0' ? 'checked' : ''}>
								 		<label for="not-paid">&nbsp; 0</label>
							 		</div>
									
									<input type="hidden" name="deleteflg" id="deleteflg" value="${reserve.deleteflg}">
									<input type="hidden" name="cancelflg" id="cancelflg" value="${reserve.cancelflg}">
								</div>
								<div class="mb-3">
									<button id="backToListBtn" class="btn btn-secondary" onclick="backToList(event);">戻る</button>
									<c:if test="${reserve.cancelflg eq '0'}">
										<button id="cancelBtn" class="btn btn-dark" onclick="cancel(event);">予約取消</button>
									</c:if>
									<c:if test="${reserve.cancelflg eq '1'}">
										<button id="cancelBtn" class="btn btn-dark" onclick="revertCancel(event);">予約復元</button>
									</c:if>
									<c:if test="${reserve.deleteflg eq '0'}">
										<button id="removeBtn" class="btn btn-danger" onclick="remove(event);">削除</button>
									</c:if>
									<c:if test="${reserve.deleteflg eq '1'}">
										<button id="removeBtn" class="btn btn-danger" onclick="restore(event);">削除復旧</button>
									</c:if>
									<button id="registerBtn" class="btn btn-warning" onclick="reigster(event);">修正</button>
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
											$("#optionsHelp").text("* 人数、日付を確認してください。");
										}
									}
									function validateACD() {
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
											
											if(isNaN(cost) || cost < 0 || cost > 999999999) {
												throw 'error';
											}
											
										} catch(error) {
											return false;
										}
										return true;
									}
									
									function cancel() {
										event.preventDefault();
										
										if(!confirm("予約を取り消します。\n続きますか？")) {
											return;
										}
										
										console.log("bankbranch : " + $("#bankbranchcd").val());
										if($("#bankbranchcd").val() === "" || $("#bankno").val() === "" ) {
											alert("口座情報を確認してください。");
											return;
										}
										$("#paymentflg").val("0");
										$("#cancelflg").val("1");
										alert($("#form"));
										$("#form").attr('action','/admin/reserve/cancel');
										$("#form").submit();
									}
									function remove(event) {
										event.preventDefault();
										
										if(!confirm("予約情報を削除しますか？")) {
											return;
										}
										$("#deleteflg").val("1");
										$("#paymentflg").val("0");
										$("#cancelflg").val("1");
										alert($("#form"));
										$("#form").attr('action','/admin/reserve/remove');
										$("#form").submit();
										//remove
									}
									function restore(event) {
										event.preventDefault();
										
										if(!confirm("予約情報を復旧しますか？")) {
											return;
										}
										$("#deleteflg").val("0");
										register(event);
									}
									
									function revertCancel(event) {
										event.preventDefault();
										
										if(!confirm("予約取消を復元しますか")) {
											return;
										}
										
										if($("#form #name").val() === "") {
											alert("名前を確認してください。");
											return;
										}
										
										if($("#form #phone").val() === "") {
											alert("電話番号を確認してください。");
											return;
										}
										
										if($("#totalcost").val() === "") {
											alert("人数、日付を確認してください。");
											return;
										}
										
										console.log("bankbranch : " + $("#bankbranchcd").val());
										if($("#bankbranchcd").val() === "" || $("#bankno").val() === "" ) {
											alert("口座情報を確認してください。");
											return;
										}
										
										var err = true;
										$.ajax({
											type:'POST' ,
											contentType: "application/json; charset=utf-8",
											data: JSON.stringify({roomno: "${reserve.roomno}",startdate: $('#startdate').val(), enddate: $('#enddate').val()}),
											url: '/admin/reserve/validateDate',
											async: false,
											error: function (xhr, status,error) {
												console.log("date validation error : " + status);
												err = true;
											},
											success: function (data,status,xhr) {
												console.log("date validation success : " + status);
												err = false;
											}
										});
										if(err) {
											alert("他の予約が存在するため復元出来ません。");
											return;
										}
										
										
										$("#deleteflg").val("0");
										$("#cancelflg").val("0");
										register(event);
									}
									
									function register(event) {
										event.preventDefault();
										
										if($("#form #name").val() === "") {
											alert("名前を確認してください。");
											return;
										}
										
										if($("#form #phone").val() === "") {
											alert("電話番号を確認してください。");
											return;
										}
										
										if($("#totalcost").val() === "") {
											alert("人数、日付を確認してください。");
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
										
										alert(form);
										form.submit();
									}
									
									function backToList(event) {
										event.preventDefault();
										
										if(!confirm("変更事項を取り消してリストに戻りますか?")) {
											return;
										}
										
										var backForm = $('#backToList');
										//var adminURL = "${admin eq 'admin' ? '/admin' : '' }";
										var adminURL = "/admin";
										console.log(adminURL);
										//alert(adminURL);
										
										backForm.attr("action",adminURL + "/reserve/list");
										backForm.attr("method","get");
										
										backForm.submit();
									}//돌아가기 클릭
								</script>
						      </div>
							</div>
						</div>
					</form>
					<form id="backToList" action="" method="get" >
						<input type="hidden" name="roomno" id="cri_roomno" value="${cri.roomno}">
						<input type="hidden" name="roomtitle" id="cri_roomtitle" value="${cri.roomtitle}">
						<input type="hidden" name="name" id="cri_name" value="${cri.name}">
						<input type="hidden" name="phone" id="cri_phone" value="${cri.phone}">
						<input type="hidden" name="cancelflg" id="cri_cancelflg" value="${cri.cancelflg}">
						<input type="hidden" name="deleteflg" id="cri_deleteflg" value="${cri.deleteflg}">
						<input type="hidden" name="paymentflg" id="cri_paymentflg" value="${cri.paymentflg}">
						<!-- criteria -->
					</form>
				</div>
			</div>
		</article>
		<jsp:include page="/WEB-INF/views/includes/commons/ListPage/modal.jsp"/>
	</body>
	
</html>