<%@ page contentType="text/html;charset=UTF-8"%>
<style type="text/css">
@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

div.font{
	font-family: "Noto Sans KR", sans-serif;
}

div.header{
	background: #d1cfcf
}

div.background{
	background: #f2f2f2
}

.button{
    color: #797979;
    font-size: 12px;
    border-radius: 4px;
    -webkit-border-radius: 4px;
    border: 1px solid #797979 !important;
    padding: 5px 15px;
    margin-right: 15px;
    background: #e5e5e5;
    margin-top: 15px;
    font-family: "Noto Sans KR", sans-serif;
}

</style>
<body>
	<section class="wrapper site-min-height">
<div align="center">
	<div class="font">
		<div class="header">
			<i class="fa fa-angle-right"></i> 건강관리 등록
		</div>
<div class="background">
<form action="/MMONG/health/regist.do?${_csrf.parameterName}=${_csrf.token}" method="post" onsubmit="return confirm('등록하시겠습니까?')">
건강 관리 정보<br>
<textarea rows="20" cols="70" name="content"></textarea><br>
<p>
<label><input type="radio" name="gender" value="m">수컷</label>
<label><input type="radio" name="gender" value="g">암컷</label>
<label><input type="radio" name="gender" value="c">중성</label>
</p>

<input type="submit" value="등록" class="button">
	</form>
</div>
</div>
</div>
</section>
</body>
</html>