<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
String db_driver="com.mysql.jdbc.Driver";
String db_url="jdbc:mysql://webmiwon.co.kr:3306/hsm_402";
String db_user="hsm_402";
String db_pass="402hsm";
Connection dbcon = null;
try{
	Class.forName(db_driver);
	dbcon = DriverManager.getConnection(db_url,db_user,db_pass);
}catch(Exception e){
	out.print(e);
	out.print("db접속이 올바르지 않습니다");
}
%>