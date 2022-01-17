<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<script src="/resources/lib/jquery/jquery-3.6.0.min.js" ></script>
	TestPage
	<form action="/">
		<input type="submit" value="submit"/>
	</form>
	<script>
	$(document).ready(function() {
		var form = $("form");
		$("input").on("click",function(event) {
			//event.preventDefault();
			alert("alert");
			//this.submit();
		})
	})
	</script>
</body>
</html>