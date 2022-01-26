<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="work-area">
		<div class="card">
			<div class="card-header">Notice.</div>
			<table class="table table-striped">
				<thead>
					<tr>
						<th>#번호</th>
						<th>제목</th>
						<th>작성일</th>
						<th>수정일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="notice" items="${noticeList}">
						<tr>
						 <td><c:out value="${notice.no}"></c:out></td>
						 <td><a class="move" href="<c:out value="${notice.no}"/>">
						 <!-- 링크로 넘길 파라미터가 많아지면 링크가 복잡 -->
						 <c:out value="${notice.title}"></c:out></a></td>
						 <td><fmt:formatDate pattern="yyyy/MM/dd" value="${notice.createdat}"/></td>
						 <td><fmt:formatDate pattern="yyyy/MM/dd" value="${notice.updatedat}"/></td>
						 <!-- date받아서 포매팅하기 -->
						 <!-- cout 을 쓰면 자동으로escape처리되기 때문에 특수문자 오류나 xss에 대응가능 -->
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="/WEB-INF/views/includes/commons/ListPage/getByTitleClick.jsp"/>
			
			<jsp:include page="/WEB-INF/views/includes/commons/ListPage/searchForm.jsp"/>
			<jsp:include page="/WEB-INF/views/includes/commons/ListPage/paging.jsp"/>
			
		</div>
		<div>
			<c:choose >
				<c:when test="${admin eq 'admin'}">
					<c:choose>
						<%-- admin user --%>
						<c:when test="${L eq '01'}">
							<!-- normal list -->
							<a href="/admin/notice/register" class="btn btn-outline-success">글쓰기</a>
							<a href="/admin/notice/deletedList" class="btn btn-outline-warning">삭제 목록</a>
						</c:when>
						<c:otherwise>
							<!-- deleted list -->
							<a href="/admin/notice/list" class="btn btn-outline-success">목록</a>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<!-- normal user -->
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<!-- modal -->
	<jsp:include page="/WEB-INF/views/includes/commons/ListPage/modal.jsp"/>
</body>
</html>