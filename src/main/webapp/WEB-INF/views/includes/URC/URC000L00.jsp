<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			<div class="card-header">相談</div>
			
			<table class="table table">
				<thead>
					<tr>
						<th>#No.</th>
						<th>タイトル</th>
						<th>作成者</th>
						<th>作成日</th>
						<th>修正日</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="consultation" items="${consultationList}">
						<c:if test="${consultation.depth eq 1}">
							<tr class="border-bottom border-dark"> 
						</c:if>
						<c:if test="${consultation.depth ne 1}">
							<tr class="border-bottom border-dark" style="background-color: #E7E9EB;">
						</c:if>
							<td><c:out value="${consultation.no}"></c:out></td>
							 <td>
							 	 <c:if test="${consultation.depth gt 1}">
								 	<c:forEach begin="3" end="${consultation.depth}" step="1" varStatus="status" >&nbsp;&nbsp;&nbsp;</c:forEach><img src="/resources/img/board_icon_reply.gif" alt="reply"/>
								 </c:if>
								 <a class="move" href="<c:out value="${consultation.no}"/>">
								 <c:out value="${consultation.title}"></c:out></a>
								 <c:if test="${consultation.lockflg eq '1'}">
								  &nbsp;&nbsp;<img src="/resources/img/lock_icon.png" alt="lock"/>
								 </c:if>
							 </td>
							 <td><span class="align-middle"><c:if test="${consultation.name eq 'Admin'}"><img src="/resources/img/admin_badge.png" alt="admin"/>&nbsp;</c:if><c:out value="${consultation.name}"></c:out></span></td>
							 <td><fmt:formatDate pattern="yyyy/MM/dd" value="${consultation.createdat}"/></td>
							 <td><fmt:formatDate pattern="yyyy/MM/dd" value="${consultation.updatedat}"/></td>
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
			<c:choose>
				<c:when test="${admin eq 'admin'}">
					<c:choose>
						<%-- admin user --%>
						<c:when test="${L eq '01'}">
							<!-- normal list -->
							<a href="/admin/consultation/register01" class="btn btn-outline-success">登録</a>
							<a href="/admin/consultation/deletedList" class="btn btn-outline-warning">削除リスト</a>
						</c:when>
						<c:otherwise>
							<!-- deleted list -->
							<a href="/admin/consultation/list" class="btn btn-outline-success">リスト</a>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<!-- normal user -->
					<a href="/consultation/register01" class="btn btn-outline-success">登録</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<!-- modal -->
	<jsp:include page="/WEB-INF/views/includes/commons/ListPage/modal.jsp"/>
</body>
</html>