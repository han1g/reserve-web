<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.demo.domain.etc.PageDTO" %>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp"%>
<nav class="d-flex justify-content-end">
	<ul class="pagination">
		<c:if test="${pageMaker.prev}">
			<li class="page-item"><a class="page-link" href="${pageMaker.startPage - 10}">prev</a></li>
		</c:if>
		<c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
			<c:choose>
				<c:when test="${pageMaker.cri.pageNum == i}">
					<li style="pointer-events : none;" class="page-item active"><a class="page-link" href="${i}">${i}</a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link" href="${i}">${i}</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${pageMaker.next}">
			<li class="page-item"><a class="page-link" href="${pageMaker.startPage + 10}">next</a></li>
		</c:if>
	</ul>
</nav>
<form id="actionForm" action="${listAction}" method="get">
	<%request.setAttribute("cri", ((PageDTO) request.getAttribute("pageMaker")).getCri()); %> <!-- cannnot send Object by <jsp;param> -->
	<jsp:include page="/WEB-INF/views/includes/commons/criteria.jsp"/>
</form>
<script type="text/javascript">
//script for paging
var actionForm = $("#actionForm");	
$(".page-item a").on("click",function(e) {
	console.log("click");
	e.preventDefault();
	actionForm.find("input[name='pageNum']").val($(this).attr("href"));
	actionForm.submit();
});//페이지 이동
</script>