<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	
	<title>UR web test site</title>
	<script src="/resources/lib/jquery/jquery-3.6.0.min.js" ></script>
	<script src="/resources/lib/bootstrap-5.1.3-dist/js/bootstrap.min.js" ></script>
	
	<link href="/resources/lib/bootstrap-5.1.3-dist/css/bootstrap.css" rel="stylesheet"/>
	<link href="/resources/css/reset.css" rel="stylesheet"/>
	<link href="/resources/css/common.css" rel="stylesheet"/>
	
	<link rel="shortcut icon" href="/resources/img/favicon.ico"/>
	 	
</head>
<body>
	<tiles:insertAttribute name="header" />
	<tiles:insertAttribute name="body" />
	<tiles:insertAttribute name="footer" />
</body>
</html>