<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
window.addEventListener('load', set_localStorage);
if(<%=login_check%> == false){
	console.log("자동로그인")
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