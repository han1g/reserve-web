<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
			<form id="searchForm" action="/admin/notice/list" method="get">
				<input type="hidden" name="pageNum" value="1"/>
				<input type="hidden" name="amount" value="${pageMaker.cri.amount}"/>
				<select name="type">
					<option value="T" 
					<c:out value="${pageMaker.cri.type == 'T' ? 'selected' : ''}"></c:out>>제목</option>
					<option value="C" 
					<c:out value="${pageMaker.cri.type == 'C' ? 'selected' : ''}"></c:out>>내용</option>
					<option value="TC" 
					<c:out value="${pageMaker.cri.type == 'TC' ? 'selected' : ''}"></c:out>>제목 + 내용</option>
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
						<c:choose>
							<c:when test="${pageMaker.cri.pageNum == i}">
								<li style="pointer-events : none;" class="page-item active"><a class="page-link" href="${i}">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" href="${i}">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${pageMaker.next}">
						<li class="page-item"><a class="page-link" href="${pageMaker.startPage + 10}">next</a></li>
					</c:if>
				</ul>
			</nav>
			<form id="actionForm" action="/admin/notice/list" method="get">
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
			});//페이지 이동
			
			$(".move").on("click",function(e) {
				console.log("click");
				e.preventDefault();
				actionForm.append('<input type="hidden" name="no" value=""/>');
				actionForm.find("input[name='no']").val($(this).attr("href"));
				actionForm.attr("action","/admin/notice/get");
				actionForm.submit();
			});//제목 클릭하면 게시글로 넘어가기
			</script>
		</div>
		<div>
			<a href="/admin/notice/register" class="btn btn-outline-success">글쓰기</a>
		</div>
	</div>
	
	 <!-- Modal -->
	<div class="modal" id="myModal" tabindex="-1">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	            </div>
	            <div class="modal-body">
	                
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
	            </div>
	        </div>
	        <!-- /.modal-content -->
	    </div>
	    <!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	<script type="text/javascript">
		$(document).ready(function() {
			var result ="<c:out value="${result}"/>";
			
			checkModal(result);
			
			history.replaceState({},null,null)//param : stateobj,title,url
			//글 등록 수정 후 뒤로가기 했을 때 모달 창 뜨는거 방지용
			
			function checkModal(result){
				if(result === '' || history.state) {
					//parseInt가 NaN일 때 true
					return;
				}
				if(parseInt(result) > 0) {
					$(".modal-body").html("게시글" + result + "번이 등록 되었습니다");
					$("#myModal").modal("show");
				} else if(result === "success") {
					$(".modal-body").html("처리 완료");
					$("#myModal").modal("show");
				}
			}
			
		})
	</script>
</body>
</html>