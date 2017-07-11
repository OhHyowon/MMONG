<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript"
	src="https://apis.skplanetx.com/tmap/js?version=1&format=javascript&appKey=6627b1a4-d735-3501-8a0d-84ad3ce149c9"></script>
<script type="text/javascript">
var map, markerLayer;
var tdata;

var markers; //POI검색시 등록되는 마커
var placeMarker; //일정 장소 마커
var cLonLat; //지도 중심 좌표

var marker_size;
var marker_offset;
var marker_icon;

var searchText = "keyword"; //검색 키워드

function initialize() {
	map = new Tmap.Map({div:"map_div", width:'400px', height:'250px'});
	map.addControl(new Tmap.Control.MousePosition());
	
	markerLayer = new Tmap.Layer.Markers("marker");
    map.addLayer(markerLayer);
    
    map.events.register("click", map, onClickMap);
    
    $("#searchPOI").on("click", function() {
		$("#result_list_div").empty();
		markerLayer.clearMarkers();
		searchText = $("#keyword").val();
		searchPOI(searchText);
	});
    
    marker_size = new Tmap.Size(24,38);
	marker_offset = new Tmap.Pixel(-(marker_size.w/2), -marker_size.h);
	marker_icon = new Tmap.Icon("https://developers.skplanetx.com/upload/tmap/marker/pin_r_m_1.png", marker_size, marker_offset);
}

function searchPOI(keyword){
	tdata = new Tmap.TData();
	tdata.events.register("onComplete", tdata, onCompleteTData);
	searchKeyword(keyword, 1);
}

function searchKeyword(keyword, searchPage) {
	var center = map.getCenter();
	tdata.getPOIDataFromSearch(encodeURIComponent(keyword), {centerLon:center.lon, centerLat:center.lat, radius:5, page:searchPage, count:10});
}

function onCompleteTData(e){
	$("#result_list_div").empty();
	markerLayer.clearMarkers();
	if($(this.responseXML).find("searchPoiInfo pois poi").text() != ''){
			$(this.responseXML).find("searchPoiInfo pois poi").each(function(){
				var name = $(this).find("name").text();
				var lon = $(this).find("frontLon").text();
				var lat = $(this).find("frontLat").text();
				var options = {
					label:new Tmap.Label(name),
					lonlat:new Tmap.LonLat(lon, lat)
				};
				addMarker(options);
				$("#result_list_div").append("<span class='index'>"+($(this).index()+1)+"</span><span class='result'><a href='javascript:selectPOI("+lon+","+lat+","+$(this).index()+")'>"+name+"</a></span><br>");
		});
		map.zoomToExtent(markerLayer.getDataExtent());
	}else {
		alert('검색결과가 없습니다.');
	}
	pagingView(searchText);
}

//function paging view 복붙

function onCompleteTData(e){
	$("#result_list_div").empty();
	markerLayer.clearMarkers();
	if($(this.responseXML).find("searchPoiInfo pois poi").text() != ''){
			$(this.responseXML).find("searchPoiInfo pois poi").each(function(){
				var name = $(this).find("name").text();
				var lon = $(this).find("frontLon").text();
				var lat = $(this).find("frontLat").text();
				var options = {
					label:new Tmap.Label(name),
					lonlat:new Tmap.LonLat(lon, lat)
				};
				addMarker(options);
				$("#result_list_div").append("<span class='index'>"+($(this).index()+1)+"</span><span class='result'><a href='javascript:selectPOI("+lon+","+lat+","+$(this).index()+")'>"+name+"</a></span><br>");
		});
		map.zoomToExtent(markerLayer.getDataExtent());
	}else {
		alert('검색결과가 없습니다.');
	}
	pagingView(searchText);
}

function onClickMap(event) {
	cLonLat = this.getLonLatFromPixel(new Tmap.Pixel(event.clientX, event.clientY-100));
	var marker_label = new Tmap.Label();
	placeMarker = new Tmap.Marker(cLonLat, marker_icon, marker_label);
	markerLayer.addMarker(placeMarker);
	
	markerLayer.markers.popup.show();
	
	map.panTo(cLonLat);
}

window.onload = function() {
	initialize();
}
</script>
<style type="text/css">
.error{
	font-size:.8em;
	color: red;
}
</style>
</head>
<body>

<h2>일정 등록 form</h2>
<form action="/MMONG/group/groupDate/register.do?${_csrf.parameterName}=${_csrf.token}" method="post" onsubmit="return confirm('등록하시겠습니까?');">
일정 이름 : <input type="text" name="title"><span class="error"><form:errors path="groupDate.title" deilimiter="&nbsp;&nbsp;"/></span><br>
날짜 : <input type="datetime-local" name="groupDate"> <span class="error"><form:errors path="groupDate.groupDate" deilimiter="&nbsp;&nbsp;"/></span><br>
장소 : <input type="text" name="place" id="keyword"><input type="button" value="검색" id="searchPOI">
<div id="map_div" style="position: relative;">
	<div id="result_list_div" style="position: absolute; left: 400px; top: 0px;width: 300px; display: flex;">
	</div>
</div>
<input type="submit" value="등록">

</form>
</body>
</html>