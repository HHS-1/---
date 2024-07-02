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











