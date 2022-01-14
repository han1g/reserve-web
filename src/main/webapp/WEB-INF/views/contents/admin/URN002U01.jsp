<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/lib/summernote-0.8.18-dist/summernote-lite.css">
<script src="/resources/lib/summernote-0.8.18-dist/summernote-lite.js"></script>
<title>Home</title>
</head>
	<body>
		<article>
			<div class="container" role="main">
				<div class="h2">
					<h2 class="write-h2">공지 수정</h2>
				</div>
				<div class="background-white">
					<form action="/admin/notice/modify" name="form" id="form" role="form" method="post">
						<input type="hidden" name="pageNum" value="${cri.pageNum}"/>
						<input type="hidden" name="amount" value="${cri.amount}"/>
						<input type="hidden" name="type" value="<c:out value="${cri.type}"/>"/>
						<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>"/>
						<input type="hidden" name="no" value="${notice.no}"/>
						
						<div class="mb-3">
							<label for="title"></label> 
							<input type="text"
								class="form-control" name="title" id="title"
								value ="${notice.title}"placeholder="제목을 입력해 주세요">
						</div>
						<div class="mb-3">
							<textarea id="summernote" name="contents">${notice.contents}</textarea>
						</div>
					</form>
					<div>
						<button type="button" class="btn btn-secondary" id="btnList" onclick="backToList($('#form'));">목록</button>
						<button type="button" class="btn btn-warning" id="btnSave" onclick="sendReviewForm($('#form'));">수정</button>
					</div>
				</div>
			</div>
		</article>
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
			         url: '/admin/notice/upload_image',
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
					var title = $('#title').val();
					var contents = $("#summernote").summernote('code');
					if (title.trim() == ''){
						alert("제목을 입력해주세요");
						return false;
					}
					
					if (contents.trim() == ''){
						alert("내용을 입력해주세요");
						return false;
					}
					
					frm.submit();
					
				}
				function backToList(form) {
					var pageNum = form.append($("input[name='pageNum']").clone());
					var amount = form.append($("input[name='amount']").clone());
					var type = form.append($("input[name='type']").clone());
					var keyword = form.append($("input[name='keyword']").clone());
					form.empty();
					form.append(pageNum);
					form.append(amount);
					form.append(type);
					form.append(keyword);
					form.attr("action","/admin/notice/list");
					form.attr("method","get");
					
					form.submit();
				}
				
		</script>
	</body>
</html>