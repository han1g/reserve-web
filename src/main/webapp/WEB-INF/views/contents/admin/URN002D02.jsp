<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
</head>
	<body>
		<article>
			<div class="container" role="main">
				<div class="h2">
					<h2 class="write-h2">공지</h2>
				</div>
				<div class="background-white">
					<form action="" name="form" id="form" role="form" method="post">
						<div class="mb-3">
							<label for="title"></label> 
							<input type="text"
								class="form-control" name="title" id="title"
								value="${notice.title}" readonly="readonly">
							<div class="d-flex justify-content-end">
								등록일 : <fmt:formatDate pattern="yyyy/MM/dd" value="${notice.createdat}"/>
							</div>
							<div class="d-flex justify-content-end">
								마지막 수정일 : <fmt:formatDate pattern="yyyy/MM/dd" value="${notice.updatedat}"/>
							</div>
						</div>
						<div class="mb-3 border border-secondary border-5 rounded">
							${notice.contents}
						</div>
					</form>
					<form id="actionForm" action="" method="post">			
						<input type="hidden" name="pageNum" value="${cri.pageNum}"/>
						<input type="hidden" name="amount" value="${cri.amount}"/>
						<input type="hidden" name="type" value="<c:out value="${cri.type}"/>"/>
						<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>"/>
						<input type="hidden" name="no" value="${notice.no}"/>
						<div>
							<button type="button" class="btn btn-secondary" id="btnList" onclick="location.href = '/admin/notice/deletedList';">목록</button>
							<a href="" role="button" class="btn btn-warning" data-oper="restore" id="btnRestore">복구</a>
						</div>
					</form>
					<script>
						$(document).ready(function() {
							var form = $("#actionForm");
							$("a[role='button']").on("click",function(event) {
								event.preventDefault();
								var operation = $(this).data("oper");
								console.log(operation);
								switch(operation) {
									case "restore":
										if(!confirm("복구하시겠습니까?")) {
											return;
										}
										form.attr("action","/admin/notice/restore");
										break;
									default : return;
								
								}
								form.submit();
							})
						})
					</script>
				</div>
			</div>
		</article>
	</body>
</html>