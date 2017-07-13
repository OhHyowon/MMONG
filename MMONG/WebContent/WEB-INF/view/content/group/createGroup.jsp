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
</head>
<body>
<h3>소모임 만들기</h3>
<form id="createGroup">
	<table>	
		<tr>
			<th>소모임 이름</th>
			<td><input type="text" id="name" name="name" value="${param.name}"></td>
		</tr>		
		<tr>
			<th>모임 설명</th>
			<td><input type="text" id="content" name="content" value="${param.content}">
				<input type="hidden" id="picture" name="picture" value="tmp"></td>
		</tr>		
		<tr>
			<td colspan="2">    
				<input type="button" id="create" value="생성">&nbsp; 
				<input type="reset" value="다시 작성">&nbsp;</td>
			</td>
		</tr>
	</table>
	<input type="hidden"  id="token" name="${_csrf.parameterName}"   value="${_csrf.token}"/>
</form>

</body>
</html>