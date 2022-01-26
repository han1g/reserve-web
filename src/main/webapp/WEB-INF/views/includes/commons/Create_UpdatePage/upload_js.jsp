<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp" %>
<c:set  value="${param.no}" var="no"/>
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
			<c:if test="${U ne null}">
				frm.append(`<input type="hidden" name="no" value="${no}"/>`);
			</c:if>
			console.log("confriM???");
			if(!confirm("등록하시겠습니까?")) {
				return false;
			}
			
			frm.submit();	
		}
		
		function backToList(form) {
			var adminURL = "${admin}" === "admin" ? "/admin" : "";
			
			console.log(adminURL);
			//alert(adminURL);
			
			form.attr("action",adminURL + "/${menu}/list");
			form.attr("method","get");
			
			form.submit();
		}

</script>
		