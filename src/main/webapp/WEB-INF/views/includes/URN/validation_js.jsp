<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp" %>
<script type="text/javascript">
		function validation() {
			var title = $('#title').val();
			var contents = $("#summernote").summernote('code');
			if (title.trim() == ''){
				alert("タイトルを入力してください。");
				return false;
			}
			
			if (contents.trim() == ''){
				alert("内容を入力してください。");
				return false;
			}
			
			return true;
		}
</script>