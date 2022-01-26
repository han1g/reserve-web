<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp" %>
<c:set value="${param.no}" var="no"/>

<div>
	<c:if test="${not empty C}">
		<button type="button" class="btn btn-secondary" id="btnList" onclick="location.href = '${admin eq 'admin' ? '/admin' : ''}/${menu}/list';">목록</button>
	</c:if>
	<c:if test="${not empty U}">
		<button type="button" class="btn btn-secondary" id="btnList" onclick="backToList($('#form'));">목록</button>
	</c:if>

	<button type="submit" class="btn btn-success" id="btnSave" onclick="sendReviewForm($('#form'));">등록</button>
</div>
<form id="backToList" action="" method="get" >
	<jsp:include page="/WEB-INF/views/includes/commons/criteria.jsp"/>
</form>
<script type="text/javascript">
		$(document).ready(function() {
		  $('#summernote').summernote({  
			  callbacks: {
				  onImageUpload: function(files, editor, welEditable) {
				              for (var i = files.length - 1; i >= 0; i--) {
				               sendFile(files[i], this);
				              }
				          }
				  }
				  });
		  });
		//summernote 설정
		function sendFile(file, el) {
		   var form_data = new FormData();
	       form_data.append('uploadFile', file);
	       $.ajax({
	         data: form_data,
	         type: "POST",
	         url: '/upload_image',
	         cache: false,
	         contentType: false,
	         enctype: 'multipart/form-data',
	         processData: false,
	         success: function(img_name) {
	        	 console.log(img_name);
	           $(el).summernote('editor.insertImage', img_name);
	         }
	       });
		}
		
		function sendReviewForm(frm) {
			if(validation !== undefined) {
				if(!validation()) {
					return false
				}
			}
			console.log("${U}");
			<c:if test="${not empty U}">
				frm.append(`<input type="hidden" name="no" value="${no}"/>`);
			</c:if>
			console.log("confriM???");
			if(!confirm("등록하시겠습니까?")) {
				return false;
			}
			<c:if test="${menu eq 'roominfo'}">
				var images = fillImageField();
				frm.append(`<input type="hidden" name="images" id="images" value="${'${images}'}">`);
			</c:if>
			
			frm.submit();	
		}
		
		function backToList(form) {
			//매개변수로 받은 form은 안씀 ㅅㄱ
			var backForm = $('#backToList');
			var adminURL = "${admin eq 'admin' ? '/admin' : '' }"
			
			console.log(adminURL);
			//alert(adminURL);
			
			backForm.attr("action",adminURL + "/${menu}/list");
			backForm.attr("method","get");
			
			backForm.submit();
		}
</script>
		