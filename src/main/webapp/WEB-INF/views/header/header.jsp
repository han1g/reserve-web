<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<header id="header">
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand">UR</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
      	<li class="nav-item">
          <a class="nav-link ${menu eq 'home' ? 'active' : '' }" aria-current="page" href="/">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${menu eq 'area' ? 'active' : '' }" aria-current="page" href="/area/">物件を探す</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${menu eq 'notice' ? 'active' : '' }" aria-current="page" href="/notice/">NOTICE。</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${menu eq 'office' ? 'active' : '' }" aria-current="page" href="/office/">営業所</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
</header>