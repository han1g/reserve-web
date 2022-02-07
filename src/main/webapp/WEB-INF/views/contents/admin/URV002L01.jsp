<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<jsp:include page="/WEB-INF/views/includes/URV/fullcalendar.jsp">
	<jsp:param value="admin" name="admin"/>
</jsp:include>
</head>
<body>
	roomtitle : ${param.roomtitle};<br>
 	name : ${param.name};<br>
 	phone : ${param.phone};<br>
 	cancel : ${param.cancelflg};<br>
 	payment : ${param.paymentflg};<br>
 	delete : ${param.deleteflg};<br>
 	
 	<div class="accordion" id="accordionExample">
	  <div class="accordion-item">
	    <h2 class="accordion-header" id="headingTwo">
	      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
	        Search Menu
	      </button>
	    </h2>
	    <div id="collapseTwo" class="accordion-collapse collapse show" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
	      <div class="accordion-body">
	        <form id="searchForm" action="/admin/reserve/list" method="get">
	        	<div class="mb-3">
					  <label for="roomtitle" class="form-label">Room Title.</label>
					  <input type="text" name="roomtitle" class="form-control" id="roomtitle" placeholder="방 이름" value="${param.roomtitle}">
				</div>
	        	<div class="mb-3">
					  <label for="name" class="form-label">Name.</label>
					  <input type="text" name="name" class="form-control" id="name" placeholder="예약자 성명" value="${param.name}">
				</div>
				<div class="mb-3">
				  <label for="phone" class="form-label">Phone Number.</label>
				  <input type="text" name="phone" class="form-control" id="phone" placeholder="전화번호('-'제외)" value="${param.phone}">
				</div>
				<div class="mb-3">
				　<label for="phone" class="form-label">CancelFlg : </label>
					<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
					  <input type="radio" class="btn-check" name="cancelflg" id="canceled1" value="" autocomplete="off" ${empty param.cancelflg ? 'checked' : ''}>
					  <label class="btn btn-outline-primary" for="canceled1">All</label>
					
					  <input type="radio" class="btn-check" name="cancelflg" id="canceled2" value="1" autocomplete="off" ${param.cancelflg eq '1' ? 'checked' : ''}>
					  <label class="btn btn-outline-primary" for="canceled2">1</label>
					
					  <input type="radio" class="btn-check" name="cancelflg" id="canceled3" value="0" autocomplete="off" ${param.cancelflg eq '0' ? 'checked' : ''}>
					  <label class="btn btn-outline-primary" for="canceled3">0</label>
					</div>
				</div>
				<div class="mb-3">
				　<label for="phone" class="form-label">PaymentFlg : </label>
					<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
					  <input type="radio" class="btn-check" name="paymentflg" id="paid1" value="" autocomplete="off" ${empty param.paymentflg ? 'checked' : ''}>
					  <label class="btn btn-outline-primary" for="paid1">All</label>
					
					  <input type="radio" class="btn-check" name="paymentflg" id="paid2" value="1" autocomplete="off" ${param.paymentflg eq '1' ? 'checked' : ''}>
					  <label class="btn btn-outline-primary" for="paid2">1</label>
					
					  <input type="radio" class="btn-check" name="paymentflg" id="paid3" value="0" autocomplete="off" ${param.paymentflg eq '0' ? 'checked' : ''}>
					  <label class="btn btn-outline-primary" for="paid3">0</label>
					</div>
				</div>
				<div class="mb-3">
				　<label for="phone" class="form-label">DeleteFlg : </label>
					<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
					  <input type="radio" class="btn-check" name="deleteflg" id="deleted1" value="" autocomplete="off" ${empty param.deleteflg ? 'checked' : ''}>
					  <label class="btn btn-outline-primary" for="deleted1">All</label>
					
					  <input type="radio" class="btn-check" name="deleteflg" id="deleted2" value="1" autocomplete="off" ${param.deleteflg eq '1'? 'checked' : ''}>
					  <label class="btn btn-outline-primary" for="deleted2">1</label>
					
					  <input type="radio" class="btn-check" name="deleteflg" id="deleted3" value="0" autocomplete="off" ${param.deleteflg eq '0' ? 'checked' : ''}>
					  <label class="btn btn-outline-primary" for="deleted3">0</label>
					</div>
				</div>
				
				<button id="#searchFormBtn" class="btn btn-outline-secondary">Search</button>
			</form>
			<script type="text/javascript">
				//script for search
				$("#searchFormBtn").on("click",function(e) {
					console.log("search");
					e.preventDefault();
	
					$("#searchForm").submit();
				});
			</script>
	      </div>
	    </div>
	  </div>
	</div>
  	<div id='calendar'></div>
</body>
</html>