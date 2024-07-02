<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    HttpSession se = request.getSession();
    ArrayList<String> al = new ArrayList<String>();
    al.add("hong");
    al.add("홍길동");
    al.add("hong@nate.com");
    se.setAttribute("user",al);
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>top session 배열 data를 로드</title>
</head>
<body>
	<input type="button" value="로그인" onclick="location.href='./page4.do';">
</body>
</html>