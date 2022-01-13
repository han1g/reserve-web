<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
					<h2 class="write-h2">공지 쓰기</h2>
				</div>
				<div class="background-white">
					<form action="/" name="form" id="form" role="form" method="post">
						<div class="mb-3">
							<label for="title"></label> 
							<input type="text"
								class="form-control" name="title" id="title"
								placeholder="제목을 입력해 주세요">
								
						</div>
						<div class="mb-3">
							<textarea id="summernote" name="content"></textarea>
						</div>
					</form>
					<div>
						<button type="button" class="btn btn-danger" id="btnList" onclick="toggleReviewForm(false);">취소</button>
						<button type="button" class="btn btn-success" id="btnSave" onclick="sendReviewForm($('#form'));">등록</button>
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
			       form_data.append('file', file);
			       $.ajax({
			         data: form_data,
			         type: "POST",
			         url: './upload_image.do',
			         cache: false,
			         contentType: false,
			         enctype: 'multipart/form-data',
			         processData: false,
			         success: function(img_name) {
			           $(el).summernote('editor.insertImage', img_name);
			         }
			       });
				}
				
				function sendReviewForm(frm) {
					var title = $('#title').val();
					var content = $("#summernote").summernote('code');
					var preview = $($("#summernote").summernote("code")).text().substring(0,80);
					if (title.trim() == ''){
						alert("제목을 입력해주세요");
						return false;
					}
					
					if (content.trim() == ''){
						alert("내용을 입력해주세요");
						return false;
					}
					
					var sendData = {"title": title,"preview" :preview,"content" : content,"pid" : <%=request.getParameter("pid") %> };
					$.ajax({
				        url:'review_create.do'
				        , method : 'POST'
				        , data: JSON.stringify(sendData)
				        , contentType : 'application/json; charset=UTF-8'
				        , dataType : 'json'
				        , success : function(resp) {
							if(resp == null) {
								alert("등록에 실패했습니다.");
								return;
							}
							alert("등록 되었습니다.");
							toggleReviewForm(false);
							loadReview(review_selected_div,1);
							$('#review-detail').load('review_detail.action',{"rid":resp.id});
							$('#review-detail').css('display','block');
							$('#review-form').css('display','none');
							
				        }
					    , error : function(error) {
							alert("등록에 실패했습니다.");
						}
				    });//ajax로 검색	
				}
		</script>
	</body>
</html>