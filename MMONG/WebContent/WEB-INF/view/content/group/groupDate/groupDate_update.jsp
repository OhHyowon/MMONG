<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript"
	src="https://apis.skplanetx.com/tmap/js?version=1&format=javascript&appKey=6627b1a4-d735-3501-8a0d-84ad3ce149c9"></script>
<script type="text/javascript">

</script>
<style type="text/css">
.error{
	font-size:.8em;
	color: red;
}
</style>


<h3>일정 수정</h3>

<form action="/MMONG/group/groupDate/updateGroupDate2.do" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
일정 이름 : <input type="text" name="title" value="${requestScope.groupDate.title }"><span class="error"><form:errors path="groupDate.title" deilimiter="&nbsp;&nbsp;"/></span><br>
날짜 : <input type="datetime-local" name="groupDate" value="${requetScope.groupDate.groupDate }"> <span class="error"><form:errors path="groupDate.groupDate" deilimiter="&nbsp;&nbsp;"/></span><br>
장소 : <input type="text" name="place" id="keyword" value="${requestScope.groupDate.place }"><input type="button" value="검색" id="searchPOI">
<div id="map_div" style="position: relative;">
	<div id="result_list_div" style="position: absolute; left: 400px; top: 0px;width: 300px; display: flex;">
	</div>
</div>
<input type="submit" value="등록">
<input type="button" value="취소" onclick="location.href='/MMONG/group/groupDate/allGroupDateList.do'">

</form>
