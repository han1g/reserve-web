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
	.carousel-thumbnail {
	    padding: 0.25rem !important;
	    background-color: #fff !important;
	    border: 2px solid #3d3d3d !important;
	    border-radius: 0.25rem !important;
	    max-width: 100% !important;
	    height: auto !important;
    }
    .carousel-border-round {
    	border-radius: 0.5rem !important;
    }
    .carousel-inner img{
   		height: 400px !important;
	  	object-fit: contain !important;
    }
}
</style>
</head>
	<body>
		<article>
			<div class="container" role="main">
				<div class="h2">
					<h2 class="write-h2">방 상세정보</h2>
				</div>
				<div class="background-white">
					<form action="/admin/roominfo/register" name="form" id="form" role="form" method="post">
						<div class="mb-3">
							<label for="roomnum">Room Num.</label> 
							<input type="number"
								class="form-control required" name="roomnum" id="roomnum" max="9999"
								value="${roominfo.roomnum}"readonly="readonly">
						</div>
						<div class="mb-3">
							<label for="roomtitle">Room Title</label> 
							<input type="text"
								class="form-control required" name="roomtitle" id="roomtitle"
								value ="${roominfo.roomtitle}" readonly="readonly">
						</div>
						<div class="mb-3">
							<label for="maxpeople">Maxpeople</label> 
							<input type="number"
								class="form-control w-25 required" name="maxpeople" id="maxpeople" value ="${roominfo.maxpeople}"
								readonly="readonly">
						</div>
						<div class="mb-3">
							<label for="adultcost">Adultcost</label>
							<div class="input-group w-25"> 
								<span class="input-group-text">￥</span>
								<input type="number"
									class="form-control w-25 required" name="adultcost" id="adultcost" min="0" value ="${roominfo.adultcost}"
									readonly="readonly">
							</div>
						</div>
						<div class="mb-3">
							<label for="childcost">Childcost</label> 
							<div class="input-group w-25"> 
								<span class="input-group-text">￥</span>
								<input type="number"
									class="form-control required" name="childcost" id="childcost" min="0"  value ="${roominfo.childcost}"
									 readonly="readonly">
							</div>
						</div>
						<div class="mb-3">
							<label for="colorcd">Colorcd</label> 
							<input type="color"
								class="form-control form-control-color required" name="colorcd" id="colorcd" value ="${roominfo.colorcd}"
								disabled>
						</div>
						<div class="mb-3">
							<div class="card">
							  <div class="card-header">
							    	Preview.
							  </div>
							  <div class="card-body">
							  	<c:choose>
								<c:when test="${empty roominfo.imagesList}">
								<div id="carouselExampleIndicators" class="carousel carousel-dark carousel-thumbnail slide" data-bs-ride="carousel">
								    <div class="carousel-inner">
									        <div class="carousel-item active">
									            <img src="/resources/img/logo_icon.png" class="d-block carousel-border-round  w-100">
									        </div>
								    </div>
								    <div class="carousel-indicators">
									        <img data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${status.index}" 
									        class="carousel-thumbnail active" src="/resources/img/logo_icon.png" class="w-100">
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
								</c:when>
								<c:otherwise>
								<div id="carouselExampleIndicators" class="carousel carousel-dark carousel-thumbnail slide" data-bs-ride="carousel">
								    <div class="carousel-inner">
								    	<c:forEach var="image" items="${roominfo.imagesList}" varStatus="status">
									        <div class="carousel-item  ${status.first ? 'active' : ''}">
									            <img src="${image}" class="d-block carousel-border-round  w-100">
									        </div>
								        </c:forEach>
								    </div>
								    <div class="carousel-indicators">
									    <c:forEach var="image" items="${roominfo.imagesList}" varStatus="status">
									        <img data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${status.index}" 
									        class="carousel-thumbnail ${status.first ? 'active' : ''}" src="${image}&thumb=true" class="w-100">
									    </c:forEach>
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
								</c:otherwise>
								</c:choose>
							  </div>
							</div>
						</div>
						<div class="mb-3">
							<label for="explanation">Explanation</label> 
							<p class="form-control required" id="explanation">wow</p>
						</div>
						</form>
							<form id="actionForm" action="" method="get">
							<input type="hidden" name="pageNum" value="${cri.pageNum}"/>
							<input type="hidden" name="amount" value="${cri.amount}"/>
							<input type="hidden" name="type" value="<c:out value="${cri.type}"/>"/>
							<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>"/>
							
							<%-- <input type="hidden" name="no" value="${consultation.no}"/> --%>
							<div>
								<a href="" role="button" class="btn btn-secondary" data-oper="list" id="btnList">목록</a>
								<a href="" role="button" class="btn btn-danger" data-oper="delete" id="btnDelete">삭제</a>
								<a href="" role="button" class="btn btn-warning" data-oper="modify" id="btnUpdate">수정</a>
							</div>
						</form>
				</div>
			</div>
		</article>
		<script type="text/javascript">
		$(document).ready(function() {
			var form = $("#actionForm");
			$("a[role='button']").on("click",function(event) {
				event.preventDefault();
				var operation = $(this).data("oper");
				console.log(operation);
				switch(operation) {
					case "modify":
						form.attr("action","/admin/roominfo/modify");
						break;
					case "delete":
						if(!confirm("삭제하시겠습니까?")) {
							return;
						}
						form.attr("action","/admin/roominfo/remove");
						form.attr("method","post");
						break;
					case "list":
						var pageNum = $("input[name='pageNum']").clone();
						var amount = $("input[name='amount']").clone();
						var type = $("input[name='type']").clone();
						var keyword = $("input[name='keyword']").clone();
						form.empty();
						form.append(pageNum);
						form.append(amount);
						form.append(type);
						form.append(keyword);
						form.attr("action","/admin/roominfo/list");
						form.attr("method","get");
						break;
					
					default : return;
				
				}
				form.submit();
			})
		})
		</script>
	</body>
</html>