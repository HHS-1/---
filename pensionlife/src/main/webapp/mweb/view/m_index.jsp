<%@page import="java.sql.Connection"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.dbconfig" %>
    <%
    HttpSession se = request.getSession();
	String user_id = (String)se.getAttribute("user_id");
	String user_name = (String)se.getAttribute("user_name");
	boolean login_check = false;
	if(se.getAttribute("login_check") != null){
		login_check = true;
	};
	
	
	
	
    dbconfig db = new dbconfig();
	Connection dbcon = db.getdbconfig();
    String sql="select * from pension_list group by pname order by rprice";
    PreparedStatement ps=dbcon.prepareStatement(sql);
    ResultSet rs=ps.executeQuery();
    %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>호텔 & 펜션 예약시스템</title>
    <link rel="stylesheet" type="text/css" href="../css/m_index.css?v=5">
    <script src="../js/jquery.js"></script>
    <script src="../js/m_index.js?v=2"></script>
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
<section>

    <ol class="product">
    <%
    while(rs.next()){ %>
        <li>
            <div onclick="reservation('<%=rs.getString("pname")%>')">
                <span><img src="<%=rs.getString("rfile")%>"></span>
                <span><%=rs.getString("pname")%></span>
                <span><% DecimalFormat df=new DecimalFormat("###,###");
        		out.print(df.format(Integer.parseInt(rs.getString("rprice")))+"원~"); %></span>
            </div>
        </li>
     <%} %>
    </ol>

</section>

<!-- 하단 시작 -->
<%@ include file="../Qmenu.jsp" %>
</main>
<%@ include file="../copyright.jsp" %>
</body>
<script>
	
	
	window.addEventListener('load', set_localStorage);
	if(<%=login_check%> == false){
		console.log("test")
		window.addEventListener('load', login_auto);
	}
	

	//자동로그인
	function set_localStorage(){
		if('<%=se.getAttribute("login_auto")%>'== "Y"){
			const user_id = '<%=user_id%>';
			const date = new Date();
			const data_autoLogin = {
					value: user_id,
			        expiry: date.getTime() + 100000,
			};
			
			localStorage.setItem("data_autoLogin",JSON.stringify(data_autoLogin));
		}else{
			return null;
		}
	}
	
	function login_auto(){
		 const data = localStorage.getItem("data_autoLogin");
		 const data_autoLogin = JSON.parse(data);
		 console.log(data_autoLogin.value);
		 if(data_autoLogin == null) return null;
		 else{
			 const date = new Date();
			 if(date.getTime() > data_autoLogin.expiry){
				 localStorage.removeItem("data_autoLogin");
			 }else{
				 $.ajax({
						type : "post",
						url : "./sign_in_auto.do",
						data : {
							user_id : data_autoLogin.value,
						},
						success : function(){
							location.reload();		
						},
						error : ((error)=>{
							console.log(error);
						}),
					});
			 }
		 }
	}

</script>
</html>
<%
rs.close();
ps.close();
dbcon.close();

%>