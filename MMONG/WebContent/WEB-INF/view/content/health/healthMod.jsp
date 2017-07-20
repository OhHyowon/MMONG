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
}
</style>
<body>
<section class="wrapper site-min-height">
<div align="center">
	<div class="font">
		<div class="header">
			<i class="fa fa-angle-right"></i> 건강관리 수정
	</div>
<div class="background">
<form action="/MMONG/health/updateHealth.do?${_csrf.parameterName}=${_csrf.token}" method="post" onsubmit="return confirm('등록하시겠습니까?')">
건강 관리 정보<br>
<textarea rows="20" cols="70" name="content">${param.checkedContent }</textarea><br>
<input type="hidden" name="no" value="${param.checkedNo }">

<input type="submit" value="수정" class="button">
</form>
</div>
</div>
</div>
</section>
</body>
</html>