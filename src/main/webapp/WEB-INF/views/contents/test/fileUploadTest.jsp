<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
	<body>
		<h1>Upload With Ajax</h1>
		<button id="registerButton" onclick="register()">등록</button>
		<div id="uploadForm">
			<form id="uploadForm">
				<button id="uploadFileButton">업로드</button>
				<input type='file' id="uploadFile" name='uploadFile' multiple="multiple"  ><!-- 화면에서 숨기기  style="display:none"-->
			</form>
		</div>
		<ul class="uploadResult">
			<li class ="rounded border border-1" style="display: flex; align-items:center">
				<img class="img-thumbnail" src="/resources/img/sort-icon.png"style="width:60px;height:60px" alt="...">
				<img src="/image?fileName=2022/01/20/c20a0e0e-cdd4-43f4-880f-3431e7e16234.PNG&thumb=true" class="img-thumbnail target" style="object-fit: contain; width:100px;height:100px" alt="..."
					onclick="showImage('/image?fileName=2022/01/20/c20a0e0e-cdd4-43f4-880f-3431e7e16234.PNG&thumb=true')">
				<form>
					<button onclick="changeFileButtonClick(event)">변경</button>
					<input type='file' name='uploadFile' onchange="changeFileListener(event)" style="display:none" ><!-- 화면에서 숨기기  style="display:none"-->
					<button onclick="deleteImageClick(event)">삭제</button>
				</form>
			</li>
			<li class ="rounded border border-1" style="display: flex; align-items:center">
				<img class="img-thumbnail" src="/resources/img/sort-icon.png"style="width:60px;height:60px" alt="...">
				<img src="/image?fileName=2022/01/20/c20a0e0e-cdd4-43f4-880f-3431e7e16234.PNG&thumb=true" class="img-thumbnail target" style="object-fit: contain; width:100px;height:100px" alt="...">
				<form>
					<button onclick="changeFileButtonClick(event)">변경</button>
					<input type='file' name='uploadFile' onchange="changeFileListener(event)" style="display:none"><!-- 화면에서 숨기기  style="display:none"-->
					<button onclick="deleteImageClick(event)">삭제</button>
				</form>
			</li>
			
		</ul>
		<script>
		function register() {
			var images = "";
			$(".target").each(function (index,item) {
				console.log(item);
				var str = $(item).attr("src");
				console.log(str);
				str = str.replace("&thumb=true","");
				console.log(str);
				images += str;
				images += ";";
			});
			images = images.substring(0, ret.length - 1);
			console.log(images);
		};
		function showImage(src) {
			console.log(src);
			src = src.replace("thumb=true","thumb=false");
			
			var img=new Image();
			img.src=src;
			img.onload = function() {
				console.log(img);
				var img_width=img.width;
				var win_width=img.width+50;
				var img_height=img.height;
				var win_height=img.height+20;
				console.log(img.width);
				console.log(img.height);
				var OpenWindow=window.open('','_blank', 'width='+win_width+', height='+ win_height+', menubars=no, scrollbars=auto');
				OpenWindow.document.write("<style>body{margin:0px;}</style><img src='"+src+"' width='"+img_width+"'>");
			}

		}
		
		$(document).ready(function () {
			$( ".uploadResult" ).sortable();
			
			
			$("#uploadFileButton").on('click',function (e) {
				e.preventDefault();
				console.log("click");
				
			    $("#uploadFile").trigger('click');
			});//클릭이벤트 전달하기
			
			$("#uploadFile").on('change',function (e) {
				var files = $("#uploadFile").prop('files');
				console.log(files);
				if(files.length > 0) {
					console.log("change");
					var formData = new FormData();
					
					//add File to formData
					for(var i = 0 ; i< files.length; i++) {
						if(!checkExtension(files[i].name,files[i].size)) {
							return false;
						}
						
						formData.append("uploadFile",files[i]);
					}
					
					$.ajax({
						url: '/upload_image',
						processData: false, // 이거 
						contentType: false, // 둘다 false로 해야됨
						data: formData,
						type: 'POST',
						datatype: 'json',//response datatype
						success: function(result) {
							console.log(result);
							alert(result);
							afterUpload(result);
						},
						complete: function() {
							console.log("complete");
							$("#uploadFile").val("");
						}
					});
				}
			});//변경이벤트 감지
			
			$(".bigPictureWrapper").on("click", function(e) {
				$(this).hide();
			});
			
			
			
			
			function afterUpload(result) {
				var arr = result.split("\n");
				arr.forEach((el) => {
					if(el === "") return;
					
					console.log("el:" + el);
					var str ="";
					str +=`<li class ="rounded border border-1" style="display: flex; align-items:center">
					<img class="img-thumbnail" src="/resources/img/sort-icon.png"style="width:60px;height:60px" alt="...">
					<img src="${'${el}'}&thumb=true" class="img-thumbnail target" style="object-fit: contain; width:100px;height:100px" alt="...">
					<form>
						<button onclick="changeFileButtonClick(event)">변경</button>
						<input type='file' name='uploadFile' onchange="changeFileListener(event)" style="display:none"><!-- 화면에서 숨기기  style="display:none"-->
						<button onclick="deleteImageClick(event)">삭제</button>
					</form>
					</li>`;
					$(".uploadResult").append(str);
				});
				
			}//업로드 이후의 처리
		});
		function changeFileButtonClick(el) {
			var target = $(el.target);
			console.log(el.target);
			console.log(target);
			console.log(target.siblings("input"));
			el.preventDefault();
			target.siblings("input").trigger("click");
		}
		function changeFileListener(el) {
			var target = $(el.target);
			console.log(target);
			var files = target.prop('files');
			console.log(files);
			if(files.length > 0) {
				console.log("change");
				var formData = new FormData();
				//add File to formData
				for(var i = 0 ; i< files.length; i++) {
					if(!checkExtension(files[i].name,files[i].size)) {
						return false;
					}
					
					formData.append("uploadFile",files[i]);
				}
				$.ajax({
					url: '/upload_image',
					processData: false, // 이거 
					contentType: false, // 둘다 false로 해야됨
					data: formData,
					type: 'POST',
					datatype: 'json',//response datatype
					success: function(result) {
						console.log(result);
						console.log(target.parent().siblings(".target"));
						console.log(target.parent().siblings(".target").html());
						target.parent().siblings(".target").attr("src",result + "&thumb=true");
					},
					complete: function() {
						console.log("complete");
						
						target.val("");
					}
				});
			}
		}
		function deleteImageClick(event) {
			event.preventDefault();
			$(event.target).closest("li").remove();
		}
		
		function checkExtension(fileName,fileSize) {
			var regex = /\.(exe|sh|zip|alz)$/;
			var maxSize = 5242880;//5mb
			console.log(fileName);
			console.log(fileSize);
			if(fileSize >= maxSize) {
				alert("파일사이즈 초과");
				return false;
			}
			if(regex.test(fileName)) {
				alert("업로드 불가능한 확장자")
				return false;
			}
			return true;
		}
		</script>
	</body>
</html>