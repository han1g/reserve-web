<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
						<th>작성자</th>
						<th>작성일</th>
						<th>수정일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="notice" items="${noticeList}">
						<tr>
						 <td><c:out value="${board.bno}"></c:out></td>
						 <td><a class="move" href="<c:out value="${board.bno}"/>">
						 <!-- 링크로 넘길 파라미터가 많아지면 링크가 복잡 -->
						 <c:out value="${board.title}"></c:out></a> <b>[<c:out value="${board.replycnt}"></c:out>]</b></td>
						 <td><c:out value="${board.writer}"></c:out></td>
						 <td><fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate}"/></td>
						 <td><fmt:formatDate pattern="yyyy/MM/dd" value="${board.updatedate}"/></td>
						 <!-- date받아서 포매팅하기 -->
						 <!-- cout 을 쓰면 자동으로escape처리되기 때문에 특수문자 오류나 xss에 대응가능 -->
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<form id="searchForm" action="/board/list" method="get">
				<input type="hidden" name="pageNum" value="1"/>
				<input type="hidden" name="amount" value="${pageMaker.cri.amount}"/>
				<select name="type">
					<option value="T" 
					<c:out value="${pageMaker.cri.type == 'T' ? 'selected' : ''}"></c:out>>제목</option>
					<option value="C" 
					<c:out value="${pageMaker.cri.type == 'C' ? 'selected' : ''}"></c:out>>내용</option>
					<option value="W" 
					<c:out value="${pageMaker.cri.type == 'W' ? 'selected' : ''}"></c:out>>작성자</option>
					<option value="TC" 
					<c:out value="${pageMaker.cri.type == 'TC' ? 'selected' : ''}"></c:out>>제목 + 내용</option>
					<option value="TW" 
					<c:out value="${pageMaker.cri.type == 'TW' ? 'selected' : ''}"/> >제목 + 작성자</option>
					<option value="TWC" 
					<c:out value="${pageMaker.cri.type == 'TWC' ? 'selected' : ''}"></c:out>>제목 + 내용 + 작성자</option>
				</select>
				<input type="text" name="keyword" value="${pageMaker.cri.keyword}">
				<button class="btn btn-outline-secondary">Search</button>
			</form>
			<script type="text/javascript">
			//script for search
			$("#searchForm button").on("click",function(e) {
				console.log("search");
				e.preventDefault();

				$("#searchForm").submit();
			});
			</script>
			<nav class="d-flex justify-content-end">
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li class="page-item"><a class="page-link" href="${pageMaker.startPage - 10}">prev</a></li>
					</c:if>
					<c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
							<li class="page-item ${i == param.page ? 'active' : ''}"><a class="page-link" href="${i}">${i}</a></li>
					</c:forEach>
					<c:if test="${pageMaker.next}">
						<li class="page-item"><a class="page-link" href="${pageMaker.startPage + 10}">next</a></li>
					</c:if>
				</ul>
			</nav>
			<form id="actionForm" action="/notice/list" method="get">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}"/>
				<input type="hidden" name="amount" value="${pageMaker.cri.amount}"/>
				<input type="hidden" name="type" value="<c:out value="${pageMaker.cri.type}"/>"/>
				<input type="hidden" name="keyword" value="<c:out value="${pageMaker.cri.keyword}"/>"/>
			</form>
			<script type="text/javascript">
			//script for paging
			var actionForm = $("#actionForm");	
			$(".page-item a").on("click",function(e) {
				console.log("click");
				e.preventDefault();
				actionForm.find("input[name='pageNum']").val($(this).attr("href"));
				actionForm.submit();
			});
			
			$(".move").on("click",function(e) {
				console.log("click");
				e.preventDefault();
				actionForm.append('<input type="hidden" name="bno" value=""/>');
				actionForm.find("input[name='bno']").val($(this).attr("href"));
				actionForm.attr("action","/board/get");
				actionForm.submit();
			});//제목 클릭하면 게시글로 넘어가기
			</script>
		</div>
	</div>
</body>
</html>