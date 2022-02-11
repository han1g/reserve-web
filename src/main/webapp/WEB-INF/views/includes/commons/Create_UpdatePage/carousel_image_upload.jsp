<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp" %>
${imagesList}
<div class="card">
  <div class="card-header">
    	사진 업로드
  </div>
  <div class="card-body">
	<div id="uploadForm">
		<form id="uploadForm">
			<button id="uploadFileButton" class="btn btn-success">画像追加</button>
			<input type='file' id="uploadFile" name='uploadFile' multiple="multiple" style="display:none" ><!-- 화면에서 숨기기  style="display:none"-->
		</form>
	</div>
	<ul class="uploadResult">
		<c:forEach var="image" items="${imagesList}" varStatus="status">
			<li class ="rounded border border-1" style="display: flex; align-items:center; cursor: grab;">
					<img class="img-thumbnail" src="/resources/img/sort-icon.png"style="width:60px;height:60px" alt="...">
					<img src="${image}&thumb=true" class="img-thumbnail carousel-image-target" style="object-fit: contain; width:100px;height:100px;cursor: zoom-in;" alt="..."
					onclick="showImage('${image}')">
					<form>
						<button class="btn btn-warning" onclick="changeFileButtonClick(event)">変更</button>
						<input type='file' name='uploadFile' onchange="changeFileListener(event)" style="display:none"><!-- 화면에서 숨기기  style="display:none"-->
						<button class="btn btn-danger" onclick="deleteImageClick(event)" >削除</button>
					</form>
			</li>
		</c:forEach>
	</ul>
	<script>
	function showImage(src) {
		console.log(src);
		
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
			console.log(result)
			var arr = result.split("\n");
			arr.forEach((el) => {
				if(el === "") return;
				
				console.log("el:" + el);
				var str ="";
				str +=`<li class ="rounded border border-1" style="display: flex; align-items:center">
				<img class="img-thumbnail" src="/resources/img/sort-icon.png"style="width:60px;height:60px;cursor: zoom-in;" alt="...">
				<img src="${'${el}'}&thumb=true" class="img-thumbnail carousel-image-target" style="object-fit: contain; width:100px;height:100px" alt="..."
				onclick="showImage('${'${el}'}')">
				<form>
					<button class="btn btn-warning" onclick="changeFileButtonClick(event)">변경</button>
					<input type='file' name='uploadFile' onchange="changeFileListener(event)" style="display:none"><!-- 화면에서 숨기기  style="display:none"-->
					<button class="btn btn-danger" onclick="deleteImageClick(event)" >삭제</button>
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
					console.log(target.parent().siblings(".carousel-image-target"));
					console.log(target.parent().siblings(".carousel-image-target").html());
					target.parent().siblings(".carousel-image-target").attr("src",result + "&thumb=true");
					target.parent().siblings(".carousel-image-target").attr("onclick","showImage('" + result + "')");
					
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
			alert("ファイルサイズ超過");
			return false;
		}
		if(regex.test(fileName)) {
			alert("この拡張子はアプロード出来ません。")
			return false;
		}
		return true;
	}
	</script>
  </div>
</div>