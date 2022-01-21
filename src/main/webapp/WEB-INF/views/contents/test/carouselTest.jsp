<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.carousel-indicators {
	  position: static;
	  display: flex;
	  flex-wrap: wrap;
	  justify-content: center;
	  width: 100% !important;
      padding-right: 15%;
      padding-left: 15%;
      margin: 0;
	}
	.carousel-indicators img {
	  width: 60px !important;
	  height: 60px !important;
	  object-fit: contain !important;
	}
	.carousel-indicator-thumbnail {
	    padding: 0.25rem !important;
	    background-color: #fff !important;
	    border: 1px solid #dee2e6 !important;
	    border-radius: 0.25rem !important;
	    max-width: 100% !important;
	    height: auto !important;
    }
}
</style>
</head>
<body>
	<div id="carouselExampleIndicators" class="carousel carousel-dark slide" data-bs-ride="carousel">
	    <div class="carousel-inner">
	        <div class="carousel-item active">
	            <img src="/resources/img/logo_icon.png" class="d-block w-100">
	        </div>
	        <div class="carousel-item">
	            <img src="/resources/img/logo_icon.png" class="d-block w-100">
	        </div>
	        <div class="carousel-item">
	            <img src="/resources/img/logo_icon.png" class="d-block w-100">
	        </div>
	        <div class="carousel-item">
	            <img src="/resources/img/logo_icon.png" class="d-block w-100">
	        </div>
	        <div class="carousel-item">
	            <img src="/resources/img/logo_icon.png" class="d-block w-100">
	        </div>
	    </div>
	    <div class="carousel-indicators">
	        <img data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="carousel-indicator-thumbnail active" src="/resources/img/logo_icon.png" class="w-100">
	        <img data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" class="carousel-indicator-thumbnail" src="/resources/img/logo_icon.png" class="w-100">
	        <img data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" class="carousel-indicator-thumbnail" src="/resources/img/logo_icon.png" class="w-100">
	        <img data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" class="carousel-indicator-thumbnail" src="/resources/img/logo_icon.png" class="w-100">
	        <img data-bs-target="#carouselExampleIndicators" data-bs-slide-to="4" class="carousel-indicator-thumbnail" src="/resources/img/logo_icon.png" class="w-100">
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