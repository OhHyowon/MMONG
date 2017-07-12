<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

 
</head>
<body>

<%--==================상단 HEADER=================== --%>
	<%-- header --%>
	<tiles:insertAttribute name="header"/>





<%--====================메인 BODY=================== --%>
	<%-- 메뉴 --%>
	<tiles:insertAttribute name="menu"/>
	
	
	<%-- 내용 --%>
	<tiles:insertAttribute name="content"/>




	
<%--===================하단 FOOTER=================== --%>


</body>
</html>