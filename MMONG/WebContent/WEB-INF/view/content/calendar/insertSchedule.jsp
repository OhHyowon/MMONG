<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
				<label>개인 <input type="radio" name="schedule" value="privateSch" checked="true"></label>
		  		<label>진료 <input type="radio" name="schedule" value="hospitalSch"></label>
		  		<label>소모임 <input type="radio" name="schedule" value="groupSch"></label>
		  		</div>
			</td>
		</tr>
		<tr> <!-- text를 이모티콘으로 변환 필요!!!!!!! 하나이상 선택 못하게!!!! -->
			<td>기분</td>  
			<td>
				<div>
					<label>기쁨 <input type="checkbox" name="emotion" value="happy"></label>
		  			<label>슬픔 <input type="checkbox" name="emotion" value="sad"></label>
		  			<label>화남 <input type="checkbox" name="emotion" value="angry"></label>
		  			<label>보통 <input type="checkbox" name="emotion" value="soso"></label>
		  			<label>우울 <input type="checkbox" name="emotion" value="gloomy"></label>
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
			<td><input type="datetime-local" name="startDate"></td>
		</tr>
		<tr> <!-- 시작일시 이전꺼 선택못하게 하기 -->
			<td>종료 일시</td>
			<td><input type="datetime-local" name="endDate" id="endDate"></td> 
		</tr>
		<tr>
			<td>메모</td>
			<td><input type="text" name="content"  value="${param.content }"></td> 
		</tr>
		<tr>
			<td>이미지 업로드</td>
			<td>
				<input type="file" name="upImage"><br>
			</td>	
		</tr>
		<tr>
			<td>공개여부</td>
			<td>
			<div>
				<label>전체공개 <input type="radio" name="secret" value="open" checked="true"></label>
			    <label>비밀글 <input type="radio" name="secret" value="secret"></label>
			    </div>
			</td>
		</tr>
	</table>
	
	<input type="submit" value="확인">
	<input type="button" value="취소" id="cancel"> 
	
</form>
</body>
</html>