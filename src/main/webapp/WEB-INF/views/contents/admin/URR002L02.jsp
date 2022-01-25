<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.ui-slider-range { background: #729fcf; }
	.search-element {margin-bottom:20px;}
</style>
</head>
<body>
	<div class="work-area">
		<div class="card">
			<div class="card-header">ROOMS.</div>
			
			<table class="table table-striped">
				<thead>
					<tr>
						<th>#Preview</th>
						<th>방 번호</th>
						<th>방 이름</th>
						<th>최대 인원</th>
						<th>어른 요금</th>
						<th>어린이 요금</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="roominfo" items="${roominfoList}">
						<tr >
						 <td><img src="${roominfo.thumb}" class="img-thumbnail target" style="object-fit: contain; width:100px;height:100px" alt="..."></td>
						 <td class="align-middle"><a class="move" href="<c:out value="${roominfo.no}"/>">
						 <!-- 링크로 넘길 파라미터가 많아지면 링크가 복잡 -->
						 <c:out value="${roominfo.roomnum}"></c:out></a></td>
						 <td class="align-middle"><c:out value="${roominfo.roomtitle}"></c:out></td>
						 <td class="align-middle"><c:out value="${roominfo.maxpeople}"></c:out>人</td>
						 <td class="align-middle"><c:out value="${roominfo.adultcost}"></c:out>￥</td>
						 <td class="align-middle"><c:out value="${roominfo.childcost}"></c:out>￥</td>
						 <!-- date받아서 포매팅하기 -->
						 <!-- cout 을 쓰면 자동으로escape처리되기 때문에 특수문자 오류나 xss에 대응가능 -->
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<div class="accordion" id="accordionExample">
			  <div class="accordion-item">
			    <h2 class="accordion-header" id="headingTwo">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
			        Search Menu
			      </button>
			    </h2>
			    <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
			      <div class="accordion-body">
			        <form id="searchForm" action="/admin/roominfo/deletedList" method="get">
						<input type="hidden" name="pageNum" value="1"/>
						<input type="hidden" name="amount" value="${pageMaker.cri.amount}"/>
						<div class="search-element">
							<p>
							  <input type="hidden" id="search_maxpeople_min" name="maxpeople_min" readonly style="border:0; color:#f6931f; font-weight:bold;">
							  <input type="hidden" id="search_maxpeople_max" name="maxpeople_max" readonly style="border:0; color:#f6931f; font-weight:bold;">
							  <label for="search_maxpeople">최대 인원:</label>
							  <input type="text" id="search_maxpeople" readonly style="border:0; color:#f6931f; font-weight:bold;">
							</p>
							<div id="slider-range"></div>
							<script>
							  $( function() {
							    $( "#slider-range" ).slider({
							      range: true,
							      min: 0,
							      max: 100,
							      values: [ ${pageMaker.cri.maxpeople_min}, ${pageMaker.cri.maxpeople_max} ],
							      slide: function( event, ui ) {
							        $( "#search_maxpeople" ).val(ui.values[ 0 ] + "人　-　" + ui.values[ 1 ] +  "人");
							        $( "#search_maxpeople_min" ).val(ui.values[ 0 ]);
							        $( "#search_maxpeople_max" ).val(ui.values[ 1 ]);
							      }
							    });
							    $( "#search_maxpeople_min" ).val($( "#slider-range" ).slider( "values", 0 ));
						        $( "#search_maxpeople_max" ).val($( "#slider-range" ).slider( "values", 1 ));
							    $( "#search_maxpeople" ).val($( "#slider-range" ).slider( "values", 0 ) +
							    		 "人　-　" + $( "#slider-range" ).slider( "values", 1 )+  "人" );
							  });
						  </script>
						</div>
						<div class="search-element">
							<p>
							  <input type="hidden" id="search_adultcost_min" name="adultcost_min" readonly style="border:0; color:#f6931f; font-weight:bold;">
							  <input type="hidden" id="search_adultcost_max" name="adultcost_max" readonly style="border:0; color:#f6931f; font-weight:bold;">
							  <label for="search_adultcost">어른 요금:</label>
							  <input type="text" id="search_adultcost" readonly style="border:0; color:#f6931f; font-weight:bold;">
							</p>
							<div id="slider-range-2"></div>
							<script>
							  $( function() {
							    $( "#slider-range-2" ).slider({
							      range: true,
							      min: 0,
							      max: 100000,
							      step: 100,
							      values: [ ${pageMaker.cri.adultcost_min}, ${pageMaker.cri.adultcost_max} ],
							      slide: function( event, ui ) {
							        $( "#search_adultcost" ).val(ui.values[ 0 ] + "￥　-　" + ui.values[ 1 ] +  "￥");
							        $( "#search_adultcost_min" ).val(ui.values[ 0 ]);
							        $( "#search_adultcost_max" ).val(ui.values[ 1 ]);
							      }
							    });
							    $( "#search_adultcost_min" ).val($( "#slider-range-2" ).slider( "values", 0 ));
						        $( "#search_adultcost_max" ).val($( "#slider-range-2" ).slider( "values", 1 ));
							    $( "#search_adultcost" ).val($( "#slider-range-2" ).slider( "values", 0 ) +
							    		 "￥　-　" + $( "#slider-range-2" ).slider( "values", 1 )+  "￥" );
							  });
						  </script>
						</div>
						<div class="search-element">
							<p>
							  <input type="hidden" id="search_childcost_min" name="childcost_min" readonly style="border:0; color:#f6931f; font-weight:bold;">
							  <input type="hidden" id="search_childcost_max" name="childcost_max" readonly style="border:0; color:#f6931f; font-weight:bold;">
							  <label for="search_childcost">어린이 요금:</label>
							  <input type="text" id="search_childcost" readonly style="border:0; color:#f6931f; font-weight:bold;">
							</p>
							<div id="slider-range-3"></div>
							<script>
							  $( function() {
							    $( "#slider-range-3" ).slider({
							      range: true,
							      min: 0,
							      max: 100000,
							      step: 100,
							      values: [ ${pageMaker.cri.childcost_min}, ${pageMaker.cri.childcost_max} ],
							      slide: function( event, ui ) {
							        $( "#search_childcost" ).val(ui.values[ 0 ] + "￥　-　" + ui.values[ 1 ] +  "￥");
							        $( "#search_childcost_min" ).val(ui.values[ 0 ]);
							        $( "#search_childcost_max" ).val(ui.values[ 1 ]);
							      }
							    });
							    $( "#search_childcost_min" ).val($( "#slider-range-3" ).slider( "values", 0 ));
						        $( "#search_childcost_max" ).val($( "#slider-range-3" ).slider( "values", 1 ));
							    $( "#search_childcost" ).val($( "#slider-range-3" ).slider( "values", 0 ) +
							    		 "￥　-　" + $( "#slider-range-3" ).slider( "values", 1 )+  "￥" );
							  });
						  </script>
						</div>
						<button id="#searchFormBtn" class="btn btn-outline-secondary">Search</button>
					</form>
					<script type="text/javascript">
						//script for search
						$("#searchFormBtn").on("click",function(e) {
							console.log("search");
							e.preventDefault();
			
							$("#searchForm").submit();
						});
					</script>
			      </div>
			    </div>
			  </div>
			</div>

			<nav class="d-flex justify-content-end">
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li class="page-item"><a class="page-link" href="${pageMaker.startPage - 10}">prev</a></li>
					</c:if>
					<c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						<c:choose>
							<c:when test="${pageMaker.cri.pageNum == i}">
								<li style="pointer-events : none;" class="page-item active"><a class="page-link" href="${i}">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" href="${i}">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${pageMaker.next}">
						<li class="page-item"><a class="page-link" href="${pageMaker.startPage + 10}">next</a></li>
					</c:if>
				</ul>
			</nav>
			<form id="actionForm" action="/admin/roominfo/deletedList" method="get">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}"/>
				<input type="hidden" name="amount" value="${pageMaker.cri.amount}"/>
				<input type="hidden" name="type" value="<c:out value="${pageMaker.cri.type}"/>"/>
				<input type="hidden" name="keyword" value="<c:out value="${pageMaker.cri.keyword}"/>"/>
				
				<input type="hidden" name="maxpeople_min" value="<c:out value="${pageMaker.cri.maxpeople_min}"/>"/>
				<input type="hidden" name="maxpeople_max" value="<c:out value="${pageMaker.cri.maxpeople_max}"/>"/>
				<input type="hidden" name="adultcost_min" value="<c:out value="${pageMaker.cri.adultcost_min}"/>"/>
				<input type="hidden" name="adultcost_max" value="<c:out value="${pageMaker.cri.adultcost_max}"/>"/>
				<input type="hidden" name="childcost_min" value="<c:out value="${pageMaker.cri.childcost_min}"/>"/>
				<input type="hidden" name="childcost_max" value="<c:out value="${pageMaker.cri.childcost_max}"/>"/>
				
			</form>
			<script type="text/javascript">
			//script for paging
			var actionForm = $("#actionForm");	
			$(".page-item a").on("click",function(e) {
				console.log("click");
				e.preventDefault();
				actionForm.find("input[name='pageNum']").val($(this).attr("href"));
				actionForm.submit();
			});//페이지 이동
			
			$(".move").on("click",function(e) {
				console.log("click");
				e.preventDefault();
				actionForm.append('<input type="hidden" name="no" value=""/>');
				actionForm.find("input[name='no']").val($(this).attr("href"));
				actionForm.attr("action","/admin/roominfo/getDeleted");
				actionForm.submit();
			});//제목 클릭하면 게시글로 넘어가기
			</script>
		</div>
		<div>
			<a href="/admin/roominfo/list" class="btn btn-outline-warning">목록</a>
		</div>
	</div>
	
	 <!-- Modal -->
	<div class="modal" id="myModal" tabindex="-1">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	            </div>
	            <div class="modal-body">
	                
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
	            </div>
	        </div>
	        <!-- /.modal-content -->
	    </div>
	    <!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	<script type="text/javascript">
		$(document).ready(function() {
			var result ="<c:out value="${result}"/>";
			
			checkModal(result);
			
			history.replaceState({},null,null)//param : stateobj,title,url
			//글 등록 수정 후 뒤로가기 했을 때 모달 창 뜨는거 방지용
			
			function checkModal(result){
				if(result === '' || history.state) {
					//parseInt가 NaN일 때 true
					return;
				}
				if(parseInt(result) > 0) {
					$(".modal-body").html("게시글" + result + "번이 등록 되었습니다");
					$("#myModal").modal("show");
				} else if(result === "success") {
					$(".modal-body").html("처리 완료");
					$("#myModal").modal("show");
				}
			}
			
		});
	</script>
</body>
</html>