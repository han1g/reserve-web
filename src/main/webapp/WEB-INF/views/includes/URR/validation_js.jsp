<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp" %>
<script type="text/javascript">
		function validation() {
			var required = $("input.required");
			console.log(required);
			for(var el of required) {
				console.log($(el));
				if($(el).val().trim() == '' ) {
					console.log("trim");
					alert("잘못된 필드가 있습니다");
					return false;
				}
				if($(el).attr("type") === "number") {
					console.log($(el));
					console.log($(el).attr("type"));
					console.log(parseInt($(el).val()));
					console.log(isNaN($(el).val()));
					console.log(parseInt($(el).attr("value")));
					console.log(parseInt($(el).attr("max")));
					console.log(parseInt($(el).attr("min")));
					
					if(isNaN(parseInt($(el).val()))) {
						alert("잘못된 필드가 있습니다");
						return false;
					}
					$(el).val(parseInt($(el).val()));
					console.log($(el).val());
					if($(el).val() > parseInt($(el).attr("max"))) {
						alert("잘못된 필드가 있습니다");
						return false;
					}
					if($(el).val() < parseInt($(el).attr("min"))) {
						alert("잘못된 필드가 있습니다");
						return false;
					}
				}
			}
			return true;
		}
</script>