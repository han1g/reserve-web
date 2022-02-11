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
					<h2 class="write-h2">相談修正</h2>
				</div>
				<div class="background-white">
					<form action="${admin eq 'admin' ? '/admin' : ''}/consultation/modify" name="form" id="form" role="form" method="post">
						<jsp:include page="/WEB-INF/views/includes/commons/criteria.jsp"/>
						<input type="hidden" name="lockflg_bef" value="${consultation.lockflg}">
						<div class="mb-3">
							<label for="title">タイトル</label> 
							<input type="text"
								class="form-control" name="title" id="title" value="${consultation.title}"
								placeholder="タイトルを入力してください。">
						</div>
						<div class="mb-3">
							<label for="name">姓名</label> 
							<input type="text"
								class="form-control" name="name" id="name" value="${consultation.name}" ${consultation.name eq 'Admin' ? 'readonly' : ''}
								placeholder="名前を入力してください。">
						</div>
						<div id="div_lock" class="form-check mb-3">
							<input type="hidden" class="form-check-input" name="lockflg" value="0" id="chk_lock_hidden"/><!-- checkbox가 언체크드면 이게 감-->
							<label for="chk_lock" class="form-check-label">ロック</label>
							<input type="checkbox" class="" name="lockflg" id="chk_lock"
								value="1"  ${consultation.lockflg eq 1 ? 'checked' : ''}>

							<label for="passwd"> &nbsp;&nbsp;パスワード: </label> 
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
