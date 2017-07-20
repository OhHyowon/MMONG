<%@ page contentType="text/html;charset=UTF-8"%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">

$('document').ready(function(){
	
	$('#modButton').on("click",function() {
		var content = $(".ContentVal").val();
		var no = '${param.checkedNo }';
		
		$.ajax({
			'url' : "/MMONG/health/updateHealth.do",
			type : "Post",
			"data":{"no":no,"content":content,"${_csrf.parameterName}":"${_csrf.token}"},
			"beforeSend":function(){
				if(!content){
					alert("내용을 입력해 주세요.")
					return false;
				}
			},
			"success":function(){
				location.href='/MMONG/health/success.do';
			}
		});	
		
	});
	
});
</script>
<style type="text/css">

.button{
		/*손가락 나오게 하는거*/
		cursor:pointer;
	}

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
건강 관리 정보<br>
<textarea rows="20" cols="70" name="content" class="ContentVal" maxlength="300">${param.checkedContent }</textarea><br>
<input type="hidden" name="no" class="checkNo" value="${param.checkedNo }">

<input type="button" value="수정" id="modButton" class="button" onsubmit="return confirm('수정하시겠습니까?')">
</div>
</div>
</div>
</section>
</body>
</html>