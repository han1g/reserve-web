<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp"%>
<script type="text/javascript">
	var actionForm = $("#actionForm");
	$(".move").on("click",function(e) {
		console.log("click");
		e.preventDefault();
		actionForm.append('<input type="hidden" name="no" value=""/>');
		actionForm.find("input[name='no']").val($(this).attr("href"));
		var adminURL = "${admin}" === "admin" ? "/admin" : "";
		var get = "${L}" === "01" ? "get" : "getDeleted";
		actionForm.attr("action", adminURL + "/${menu}/" + get);
		//alert(actionForm.attr("action"));//log
		actionForm.submit();
	});//제목 클릭하면 게시글로 넘어가기
</script>