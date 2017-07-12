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
#content{ line-height: 50px; }
</style>
<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
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

<h3>소모임 수정하기</h3>

<form id="updateGroup" >

	<table>	
		<tr>
			<th>소모임 이름</th>
			<td><input type="text" id="name" name="name" value="${requestScope.group.name}"><form:errors path="group.name" deilimiter="&nbsp;&nbsp;"/></td>
		</tr>		
		<tr>
			<th>모임 설명</th>
			<td><input type="text" id="content" name="content" value="${requestScope.group.content}"><form:errors path="group.content" deilimiter="&nbsp;&nbsp;"/>
				<input type="hidden" id="picture" name="picture" value="tmp"></td>
		</tr>		
		<tr>
			<td colspan="2">    
				<input type="button" id="updateBtn" value="수정">&nbsp; 
				<input type="reset" value="다시 작성">&nbsp;</td>
			</td>
		</tr>
	</table>
	<input type="hidden"  id="token" name="${_csrf.parameterName}"   value="${_csrf.token}"/>
</form>

</body>
</html>