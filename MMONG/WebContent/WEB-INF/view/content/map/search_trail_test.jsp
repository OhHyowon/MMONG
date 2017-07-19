<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div style="position:absolute; top:100px; left:300px;">
	산책로 NO : ${requestScope.trail.no }<br>
	산책로 카테고리 : ${requestScope.trail.category }<br>
	산책로 이름 : ${requestScope.trail.title }<br>
	산책로 설명 : ${requestScope.trail.content }<br>
	산책로 루트1 : ${requestScope.trail.route1 }<br>
	산책로 루트2 : ${requestScope.trail.route2 }<br>
	산책로 루트3 : ${requestScope.trail.route3 }<br>
	산책로 루트4 : ${requestScope.trail.route4 }<br>
	산책로 루트5 : ${requestScope.trail.route5 }<br>
	산책로 주인 : ${requestScope.trail.memberId }
</div>
</body>
</html>