<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
	
	$("#updateImg").on("click", function(){
		$("#file").empty();
		$("#file").append("<input type='file' name='upImage'><br>");
	});

	 $("#deleteImg").on("click",function(){
		$("#pic").empty();
		$("#pic").append("현재 이미지　없음");
		$("#file").empty();
		$("#file").append("<input type='hidden' name='delete' value=1>");
	 });
	 
	 $("input[class='check']").on("click", function(){
			$("input[class='check']").prop("checked", false);
			$(this).prop("checked", true);
		});
});

</script>

<style type="text/css">
span.error{
	font-size:small; /* 1em : 기본 크기의 1배수 크기 */
	color: red;
}
</style>

</head>
<body>
<div class="viewName" align="center"><br><h2>일정 수정</h2><br></div>
<br>
<div align="center">
<form action="/MMONG/calendar/update.do?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data" onsubmit="return confirm('수정하시겠습니까?');">
<table>
	<tr>
		<th>일정</th>
		<td style="width: 300px;padding:0px 0px 0px 20px;">
			<c:choose>
				<c:when test="${requestScope.updateInfo.type eq 0}">
					<div>
						<label>개인 <input type="radio" name="type" value=0 style="margin-right:10px" checked="true"></label>
		  				<label>진료 <input type="radio" name="type" value=1 style="margin-right:10px"></label>
		  				<label>소모임 <input type="radio" name="type" value=2 style="margin-right:10px"></label>
		  			</div>
				</c:when>
				<c:when test="${requestScope.updateInfo.type eq 1}">
					<div>
						<label>개인 <input type="radio" name="type" value=0 style="margin-right:10px"></label>
		  				<label>진료 <input type="radio" name="type" value=1 style="margin-right:10px" checked="true"></label>
		  				<label>소모임 <input type="radio" name="type" value=2 style="margin-right:10px"></label>
		  			</div>
				</c:when>
				<c:otherwise>
					<div>
						<label>개인 <input type="radio" name="type" value=0 style="margin-right:10px"></label>
		  				<label>진료 <input type="radio" name="type" value=1 style="margin-right:10px"></label>
		  				<label>소모임 <input type="radio" name="type" value=2 style="margin-right:10px" checked="true"></label>
		  			</div>
				</c:otherwise>
			</c:choose>
		</td> 
	</tr>
	<tr style="line-height:30px;">
		<th>기분</th>
		<td style="width: 300px;padding:0px 0px 0px 20px;">
			<c:choose>
				<c:when test="${requestScope.updateInfo.emotion eq 1}">
					<div>
						<label><img src="/MMONG/resource/calendar/emoticon/happy.png" width="20" height="20"> 
									<input type="checkbox" class="check" name="emotion" value=1 style="margin-right:10px" checked="checked"></label>
			  			<label><img src="/MMONG/resource/calendar/emoticon/sad.png" width="20" height="20"> 
			  						<input type="checkbox" class="check" name="emotion" value=2 style="margin-right:10px"></label>
			  			<label><img src="/MMONG/resource/calendar/emoticon/upset.png" width="20" height="20"> 
			  						<input type="checkbox" class="check" name="emotion" value=3 style="margin-right:10px"></label>
			  			<label><img src="/MMONG/resource/calendar/emoticon/soso.png" width="20" height="20">
			  						<input type="checkbox" class="check" name="emotion" value=4 style="margin-right:10px"></label>
			  			<label><img src="/MMONG/resource/calendar/emoticon/gloomy.png" width="20" height="20"> 
			  						<input type="checkbox" class="check" name="emotion" value=5 style="margin-right:10px"></label>
		  			</div>
				</c:when>
				<c:when test="${requestScope.updateInfo.emotion eq 2}">
					<div>
						<label><img src="/MMONG/resource/calendar/emoticon/happy.png" width="20" height="20"> 
									<input type="checkbox" class="check" name="emotion" value=1 style="margin-right:10px"></label>
			  			<label><img src="/MMONG/resource/calendar/emoticon/sad.png" width="20" height="20"> 
			  						<input type="checkbox" class="check" name="emotion" value=2 style="margin-right:10px" checked="checked"></label>
			  			<label><img src="/MMONG/resource/calendar/emoticon/upset.png" width="20" height="20"> 
			  						<input type="checkbox" class="check" name="emotion" value=3 style="margin-right:10px"></label>
			  			<label><img src="/MMONG/resource/calendar/emoticon/soso.png" width="20" height="20">
			  						<input type="checkbox" class="check" name="emotion" value=4 style="margin-right:10px"></label>
			  			<label><img src="/MMONG/resource/calendar/emoticon/gloomy.png" width="20" height="20"> 
			  						<input type="checkbox" class="check" name="emotion" value=5 style="margin-right:10px"></label>
		  			</div>
				</c:when>
				<c:when test="${requestScope.updateInfo.emotion eq 3}">
					<div>
						<label><img src="/MMONG/resource/calendar/emoticon/happy.png" width="20" height="20"> 
									<input type="checkbox" class="check" name="emotion" value=1 style="margin-right:10px"></label>
			  			<label><img src="/MMONG/resource/calendar/emoticon/sad.png" width="20" height="20"> 
			  						<input type="checkbox" class="check" name="emotion" value=2 style="margin-right:10px"></label>
			  			<label><img src="/MMONG/resource/calendar/emoticon/upset.png" width="20" height="20"> 
			  						<input type="checkbox" class="check" name="emotion" value=3 style="margin-right:10px" checked="checked"></label>
			  			<label><img src="/MMONG/resource/calendar/emoticon/soso.png" width="20" height="20">
			  						<input type="checkbox" class="check" name="emotion" value=4 style="margin-right:10px"></label>
			  			<label><img src="/MMONG/resource/calendar/emoticon/gloomy.png" width="20" height="20"> 
			  						<input type="checkbox" class="check" name="emotion" value=5 style="margin-right:10px"></label>
		  			</div>
				</c:when>
				<c:when test="${requestScope.updateInfo.emotion eq 4}">
					<div>
						<label><img src="/MMONG/resource/calendar/emoticon/happy.png" width="20" height="20"> 
									<input type="checkbox" class="check" name="emotion" value=1 style="margin-right:10px"></label>
			  			<label><img src="/MMONG/resource/calendar/emoticon/sad.png" width="20" height="20"> 
			  						<input type="checkbox" class="check" name="emotion" value=2 style="margin-right:10px"></label>
			  			<label><img src="/MMONG/resource/calendar/emoticon/upset.png" width="20" height="20"> 
			  						<input type="checkbox" class="check" name="emotion" value=3 style="margin-right:10px"></label>
			  			<label><img src="/MMONG/resource/calendar/emoticon/soso.png" width="20" height="20">
			  						<input type="checkbox" class="check" name="emotion" value=4 style="margin-right:10px" checked="checked"></label>
			  			<label><img src="/MMONG/resource/calendar/emoticon/gloomy.png" width="20" height="20"> 
			  						<input type="checkbox" class="check" name="emotion" value=5 style="margin-right:10px"></label>
		  			</div>
				</c:when>
				<c:when test="${requestScope.updateInfo.emotion eq 5}">
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
			  						<input type="checkbox" class="check" name="emotion" value=5 style="margin-right:10px" checked="checked"></label>
		  			</div>
				</c:when>
				<c:otherwise>
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
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	<tr>
		<th style="line-height:30px;">제목</th>
		<td style="width: 300px;padding:0px 0px 0px 20px;"><input type="text" name="title" style="width:247.5px; height:30px;" value="${requestScope.updateInfo.title }">
				<br><span class="error"><form:errors path="calendar.title"/></span></td> 
	</tr>
	<tr style="line-height:30px;">
		<td>시작 일시</td>
		<td style="width: 300px;padding:10px 0px 0px 20px;"><input type="datetime-local" name="startDate" value="<fmt:formatDate value="${requestScope.updateInfo.startDate }" pattern="yyyy-MM-dd'T'HH:mm"/>">
				<br><span class="error"><form:errors path="calendar.startDate"/></span></td>
	</tr>
	<tr style="line-height:30px;">
		<td>종료 일시</td>
		<td style="width: 300px;padding:10px 0px 0px 20px;"><input type="datetime-local" name="endDate"  value="<fmt:formatDate value="${requestScope.updateInfo.endDate }" pattern="yyyy-MM-dd'T'HH:mm"/>">
				<br><span class="error"><form:errors path="calendar.endDate"/></span></td> 
	</tr>
	<tr style="line-height:30px;">
		<th>메모</th>
		<td style="width: 300px;padding:10px 0px 0px 20px;"><input type="text" name="content" style="width:247.5px; height:80px;" value="${requestScope.updateInfo.content }">
				<br><span class="error"><form:errors path="calendar.content"/></span></td>
	</tr>
	<tr style="line-height:30px;">
		<th>이미지</th>
		<td style="width: 300px;padding:10px 0px 0px 20px;">
			<div id="pic">
				<c:choose>
					<c:when test="${not empty requestScope.updateInfo.picture}">
						현재 이미지　${requestScope.updateInfo.picture }
					</c:when>
					<c:otherwise>
						현재 이미지　없음
					</c:otherwise>
				</c:choose>
			</div>
			<label>이미지 수정<input type="radio" id="updateImg" name="imgCheck" value="updateImg" style="margin-right:10px"></label> 
			<label>이미지 삭제<input type="radio" id="deleteImg" name="imgCheck" value="deleteImg" style="margin-right:10px"></label><br>
			<div id="file"></div>
		</td>
	</tr>
</table>
	<input type="hidden" value="${requestScope.updateInfo.picture }" name="savedImg">

	<input type="submit" class="btn btn-default" value="확인">
	<input type="button" class="btn btn-default" value="취소" onclick="javascript:history.back(-1)">
	<input type="hidden" name="no" value="${requestScope.updateInfo.no }">
</form>
</div>
</body>
</html>