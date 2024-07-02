
$(()=>{

	var $ck_pw = false;
	
	$(".ck_pw").keyup(()=>{
		if($("#ck_pw").val() != ""){
			if($("#pw").val() != $("#ck_pw").val()){
			$("#wrong_pw").css("display","block");
			}else{
				$("#wrong_pw").css("display","none");
				$ck_pw = true;
			}
		}
		
		
	})
	
	$("#btn_signUp").click(()=>{
	
		var $u_info = document.getElementsByName("u_info");

		for(var f = 0 ; f < $u_info.length ; f++){
			if($u_info[f].value == ""){
				alert('회원가입 정보를 모두 입력해주세요!');
				return false;
			}
		}
		if($ck_pw == false){
			alert('비밀번호가 틀렸습니다.');
			return false;
		}else if($("#securityCode").val() != $("#securityCode_input").val()){
			alert('보안코드가 틀렸습니다.');
			return false;
		}
		
		$("#frm").attr("method","post");
		$("#frm").attr("action","./sign_up.do");
		$("#frm").submit();

		/*$.ajax({
			type : 'post',
			url : './sign_up.do',
			async : true,
			headers : {
				"Content-Type" : "aplication/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType : 'html',
			data : {
				userInfo : $u_info
			},
			success : function(result){        
				console.log(result);    
			},    
			error : function(error){ 
				console.log(error);
			}
		})*/
		
	});
	
	
})