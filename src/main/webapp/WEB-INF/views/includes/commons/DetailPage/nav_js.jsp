<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp" %>
<c:set value="${param.no}" var="no"/>
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
					
				case "reply":
					form.append(`<input type="hidden" name="no" value="${no}"/>`);
					form.attr("action",adminURL + "/${menu}/register02"); // only for consultation
					break;
					
				case "restore":
					if(!confirm("복구하시겠습니까?")) {
						return;
					}
					form.append(`<input type="hidden" name="no" value="${no}"/>`);
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