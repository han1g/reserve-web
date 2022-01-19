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
					<h2 class="write-h2">상담</h2>
				</div>
				<div class="background-white">
					<form action="" name="form" id="form" role="form" method="post">
						<div class="mb-3">
							<label for="title">제목</label> 
							<input type="text"
								class="form-control" name="title" id="title"
								value="${consultation.title}" readonly="readonly">
							<label for="name">작성자</label> 
							<input type="text"
							class="form-control" name="name" id="name"
							value="${consultation.name}" readonly="readonly">
							<div class="d-flex justify-content-end">
								등록일 : <fmt:formatDate pattern="yyyy/MM/dd" value="${consultation.createdat}"/>
							</div>
							<div class="d-flex justify-content-end">
								마지막 수정일 : <fmt:formatDate pattern="yyyy/MM/dd" value="${consultation.updatedat}"/>
							</div>
						</div>
						<div class="mb-3 border border-secondary border-5 rounded">
							${consultation.contents}
						</div>
					</form>
					<form id="actionForm" action="" method="get">
						<input type="hidden" name="pageNum" value="${cri.pageNum}"/>
						<input type="hidden" name="amount" value="${cri.amount}"/>
						<input type="hidden" name="type" value="<c:out value="${cri.type}"/>"/>
						<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>"/>
						
						<input type="hidden" name="no" value="${consultation.no}"/>
						<div>
							<a href="" role="button" class="btn btn-secondary" data-oper="list" id="btnList">목록</a>
							<a href="" role="button" class="btn btn-danger" data-oper="delete" id="btnDelete">삭제</a>
							<a href="" role="button" class="btn btn-warning" data-oper="modify" id="btnUpdate">수정</a>
							<a href="" role="button" class="btn btn-primary" data-oper="reply" id="btnReply">답글</a>
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
									case "modify":
										form.attr("action","/consultation/modify");
										break;
									case "delete":
										if(!confirm("삭제하시겠습니까?")) {
											return;
										}
										form.append('<input type="hidden" name="lockflg_bef" value="${consultation.lockflg}"/>');
										form.attr("action","/consultation/remove");
										form.attr("method","post");
										break;
									case "reply":
										form.attr("action","/consultation/registerReply");
										break;
									case "list":
										var pageNum = $("input[name='pageNum']").clone();
										var amount = $("input[name='amount']").clone();
										var type = $("input[name='type']").clone();
										var keyword = $("input[name='keyword']").clone();
										form.empty();
										form.append(pageNum);
										form.append(amount);
										form.append(type);
										form.append(keyword);
										form.attr("action","/consultation/list");
										form.attr("method","get");
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