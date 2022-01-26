<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp" %>
<c:set  value="${param.no}" var="no"/>
<form id="actionForm" action="" method="get">
	<jsp:include page="/WEB-INF/views/includes/commons/criteria.jsp">
		<jsp:param value="${cri}" name="cri"/>
	</jsp:include>	
	<div>
		<c:choose>
			<c:when test="${D eq '01'}"> <!-- undeleted list-->
				<a href="" role="button" class="btn btn-secondary" data-oper="list" id="btnList">목록</a>
				<c:if test="${admin eq 'admin'}">
					<a href="" role="button" class="btn btn-danger" data-oper="delete" id="btnDelete">삭제</a>
					<a href="" role="button" class="btn btn-warning" data-oper="modify" id="btnUpdate">수정</a>
				</c:if>
			</c:when>
			<c:otherwise> <!-- deleted list -->
				<a href="" role="button" class="btn btn-secondary" data-oper="deletedList" id="btnList">목록</a>
				<a href="" role="button" class="btn btn-warning" data-oper="restore" id="btnRestore">복구</a>
			</c:otherwise>
		</c:choose>
	</div>
</form>
<script>
	$(document).ready(function() {
		var form = $("#actionForm");
		var adminURL = "${admin}" === "admin" ? "/admin" : "";
		$("a[role='button']").on("click",function(event) {
			event.preventDefault();
			var operation = $(this).data("oper");
			console.log(operation);
			switch(operation) {
				case "modify":
					form.append(`<input type="hidden" name="no" value="${no}"/>`);
					form.attr("action", adminURL + "/${menu}/modify");
					break;
				case "delete":
					if(!confirm("삭제하시겠습니까?")) {
						return;
					}
					form.append(`<input type="hidden" name="no" value="${no}"/>`);
					form.attr("action",adminURL + "/${menu}/remove");
					form.attr("method","post");
					break;
					
				case "restore":
					if(!confirm("복구하시겠습니까?")) {
						return;
					}
					form.attr("action",adminURL + "/${menu}/restore");
					form.attr("method","post");
					break;
					
				case "list":
					form.attr("action",adminURL + "/${menu}/list");
					form.attr("method","get");
					break;
					
				case "deletedList":
					form.attr("action",adminURL + "/${menu}/deletedList");
					form.attr("method","get");
					break;
					
				default : return;
			
			}
			form.submit();
		})
	})
</script>