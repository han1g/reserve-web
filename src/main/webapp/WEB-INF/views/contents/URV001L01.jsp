<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<jsp:include page="/WEB-INF/views/includes/URV/fullcalendar.jsp"/>
</head>
<body>
 	name : ${param.name};<br>phone : ${param.phone};
  <div id='calendar'></div>
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
				} else {
					$(".modal-body").html(result);
					$("#myModal").modal("show");
				}
			}
			
		});
	</script>

</body>
</html>