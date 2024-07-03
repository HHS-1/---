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
    <span id="hidden_space"></span>
    <li><a href='./m_index.jsp'><img src="../img/header_logo.png"></a></li>
    <%if(user_name != null){ %>
    <li class="logout"><span><%=user_name %>님</span> &nbsp;<span id="logout">[로그아웃]</span></li>
    <%}else{ %>
    <li onclick="login_pop();"><img src="../img/login.svg"></li>
    <%} %>
</ul>
</header>
<form id="frm_login">
<aside class="popup" id="popup" style="display:none;">

	<div class="login">
		<span class="close" onclick="pop_close();">X</span>
		<p>MEMBER-LOGIN</p>
		<ol>
		<li><input type="text" class="login_input" id="user_id" name="login_info" placeholder="아이디를 입력하세요"></li>
		<li><input type="password" class="login_input" id="user_pw" name="login_info" placeholder="패스워드를 입력하세요"></li>
		<li class="parent">
		<label><input type="checkbox" id="login_auto" name="login_auto" class="login_check" value="Y"> 로그인 상태 유지</label><br>
		<span id="login_fail_msg">아이디 또는 비밀번호를 확인해주세요.</span>
		</li>
		<li style="padding-top:10px"><input type="submit" value="로그인" class="login_btn"></li>
		<li class="login_info">
		<span onclick="location.href='./m_idsearch.jsp'">아이디 찾기</span>
		<span onclick="location.href='./m_join.jsp'">회원가입</span>
		</li>
		</ol>
	</div>
</aside>
</form>
