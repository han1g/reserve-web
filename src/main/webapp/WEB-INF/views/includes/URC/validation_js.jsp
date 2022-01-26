<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp" %>
<script type="text/javascript">
		function validation() {
			var title = $('#title').val();
			var contents = $("#summernote").summernote('code');
			console.log(contents);
			var writer = $("#name").val();
			var passwd = $("#passwd").val();
			if (title.trim() == ''){
				alert("제목을 입력해주세요");
				return false;
			}
			
			if (contents.trim() == ''){
				alert("내용을 입력해주세요");
				return false;
			}
			if (writer.trim() =='') {
				alert("이름을 입력해주세요");
				return false;
			}
			<c:if test="${admin ne 'admin'}">
				if (writer.trim().includes('운영자')) {
					alert("이 이름은 사용 할 수 없습니다.");
					return false;
				}
				if(passwd.trim() == '') {
					alert("비밀번호를 입력하세요");
					return false;
				}
			</c:if>
			
			
			return true;
		}

</script>
		