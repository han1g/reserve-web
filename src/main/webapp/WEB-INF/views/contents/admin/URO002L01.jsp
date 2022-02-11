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
				<span>オプション</span>
				<span>
					<button class="btn btn-sm btn-success" onclick="addOption()">+</button>
					<button class="btn btn-sm btn-primary" onclick="submit()">保存</button>
				</span>
			</div>
			<form id="options_register_form" action="/admin/options/register" method="post">
				<table id="optionsTable" class="table table-striped table-sm" >
					<thead>
						<tr>
							<th>オプション名</th>
							<th>料金</th>
							<th>活性化</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="option" items="${options}" varStatus="status">
							<tr>
							 <td>
							 <input type="hidden" class="form-control" name="options[${status.index}].no" value="<c:out value="${option.no}"/>">
							 <input type="hidden" class="form-control" name="options[${status.index}].deleteflg" value="<c:out value="${option.deleteflg}"/>">
							 <input class="form-control" name="options[${status.index}].item" value="<c:out value="${option.item}"/>">
							 </td>
							 <td><input type="number" class="form-control" name="options[${status.index}].cost" value="<c:out value="${option.cost}"/>"></td>
							 <!-- date받아서 포매팅하기 -->
							 <!-- cout 을 쓰면 자동으로escape처리되기 때문에 특수문자 오류나 xss에 대응가능 -->
							 <td><div class="input-group-text">
							 		<input id="radio[${status.index}]1" class="form-check-input mt-0" type="radio" name="options[${status.index}].activity" value="1" ${option.activity eq '1' ? 'checked' : ''}><label for="radio[${status.index}]1">&nbsp; オン</label>
							 		&nbsp;
							 		<input id="radio[${status.index}]2" class="form-check-input mt-0" type="radio" name="options[${status.index}].activity" value="0" ${option.activity eq '0' ? 'checked' : ''}><label for="radio[${status.index}]2">&nbsp; オフ</label> </div></td>
							<td><button class="btn btn-danger" onclick="deleteOptionClick(event,true)" >削除</button><td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</form>
		</div>
		<div>
			<a href="/admin/options/deletedList" class="btn btn-outline-warning">削除リスト</a>
		</div>
	</div>
	<script>
		var length = ${options.size()};
		function deleteOptionClick(event,del) {
			//del == true ? (delete) : (restore)
			
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
			
			if(del) {
				tr.find("input[name*='deleteflg']").val('1');
			} else {
				tr.find("input[name*='deleteflg']").val('0');
			}
			
			console.log(tr.find("input[name*='deleteflg']").val());
			
		}
		function giveArrIndex() {
			$('#optionsTable > tbody tr').each(function(index , val) {
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
			$('#optionsTable > tbody').append(`
					<tr class="new-tr">
					 <td>
					 <input type="hidden" class="form-control" name="options[${'${length}'}].deleteflg" value="<c:out value="0"/>">
					 <input class="form-control" name="options[${'${length}'}].item" value="item"></td>
					 <td><input class="form-control" name="options[${'${length}'}].cost" value="0"></td>
					 <td><div class="input-group-text">
					 		<input id="radio[${'${length}'}]1" class="form-check-input mt-0" type="radio" name="options[${'${length}'}].activity" value="1" checked><label for="radio[${'${length}'}]1">&nbsp; オン</label>
					 		&nbsp;
					 		<input id="radio[${'${length}'}]2" class="form-check-input mt-0" type="radio" name="options[${'${length}'}].activity" value="0"><label for="radio[${'${length}'}]2">&nbsp; オフ</label> </div></td>
					 <td><button class="btn btn-danger" onclick="deleteOptionClick(event)" >削除</button><td>
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