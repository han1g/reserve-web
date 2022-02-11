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
					<h2 class="write-h2">お知らせ</h2>
				</div>
				<div class="background-white">
					<form action="" name="form" id="form" role="form" method="post">
						<div class="mb-3">
							<label for="title"></label> 
							<input type="text"
								class="form-control" name="title" id="title"
								value="${notice.title}" readonly="readonly">
							<div class="d-flex justify-content-end">
								登録日 : <fmt:formatDate pattern="yyyy/MM/dd" value="${notice.createdat}"/>
							</div>
							<div class="d-flex justify-content-end">
								修正日 : <fmt:formatDate pattern="yyyy/MM/dd" value="${notice.updatedat}"/>
							</div>
						</div>
						<div class="mb-3 border border-secondary border-5 rounded">
							${notice.contents}
						</div>
					</form>
					<form id="actionForm" action="" method="get">
						<jsp:include page="/WEB-INF/views/includes/commons/criteria.jsp"/>
						<div>
							<c:choose>
								<c:when test="${D eq '01'}"> <!-- undeleted list-->
									<a href="" role="button" class="btn btn-secondary" data-oper="list" id="btnList">リスト</a>
									<c:if test="${admin eq 'admin'}">
										<a href="" role="button" class="btn btn-danger" data-oper="delete" id="btnDelete">削除</a>
										<a href="" role="button" class="btn btn-warning" data-oper="modify" id="btnUpdate">修正</a>
									</c:if>
								</c:when>
								<c:otherwise> <!-- deleted list -->
									<a href="" role="button" class="btn btn-secondary" data-oper="deletedList" id="btnList">リスト</a>
									<a href="" role="button" class="btn btn-warning" data-oper="restore" id="btnRestore">復旧</a>
								</c:otherwise>
							</c:choose>
						</div>
					</form>
					<jsp:include page="/WEB-INF/views/includes/commons/DetailPage/nav_js.jsp">
						<jsp:param value="${notice.no}" name="no"/>
					</jsp:include>
				</div>
			</div>
		</article>
	</body>
</html>