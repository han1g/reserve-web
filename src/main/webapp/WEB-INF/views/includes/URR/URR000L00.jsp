<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.ui-slider-range { background: #729fcf; }
	.search-element {margin-bottom:20px;}
</style>
</head>
<body>
	<div class="work-area">
		<div class="card">
			<div class="card-header">ROOMS.</div>
			
			<table class="table table-striped">
				<thead>
					<tr>
						<th>#Preview</th>
						<th>방 번호</th>
						<th>방 이름</th>
						<th>최대 인원</th>
						<th>어른 요금</th>
						<th>어린이 요금</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="roominfo" items="${roominfoList}">
						<tr >
						 <td><img src="${roominfo.thumb}" class="img-thumbnail target" style="object-fit: contain; width:100px;height:100px" alt="..."></td>
						 <td class="align-middle"><a class="move" href="<c:out value="${roominfo.no}"/>">
						 <!-- 링크로 넘길 파라미터가 많아지면 링크가 복잡 -->
						 <c:out value="${roominfo.roomnum}"></c:out></a></td>
						 <td class="align-middle"><c:out value="${roominfo.roomtitle}"></c:out></td>
						 <td class="align-middle"><c:out value="${roominfo.maxpeople}"></c:out>人</td>
						 <td class="align-middle"><c:out value="${roominfo.adultcost}"></c:out>￥</td>
						 <td class="align-middle"><c:out value="${roominfo.childcost}"></c:out>￥</td>
						 <!-- date받아서 포매팅하기 -->
						 <!-- cout 을 쓰면 자동으로escape처리되기 때문에 특수문자 오류나 xss에 대응가능 -->
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="/WEB-INF/views/includes/commons/ListPage/getByTitleClick.jsp"/>
						
			<div class="accordion" id="accordionExample">
			  <div class="accordion-item">
			    <h2 class="accordion-header" id="headingTwo">
			      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
			        Search Menu
			      </button>
			    </h2>
			    <div id="collapseTwo" class="accordion-collapse collapse show" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
			      <div class="accordion-body">
			        <form id="searchForm" action="${listAction}" method="get">
						<input type="hidden" name="pageNum" value="1"/>
						<input type="hidden" name="amount" value="${pageMaker.cri.amount}"/>
						
						<jsp:include page="/WEB-INF/views/includes/URR/range_slider.jsp">
							<jsp:param value="최대 인원" name="labelName"/>
							<jsp:param value="maxpeople" name="rangeName"/>
							<jsp:param value="0" name="rangeMin"/>
							<jsp:param value="100" name="rangeMax"/>
							<jsp:param value="1" name="rangeStep"/>
							<jsp:param value="人" name="rangeUnit"/>
							<jsp:param value="${pageMaker.cri.maxpeople_min}" name="criMin"/>
							<jsp:param value="${pageMaker.cri.maxpeople_max}" name="criMax"/>
						</jsp:include>
						
						<jsp:include page="/WEB-INF/views/includes/URR/range_slider.jsp">
							<jsp:param value="어른 요금" name="labelName"/>
							<jsp:param value="adultcost" name="rangeName"/>
							<jsp:param value="0" name="rangeMin"/>
							<jsp:param value="100000" name="rangeMax"/>
							<jsp:param value="100" name="rangeStep"/>
							<jsp:param value="￥" name="rangeUnit"/>
							<jsp:param value="${pageMaker.cri.adultcost_min}" name="criMin"/>
							<jsp:param value="${pageMaker.cri.adultcost_max}" name="criMax"/>
						</jsp:include>
						
						<jsp:include page="/WEB-INF/views/includes/URR/range_slider.jsp">
							<jsp:param value="어린이 요금" name="labelName"/>
							<jsp:param value="childcost" name="rangeName"/>
							<jsp:param value="0" name="rangeMin"/>
							<jsp:param value="100000" name="rangeMax"/>
							<jsp:param value="100" name="rangeStep"/>
							<jsp:param value="￥" name="rangeUnit"/>
							<jsp:param value="${pageMaker.cri.childcost_min}" name="criMin"/>
							<jsp:param value="${pageMaker.cri.childcost_max}" name="criMax"/>
						</jsp:include>

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
			
			<jsp:include page="/WEB-INF/views/includes/commons/ListPage/paging.jsp"/>
			
		</div>
		<div>
			<c:choose>
				<c:when test="${admin eq 'admin'}">
					<c:choose>
						<%-- admin user --%>
						<c:when test="${L eq '01'}">
							<!-- normal list -->
							<a href="/admin/roominfo/register" class="btn btn-outline-success">글쓰기</a>
							<a href="/admin/roominfo/deletedList" class="btn btn-outline-warning">삭제 목록</a>
						</c:when>
						<c:otherwise>
							<!-- deleted list -->
							<a href="/admin/roominfo/list" class="btn btn-outline-success">목록</a>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<!-- normal user -->
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<!-- modal -->
	<jsp:include page="/WEB-INF/views/includes/commons/ListPage/modal.jsp"/>
</body>
</html>