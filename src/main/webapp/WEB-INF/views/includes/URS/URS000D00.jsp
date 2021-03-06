<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .carousel-inner img{
   		height: 600px !important;
	  	object-fit: contain !important;
    }

</style>
</head>
<body>
	<div id="carouselExampleIndicators" class="carousel carousel-dark carousel-thumbnail slide" data-bs-ride="carousel">
	    <div class="carousel-inner">
	    	<c:forEach var="image" items="${imagesList}" varStatus="status">
		        <div class="carousel-item  ${status.first ? 'active' : ''}">
		            <img src="${image.filename}" class="d-block carousel-border-round  w-100">
		        </div>
	        </c:forEach>
	        <c:if test="${empty imagesList}">
	        	<div class="carousel-item active">
		            <img src="/resources/img/logo_icon.png" class="d-block carousel-border-round  w-100">
		        </div>
	        </c:if>
	    </div>
	    <div class="carousel-indicators">
		    <c:forEach var="image" items="${imagesList}" varStatus="status">
		        <button data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${status.index}" 
		        class="${status.first ? 'active' : ''}"></button>
		    </c:forEach>
		    <c:if test="${empty imagesList}">
		    	<button data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" 
		        class="active"></button>
		    </c:if>
		</div>
		<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span>
			<span class="visually-hidden">Next</span>
		</button>
	</div>
</body>
</html>