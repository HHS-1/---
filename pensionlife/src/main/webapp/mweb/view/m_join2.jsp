<%@page import="java.util.Arrays"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ page import="model.dbconfig" %>
    
    <%
    	request.setCharacterEncoding("utf-8");
	    HttpSession se = request.getSession();
		String user_id = (String)se.getAttribute("user_id");
    
    	boolean agree_ck = false;
    	//약관동의 정보
  
   		String ck[] = request.getParameterValues("ck");
   	  	if(request.getParameterValues("ck") != null){ 
    		agree_ck = true;
   	  	}
    	
    	

    	//보안코드 6자리
    	StringBuilder ranNum = new StringBuilder();
    	for(int f = 0 ; f < 6 ; f++){
    		ranNum.append(String.valueOf((int)Math.floor(Math.random()*10)));
    	}
    	
    %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>호텔 & 펜션 예약시스템</title>
    <link rel="stylesheet" type="text/css" href="../css/m_index.css?v=1">
    <link rel="stylesheet" type="text/css" href="../css/m_sub.css?v=3">
 
    <script src="../js/jquery.js"></script>
        <script src="../js/m_index.js"></script>
    <script src="../js/m_join.js?v=1"></script>
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
    <div class="member_agree">
    <p>회원 기본 정보입력</p>
    <ol class="join_ol">
    <li><input type="text" class="join_input1" name="u_info" placeholder="아이디 (영문/숫자 6~16자리)" maxlength="16"></li>
    <li><input type="text" class="join_input1" name="u_info" placeholder="이름 (홍길동)" maxlength="10"></li>
    <li><input type="password" class="join_input1 ck_pw" id="pw" name="u_info" placeholder="비밀번호 (영문/숫자 6~12자리)" maxlength="12"></li>
    <li id="parent"><input type="password" class="join_input1 ck_pw" id="ck_pw" placeholder="동일한 패스워드를 입력하세요" maxlength="12"><span id="wrong_pw">비밀번호가 틀립니다.</span></li>
    <li><input type="email" class="join_input1" name="u_info" placeholder="이메일을 입력하세요" maxlength="35"></li>
    <li><input type="tel" class="join_input1" name="u_info" placeholder="연락처 ('-'는 미입력)" maxlength="11"></li>
    <li class="security">
    보안코드 : <input type="text" class="join_input2 bgcolor" id="securityCode" maxlength="6" readonly="readonly" value=<%=ranNum %>>
    <input type="number" class="join_input2" id="securityCode_input" placeholder="보안코드 6자리 입력" maxlength="6">
    <%if(agree_ck == true){
    	for(int f = 0 ; f < ck.length ; f++){ %>
    	<input type="hidden" name="u_info" value=<%=ck[f] %>>
    <%}} %>
    </li>
    </ol>
    <div class="member_agreebtn" id="btn_signUp">회원가입</div>
    </div>
</form>
</section>

<!-- 하단 시작 -->
<%@ include file="../Qmenu.jsp" %>
</main>
<%@ include file="../copyright.jsp" %>
</body>
<script>
	//잘못된 접근 감지
	window.onload = function(){
		if(<%=request.getParameter("token")%> == null){
			alert("잘못된 접근입니다.");
			history.go(-1);
		}else if(<%=request.getParameter("realToken")%> != <%=request.getParameter("token")%>){
			alert("잘못된 접근입니다.");
			history.go(-1);
		}
	}
</script>
</html>