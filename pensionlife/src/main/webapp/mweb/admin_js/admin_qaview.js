function openPopup(url) {
        window.open(url, '이미지', 'width=800,height=600'); // 적절한 창 크기로 변경 가능
    }

$(function(){
	$(".adbtn1").click(function(){
		location.href="./admin_oklist.jsp";
	})
})