<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.card-header {
	display:flex;
	justify-content: space-between;
	vertical-align: center;
}
</style>
</head>
<body>
	<div class="work-area">
		<div class="card">
			<div class="card-header">
				<span>Options.</span>
				<span>
					<button class="btn btn-sm btn-success" onclick="giveArrIndex()">giveArrIndex()</button>
					<button class="btn btn-sm btn-success" onclick="addOption()">+</button>
					<button class="btn btn-sm btn-primary" onclick="submit()">저장</button>
				</span>
			</div>
			<form id="options_register_form" action="/admin/options/register" method="post">
				<table id="optionsTable" class="table table-striped table-sm" >
					<thead>
						<tr>
							<th>ITEM</th>
							<th>COST</th>
							<th>ACTIVITY</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="option" items="${options}" varStatus="status">
							<tr>
							 <td>
							 <input type="hidden" class="form-control" name="options[${options.size() - status.count}].no" value="<c:out value="${option.no}"/>">
							 <input type="hidden" class="form-control" name="options[${options.size() - status.count}].deleteflg" value="<c:out value="${option.deleteflg}"/>">
							 <input class="form-control" name="options[${options.size() - status.count}].item" value="<c:out value="${option.item}"/>">
							 </td>
							 <td><input type="number" class="form-control" name="options[${options.size() - status.count}].cost" value="<c:out value="${option.cost}"/>"></td>
							 <!-- date받아서 포매팅하기 -->
							 <!-- cout 을 쓰면 자동으로escape처리되기 때문에 특수문자 오류나 xss에 대응가능 -->
							 <td><div class="input-group-text">
							 		<input id="radio[${options.size() - status.count}]1" class="form-check-input mt-0" type="radio" name="options[${options.size() - status.count}].activity" value="1" ${option.activity eq '1' ? 'checked' : ''}><label for="radio[${options.size() - status.count}]1">&nbsp; ON</label>
							 		&nbsp;
							 		<input id="radio[${options.size() - status.count}]2" class="form-check-input mt-0" type="radio" name="options[${options.size() - status.count}].activity" value="0" ${option.activity eq '0' ? 'checked' : ''}><label for="radio[${options.size() - status.count}]2">&nbsp; OFF</label> </div></td>
							 <td><button class="btn btn-danger" onclick="deleteOptionClick(event)" >삭제</button><td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</form>
		</div>
	</div>
	<script>
		var length = ${options.size()};
		function deleteOptionClick(event) {
			event.preventDefault();
			
			var tr = $(event.target).closest("tr");
			if(tr.hasClass("new-tr")) {
				tr.remove();
				return;
				// 버튼눌러서 추가한 행이면 그냥 지움
			}
			else {
				tr.css('display','none');
				//안보이게 하기 : form은 전송됨
			}
			console.log(tr.find("input[name*='deleteflg']").attr('name'));
			
			tr.find("input[name*='deleteflg']").val('1');
			console.log(tr.find("input[name*='deleteflg']").val());
			
		}
		function restoreOptionClick() {
			event.preventDefault();
			console.log($(event.target).find("input[name*='deleteflg']"));
			$(event.target).closest("tr").css('display','none');
			//안보이게 하기 : form은 전송됨
			
			$(event.target).find("input[name*='deleteflg']").val('0');
		}
		function giveArrIndex() {
			$($('#optionsTable > tbody tr').get().reverse()).each(function(index , val) {
				console.log(index);
				console.log($('#optionsTable tr'));
				console.log($(val));
				console.log($(val).find('input'));
				$(val).find('input').each(function() {
					console.log(this);
					var name = $(this).attr('name');
					console.log('name : ' + name);
					console.log('index : ' + index);
					//options[].attr
					
					var index_bef = name.substring(name.indexOf('[') + 1,name.indexOf(']'));
					name = name.replace(index_bef,index);
					$(this).attr('name',name);
					console.log($(this).attr('name'));
				});
			});
		}
		function addOption() {
			console.log('addOption');
			console.log('length : ' + length);
			$('#optionsTable > tbody').prepend(`
					<tr class="new-tr">
					 <td>
					 <input type="hidden" class="form-control" name="options[${'${length}'}].deleteflg" value="<c:out value="0"/>">
					 <input class="form-control" name="options[${'${length}'}].item" value="item"></td>
					 <td><input class="form-control" name="options[${'${length}'}].cost" value="0"></td>
					 <td><div class="input-group-text">
					 		<input id="radio[${'${length}'}]1" class="form-check-input mt-0" type="radio" name="options[${'${length}'}].activity" value="1" checked><label for="radio[${'${length}'}]1">&nbsp; ON</label>
					 		&nbsp;
					 		<input id="radio[${'${length}'}]2" class="form-check-input mt-0" type="radio" name="options[${'${length}'}].activity" value="0"><label for="radio[${'${length}'}]2">&nbsp; OFF</label> </div></td>
					 <td><button class="btn btn-danger" onclick="deleteOptionClick(event)" >삭제</button><td>
					</tr>
			`);
			length++;
		}
		function submit() {
			giveArrIndex();
			$('#options_register_form').submit();
		}
	</script>
	<!-- modal -->
	<jsp:include page="/WEB-INF/views/includes/commons/ListPage/modal.jsp"/>
	
</body>
</html>