<%@ page contentType="text/html;charset=UTF-8"%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">

$('document').ready(function(){
	
	$('#registButton').on("click",function() {
		var content = $(".registContent").val();
		var gender = $("input:radio[name=gender]:checked").val();
	
		$.ajax({
			'url' : "/MMONG/health/regist.do",
			type : "Post",
			"data":{"gender":gender,"content":content,"${_csrf.parameterName}":"${_csrf.token}"},
			"beforeSend":function(){
				if(!content){
					alert("내용을 입력해 주세요.");
					return false;
				}else if(!gender){
					alert("성별을 선택해 주세요.");
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
@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

.button{
		/*손가락 나오게 하는거*/
		cursor:pointer;
	}

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
			건강관리 등록
		</div>
<div class="background">
건강 관리 정보<br>
<textarea rows="20" cols="70" name="content" class="registContent" maxlength="300"></textarea><br>
<p>
<label><input type="radio" name="gender" class="registGender" value="m">수컷</label>
<label><input type="radio" name="gender" class="registGender" value="g">암컷</label>
<label><input type="radio" name="gender" class="registGender" value="c">중성</label>
</p>

<input type="button" value="등록" class="button" id="registButton">
</div>
</div>
</div>
</section>
</body>
</html>