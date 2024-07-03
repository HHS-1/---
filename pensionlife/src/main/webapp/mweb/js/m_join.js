
$(()=>{
	
	$("#id_spot").on("input", ()=>{
		const check_id = document.querySelector("#check_id");
		check_id.value = "false";
		$("#usable_id").css("display","none");
	})
	
	var $ck_pw = false;
	//비밀번호 확인
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
	
	//회원가입 버튼 클릭
	$("#btn_signUp").click(()=>{
	
		var $u_info = document.getElementsByName("u_info");
		const $check_id = document.querySelector("#check_id");
		
		for(var f = 0 ; f < $u_info.length ; f++){
			if($u_info[f].value == ""){
				alert('회원가입 정보를 모두 입력해주세요!');
				return false;
			}
		}
		console.log($check_id.value);
		if($check_id.value != "true"){
			alert('아이디 중복 검사를 해주세요');
			return false;
		}
		else if($ck_pw == false){
			alert('비밀번호가 틀렸습니다.');
			return false;
		}else if($("#securityCode").val() != $("#securityCode_input").val()){
			alert('보안코드가 틀렸습니다.');
			return false;
		}
		
		$("#frm").attr("method","post");
		$("#frm").attr("action","./sign_up.do");
		$("#frm").submit();

		
	});
	
	
})