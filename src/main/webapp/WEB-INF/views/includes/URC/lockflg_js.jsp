<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp"%>
<script type="text/javascript">
			$(document).ready(function() {
				if($("#chk_lock").is(":checked")) {
					$("#chk_lock_hidden").attr('disabled','disabled');
				} else {
					$("#chk_lock_hidden").removeAttr('disabled');
				}
				
				$("#chk_lock").on('change',function() {
					
					if($("#chk_lock").is(":checked")) {
						$("#chk_lock_hidden").attr('disabled','disabled');
					} else {
						$("#chk_lock_hidden").removeAttr('disabled');
					}
				});
			});//비밀글 관련 div 설정
</script>