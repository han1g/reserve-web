<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Auth</title>
</head>
	<body>
		<article>
			<div class="container" role="main">
				<div class="h2">
					<h2 class="write-h2">相談</h2>
				</div>
				<div class="background-white">
					<c:if test="${method eq 'get'}">
						<div>
							ロックされています。
						</div>
					</c:if>
					<form id="actionForm" action="/consultation/auth" method="post">
						<input type="hidden" name="pageNum" value="${cri.pageNum}"/>
						<input type="hidden" name="amount" value="${cri.amount}"/>
						<input type="hidden" name="type" value="<c:out value="${cri.type}"/>"/>
						<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>"/>			
						<input type="hidden" name="no" value="${param.no}"/>
						<input type="hidden" name="method" value="${method}"/>
						<div>
							<input type="password" name="passwd" id="passwd" value="" placeholder="パスワード入力"/>
							<a id="submitBtn" href="" role="button" class="btn btn-success" data-oper="confirm" id="btnUpdate">確認</a>
						</div>
					</form>
					<script>
						$(document).ready(function() {
							var form = $("#actionForm");
							$("#submitBtn").on("click",function(event) {
								event.preventDefault();
								var operation = $(this).data("oper");
								console.log(operation);
								
								switch(operation) {
									case "confirm":
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