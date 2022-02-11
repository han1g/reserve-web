<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp" %>
<script type="text/javascript">
		function validation() {
			var title = $('#title').val();
			var contents = $("#summernote").summernote('code');
			console.log(contents);
			var writer = $("#form #name").val();
			var passwd = $("#passwd").val();
			if (title.trim() == ''){
				alert("タイトルを入力してください。");
				return false;
			}
			
			if (contents.trim() == ''){
				alert("内容を入力してください。");
				return false;
			}
			if (writer.trim() =='') {
				alert("名前を入力してください。");
				return false;
			}
			<c:if test="${admin ne 'admin'}">
				if (writer.trim().includes('Admin')) {
					alert("この名前は使用出来ません。");
					return false;
				}
				if(passwd.trim() == '') {
					alert("パスワードを入力してください。");
					return false;
				}
			</c:if>
			
			
			return true;
		}

</script>
		