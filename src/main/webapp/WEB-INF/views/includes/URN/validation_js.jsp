<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp" %>
<script type="text/javascript">
		function validation() {
			var title = $('#title').val();
			var contents = $("#summernote").summernote('code');
			if (title.trim() == ''){
				alert("제목을 입력해주세요");
				return false;
			}
			
			if (contents.trim() == ''){
				alert("내용을 입력해주세요");
				return false;
			}
			
			return true;
		}
</script>