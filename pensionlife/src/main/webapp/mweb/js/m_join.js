/* 회원가입 */
//전체 선택
function all_check(){
	var ck_all = document.getElementById("ck_all");
	for(var f = 1 ; f <= 5 ; f++){
		document.getElementById("ck" + f).checked = ck_all.checked;
	}
}

//개별 체크에 따른 전체체크 활성화/비활성화
function check(){
	var ck = true;
	var ck_all = document.getElementById("ck_all");
	for(var f = 1 ; f <= 5 ; f++){
		if(document.getElementById("ck" + f).checked == false){
			ck_all.checked = false;
			ck = false;
			break;
		}
	}
	if(ck == true){
		ck_all.checked = true;
	}
}

// 회원가입 약관동의 완료(회원 가입 페이지로 이동)
function regist_agree(){
	for(var f = 1 ; f <= 4 ; f++){
		var ck_btn = document.getElementById("ck" + f);
		if(ck_btn.checked == false && f != 5){
			alert("필수 동의 사항을 체크해주세요");
			return false;		
		}
	}

	if(!document.getElementById("ck5").checked){
		 var ck_marketing = document.createElement("input");
         ck_marketing.type = "hidden";
         ck_marketing.name = "ck";
         ck_marketing.value = "N";
		 document.getElementById("frm").appendChild(ck_marketing); 	
	}
	
	var token = document.getElementById("token").value = 123;
	frm.method = "post";
	frm.action = "./m_join2.jsp?token=" + token;
	frm.submit();
}


$(()=>{
	
	$("#id_spot").on("input", ()=>{
		const check_id = document.querySelector("#check_id");
		check_id.value = "false";
		$("#usable_id").text("");
	})
	
	//아이디 중복검사
	$("#btn_ckId").click(()=>{
		const user_id = document.querySelector("#id_spot").value;
		const check_id = document.querySelector("#check_id"); 
		$.ajax({
			type : "post",
			url : "./check_id.do",
			data : {
				user_id : user_id,
			},
			success : function(success){
				if(success == "true"){
					check_id.value = "true";
					$("#usable_id").css("color","blue");
					$("#usable_id").text("사용 가능한 아이디입니다.");
					
				}
			},
			error : ((error)=>{
				$("#usable_id").css("color","red");
				$("#usable_id").text('아이디가 중복됩니다.');
			}),
		});
		
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