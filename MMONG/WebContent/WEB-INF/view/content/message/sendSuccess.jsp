<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>쪽지 보내기 성공</h2>

<ul>
	<li><a href="/MMONG/message/sendMessage.do">쪽지보내기</a></li>
	<!-- 실제론 컨트롤러 거쳐야한다. 게시판->컨트롤러(insert) ->쪽지보내기 폼 , 닉네임 가져와야해서-->
	<!-- 게시판에서 아이디 누를때, 아이디랑 닉네임 둘다 세션에 받아오면 ㄱㅊ -->
	
	<li><a href="/MMONG/message/selectReceiveMsg.do">받은 쪽지함</a></li>
	<li><a href="/MMONG/message/selectSendMsg.do">보낸 쪽지함</a></li>
</ul>
</body>
</html>