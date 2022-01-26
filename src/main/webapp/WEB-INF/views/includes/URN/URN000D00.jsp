<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp"%>
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
					<jsp:include page="/WEB-INF/views/includes/commons/DetailPage/navs.jsp">
						<jsp:param value="${notice.no}" name="no"/>
					</jsp:include>
				</div>
			</div>
		</article>
	</body>
</html>