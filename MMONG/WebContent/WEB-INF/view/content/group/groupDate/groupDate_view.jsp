<%@page import="com.mmong.vo.GroupDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
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
var map;
var markerLayer;
var marker;
var cLonLat;

function initialize() {
	$("#total_div").css("min-height", (document.body.scrollHeight-38.4)+"px");
	map = new Tmap.Map({div:"map_div", width:'350px', height:'240px'});
	cLonLat = new Tmap.LonLat(14149513.77048, 4495298.9298456);
	map.ctrl_nav.deactivate();
	
	markerLayer = new Tmap.Layer.Markers("marker");
	map.addLayer(markerLayer);
}

$(document).ready(function() {
	var placeSplit = $("#placeSplit").val();
	var place = placeSplit.split("_");
	
	cLonLat = new Tmap.LonLat(place[0], place[1]);
	map.setCenter(cLonLat, 14);
	
	var size = new Tmap.Size(24,38);
	var offset = new Tmap.Pixel(-(size.w/2), -size.h);
	var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_r_b_a.png', size, offset);
	var placeName = new Tmap.Label("<div style='text-align:center; font-size:14px;'>"+place[2]+"</div>");
	
	marker = new Tmap.Markers(cLonLat, icon, placeName);
	markerLayer.addMarker(marker);
	markerLayer.markers[0].popup.show();
});

window.onload=function(){
	initialize();
}

$(document).ready(function(){
	$(".insertBtn").on("click",function(){
		$.ajax({
			url:"/MMONG/group/groupDate/registerMeet.do",
			type:"post",
			data:{"${_csrf.parameterName}":"${_csrf.token}"},
			dataType:"json",
			success:function(txt){
				if(txt=='1'){
					alert("일정 참여 되었습니다.");
					location.href="/MMONG/group/groupDate/groupDateView.do?groupDateNo=${requestScope.groupDate.no}"
				}else{
					alert("일정 참여 실패");
				}
			}
		});
	}); // end of insertBtn
	$("#cancelBtn").on("click",function(){
		$.ajax({
			url:"/MMONG/group/groupDate/cancelMeet.do",
			type:"post",
			data:{"${_csrf.parameterName}":"${_csrf.token}"},
			dataType:"json",
			success:function(txt){
				if(txt=='1'){
					alert("일정 참여 취소 되었습니다.");
					location.href="/MMONG/group/groupDate/groupDateView.do?groupDateNo=${requestScope.groupDate.no}"
				}else{
					alert("에러");
				}
			}
		});
	}); // end of cancelBtn
	$("#deleteBtn").on("click",function(){
		if(!confirm("삭제하시겠습니까?")){
			return;
		}else{
			$.ajax({
				url:"/MMONG/group/groupDate/groupDateDelete.do",
				type:"post",
				data:{"${_csrf.parameterName}":"${_csrf.token}"},
				dataType:"json",
				success:function(txt){
					if(txt=="1"){
						alert("삭제되었습니다.");
						opener.parent.location.reload();
						self.close();		
					}else{
						alert("삭제 실패");
					}
				}
			});
		}
	}); // end of deleteBtn
});
</script>
<style>

</style>
<body>
<%-- 일정 상세보기 페이지가 열릴 때 마다 groupDateNo 세션에 저장 --%>
<%
	int groupDateNo = ((GroupDate)request.getAttribute("groupDate")).getNo();
	session.setAttribute("groupDateNo",groupDateNo);
%>
	<sec:authentication property="principal.memberId" var="loginId"/>


<div class="col-lg-8">

		<div>&nbsp;</div>
		<table class="table" style="font-size:12; text-align:center;">
			<tr>
				<td><b>이름 : ${requestScope.groupDate.title}</b></td>
			</tr>
			<tr>
				<td>일정 : <fmt:formatDate value="${requestScope.groupDate.groupDate}" pattern="yyyy-MM-dd HH:mm"/></td>
			</tr>
			<tr>
				<td>
				<c:choose>
						<c:when test="${empty requestScope.memberIdList}">
							<%--일정 참여자(memberList)가 없을 때--%>
							<div style="display: flex">
								<div>
									<li>일정 참여자가 없습니다!
								</div>
								<div style="margin-right: 150px;">
									&nbsp;&nbsp;<input class="btn btn-default btn-xs insertBtn"
										type="button" value="참여하기">
								</div>
							</div>
						</c:when>

						<c:otherwise>
							<%-- 일정 참여자가 있을 때 --%>
							<div style="text-align: center">일정 참여자</div>
							<c:forEach items="${requestScope.memberIdList }" var="memberId"
								varStatus="idx">
								<c:choose>
									<c:when test="${memberId == loginId }">
										<%-- 로그인된 아이디와 참여자 아이디가 같다면 참여 취소 버튼 보임 --%>
										<li>${memberId }(${requestScope.nickNameList[idx.index] })&nbsp;&nbsp;<input
											type="button" value="참여 취소" id="cancelBtn"
											class="btn btn-default btn-xs">
										</li>
									</c:when>

									<c:when test="${memberId != loginId }">
										<%-- 로그인된 아이디와 참여자 아이디가 다르다면 --%>
										<li>${memberId }(${requestScope.nickNameList[idx.index] })
										</li>
									</c:when>
								</c:choose>
							</c:forEach>

							<%
								int i = 1;
							%>
							<%-- 1이면 memberList(참여멤버)에 본인 없음, 2이면 본인 있음 --%>
							<c:forEach items="${requestScope.memberIdList }" var="memberId">
								<c:if test="${memberId==loginId }">
									<% i=2; %>
								</c:if>
							</c:forEach>
							<% if (i==1){%>
							<input type="button" value="참여 하기"
								class="btn btn-default btn-xs insertBtn">
							<%}%>
		
						</c:otherwise>
					</c:choose></td>
			</tr>
			<tr>
				<td style="padding-left:58px">
					<input type="hidden" value="${requestScope.groupDate.place }" id="placeSplit">
					<div id="map_div"></div>					
				</td>
			</tr>
			<tr>
				<td>
					<c:if test="${requestScope.groupDate.memberId == loginId }">
						<form action="/MMONG/group/groupDate/updateGroupDate1.do" method="post">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							<input type="hidden" name="groupDateNo" value="${requestScope.groupDate.no }">
							<input class="btn btn-default btn-sm" type="submit" value="수정하기" id="updateBtn" class="Btn" style="float:right;">
							<input class="btn btn-default btn-sm" type="button" value="삭제하기" id="deleteBtn" class="Btn" style="float:right;">	
						</form>						
					</c:if>					
				</td>
			</tr>
		</table>	
	</div>
</body> 