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
          <a class="nav-link ${menu eq 'home' ? 'active' : '' }" aria-current="page" href="/">ホーム。</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${menu eq 'roominfo' ? 'active' : '' }" aria-current="page" href="/roominfo/list">部屋リスト。</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${menu eq 'notice' ? 'active' : '' }" aria-current="page" href="/notice/list">お知らせ。</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${menu eq 'consultation' ? 'active' : '' }" aria-current="page" href="/consultation/list">相談。</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${menu eq 'reserve' ? 'active' : '' }" aria-current="page" href="/"  data-bs-toggle="modal" data-bs-target="#reserveModal">予約確認。</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
</header>
<!-- Modal -->
<div class="modal fade" id="reserveModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            	予約者情報入力
            </div>
            <form action="/reserve/list" id="reserve-modal-form" method="get">
	            <div class="modal-body">
	                <div class="mb-3">
					  <label for="name" class="form-label">姓名</label>
					  <input type="text" name="name" class="form-control" id="name" placeholder="名前入力">
					</div>
					<div class="mb-3">
					  <label for="phone" class="form-label">電話番号</label>
					  <input type="text" name="phone" class="form-control" id="phone" placeholder="電話番号('-'無し)">
					</div>
	            </div>
            </form>
            <div class="modal-footer">
            	<button type="button" class="btn btn-danger" data-bs-dismiss="modal">取消</button>
                <button type="submit" form="reserve-modal-form" class="btn btn-success">確認</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>