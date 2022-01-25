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
					<h2 class="write-h2">방 수정</h2>
				</div>
				<div class="background-white">
					<form action="/admin/roominfo/modify" name="form" id="form" role="form" method="post">
							<input type="hidden" name="pageNum" value="${cri.pageNum}"/>
							<input type="hidden" name="amount" value="${cri.amount}"/>
							<input type="hidden" name="type" value="<c:out value="${cri.type}"/>"/>
							<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>"/>
							
							<input type="hidden" name="maxpeople_min" value="<c:out value="${cri.maxpeople_min}"/>"/>
							<input type="hidden" name="maxpeople_max" value="<c:out value="${cri.maxpeople_max}"/>"/>
							<input type="hidden" name="adultcost_min" value="<c:out value="${cri.adultcost_min}"/>"/>
							<input type="hidden" name="adultcost_max" value="<c:out value="${cri.adultcost_max}"/>"/>
							<input type="hidden" name="childcost_min" value="<c:out value="${cri.childcost_min}"/>"/>
							<input type="hidden" name="childcost_max" value="<c:out value="${cri.childcost_max}"/>"/>
							<!-- criteria to return to previous list -->
							
						<div class="mb-3">
							<label for="roomnum">Room Num.</label> 
							<input type="number"
								class="form-control required" name="roomnum" min="0" id="roomnum" max="9999" value="${roominfo.roomnum}"
								placeholder="방 번호를 입력해 주세요" required>
						</div>
						<div class="mb-3">
							<label for="roomtitle">Room Title</label> 
							<input type="text"
								class="form-control required" name="roomtitle" id="roomtitle" value="${roominfo.roomtitle}"
								placeholder="방 이름을 입력해 주세요" required>
						</div>
						<div class="mb-3">
							<label for="explanation">Explanation</label> 
							<textarea 
								class="form-control required" name="explanation" id="explanation"
								placeholder="설명을 입력해 주세요" rows="3" required>${roominfo.explanation}</textarea>
						</div>
						<div class="mb-3">
							<label for="maxpeople">Maxpeople</label> 
							<input type="number"
								class="form-control w-25 required" name="maxpeople" id="maxpeople" min="0" value="${roominfo.maxpeople}" max="100"
								placeholder="최대 인원수를 입력해주세요" required>
						</div>
						<div class="mb-3">
							<label for="adultcost">Adultcost</label>
							<div class="input-group w-25"> 
								<span class="input-group-text">￥</span>
								<input type="number"
									class="form-control w-25 required" name="adultcost" id="adultcost" min="0" value="${roominfo.adultcost}" max="100000"
									placeholder="어른 1명당 가격" required>
							</div>
						</div>
						<div class="mb-3">
							<label for="childcost">Childcost</label> 
							<div class="input-group w-25"> 
								<span class="input-group-text">￥</span>
								<input type="number"
									class="form-control required" name="childcost" id="childcost" min="0" value="${roominfo.childcost}" max="100000"
									placeholder="어린이 1명당 가격" required>
							</div>
						</div>
						<div class="mb-3">
							<label for="colorcd">Colorcd(색을 선택해주세요)</label> 
							<input type="color"
								class="form-control form-control-color required" name="colorcd" id="colorcd" value="${roominfo.colorcd}"
								placeholder="" required>
						</div>
					</form>
					<div class="card">
					  <div class="card-header">
					    	사진 업로드
					  </div>
					  <div class="card-body">
						<div id="uploadForm">
							<form id="uploadForm">
								<button id="uploadFileButton" class="btn btn-success">사진 추가</button>
								<input type='file' id="uploadFile" name='uploadFile' multiple="multiple" style="display:none" ><!-- 화면에서 숨기기  style="display:none"-->
							</form>
						</div>
						<ul class="uploadResult">
							<c:forEach var="image" items="${roominfo.imagesList}" varStatus="status">
								<li class ="rounded border border-1" style="display: flex; align-items:center">
										<img class="img-thumbnail" src="/resources/img/sort-icon.png"style="width:60px;height:60px" alt="...">
										<img src="${image}&thumb=true" class="img-thumbnail target" style="object-fit: contain; width:100px;height:100px" alt="..."
										onclick="showImage('${image}')">
										<form>
											<button class="btn btn-warning" onclick="changeFileButtonClick(event)">변경</button>
											<input type='file' name='uploadFile' onchange="changeFileListener(event)" style="display:none"><!-- 화면에서 숨기기  style="display:none"-->
											<button class="btn btn-danger" onclick="deleteImageClick(event)" >삭제</button>
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
								var arr = result.split("\n");
								arr.forEach((el) => {
									if(el === "") return;
									
									console.log("el:" + el);
									var str ="";
									str +=`<li class ="rounded border border-1" style="display: flex; align-items:center">
									<img class="img-thumbnail" src="/resources/img/sort-icon.png"style="width:60px;height:60px" alt="...">
									<img src="${'${el}'}&thumb=true" class="img-thumbnail target" style="object-fit: contain; width:100px;height:100px" alt="..."
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
										console.log(target.parent().siblings(".target"));
										console.log(target.parent().siblings(".target").html());
										target.parent().siblings(".target").attr("src",result + "&thumb=true");
										target.parent().siblings(".target").attr("onclick","showImage('" + result + "')");
										
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
					  </div>
					</div>
					
					<div>
						<button type="button" class="btn btn-secondary" id="btnList" onclick="backToList($('#actionForm'));">목록</button>
						<button type="submit" class="btn btn-success" id="btnSave" onclick="sendReviewForm($('#form'));">수정</button>
					</div>
				</div>
			</div>
		</article>
		<script type="text/javascript" >
				function fillImageField() {
					var images = "";
					$(".target").each(function (index,item) {
						console.log(item);
						var str = $(item).attr("src");
						console.log("str:" + str);
						str = str.replace("&thumb=true","");
						console.log("str:" + str);
						images += str;
						images += ";";
					});
					images = images.substring(0, images.length - 1);
					console.log("images:" + images);
					return images;
				};
				function sendReviewForm(frm) {
					var required = $("input.required");
					console.log(required);
					for(var el of required) {
						console.log($(el));
						if($(el).val().trim() == '' ) {
							console.log("trim");
							alert("잘못된 필드가 있습니다");
							return false;
						}
						if($(el).attr("type") === "number") {
							console.log($(el));
							console.log($(el).attr("type"));
							console.log(parseInt($(el).val()));
							console.log(isNaN($(el).val()));
							console.log(parseInt($(el).attr("value")));
							console.log(parseInt($(el).attr("max")));
							console.log(parseInt($(el).attr("min")));
							
							if(isNaN(parseInt($(el).val()))) {
								alert("잘못된 필드가 있습니다");
								return false;
							}
							$(el).val(parseInt($(el).val()));
							console.log($(el).val());
							if($(el).val() > parseInt($(el).attr("max"))) {
								alert("잘못된 필드가 있습니다");
								return false;
							}
							if($(el).val() < parseInt($(el).attr("min"))) {
								alert("잘못된 필드가 있습니다");
								return false;
							}
						}
					}
					
					if(!confirm("등록하시겠습니까?")) {
						return false;
					}
					var images = fillImageField();
					frm.append(`<input type="hidden" name="images" id="images" value="${'${images}'}">`);
					
					frm.submit();
				}
				function backToList(form) {
					form.attr("action","/admin/roominfo/list");
					form.attr("method","get");
					
					form.submit();
				}
		</script>
		<form id="actionForm" action="" method="get">
			<input type="hidden" name="pageNum" value="${cri.pageNum}"/>
			<input type="hidden" name="amount" value="${cri.amount}"/>
			<input type="hidden" name="type" value="<c:out value="${cri.type}"/>"/>
			<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>"/>
			
			<input type="hidden" name="maxpeople_min" value="<c:out value="${cri.maxpeople_min}"/>"/>
			<input type="hidden" name="maxpeople_max" value="<c:out value="${cri.maxpeople_max}"/>"/>
			<input type="hidden" name="adultcost_min" value="<c:out value="${cri.adultcost_min}"/>"/>
			<input type="hidden" name="adultcost_max" value="<c:out value="${cri.adultcost_max}"/>"/>
			<input type="hidden" name="childcost_min" value="<c:out value="${cri.childcost_min}"/>"/>
			<input type="hidden" name="childcost_max" value="<c:out value="${cri.childcost_max}"/>"/>
		</form>
	</body>
</html>