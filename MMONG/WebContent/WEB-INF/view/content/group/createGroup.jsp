<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MMONG - 소모임 만들기</title>
<style>
#content{ line-height: 50px; }
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="/MMONG/resource/assets/js/jquery.js"></script>
<!-- Bootstrap core CSS -->
<link href="/MMONG/resource/assets/css/bootstrap.css?var=1" rel="stylesheet">

<!--external css-->
<link href="/MMONG/resource/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="/MMONG/resource/assets/js/gritter/css/jquery.gritter.css" />
<link rel="stylesheet" type="text/css" href="/MMONG/resource/assets/lineicons/style.css">        

<!-- Custom styles for this template -->
<!-- <link href="/MMONG/resource/assets/css/style.css?var=3" rel="stylesheet"> -->
<link href="/MMONG/resource/assets/css/style-responsive.css" rel="stylesheet">
    
<script type="text/javascript">
$('document').ready(function(){
	$("#create").on('click', function(){
		
		var params = jQuery("#createGroup").serialize();
		if( $('#name').val()==""){
			alert("모임 이름을 입력하세요.");
			return;
		}
		if( $('#content').val()==""){
			alert("모임에 대한 설명을 입력하세요.");
			return;
		}
		$.ajax({
			url : "/MMONG/group/insertGroup.do",
			type : "Post",
			data : params,
			cache : false,
			async : false,
			success : function(response) {
				if(response=="가입완료"){
					alert("모임 생성이 완료되었습니다.");
					opener.parent.location.reload();
					window.close();
				}
			}
		});			
	});
	
});
</script>
<style type="text/css">

th, td{
	padding: 8px;
}
</style>
</head>
<body>

	<section class="wrapper site-min-height">
<div align="center">
		<h3>
			<i class="fa fa-angle-right"></i> 소모임 만들기
		</h3>

<form id="createGroup">
	<table>	
		<tr>
			<th>소모임 이름&nbsp</th>
			<td><input type="text" id="name" name="name" value="${param.name}" class="form-control"></td>
		</tr>
		<tr>
			<th>모임 설명&nbsp</th>
			<td><input type="text" id="content" name="content" value="${param.content}" class="form-control">
				<input type="hidden" id="picture" name="picture" value="tmp"></td>
				
		</tr>
	</table>
	<br>
	<input type="button" id="create" value="생성" class="btn btn-default btn-sm" >&nbsp; 
	<input type="reset" value="다시 작성" class="btn btn-default btn-sm">&nbsp;
	<input type="hidden"  id="token" name="${_csrf.parameterName}"   value="${_csrf.token}"/>
</form>
</div>
</section>
</body>
</html>