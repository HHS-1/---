
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

function login_pop_rck(){
	var pop_rck = document.getElementById("popup_rck");
	if(pop_rck.style.display=="none"){
		pop_rck.style.display = "flex";
	}
	else{
		pop_rck.style.display = "none";
	}
}

//비회원 로그인 버튼
function unmember_submit(){
	var form_unmember=document.getElementById("form_unmember");
	form_unmember.method="post";
	form_unmember.action="./m_reservation_list.jsp";
	form_unmember.submit();
}
//비회원 로그인 팝업창 닫기
function pop_close_rck(){
	var pop_rck = document.getElementById("popup_rck");
	pop_rck.style.display = "none";
}
//비회원 로그인 팝업에서 회원 로그인 팝업 spa
function login_pop_onrck(){
	var pop = document.getElementById("popup");
	var pop_rck = document.getElementById("popup_rck");
	pop_rck.style.display = "none";
	pop.style.display = "flex";
}
//로그인 팝업의 비회원 예약확인 버튼
function unmember_login(){
	var pop = document.getElementById("popup");
	var pop_rck = document.getElementById("popup_rck");
	pop_rck.style.display = "flex";
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



$(()=>{ //로그인,로그아웃

	//로그인
	$("#frm_login").submit((event)=>{
		event.preventDefault();
		const user_id = document.querySelector("#user_id").value;
		const user_pw = document.querySelector("#user_pw").value;
		const login_auto = document.querySelector("#login_auto").value;

		if(document.querySelector("#login_auto").checked == true){
			if(!confirm("피시방 등 공공장소에서는 자동로그인 사용을 권장하지 않습니다.\n취소를 클릭 시 자동로그인이 해제되어 로그인됩니다.")){
				document.querySelector("#login_auto").value = null;
			}	
		}

		$.ajax({
			type : "post",
			url : "./sign_in.do",
			data : {
				user_id : user_id,
				user_pw : user_pw,
				login_auto : login_auto,
			},
			success : function(success){
				console.log(success);
				if(success=="true"){
					
	    			location.reload();
				}
			},
			error : ((error)=>{
				console.log("실패");
				$("#login_fail_msg").css("display","block");
			}),
		});
	})
	
	

	
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
	
	//아이디 찾기
	$("#btn_findId").click(()=>{
		const user_name = document.querySelector("#user_name").value;
		const user_tel = document.querySelector("#user_tel").value;
		const user_email = document.querySelector("#user_email").value;
		const id_searchview = document.querySelector("#id_searchview");
		$.ajax({
			type : "post",
			url : "./find_id.do",
			data : {
				user_name : user_name,
				user_tel : user_tel,
				user_email : user_email,
			},
			success : function($user_id){
				console.log($user_id);
				id_searchview.innerText = "고객님의 아이디는 " + $user_id + "입니다."; 
			},
			error : ((error)=>{
				id_searchview.innerText = "해당 고객정보는 확인이 되지 않습니다.";
			}),
		});
	})
	
	//비밀번호 찾기
	$("#btn_changePw").click(()=>{
		const user_id = document.querySelector("#user_id2").value;
		const user_name = document.querySelector("#user_name2").value;
		const user_tel = document.querySelector("#user_tel2").value;
		
		$.ajax({
			type : "post",
			url : "./change_pw.do",
			data : {
				user_id : user_id,
				user_name : user_name,
				user_tel : user_tel,
			},
			success : function(success){
				if(success == "true"){
					alert(user_name + '님의 비밀번호 변경이 완료되었습니다.');
					location.href = './m_index.jsp'
				}
			},
			error : ((error)=>{
				id_searchview.innerText = "해당 고객정보는 확인이 되지 않습니다.";
			}),
		});
	})
	

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








