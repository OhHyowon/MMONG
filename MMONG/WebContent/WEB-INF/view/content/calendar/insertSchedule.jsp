<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

 <!-- Bootstrap core CSS -->
    <link href="/MMONG/resource/assets/css/bootstrap.css?var=1" rel="stylesheet">
    
    <!--external css-->
    <link href="/MMONG/resource/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="/MMONG/resource/assets/js/gritter/css/jquery.gritter.css" />
    <link rel="stylesheet" type="text/css" href="/MMONG/resource/assets/lineicons/style.css">        
   
    <!-- Custom styles for this template -->
    <link href="/MMONG/resource/assets/css/style.css?var=2" rel="stylesheet">
    <link href="/MMONG/resource/assets/css/style-responsive.css" rel="stylesheet">


<style type="text/css">
span.error{
	font-size:small; /* 1em : 기본 크기의 1배수 크기 */
	color: red;
}

body{
	font-size: 16px;
}

.viewName{
	background-color: #F2F2F2;
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
<div class="viewName" align="center"><br><h2>일정 추가</h2><br></div>
<br>
<div align="center">
<form action="/MMONG/calendar/insert.do?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data" onsubmit="return confirm('등록하시겠습니까?');">

	<table>
		<tr>
			<td>일정</td>
			<td style="width: 300px;padding:0px 0px 0px 20px;">
			<div>
		  		<label>개인 <input type="radio" name="schedule" value=0 style="margin-right:10px" checked="true" ></label>
		  		<label>진료 <input type="radio" name="schedule" value=1 style="margin-right:10px"></label>
		  		<label>소모임 <input type="radio" name="schedule" value=2 style="margin-right:10px"></label>
		  		</div>
			</td>
		</tr>
		<tr style="line-height:30px;">
			<td>기분</td>  
			<td style="width: 300px;padding:0px 0px 0px 20px;">
				<div>
		  			<label><img src="/MMONG/resource/calendar/emoticon/happy.png" width="20" height="20"> 
		  						<input type="checkbox" class="check" name="emotion" value=1 style="margin-right:10px"></label>
		  			<label><img src="/MMONG/resource/calendar/emoticon/sad.png" width="20" height="20">
		  						<input type="checkbox" class="check" name="emotion" value=2 style="margin-right:10px"></label>
		  			<label><img src="/MMONG/resource/calendar/emoticon/upset.png" width="20" height="20">
		  						<input type="checkbox" class="check" name="emotion" value=3 style="margin-right:10px"></label>
		  			<label><img src="/MMONG/resource/calendar/emoticon/soso.png" width="20" height="20">
		  						<input type="checkbox" class="check" name="emotion" value=4 style="margin-right:10px"></label>
		  			<label><img src="/MMONG/resource/calendar/emoticon/gloomy.png" width="20" height="20">
		  						<input type="checkbox" class="check" name="emotion" value=5 style="margin-right:10px"></label>
		  		</div>
			</td>
		</tr>
		<tr style="line-height:30px;">
			<td>제목</td>
			<td style="width: 300px;padding:0px 0px 0px 20px;"><input type="text" name="title" style="width:247.5px; height:30px;" value="${param.title }">
					<br><span class="error"><form:errors path="calendar.title"/></span></td>
		</tr>
		<tr style="line-height:30px;">
			<td>시작 일시</td>
			<td style="width: 300px;padding:10px 0px 0px 20px;"><input type="datetime-local" name="startDate" id="from" value="<fmt:formatDate value="${requestScope.insertInfo.startDate }" pattern="yyyy-MM-dd'T'HH:mm"/>">
					<br><span class="error"><form:errors path="calendar.startDate"/></span></td>
		</tr>
		<tr style="line-height:30px;">
			<td>종료 일시</td>
			<td style="width: 300px;padding:10px 0px 0px 20px;"><input type="datetime-local" name="endDate" id="to" value="<fmt:formatDate value="${requestScope.insertInfo.endDate }" pattern="yyyy-MM-dd'T'HH:mm"/>">
					<br><span class="error"><form:errors path="calendar.endDate"/></span></td> 
		</tr>
		<tr style="line-height:30px;">
			<td>메모</td>
			<td style="width: 300px;padding:10px 0px 0px 20px;"><input type="text" name="content" style="width:247.5px; height:80px;" value="${param.content }">
					<br><span class="error"><form:errors path="calendar.content"/></span></td> 
		</tr>
		<tr style="line-height:30px;">
			<td>이미지 업로드</td>
			<td style="width: 300px;padding:10px 0px 0px 20px;">
				<input type="file" name="upImage"><br>
			</td>	
		</tr>
		
	</table>
	
	<input type="submit" class="btn btn-default" value="전송">
	<input type="button" class="btn btn-default" value="취소" id="cancel"> 
</form>
</div>
</body>
</html>