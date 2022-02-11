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
					<h2 class="write-h2">部屋登録</h2>
				</div>
				<div class="background-white">
					<form action="/admin/roominfo/register" name="form" id="form" role="form" method="post">
						<div class="mb-3">
							<label for="roomnum">部屋番号</label> 
							<input type="number"
								class="form-control required" name="roomnum"  min="0" id="roomnum" max="9999"
								placeholder="部屋番号を入力してください。 (0 - 9999)" required>
						</div>
						<div class="mb-3">
							<label for="roomtitle">部屋名</label> 
							<input type="text"
								class="form-control required" name="roomtitle" id="roomtitle"
								placeholder="部屋名を入力してください。" required>
						</div>
						<div class="mb-3">
							<label for="explanation">詳細情報</label> 
							<textarea 
								class="form-control required" name="explanation" id="explanation"
								placeholder="詳細情報を入力してください。" rows="3" required></textarea>
						</div>
						<div class="mb-3">
							<label for="maxpeople">最大人数</label> 
							<input type="number"
								class="form-control w-25 required" name="maxpeople" id="maxpeople" min="0" value="" max="100"
								placeholder="最大人数 (0 - 100)" required>
						</div>
						<div class="mb-3">
							<label for="adultcost">大人料金</label>
							<div class="input-group w-25"> 
								<span class="input-group-text">￥</span>
								<input type="number"
									class="form-control w-25 required" name="adultcost" id="adultcost" min="0" value="" max="100000"
									placeholder="大人1人当たりの料金(0 - 100000)" required>
							</div>
						</div>
						<div class="mb-3">
							<label for="childcost">小人料金</label> 
							<div class="input-group w-25"> 
								<span class="input-group-text">￥</span>
								<input type="number"
									class="form-control required" name="childcost" id="childcost" min="0"  value="" max="100000"
									placeholder="小人1人当たりの料金 (0 - 100000) " required>
							</div>
						</div>
						<div class="mb-3">
							<label for="colorcd">色コード</label> 
							<input type="color"
								class="form-control form-control-color required" name="colorcd" id="colorcd" value="#000000"
								placeholder="" required>
						</div>
					</form>
					
					<jsp:include page="/WEB-INF/views/includes/commons/Create_UpdatePage/carousel_image_upload.jsp"/>
					
					<jsp:include page="/WEB-INF/views/includes/URR/validation_js.jsp"/>
					<jsp:include page="/WEB-INF/views/includes/commons/Create_UpdatePage/upload_form.jsp">
						<jsp:param value="01" name="C"/>
					</jsp:include>
				</div>
			</div>
		</article>
		
	</body>
</html>