<%@page import="com.example.demo.domain.etc.Criteria"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/includes/commons/variables.jsp"%>

<input type="hidden" name="pageNum" value="${cri.pageNum}"/>
<input type="hidden" name="amount" value="${cri.amount}"/>
<input type="hidden" name="type" value="<c:out value="${cri.type}"/>"/>
<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>"/>

<c:if test="${menu eq 'roominfo' or menu eq 'reserve'}">
<input type="hidden" name="maxpeople_min" value="<c:out value="${cri.maxpeople_min}"/>"/>
<input type="hidden" name="maxpeople_max" value="<c:out value="${cri.maxpeople_max}"/>"/>
<input type="hidden" name="adultcost_min" value="<c:out value="${cri.adultcost_min}"/>"/>
<input type="hidden" name="adultcost_max" value="<c:out value="${cri.adultcost_max}"/>"/>
<input type="hidden" name="childcost_min" value="<c:out value="${cri.childcost_min}"/>"/>
<input type="hidden" name="childcost_max" value="<c:out value="${cri.childcost_max}"/>"/>
</c:if>