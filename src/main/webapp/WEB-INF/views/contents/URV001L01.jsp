<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<jsp:include page="/WEB-INF/views/includes/URV/fullcalendar.jsp"/>
</head>
<body>
  <div id='calendar'></div>
  <jsp:include page="/WEB-INF/views/includes/commons/ListPage/modal.jsp"/>
</body>
</html>