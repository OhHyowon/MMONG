<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <!-- Bootstrap core CSS -->
    <link href="/MMONG/resource/assets/css/bootstrap.css?var=1" rel="stylesheet">
    
    <!--external css-->
    <link href="/MMONG/resource/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="/MMONG/resource/assets/js/gritter/css/jquery.gritter.css" />
    <link rel="stylesheet" type="text/css" href="/MMONG/resource/assets/lineicons/style.css">        
   
    <!-- Custom styles for this template -->
    <link href="/MMONG/resource/assets/css/style.css?var=2" rel="stylesheet">
    <link href="/MMONG/resource/assets/css/style-responsive.css" rel="stylesheet">
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

		<div class="col-lg-8">
	<div class="form-panel">
	<div>&nbsp;</div>
	
<form action="/MMONG/group/groupDate/updateGroupDate2.do" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
일정 이름 : <input type="text" name="title" value="${requestScope.groupDate.title }" class="form-control" ><span class="error"><form:errors path="groupDate.title" deilimiter="&nbsp;&nbsp;"/></span><br>
날짜 : <input type="datetime-local" name="groupDate" class="form-control" value="<fmt:formatDate value="${requestScope.groupDate.groupDate }" pattern="yyyy-MM-dd'T'HH:mm"/>"> <span class="error"><form:errors path="groupDate.groupDate" deilimiter="&nbsp;&nbsp;"/></span><br>
장소 : <input type="text" name="place" id="keyword" class="form-control" value="${requestScope.groupDate.place }"><input type="button" value="검색" id="searchPOI">
<div id="map_div" style="position: relative;">
	<div id="result_list_div" style="position: absolute; left: 400px; top: 0px;width: 300px; display: flex;">
	</div>
</div>
<input type="hidden" name="groupDateNo" value="${requestScope.groupDate.no }">
<div style="margin-left:510px">
	<input type="submit" value="등록" class="btn btn-default btn-sm">
	<input type="button" value="취소" onclick="window.close()" class="btn btn-default btn-sm">
</div>
</form>
</div>
</div>
</section>