<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인증오류 페이지</title>
</head>
	<body>
	<div class="modal" id="myModal" tabindex="-1">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	            </div>
	            <div class="modal-body">
	            </div>
	            <div class="modal-footer">
	                <button id="okButton" type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
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
				$("#okButton").focus();
			}
			
			$("#myModal").on("hidden.bs.modal",function(event) {
				history.back();
			})
			
		});
	</script>
	</body>
</html>