<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
	<body>
		<img src="/notice/image?fileName=2022/01/14/b410fa5c-06c2-430a-a37f-675509e1670c.PNG">
		<form action="/admin/notice/upload_image" method="post" enctype="multipart/form-data">
			<input type='file' name='uploadFile'>
			<button>Submit</button>
		</form>
	</body>
</html>