<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>소모임 수정하기</title>
<style>
#content {
	line-height: 50px;
}
th, td{
	padding: 8px;
}
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
<link href="/MMONG/resource/assets/css/style-responsive.css" rel="stylesheet">

<script type="text/javascript"
	src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#updateBtn").on("click",function(){
		var params = jQuery("#updateGroup").serialize();
		if( $('#name').val()==""){
			alert("모임 이름을 입력하세요.");
			return;
		}
		if( $('#content').val()==""){
			alert("모임에 대한 설명을 입력하세요.");
			return;
		}
		$.ajax({
			url:"/MMONG/group/updateGroup2.do",
			type:"post",
			data:params,
			cache : false,
			async : false,
			success : function(response) {
				if(response=="1"){
					alert("모임 수정 완료되었습니다.");
					opener.parent.location.reload();
					window.close();
				}
			}
		});
	}); // end of updateBtn
});
</script>
</head>
<body>

<section class="wrapper site-min-height">
	<div align="center">
		<h3>
			<i class="fa fa-angle-right"></i> 소모임 수정하기
		</h3>
		<form id="updateGroup">
			<table>
				<tr>
					<th>소모임 이름&nbsp</th>
					<td><input type="text" id="name" name="name" class="form-control" value="${requestScope.group.name}" >
					<form:errors path="group.name" deilimiter="&nbsp;&nbsp;" /></td>
				</tr>
				<tr>
					<th>모임 설명&nbsp</th>
					<td><input type="text" id="content" class="form-control"  name="content" value="${requestScope.group.content}" >
					<form:errors path="group.content" deilimiter="&nbsp;&nbsp;" />
					<input type="hidden" id="picture" name="picture" value="tmp"></td>
				</tr>
			</table>
			<br>
				<input type="button" id="updateBtn" value="수정" class="btn btn-default btn-sm">&nbsp;
				<input type="reset" value="다시 작성" class="btn btn-default btn-sm">&nbsp;
				<input type="hidden" id="token" name="${_csrf.parameterName}" value="${_csrf.token}" />
		</form>
	</div>
	</section>
</body>
</html>