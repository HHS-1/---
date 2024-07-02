<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<div class="menus_bar" id="menus_bar">
    <div class="load_menus" id="load_menus">
        <ul>
            <li>팬션 예약확인</li>
            <li>팬션 예약취소</li>
            <li>1:1문의 게시판</li>
        </ul>
    </div>
</div>

<header>
<ul class="top_menu">
    <li id="menu_slide"><img src="../img/menu.svg"></li>
    <li><img src="../img/header_logo.png"></li>
    <%if(user_id != null){ %>
    <li><%=user_id %>님 환영합니다.</li>
    <%}else{ %>
    <li onclick="login_pop();"><img src="../img/login.svg"></li>
    <%} %>
</ul>
</header>
<form id="frm_login" onsubmit="login()">
<aside class="popup" id="popup" style="display:none;">

	<div class="login">
		<span class="close" onclick="pop_close();">X</span>
		<p>MEMBER-LOGIN</p>
		<ol>
		<li><input type="text" class="login_input" name="login_info" placeholder="아이디를 입력하세요"></li>
		<li><input type="password" class="login_input" name="login_info" placeholder="패스워드를 입력하세요"></li>
		<li><label><input type="checkbox" class="login_check"> 자동로그인</label></li>
		<li><input type="submit" value="로그인" class="login_btn"></li>
		<li class="login_info">
		<span onclick="page_location(1)">아이디 찾기</span>
		<span onclick="page_location(2)">회원가입</span>
		</li>
		</ol>
	</div>
</aside>
</form>
<script>
function login(){
	frm_login.method = "post";
	frm_login.action = "./sign_in.do";
}
</script>