<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">
span.error{
	font-size:small; /* 1em : 기본 크기의 1배수 크기 */
	color: red;
}
</style>

<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#cancel").on("click", function(){
		self.close();		
	});
	
	$("#to").one("click", function(){ //종료일시 기입시, 시작일시가 minimum value가 되도록 설정
		to.min = $("#from").val();
	});
	
	$("input[class='check']").on("click", function(){
		$("input[class='check']").prop("checked", false);
		$(this).prop("checked", true);
	});

});

</script>

</head>
<body>
<h2>일정 추가 팝업창</h2>

<form action="/MMONG/calendar/insert.do?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data" onsubmit="return confirm('등록하시겠습니까?');">

	<table>
		<tr>
			<td>일정 구분</td>
			<td>
			<div>
		  		<label>개인 <input type="radio" name="schedule" value=0 checked="true"></label>
		  		<label>진료 <input type="radio" name="schedule" value=1></label>
		  		<label>소모임 <input type="radio" name="schedule" value=2></label>
		  		</div>
			</td>
		</tr>
		<tr> <!-- text를 이모티콘으로 변환 필요!!!!!!! 하나이상 선택 못하게!!!! -->
			<td>기분</td>  
			<td>
				<div>
		  			<label>기쁨 <input type="checkbox" class="check" name="emotion" value=1></label>
		  			<label>슬픔 <input type="checkbox" class="check" name="emotion" value=2></label>
		  			<label>화남 <input type="checkbox" class="check" name="emotion" value=3></label>
		  			<label>보통 <input type="checkbox" class="check" name="emotion" value=4></label>
		  			<label>우울 <input type="checkbox" class="check" name="emotion" value=5></label>
		  		</div>
			</td>
		</tr>
		<tr>
			<td>제목</td>
			<td><input type="text" name="title"  value="${param.title }">
					<span class="error"><form:errors path="calendar.title"/></span></td>
		</tr>
		<tr>
			<td>시작 일시</td>
			<td><input type="datetime-local" name="startDate" id="from" value="<fmt:formatDate value="${requestScope.insertInfo.startDate }" pattern="yyyy-MM-dd'T'HH:mm"/>">
					<span class="error"><form:errors path="calendar.startDate"/></span></td>
		</tr>
		<tr> <!-- 시작일시 이전꺼 선택못하게 하기 -->
			<td>종료 일시</td>
			<td><input type="datetime-local" name="endDate" id="to" value="<fmt:formatDate value="${requestScope.insertInfo.endDate }" pattern="yyyy-MM-dd'T'HH:mm"/>">
					<span class="error"><form:errors path="calendar.endDate"/></span></td> 
		</tr>
		<tr>
			<td>메모</td>
			<td><input type="text" name="content"  value="${param.content }">
					<span class="error"><form:errors path="calendar.content"/></span></td> 
		</tr>
		<tr>
			<td>이미지 업로드</td>
			<td>
				<input type="file" name="upImage"><br>
			</td>	
		</tr>
		
	</table>
	
	<input type="submit" value="전송">
	<input type="button" value="취소" id="cancel"> 
	
</form>
</body>
</html>