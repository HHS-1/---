<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    HttpSession se = request.getSession();
	String user_id = (String)se.getAttribute("user_id");
	String user_name = (String)se.getAttribute("user_name");
	
	if(user_id != null){ // 로그인 상태로 접속 불가
		out.print("<script>location.href = './m_index.jsp';</script>");
	}
    %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>호텔 & 펜션 예약시스템</title>
    <link rel="stylesheet" type="text/css" href="../css/m_index.css?v=1">
    <link rel="stylesheet" type="text/css" href="../css/m_sub.css?v=2">
    <link rel="stylesheet" type="text/css" href="../css/m_qaboard.css?v=2">
    <script src="../js/jquery.js"></script>
    <script src="../js/m_index.js?v=1"></script>
</head>
<body>
<!-- 상단 시작 -->
<%@ include file="../top.jsp" %>
<!-- 상단 끝 -->
<main>
<!-- 배너 -->
<%@ include file="../banner.jsp" %>
<!-- 배너 끝-->
<!-- 중단 -->
<section class="subpage">
    <div class="member_agree">
        <p>아이디 찾기</p>    
        <span class="sub_titles">가입하신 정보를 입력하세요.</span>
        <ul class="write_ul">
            <li><input type="text" class="w_input1" id="user_name" placeholder="고객명을 입력하세요"></li>
            <li><input type="tel" class="w_input1" id="user_tel" placeholder="연락처를 입력하세요('-'는 미입력)"></li>
            <li><input type="email" class="w_input1" id="user_email" placeholder="이메일을 입력하세요"></li>
        </ul>
        <!--아이디가 출력되는 곳-->
        <span class="id_searchview" id="id_searchview" style="display: block;"></span>
        <div id="btn_findId" class="member_agreebtn">아이디 찾기</div>
        <span class="part_line"></span>
        <p>비밀번호 찾기</p>    
        <span class="sub_titles">패스워드 변경 후 로그인 시 해당 비밀번호가 적용 됩니다.</span>  
        <ul class="write_ul">
            <li><input type="text" class="w_input1" id="user_id2" placeholder="아이디를 입력하세요"></li>
            <li><input type="text" class="w_input1" id="user_name2" placeholder="고객명을 입력하세요"></li>
            <li><input type="tel" class="w_input1" id="user_tel2" placeholder="연락처를 입력하세요('-'는 미입력)"></li>
        </ul>
        <div id="btn_changePw" class="member_agreebtn">패스워드 변경</div>
    </div>
</section>
<!-- 하단 시작 -->
<%@ include file="../Qmenu.jsp" %>
</main>
<%@ include file="../copyright.jsp" %>
</body>
</html>