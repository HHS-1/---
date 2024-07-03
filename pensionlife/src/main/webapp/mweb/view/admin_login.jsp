<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
		HttpSession se = request.getSession();
		String admin_id = (String)se.getAttribute("admin_id");
		if(admin_id != null){
			out.print("<script>location.href = './admin_qalist.jsp';</script>");
		}

    %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>호텔 & 펜션 예약시스템</title>
    <link rel="stylesheet" type="text/css" href="../css/m_index.css?v=1">
    <link rel="stylesheet" type="text/css" href="../admin_css/index.css?v=4">
    <script src="../js/jquery.js"></script>
    <script src="../admin_js/admin_login.js?v=1"></script>
</head>
<body>
<header class="admin_header"><img src="../img/header_logo.png"></header>
<form id="frm_admin_login">
<aside class="admin_login">
    <p><img src="../admin_img/logo.png"><span>ADMINISTRATOR</span></p>
    <ol class="admin_part">
        <li><input type="text" id="admin_id" class="adin1" placeholder="아이디를 입력하세요"></li>
        <li><input type="text" id="admin_pw" class="adin1" placeholder="패스워드를 입력하세요"></li>
        <li><input type="submit"  class="adbtn1" value="LOGIN"></li>
    </ol>
</aside>
</form>
<%@include file="../copyright.jsp" %>
</body>
</html>