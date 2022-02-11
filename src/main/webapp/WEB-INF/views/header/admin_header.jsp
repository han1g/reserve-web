<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<header id="header">
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <img class="navbar-brand" src="/resources/img/logo_icon.png" height="60px" alt="logo"></img>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
      	<li class="nav-item">
          <a class="nav-link ${menu eq 'home' ? 'active' : '' }" aria-current="page" href="/admin/">ホーム。</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${menu eq 'roominfo' ? 'active' : '' }" aria-current="page" href="/admin/roominfo/list">部屋リスト。</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${menu eq 'notice' ? 'active' : '' }" aria-current="page" href="/admin/notice/list">お知らせ。</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${menu eq 'consultation' ? 'active' : '' }" aria-current="page" href="/admin/consultation/list">相談。</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${menu eq 'options' ? 'active' : '' }" aria-current="page" href="/admin/options/list">オプション。</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${menu eq 'reserve' ? 'active' : '' }" aria-current="page" href="/admin/reserve/list">予約リスト。</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
</header>