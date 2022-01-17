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
					<h2 class="write-h2">상담</h2>
				</div>
				<div class="background-white">
					<c:if test="${method eq 'get'}">
						<div>
							비밀글입니다.
						</div>
					</c:if>
					<form id="actionForm" action="" method="post">			
						<input type="hidden" name="pageNum" value="${cri.pageNum}"/>
						<input type="hidden" name="amount" value="${cri.amount}"/>
						<input type="hidden" name="type" value="<c:out value="${cri.type}"/>"/>
						<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>"/>
						<input type="hidden" name="no" value="${param.no}"/>
						<div>
							<input type="password" name="pw" value="" placeholder="패스워드 입력"/>
							<a href="" role="button" class="btn btn-success" data-oper="confirm" id="btnUpdate">확인</a>
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
									case "confirm":
										form.attr("action","/consultation/${method}");
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
			console.log("result : " + result)
			checkModal(result);
			
			history.replaceState({},null,null);//param : stateobj,title,url
			console.log("replaceState");
			//이전 주소를 지움
			//글 등록 수정 후 뒤로가기 했을 때 모달 창 뜨는거 방지용
			
			function checkModal(result){
				if(result === '' || history.state) {
					//parseInt가 NaN일 때 true
					return;
				}

				$(".modal-body").html(result);
				$("#myModal").modal("show");
			}
			
		});
	</script>
	</body>
</html>