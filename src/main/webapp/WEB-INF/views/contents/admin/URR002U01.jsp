<%@page import="com.example.demo.domain.roominfo.RoominfoDTO"%>
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
						<jsp:include page="/WEB-INF/views/includes/commons/criteria.jsp"/>
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
					<%request.setAttribute("imagesList", ((RoominfoDTO) request.getAttribute("roominfo")).getImagesList());%>
					<jsp:include page="/WEB-INF/views/includes/commons/Create_UpdatePage/carousel_image_upload.jsp"/>
					
					<jsp:include page="/WEB-INF/views/includes/URR/validation_js.jsp"/>
					<jsp:include page="/WEB-INF/views/includes/commons/Create_UpdatePage/upload_form.jsp">
						<jsp:param value="01" name="U"/>
					</jsp:include>
				</div>
			</div>
		</article>
		
	</body>
</html>