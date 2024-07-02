<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax - select 값 변경</title>
</head>
<body>
<select onchange="infodata(this.value)">
	<option value="data1">데이터1</option>
	<option value="data2">데이터2</option>
	<option value="data3">데이터3</option>
</select>
<div id="dataload">
데이터 출력
</div>

</body>
<script>
function infodata(z){
	console.log(z);
	var http, result;
	http = new XMLHttpRequest();
	http.onreadystatechange = function(){
		if(http.readyState == 4 && http.status == 200){
			console.log(this.response);
		}
	}
	
	http.open("post", "./ajax2.do", true);
	http.setRequestHeader("content-type","application/x-www-form-urlencoded");
	http.send("idx="+z);
	
}
</script>
</html>