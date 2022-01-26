<%@page import="com.example.demo.domain.etc.Criteria"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp"%>
<input type="hidden" name="pageNum" value="${cri.pageNum}"/>
<input type="hidden" name="amount" value="${cri.amount}"/>
<input type="hidden" name="type" value="<c:out value="${cri.type}"/>"/>
<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>"/>