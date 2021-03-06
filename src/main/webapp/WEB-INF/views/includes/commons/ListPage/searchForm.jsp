<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp"%>
<form id="searchForm" action="${listAction}" method="get">
	<input type="hidden" name="pageNum" value="1"/>
	<input type="hidden" name="amount" value="${pageMaker.cri.amount}"/>
	<select name="type">
		<option value="T" 
		<c:out value="${pageMaker.cri.type == 'T' ? 'selected' : ''}"></c:out>>タイトル</option>
		<option value="C" 
		<c:out value="${pageMaker.cri.type == 'C' ? 'selected' : ''}"></c:out>>内容</option>
		<c:if test="${menu  eq 'consultation'}">
			<option value="W" 
			<c:out value="${pageMaker.cri.type == 'W' ? 'selected' : ''}"></c:out>>作成者</option>
		</c:if>
		<option value="TC" 
		<c:out value="${pageMaker.cri.type == 'TC' ? 'selected' : ''}"></c:out>>タイトル + 内容</option>
		
		
		<c:if test="${menu  eq 'consultation'}">
			<option value="TCW" 
			<c:out value="${pageMaker.cri.type == 'TCW' ? 'selected' : ''}"></c:out>>タイトル + 内容 + 作成者</option>
		</c:if>
	</select>
	<input type="text" name="keyword" value="${pageMaker.cri.keyword}">
	<button class="btn btn-outline-secondary">検索</button>
</form>
<script type="text/javascript">
//script for search
$("#searchForm button").on("click",function(e) {
	console.log("search");
	e.preventDefault();

	$("#searchForm").submit();
});
</script>