<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ include file="./page2.jsp" %>
	<%
		out.print(request.getAttribute("room"));
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>page2에서 출력되는 세션 값 및 page4.do에 있는 값도 출력</title>
</head>
<body>

</body>
</html>