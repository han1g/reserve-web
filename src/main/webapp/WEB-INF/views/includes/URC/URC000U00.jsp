<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp"%>
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
					<h2 class="write-h2">상담 수정</h2>
				</div>
				<div class="background-white">
					<form action="${admin eq 'admin' ? '/admin' : ''}/consultation/modify" name="form" id="form" role="form" method="post">
						<jsp:include page="/WEB-INF/views/includes/commons/criteria.jsp"/>
						<input type="hidden" name="lockflg_bef" value="${consultation.lockflg}">
						<div class="mb-3">
							<label for="title">Title</label> 
							<input type="text"
								class="form-control" name="title" id="title" value="${consultation.title}"
								placeholder="제목을 입력해 주세요">
						</div>
						<div class="mb-3">
							<label for="name">Name</label> 
							<input type="text"
								class="form-control" name="name" id="name" value="${consultation.name}" ${consultation.name eq '운영자' ? 'readonly' : ''}
								placeholder="이름을 입력해 주세요">
						</div>
						<div id="div_lock" class="form-check mb-3">
							<input type="hidden" class="form-check-input" name="lockflg" value="0" id="chk_lock_hidden"/><!-- checkbox가 언체크드면 이게 감-->
							<label for="chk_lock" class="form-check-label">비밀글</label>
							<input type="checkbox" class="" name="lockflg" id="chk_lock"
								value="1"  ${consultation.lockflg eq 1 ? 'checked' : ''}>

							<label for="passwd"> &nbsp;&nbsp;pw: </label> 
							<input type="password" id="passwd" name="passwd" value="">
						</div>
						<div class="mb-3">
							<textarea id="summernote" name="contents">.${consultation.contents}</textarea>
						</div>
					</form>
					<jsp:include page="/WEB-INF/views/includes/URC/lockflg_js.jsp"/>
					<jsp:include page="/WEB-INF/views/includes/URC/validation_js.jsp"/>
					<jsp:include page="/WEB-INF/views/includes/commons/Create_UpdatePage/upload_form.jsp"/>
				</div>
			</div>
		</article>
	</body>
</html>
