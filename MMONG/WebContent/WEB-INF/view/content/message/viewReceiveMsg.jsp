<%@ page contentType="text/html;charset=UTF-8"%>

<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	//팝업창 크기 조절
	var width=480, height=480;
	var left = (screen.availWidth - width)/2;
	var top = (screen.availHeight - height)/2;
	var specs = "width=" + width;
	specs += ",height=" + height;
	specs += ",left=" + left;
	specs += ",top=" + top;
	
	$(".reply").on("click", function(){
		var no = $("#no").val()
		
		window.open("/MMONG/message/selectMsgIdNick.do?no="+no, "답장보내기", specs);
	});
});
</script>

		<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 받은 쪽지 내용 보기
		</h3>
	
		<table>
			<tr><td>보낸이</td><td>${requestScope.message.sendId }(${requestScope.message.member.nickName })</td></tr>
			<tr><td>받은 시간</td><td>${requestScope.message.messageDate }</td></tr>
			<tr><td>제목</td><td>${requestScope.message.title }</td></tr>
			<tr><td>내용</td><td>${requestScope.message.content }</td></tr>
		</table>
	
		<input type="button" value="답장" class="reply">
		<input type="button" value="확인" onclick="location.href='/MMONG/message/selectReceiveMsg.do'">
		<input type="hidden" value="${requestScope.message.no}" id="no">
	</section>
