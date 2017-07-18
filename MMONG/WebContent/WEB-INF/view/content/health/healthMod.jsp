<%@ page contentType="text/html;charset=UTF-8"%>
<style type="text/css">
.button{
    color: #f74009;
    font-size: 12px;
    border-radius: 4px;
    -webkit-border-radius: 4px;
    border: 1px solid #fcab59 !important;
    padding: 5px 15px;
    margin-right: 15px;
    background: #ffd777;
    margin-top: 15px;
}
</style>
<body>
	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 건강관리 수정
		</h3>
<form action="/MMONG/health/updateHealth.do?${_csrf.parameterName}=${_csrf.token}" method="post" onsubmit="return confirm('등록하시겠습니까?')">
건강 관리 정보<br>
<textarea rows="20" cols="70" name="content">${param.checkedContent }</textarea><br>
<input type="hidden" name="no" value="${param.checkedNo }">

<input type="submit" value="등록" class="button">
</form>
</section>
</body>
</html>