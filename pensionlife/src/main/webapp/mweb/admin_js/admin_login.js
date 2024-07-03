$(()=>{
	//로그인
	$("#frm_admin_login").submit((event)=>{
		event.preventDefault();
		const admin_id = document.querySelector("#admin_id").value;
		const admin_pw = document.querySelector("#admin_pw").value;
		$.ajax({
			type : "post",
			url : "./admin_login.do",
			data : {
				admin_id : admin_id,
				admin_pw : admin_pw,
			},
			success : function(){
				alert(admin_id + "님 로그인 하셨습니다.");
				location.href = "./admin_qalist.jsp";
			},
			error : ((error)=>{
				alert('로그인 실패하셨습니다.');
			}),
		});
	})
	
	//로그아웃
	$("#admin_logout").click(()=>{
		$.ajax({
			type : "post",
			url : "./admin_logout.do",
			success : function(){
				location.href = './admin_login.jsp';		
			},
			error : ((error)=>{
				console.log(error);
			}),
		});
		
	})
})

