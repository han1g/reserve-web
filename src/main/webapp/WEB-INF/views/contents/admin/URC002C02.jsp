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
					<h2 class="write-h2">답글 등록</h2>
				</div>
				<div class="background-white">
					<form action="/admin/consultation/registerReply" name="form" id="form" role="form" method="post">
						<input type="hidden" name="pageNum" value="${cri.pageNum}"/>
						<input type="hidden" name="amount" value="${cri.amount}"/>
						<input type="hidden" name="type" value="<c:out value="${cri.type}"/>"/>
						<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>"/>
						
						<input type="hidden" name="ref_no" value="${consultation.no}"/>
						<div class="mb-3">
							<label for="title">Title</label> 
							<input type="text"
								class="form-control" name="title" id="title" value="Re: ${consultation.title}"
								placeholder="제목을 입력해 주세요">
						</div>
						<div class="mb-3">
							<label for="name">Name</label> 
							<input type="text"
								class="form-control" name="name" id="name" value="운영자" readonly="readonly"
								placeholder="이름을 입력해 주세요">
						</div>
						<div id="div_lock" class="form-check mb-3">
							<input type="hidden" class="form-check-input" name="lockflg" value="0" id="chk_lock_hidden"/><!-- checkbox가 언체크드면 이게 감-->
							<label for="chk_lock" class="form-check-label">비밀글</label>
							<input type="checkbox" class="" name="lockflg" id="chk_lock"
								value="1">
						</div>
						<div class="mb-3">
							<textarea id="summernote" name="contents"></textarea>
						</div>
					</form>
					<div>
						<button type="button" class="btn btn-secondary" id="btnList" onclick="backToList($('#form'));">목록</button>
						<button type="submit" class="btn btn-success" id="btnSave" onclick="sendReviewForm($('#form'));">등록</button>
					</div>
				</div>
			</div>
		</article>
		<script type="text/javascript">
				var initContent = "<p><br><p>";
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
				  console.log(initContent);
				  $('#summernote').summernote('code', initContent);
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
				$(document).ready(function() {
					if($("#chk_lock").is(":checked")) {
						$("#chk_lock_hidden").attr('disabled','disabled');
					} else {
						$("#chk_lock_hidden").removeAttr('disabled');
					}
					
					$("#chk_lock").on('change',function() {
						
						if($("#chk_lock").is(":checked")) {
							$("#chk_lock_hidden").attr('disabled','disabled');
						} else {
							$("#chk_lock_hidden").removeAttr('disabled');
						}
					});
				});//비밀글 관련 div 설정
				
				function sendReviewForm(frm) {
					var title = $('#title').val();
					var contents = $("#summernote").summernote('code');
					console.log(contents);
					var writer = $("#name").val();
					var passwd = $("#passwd").val();
					if (title.trim() == ''){
						alert("제목을 입력해주세요");
						return false;
					}
					
					if (contents.trim() == '' || contents.trim() == initContent){
						alert("내용을 입력해주세요");
						return false;
					}
					if (writer.trim() =='') {
						alert("이름을 입력해주세요");
						return false;
					}
					
					if(!confirm("등록하시겠습니까?")) {
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
					form.attr("action","/admin/consultation/list");
					form.attr("method","get");
					
					form.submit();
				}
				
		</script>
	</body>
</html>