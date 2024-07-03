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
    <link rel="stylesheet" type="text/css" href="../css/m_index.css?v=2">
    <link rel="stylesheet" type="text/css" href="../css/m_sub.css?v=1">
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
<form id="frm">
	<input type="hidden" id="token" name="realToken" value="">
    <div class="member_agree">
    <p>회원가입 약관동의</p>
    <ol class="agree_ol">
    <li><label><input type="checkbox" id="ck1" name="ck" class="ckbox" value="Y" onclick="check()"> 이용약관의 동의</label><span class="agree_info">[자세히 보기]</span></li>
    <li><label><input type="checkbox" id="ck2" name="ck" class="ckbox" value="Y" onclick="check()"> 개인정보 수집의 동의</label><span class="agree_info">[자세히 보기]</span></li>
    <li><label><input type="checkbox" id="ck3" name="ck" class="ckbox" value="Y" onclick="check()"> 개인정보 제3자 제공 동의</label><span class="agree_info">[자세히 보기]</span></li>
    <li><label><input type="checkbox" id="ck4" name="ck" class="ckbox" value="Y" onclick="check()"> 개인정보 위탁제공 동의</label><span class="agree_info">[자세히 보기]</span></li>
    <li><label><input type="checkbox" id="ck5" name="ck" class="ckbox" value="Y" onclick="check()"> 마케팅 활용 동의 (선택)</label><span class="agree_info">[자세히 보기]</span></li>
    <li><label><input type="checkbox" id="ck_all" class="ckbox" onclick="all_check()"> 위 약관에 모두 동의 합니다.</label></li>
    </ol>

    <div class="member_agreebtn" onclick="regist_agree()">기본정보 등록하기</div>
    </div>
</form>
</section>
<!-- 하단 시작 -->
<%@ include file="../Qmenu.jsp" %>
</main>
<%@ include file="../copyright.jsp" %>
</body>
</html>