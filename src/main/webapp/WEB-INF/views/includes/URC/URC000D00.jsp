<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
					<h2 class="write-h2">相談</h2>
				</div>
				<div class="background-white">
					<form action="" name="form" id="form" role="form" method="post">
						<div class="mb-3">
							<label for="title">タイトル</label> 
							<input type="text"
								class="form-control" name="title" id="title"
								value="${consultation.title}" readonly="readonly">
							<label for="name">作成者</label> 
							<input type="text"
							class="form-control" name="name" id="name"
							value="${consultation.name}" readonly="readonly">
							<div class="d-flex justify-content-end">
								登録日 : <fmt:formatDate pattern="yyyy/MM/dd" value="${consultation.createdat}"/>
							</div>
							<div class="d-flex justify-content-end">
								修正日 : <fmt:formatDate pattern="yyyy/MM/dd" value="${consultation.updatedat}"/>
							</div>
						</div>
						<div class="mb-3 border border-secondary border-5 rounded">
							${consultation.contents}
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
									</c:if>
									<c:if test="${admin ne 'admin'}">
										<a href="" role="button" class="btn btn-danger" data-oper="delete-consult" id="btnDelete">削除</a>
									</c:if>
									<a href="" role="button" class="btn btn-warning" data-oper="modify" id="btnUpdate">修正</a>
									<a href="" role="button" class="btn btn-primary" data-oper="reply" id="btnReply">返信</a>
								</c:when>
								<c:otherwise> <!-- deleted list -->
									<a href="" role="button" class="btn btn-secondary" data-oper="deletedList" id="btnList">リスト</a>
									<a href="" role="button" class="btn btn-warning" data-oper="restore" id="btnRestore">復旧</a>
								</c:otherwise>
							</c:choose>
						</div>
					</form>
					<jsp:include page="/WEB-INF/views/includes/commons/DetailPage/nav_js.jsp">
						<jsp:param name="no" value="${consultation.no}" />
					</jsp:include>
				</div>
			</div>
		</article>
	</body>
</html>