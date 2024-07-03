<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.dbconfig" %>

<%
	HttpSession se = request.getSession();
	String user_id = (String)se.getAttribute("user_id");
	String user_name = (String)se.getAttribute("user_name");
	
	dbconfig db = new dbconfig();
	Connection dbcon = db.getdbconfig();

	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8");
	
	//리스트 5개씩 출력
	int pno = 1;
	if(request.getParameter("pno") != null){
		pno = Integer.parseInt(request.getParameter("pno")); 
	}
	
	int pages = (pno-1)*5;
	int list = 5;
	
	//DB데이터 역순으로 5개씩 가져옴
	String sql = "select * from qa_board where user_id=? order by qidx desc limit ?,?";
	PreparedStatement pst = dbcon.prepareStatement(sql);
	pst.setString(1, user_id);
	pst.setInt(2, pages);
	pst.setInt(3, list);
	ResultSet rs = pst.executeQuery();
	
	//DB qa_board 데이터개수 파악
	String sql2 = "select count(*) as ctn from qa_board where user_id=?";
	pst = dbcon.prepareStatement(sql2);
	pst.setString(1, user_id);
	ResultSet rs2 = pst.executeQuery();
	rs2.next();
	int ctn = rs2.getInt("ctn");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>호텔 & 펜션 예약시스템</title>
    <link rel="stylesheet" type="text/css" href="../css/m_index.css?v=2">
    <link rel="stylesheet" type="text/css" href="../css/m_sub.css?v=3">
    <link rel="stylesheet" type="text/css" href="../css/m_qaboard.css?v=4">
    <script src="../js/jquery.js"></script>
    <script src="../js/m_index.js"></script>
    <script src="../js/m_qalist.js?v=1"></script>
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
        <p>1:1 문의게시판</p>
        <span class="sub_titles">질문하신 리스트가 출력 됩니다.</span>
        <ul class="qa_lists">
            <li>질문제목</li>
            <li>글쓴이</li>
            <li>등록일</li>
            <li>처리</li>
        </ul>
        <%if(ctn<=0){ %>
        <ul class="qa_lists2">
        	<li>문의하신 내용이 없습니다.</li>
       	</ul>
       	<%}else{ %>
        <%
        while(rs.next()){
        %>
        <ul class="qa_lists2">
            <li class="qa_view" data-load="<%=rs.getString("qidx")%>">
            <%
            	//15자 초과하면 ...으로 처리
				if(rs.getString("qtitle").length() > 15){
					out.print(rs.getString("qtitle").substring(0,15)+"...");
				}else{
					out.print(rs.getString("qtitle"));
				}
			%>
            </li>
            <li><%=rs.getString("user_name") %></li>
            <li><%=rs.getDate("qdate") %></li>
            <%if(rs.getString("qhandle").equals("답변완료")){ %>
            <li><a style="color: red;"><%=rs.getString("qhandle") %></a></li>
            <%}else{ %>
            <li><%=rs.getString("qhandle") %></li>
            <%} %>
        </ul>
	    <%
        	}
        }
	    %>
        <table border="1" cellpadding="0" cellspacing="0">
			<tr>
				<% 
				double alldata = rs2.getInt("ctn");
				int pg = (int)Math.ceil(alldata/list);
				for(int f=1; f<=pg; f++){ 
				%>
				<!-- 5개 리스트 출력 페이지 넘버 -->
				<td width="20" align="center"><a href="./m_qalist.jsp?pno=<%=f %>"><%=f %></a></td>
				<%
				} 
				%>
			</tr>
		</table>
        <div class="member_agreebtn" onclick="member_agreebtn()">문의하기</div>
    </div>
</section>
<form id="frm">
<input type="hidden" id="hd" name="qidx" value="">
</form>
<!-- 하단 시작 -->
<%@ include file="../Qmenu.jsp" %>
</main>
<%@ include file="../copyright.jsp" %>
</body>
</html>
<%
rs.close();
pst.close();
dbcon.close();
%>