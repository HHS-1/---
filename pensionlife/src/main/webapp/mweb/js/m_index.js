

//로그인 팝업
function login_pop(){
	var pop = document.getElementById("popup");
	if(pop.style.display=="none"){
		pop.style.display = "flex";
	}
	else{
		pop.style.display = "none";
	}
}
//로그인 팝업 닫기
function pop_close(){
	var pop = document.getElementById("popup");
	pop.style.display = "none";
}

//페이지 이동
function page_location(n){
	var url = "";
	if(n==1){
		url = "./m_idsearch.html";
	}
	else if(n==2){
		url = "./m_join.html";
	}
	location.href = url;
}

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
	}
	
	var token = document.getElementById("token").value = 123;
	frm.method = "post";
	frm.action = "./m_join2.jsp?token=" + token;
	frm.submit();
}



//middle 펜션 리스트 클릭시 예약 페이지로 이동
function reservation(c){
	var frm=document.createElement("form");
	frm.setAttribute("method","post");
	frm.setAttribute("action","./m_reservation.jsp");
	var input = document.createElement("input");
            input.setAttribute("type", "hidden");
            input.setAttribute("name", "hpname");
            input.setAttribute("value", c);
			frm.append(input);
            document.body.append(frm);
			frm.submit();
}

$(()=>{
		//로그아웃
	$("#logout").click(()=>{
		
		$.ajax({
			type : "post",
			url : "./sign_out.do",
			headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "POST"},
			data : {
				test : "test"
			},
			success : function(){
				localStorage.removeItem("data_autoLogin");
				location.reload();		
			},
			error : ((error)=>{
				console.log(error);
			}),
		});
		
	});

	$(function(){
		//1:1문의 select 부분
		$(".qa_part > li").click(function(){
			$n = $(this).index();
			$(".qa_part > li").attr("class","");
			$(".qa_part > li").eq($n).attr("class","onselect");
		});
	
		//햄버거 버튼 부분
		$("#menu_slide").click(function(){
			$("#menus_bar").fadeToggle();
		});
	
	});

})








