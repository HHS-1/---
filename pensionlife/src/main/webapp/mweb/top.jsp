<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<div class="menus_bar" id="menus_bar">
    <div class="load_menus" id="load_menus">
        <ul>
        	<%if(user_name == null){ %>
        	<li><a onclick="login_pop_rck()">팬션 예약확인</a></li>
        	<%}else{ %>
            <li><a href="./m_reservation_list.jsp">팬션 예약확인</a></li>
            <%} %>
            <li><a href="./view/m_qalist.jsp">1:1문의 게시판</a></li>
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
		<span onclick="unmember_login()">비회원 예약확인</span>
		<span onclick="location.href='./m_join.jsp'">회원가입</span>
		</li>
		</ol>
	</div>
</aside>
</form>

<form id="form_unmember">
<aside class="popup" id="popup_rck" style="display:none;">
	<div class="login">
		<span class="close" onclick="pop_close_rck();">X</span>
		<p>UNMEMBER</p>
		<ol>
		<li><input type="text" class="login_input" name="r_name" placeholder="예약자 이름을 입력하세요"></li>
		<li><input type="text" class="login_input" name="r_email" placeholder="예약자 이메일을 입력하세요"></li>
		<li style="padding-top:10px"><input type="submit" value="비회원 예약확인" class="login_btn" onclick="unmember_submit()"></li>
		<li class="login_info">
		<span onclick="login_pop_onrck()">회원이신가요?</span>
		<span onclick="location.href='./m_join.jsp'">회원가입</span>
		</li>
		</ol>
	</div>
</aside>
</form>

