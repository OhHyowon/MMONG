<%@ page contentType="text/html;charset=UTF-8"%>
<style type="text/css">
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

<input type="submit" value="등록" class="button">
</form>
</section>
</body>
</html>