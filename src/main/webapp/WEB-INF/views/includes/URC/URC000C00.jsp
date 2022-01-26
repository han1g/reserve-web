<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp"%>
<c:set var="title" value="${param.title}"/>
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
					<h2 class="write-h2">${title}</h2>
				</div>
				<div class="background-white">
					<form action="/admin/consultation/register${C}" name="form" id="form" role="form" method="post">
						<c:if test="${C eq '02' }">
							<jsp:include page="/WEB-INF/views/includes/commons/criteria.jsp"/>
							<input type="hidden" name="ref_no" value="${consultation.no}"/>
						</c:if>
						<div class="mb-3">
							<label for="title">Title</label> 
							<input type="text"
								class="form-control" name="title" id="title" value="${C eq '02' ? ('Re: '.concat(consultation.title)) : ''}"
								placeholder="제목을 입력해 주세요">
						</div>
						<div class="mb-3">
							<label for="name">Name</label> 
							<input type="text"
								class="form-control" name="name" id="name" value="${admin eq 'admin' ? '운영자' : ''}" ${admin eq 'admin' ? 'readonly' : ''}
								placeholder="이름을 입력해 주세요">
						</div>
						<div id="div_lock" class="form-check mb-3">
							<input type="hidden" class="form-check-input" name="lockflg" value="0" id="chk_lock_hidden"/><!-- checkbox가 언체크드면 이게 감-->
							<label for="chk_lock" class="form-check-label">비밀글</label>
							<input type="checkbox" class="" name="lockflg" id="chk_lock"
								value="1">

							<c:if test="${admin ne 'admin'}">
								<label for="passwd"> &nbsp;&nbsp;pw: </label> 
								<input type="password" id="passwd" name="passwd" value="">
							</c:if> 
						</div>
						<div class="mb-3">
							<textarea id="summernote" name="contents"></textarea>
						</div>
					</form>
					<div>
						<button type="button" class="btn btn-secondary" id="btnList" onclick="location.href = '${admin eq 'admin' ? '/admin' : ''}/consultation/list';">목록</button>
						<button type="submit" class="btn btn-success" id="btnSave" onclick="sendReviewForm($('#form'));">등록</button>
					</div>
				</div>
			</div>
		</article>
		<script type="text/javascript">
			$(document).ready(function() {
				if($("#chk_lock").is(":checked")) {
					$("#chk_lock_hidden").attr('disabled','disabled');
				} else {
					$("#chk_lock_hidden").removeAttr('disabled');
				}
				
				$("#chk_lock").on('change',function() {
					
					if($("#chk_lock").is(":checked")) {
						$("#chk_lock_hidden").attr('disabled','disabled');
					} else {
						$("#chk_lock_hidden").removeAttr('disabled');
					}
				});
			});//비밀글 관련 div 설정
		</script>
		<jsp:include page="/WEB-INF/views/includes/URC/validation_js.jsp"/>
		<jsp:include page="/WEB-INF/views/includes/commons/Create_UpdatePage/upload_js.jsp"/>
		
	</body>
</html>
