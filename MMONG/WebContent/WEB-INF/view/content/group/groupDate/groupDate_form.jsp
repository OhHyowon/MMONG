<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<style type="text/css">
.error{
	font-size:.8em;
	color: red;
}


<h3>일정 등록 form</h3>
<form action="/MMONG/group/groupDate/register.do?${_csrf.parameterName}=${_csrf.token}" method="post" onsubmit="return confirm('등록하시겠습니까?');">
일정 이름 : <input type="text" name="title"><span class="error"><form:errors path="groupDate.title" deilimiter="&nbsp;&nbsp;"/></span><br>
날짜 : <input type="datetime-local" name="groupDate"> <span class="error"><form:errors path="groupDate.groupDate" deilimiter="&nbsp;&nbsp;"/></span><br>
장소 : <input type="text" name="place">
<!--  
			장소는 지도로 바꿀 예정!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-->
<input type="submit" value="등록">

</form>
