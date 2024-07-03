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
<form id="frm_login" onsubmit="login()">
<aside class="popup" id="popup" style="display:none;">

	<div class="login">
		<span class="close" onclick="pop_close();">X</span>
		<p>MEMBER-LOGIN</p>
		<ol>
		<li><input type="text" class="login_input" name="login_info" placeholder="아이디를 입력하세요"></li>
		<li><input type="password" class="login_input" name="login_info" placeholder="패스워드를 입력하세요"></li>
		<li><label><input type="checkbox" id="login_auto" name="login_auto" class="login_check" value="Y"> 자동로그인</label></li>
		<li><input type="submit" value="로그인" class="login_btn"></li>
		<li class="login_info">
		<span onclick="location.href='./m_idsearch.jsp'">아이디 찾기</span>
		<span onclick="location.href='./m_join.jsp'">회원가입</span>
		</li>
		</ol>
	</div>
</aside>
</form>
<script>
//로그인
function login(){
	if(document.querySelector("#login_auto").checked == true){
		if(confirm("피시방 등 공공장소에서는 자동로그인 사용을 권장하지 않습니다.\n취소를 클릭 시 자동로그인이 해제되어 로그인됩니다.")){
			frm_login.method = "post";
			frm_login.action = "./sign_in.do";
		}else{
			document.querySelector("#login_auto").value = null;
			frm_login.method = "post";
			frm_login.action = "./sign_in.do";
		}	
	}else{
		frm_login.method = "post";
		frm_login.action = "./sign_in.do";
	}
	
}

</script>