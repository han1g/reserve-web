<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#uploadForm {
	display:flex;
	justify-content: space-between;
	vertical-align: center;
}

</style>
</head>
<body>
	<div class="card">
	  <div class="card-header">
	    	사진 업로드
	  </div>
	  <div class="card-body">
		<div id="uploadDiv">
			<form id="uploadForm">
				<span>
					<a type="button" href="/admin/deletedSliderimages" class="btn btn-warning">삭제 목록</a>
					<button id="uploadFileButton" class="btn btn-success">사진 추가</button>
				</span>
				<span>
					<input type='file' id="uploadFile" name='uploadFile' multiple="multiple" style="display:none" ><!-- 화면에서 숨기기  style="display:none"-->
					<button class="btn btn-sm btn-primary" onclick="save(event);">저장</button>
				</span>
			</form>
		</div>
		<form id="sliderimages_register_form" action="/admin/sliderimages/register" method="post">
		<ul class="uploadResult">
			<c:forEach var="image" items="${imagesList}" varStatus="status">
				<li  class ="rounded border border-1 new-li" style="display: flex; align-items:center">
					<input type="hidden" class="form-control" name="sliderimages[${status.index}].no" value="<c:out value="${image.no}"/>">
					<input type="hidden" class="form-control" name="sliderimages[${status.index}].filename" value="<c:out value="${image.filename}"/>">
					<input type="hidden" class="form-control" name="sliderimages[${status.index}].deleteflg" value="<c:out value="${image.deleteflg}"/>">
					<input type="hidden" class="form-control" name="sliderimages[${status.index}].sortno" value="<c:out value="${image.sortno}"/>">
					<img class="img-thumbnail" src="/resources/img/sort-icon.png"style="width:60px;height:60px" alt="...">
					<img src="${image.filename}&thumb=true" class="img-thumbnail carousel-image-target" style="object-fit: contain; width:100px;height:100px" alt="..."
					onclick="showImage('${image}')">
					<input type='file' onchange="changeFileListener(event)" style="display:none" ><!-- 화면에서 숨기기  style="display:none"-->
					<button class="btn btn-warning" onclick="changeFileButtonClick(event)">사진 변경</button>
					<div class="input-group-text">
						<input id="btn-check[${status.index}]" type="checkbox" class="form-check-input" autocomplete="off"  name="sliderimages[${status.index}].activity" value="1" ${image.activity eq '1' ? 'checked' : ''}>
						&nbsp;&nbsp;
						<label for="btn-check[${status.index}]">ACTIVITY</label>
					</div>
					<button class="btn btn-danger" onclick="deleteImageClick(event,true)" >삭제</button>
				</li>
			</c:forEach>
		</ul>
		</form>
	<script>
	var length = ${empty imageList ? '0' : imageList.size() };
	//var length = 1;
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
				str +=`<li class ="rounded border border-1 new-li" style="display: flex; align-items:center">
				<input type="hidden" class="form-control" name="sliderimages[${'${length}'}].filename" value="${'${el}'}">
				<input type="hidden" class="form-control" name="sliderimages[${'${length}'}].deleteflg" value="0">
				<input type="hidden" class="form-control" name="sliderimages[${'${length}'}].sortno" value="${'${length}'}">
				<img class="img-thumbnail" src="/resources/img/sort-icon.png"style="width:60px;height:60px" alt="...">
				<img src="${'${el}'}&thumb=true" class="img-thumbnail carousel-image-target" style="object-fit: contain; width:100px;height:100px" alt="..."
				onclick="showImage('${'${el}'}')">
				<input type='file' name='uploadFile' onchange="changeFileListener(event)" style="display:none"><!-- 화면에서 숨기기  style="display:none"-->
				<button class="btn btn-warning" onclick="changeFileButtonClick(event)">사진 변경</button>
				<div class="input-group-text">
					<input id="btn-check[${'${length}'}]" type="checkbox" class="form-check-input" autocomplete="off"  name="sliderimages[${'${length}'}].activity" value="1" checked>
					&nbsp;&nbsp;
					<label for="btn-check[${'${length}'}]">ACTIVITY</label>
				</div>
				<button class="btn btn-danger" onclick="deleteImageClick(event,true)" >삭제</button>
				</li>`;
				$(".uploadResult").append(str);
				length++;
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
		console.log(el.target);
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
					console.log("carousel-image-target :" + target.siblings(".carousel-image-target"));
					console.log(target.siblings(".carousel-image-target").html());
					target.siblings("input[name *= filename]").val(result);
					target.siblings(".carousel-image-target").attr("src",result + "&thumb=true");
					target.siblings(".carousel-image-target").attr("onclick","showImage('" + result + "')");
					
				},
				complete: function() {
					console.log("complete");
					
					target.val("");
				}
			});
		}
	}
	function deleteImageClick(event,del) {
		event.preventDefault();
		
		var li = $(event.target).closest("li");
		if(li.hasClass("new-li")) {
			li.remove();
			return;
			// 버튼눌러서 추가한 행이면 그냥 지움
		}
		else {
			li.css('display','none');
			//안보이게 하기 : form은 전송됨
		}
		console.log(li.find("input[name*='deleteflg']").attr('name'));
		
		if(del) {
			li.find("input[name*='deleteflg']").val('1');
		} else {
			li.find("input[name*='deleteflg']").val('0');
		}
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
	
	function giveArrIndex() {
		$('.uploadResult > li').each(function(index , val) {
			console.log(index);
			console.log($('.uploadResult > li'));
			
			
			$(val).find('input[name *= "sliderimages"]').each(function() {
				console.log(this);
				var name = $(this).attr('name');
				console.log('name : ' + name);
				console.log('index : ' + index);
				//options[].attr
				
				var index_bef = name.substring(name.indexOf('[') + 1,name.indexOf(']'));
				name = name.replace(index_bef,index);
				$(this).attr('name',name);
				console.log($(this).attr('name'));
			});
			$(val).find("input[name *='sortno']").val(index + 1);
			
		});
	}
	
	function save(event) {
		
		event.preventDefault();
		giveArrIndex();
		//alert("prevent");
		$('#sliderimages_register_form').submit();
	}
	</script>
  </div>
</div>
</body>
</html>