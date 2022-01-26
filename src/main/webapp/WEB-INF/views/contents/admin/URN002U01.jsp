<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/lib/summernote-0.8.18-dist/summernote-lite.css">
<script src="/resources/lib/summernote-0.8.18-dist/summernote-lite.js"></script>
<title>Home</title>
</head>
	<body>
		<article>
			<div class="container" role="main">
				<div class="h2">
					<h2 class="write-h2">공지 수정</h2>
				</div>
				<div class="background-white">
					<form action="/admin/notice/modify" name="form" id="form" role="form" method="post">
						<jsp:include page="/WEB-INF/views/includes/commons/criteria.jsp"/>
						
						<div class="mb-3">
							<label for="title">Title</label> 
							<input type="text"
								class="form-control" name="title" id="title"
								value ="${notice.title}"placeholder="제목을 입력해 주세요">
						</div>
						<div class="mb-3">
							<textarea id="summernote" name="contents">${notice.contents}</textarea>
						</div>
					</form>
					<jsp:include page="/WEB-INF/views/includes/URN/validation_js.jsp"/>
					<jsp:include page="/WEB-INF/views/includes/commons/Create_UpdatePage/upload_form.jsp">
						<jsp:param value="01" name="U"/>
						<jsp:param value="${notice.no}" name="no"/>
					</jsp:include>
				</div>
			</div>
		</article>
		
	</body>
</html>