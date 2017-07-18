<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 건강관리 등록
		</h3>
<form action="/MMONG/health/regist.do?${_csrf.parameterName}=${_csrf.token}" method="post" onsubmit="return confirm('등록하시겠습니까?')">
건강 관리 정보<br>
<textarea rows="20" cols="70" name="content"></textarea><br>
<p>
<label><input type="radio" name="gender" value="m">수컷</label>
<label><input type="radio" name="gender" value="g">암컷</label>
<label><input type="radio" name="gender" value="c">중성</label>
</p>

<input type="submit" value="등록">
</form>
</section>
</body>
</html>