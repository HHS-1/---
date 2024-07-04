//객실 선택onchange에서 두 개의 function 작동
function rinfo(z){
	rinfo1(z); // 선택한 객실의 예약된 날짜는 선택 못하게 하기 위한 예약된 날짜 배열화
	rinfo2(z); // 예약 페이지 업데이트
}

//선택한 객실의 예약된 날짜 배열화
var reserved_dates=[];
function rinfo1(z){
	var http = new XMLHttpRequest();
	http.onreadystatechange = function() {
		if (http.readyState == 4 && http.status == 200) {
		reserved_dates = JSON.parse(http.responseText);
		//console.log(reserved_dates);
		}
	}
http.open("POST", "./reserve_dates.do", true);
http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
http.send("rname=" + z);
}
/* 객실 선택시 페이지 예약 정보 업데이트*/
function rinfo2(z) {
    var http = new XMLHttpRequest();
    http.onreadystatechange = function() {
        if (http.readyState == 4 && http.status == 200) {
			var selectr=document.getElementById("selectr");
			if(selectr.value!=""){
			    var responseData = JSON.parse(http.responseText);
			    var rdetail = document.getElementById("rdetail");
			    var rsp_rmp = document.getElementById("rsp_rmp");
			    var rprice = document.getElementById("rprice");
				var pselect = document.getElementById("pselect");
			    var pea = "기준" + responseData.rsp + " / 최대" + responseData.rmp + "인";
			    rdetail.innerText = responseData.rdetail;
			    rsp_rmp.innerText = pea;
			    rprice.innerText = responseData.rprice;
			    pselect.innerHTML = ""; // 기존 옵션 초기화
		    	for (var w = parseInt(responseData.rsp); w <= parseInt(responseData.rmp); w++) {
			        var option = document.createElement("option");
			        option.text = w;
			        option.value = w;
			        pselect.appendChild(option);
		        }
			}
        }
    }
    http.open("POST", "./room_info.do", true);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("rname=" + z);
	
//객실 선택시 예약자정보 입력창의 객실선택 옵션 업데이트
var r_room = document.getElementById("r_room");
var pselect = document.getElementById("pselect");
	if(selectr.value==""){
		r_room.value = "객실을 선택하세요";
		var origin_pea = "<option value=''>입실 인원선택</option>";
		var rdetail = document.getElementById("rdetail");
		var rsp_rmp = document.getElementById("rsp_rmp");
		var rprice = document.getElementById("rprice");
		rdetail.innerText = "원하시는 객실을 선택하세요";
		rsp_rmp.innerText = "원하시는 객실을 선택하세요";
		rprice.innerText = "원하시는 객실을 선택하세요";
		pselect.innerHTML=origin_pea;
	}
	else{
	    r_room.value = z;
	}
}
//예약하기 버튼
function reserve_ok(){
	var datepicker=document.getElementById("datepicker");
	var r_room=document.getElementById("r_room");
	var r_name=document.getElementById("r_name");
	var r_tel=document.getElementById("r_tel");
	var r_cp=document.getElementById("pselect");
	var r_email=document.getElementById("r_email");
	var form=document.getElementById("form");
		if(r_room.value==""){
			alert("객실을 선택하세요");
			selectr.focus();
		}else if(datepicker.value==""){
			alert("날짜를 선택하세요");
			datepicker.focus();
		}else if(r_name.value==""){
			alert("예약자명을 입력하세요");
			r_name.focus();
		}else if(r_tel.value.length<11){
			alert("휴대폰 번호 11자리를 입력하세요");
			r_tel.focus();
		}else if(r_cp.value==""){
			alert("입실 인원을 선택하세요");
			r_cp.focus();
		}else if(r_email.value==""){
			alert("이메일을 입력하세요");
			r_email.focus();
		}
		else{
			if(confirm("예약 정보는 수정이 불가능 하며, 취소 후 다시 예약하셔야 합니다. 예약하시겠습니까?")){
				form.setAttribute("method","post");
				form.setAttribute("action","./reserve_ok.do");
				form.submit();
			}
			else{
				return false;
			}
		}
}

//휴대폰 번호 maxlength적용
function tel_maxlength(input) {
	const maxLength = input.getAttribute('maxlength');
		if (input.value.length > maxLength) {
			input.value = input.value.slice(0, maxLength);
		}
}


//달력 핸들링
 $(document).ready(function() {
            $('#datepicker').datepicker({
                dateFormat: 'yy-mm-dd', 
                minDate: '+1d', 
                onSelect: function(dateText, inst) {
					r_room.value = "객실을 선택하세요";
					var origin_pea = "<option value=''>입실 인원선택</option>";
					pselect.innerHTML=origin_pea;
					var rdetail = document.getElementById("rdetail");
					var rsp_rmp = document.getElementById("rsp_rmp");
					var rprice = document.getElementById("rprice");
					rdetail.innerText = "원하시는 객실을 선택하세요";
					rsp_rmp.innerText = "원하시는 객실을 선택하세요";
					rprice.innerText = "원하시는 객실을 선택하세요";
                    $(this).val(dateText);
					available_rooms(dateText);
                },
				beforeShowDay: function(date) {
		            var string = $.datepicker.formatDate('yy-mm-dd', date);
		            return [reserved_dates.indexOf(string) == -1]; // 예약된 날짜는 선택 불가능하도록 설정
				}
            });
        });

//날짜 선택시 해당 날짜에 선택 가능한 객실 option추가
function available_rooms(dateText) {
                var pname = document.getElementById("pname").value;
				var rooms=[];
                $.ajax({
                    url: 'available_rooms.do',
                    type: 'GET',
                    data: {
                        pname: pname,
                        checkin_date: dateText
                    },
                    success: function(response) {
                        rooms = JSON.parse(response);
                        var options = '<option value="">객실선택</option>';
	                        rooms.forEach(function(room) {
	                        options += '<option value="' + room + '">' + room + '</option>';
	                        });
                        $("#selectr").html(options);
                    }
                });
}

