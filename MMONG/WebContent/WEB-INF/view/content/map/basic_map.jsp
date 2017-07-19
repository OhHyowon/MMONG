<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript"
	src="https://apis.skplanetx.com/tmap/js?version=1&format=javascript&appKey=6627b1a4-d735-3501-8a0d-84ad3ce149c9"></script>
<script type="text/javascript" src="/MMONG/resource/map/map_func.js"></script>
<script type="text/javascript">
var appKey = "6627b1a4-d735-3501-8a0d-84ad3ce149c9";
var map;
var markerLayer; //산책로 등록시 사용할 마커 레이어
var markersLayer; //POI검색시 사용할 마커 레이어
var markerLayer_bak; //마커 삭제시 백업에 사용할 마커 레이어
var tdata;

var marker; //산책로 등록시 사용할 마커 5개
var markers; //POI검색시 사용할 마커
var i = 0; //산책로 마커 index
var cLonLat; //맵 중심 좌표

var marker_lonlat;
var marker_lon = new Array(5); //산책로 각 마커의 lon 좌표를 저장할 변수
var marker_lat = new Array(5); //산책로 각 마커의 lat 좌표를 저장할 변수
var marker_cLonLat; //산책로 마커들의 중심 좌표
var marker_cLonLat_lon = 0; //산책로 마커들의 lon 좌표의 합을 저장할 변수
var marker_cLonLat_lat = 0; //산책로 마커들의 lat 좌표의 합을 저장할 변수

var bounds; //산책로 마커들을 전부 포함할 bound
var bound_left = 0; //산책로 마커들을 전부 포함할 bound의 left 좌표 (마커들 중 lon 좌표의 크기가 가장 작은 좌표를 삽입)
var bound_bottom = 0; //산책로 마커들을 전부 포함할 bound의 bottom 좌표 (마커들 중 lat 좌표의 크기가 가장 작은 좌표를 삽입)
var bound_right = 0; //산책로 마커들을 전부 포함할 bound의 right 좌표 (마커들 중 lon 좌표의 크기가 가장 큰 좌표를 삽입)
var bound_top = 0; //산책로 마커들을 전부 포함할 bound의 top 좌표 (마커들 중 lat 좌표의 크기가 가장 큰 좌표를 삽입)
var temp = true; //현재 bound가 모든 산책로 마커들을 포함하고 있는지 여부, 기본값 true, 포함하지 않을 때 false

var searchLonLat; //POI검색 좌표
var searchText = "keyword"; //POI 검색 키워드
var markerName; //산책로 마커 이름

var no = new Array();
var category = new Array();

var tArr = new Array();

var title = new Array();
var content = new Array();
var route1 = new Array();
var route2 = new Array();
var route3 = new Array();
var route4 = new Array();
var route5 = new Array();
var memberId = new Array();
var trailIndex;

//맵 초기화 함수
function initialize() {
	map = new Tmap.Map({div:"map_div", width:'600px', height:'400px', animation:true}); //div#map_div에 맵 등록, 기본 zoom 레벨 15
	cLonLat = new Tmap.LonLat(14149513.77048, 4495298.9298456);
	map.setCenter(cLonLat, 16);//유스페이스2 좌표를 맵 중심으로 설정
	map.addControl(new Tmap.Control.MousePosition()); //마우스 위치 상의 좌표를 맵 우측 하단에 띄워주는 control 등록
	
	markersLayer = new Tmap.Layer.Markers("markers");
	markerLayer = new Tmap.Layer.Markers("marker");
	markerLayer_bak = new Tmap.Layer.Markers("bak");
	map.addLayer(markerLayer);
	map.addLayer(markersLayer);
	map.addLayer(markerLayer_bak);
}

//☆☆ js파일로 빼면 안됨
//생성된 산책로 마커를 리스트(div#trail_list_div)에 등록하는 함수
function addMarkerToList(marker, index) {
	var contentHTML = markerLayer.markers[index].popup.contentHTML;
	replaceContentHTML = contentHTML.replace(/<\/?[^>]+>/gi, "");

	if(index%2==0) {
		$("#trail_list_div").append("<div style='display:flex; margin: 15px 0;' name='listDiv"+(index+1)+"'><div class='marker' name='marker"+(index+1)+"'><a href='javascript:panToSelectMarker("
				+marker.lonlat.lon+", "+marker.lonlat.lat+", "+index+", 0)'><img src='/MMONG/resource/assets/img/map/list_pin_"+(index+1)+
				".png'/></a></div><div class='content' name='content"+(index+1)+"'><a href='javascript:panToSelectMarker("+markerLayer.markers[index].lonlat.lon+", "
						+markerLayer.markers[index].lonlat.lat+", "+index+", 0)'>"+replaceContentHTML+"</a></div>&nbsp;<div class='listOption' name='listOption"+(index+1)+
						"'><input type='hidden' class='markerIndex' value='"+index+"'><input type='button' class='modifyName' name='modifyName"+(index+1)+
						"' value='수정'><input type='button' class='removeMarker' name='removeMarker"+(index+1)+"' value='삭제'></div></div>");
	}else {
		$("#trail_list_div").append("<div style='display:flex; margin: 15px 0;' name='listDiv"+(index+1)+"'><div class='marker' name='marker"+(index+1)+"'><a href='javascript:panToSelectMarker("
				+marker.lonlat.lon+", "+marker.lonlat.lat+", "+index+", 0)'><img src='/MMONG/resource/assets/img/map/list_pin_"+(index+1)+
				".png'/></a></div><div class='content' name='content"+(index+1)+"'><a href='javascript:panToSelectMarker("+markerLayer.markers[index].lonlat.lon+", "
						+markerLayer.markers[index].lonlat.lat+", "+index+", 0)'>"+replaceContentHTML+"</a></div>&nbsp;<div class='listOption' name='listOption"+(index+1)+
						"'><input type='hidden' class='markerIndex' value='"+index+"'><input type='button' class='modifyName' name='modifyName"+(index+1)+
						"' value='수정'><input type='button' class='removeMarker' name='removeMarker"+(index+1)+"' value='삭제'></div></div>");
	}
	$("#route_menu_div").empty();
	$("#route_menu_div").append("<a href='javascript:searchRoute()'>소요 시간 및 거리 계산</a><br>");
	$("#trail_menu_div").find($("input#fixTrail")).removeAttr("disabled");
}

//등록된 산책로 마커 리스트를 div#trail_list_div에 등록하는 함수
function addTrailToList(marker, index) {
	var contentHTML = markerLayer.markers[index].popup.contentHTML;
	replaceContentHTML = contentHTML.replace(/<\/?[^>]+>/gi, "");
	
	if(index%2==0) {
		$("#trail_list_div").append("<div style='display:flex; margin: 15px 0;' name='listDiv"+(index+1)+"'><div class='marker' name='marker"+(index+1)+"'><a href='javascript:panToSelectMarker("
				+marker.lonlat.lon+", "+marker.lonlat.lat+", "+index+", 0)'><img src='/MMONG/resource/assets/img/map/list_pin_"+(index+1)+
				".png'/></a></div><div class='trailContent' name='content"+(index+1)+"'><a href='javascript:panToSelectMarker("+markerLayer.markers[index].lonlat.lon+", "
						+markerLayer.markers[index].lonlat.lat+", "+index+", 0)'>"+replaceContentHTML+"</a></div></div>");
	}else {
		$("#trail_list_div").append("<div style='display:flex; margin: 15px 0;' name='listDiv"+(index+1)+"'><div class='marker' name='marker"+(index+1)+"'><a href='javascript:panToSelectMarker("
				+marker.lonlat.lon+", "+marker.lonlat.lat+", "+index+", 0)'><img src='/MMONG/resource/assets/img/map/list_pin_"+(index+1)+
				".png'/></a></div><div class='trailContent' name='content"+(index+1)+"'><a href='javascript:panToSelectMarker("+markerLayer.markers[index].lonlat.lon+", "
						+markerLayer.markers[index].lonlat.lat+", "+index+", 0)'>"+replaceContentHTML+"</a></div></div>");
	}
	$("#route_menu_div").empty();
	$("#route_menu_div").append("<a href='javascript:searchRoute()'>소요 시간 및 거리 계산</a><br>");
	$("#trail_menu_div").find($("input#fixTrail")).removeAttr("disabled");
}

function poiToMarkerOnClick() {
	$("#result_list_div").on("click", "input.poiToMarker", function() {
		for(var j=0; j<markerLayer.markers.length; j++) {
			markerLayer.markers[j].popup.hide();
		}
		for(var j=0; j<markersLayer.markers.length; j++) {
			markersLayer.markers[j].popup.hide();
		}
		
		var poiName = $(this).prev().prev().prev().val();
		alert(poiName);
		var poiLon = $(this).prev().prev().val();
		var poiLat = $(this).prev().val();
		
		cLonLat = new Tmap.LonLat(poiLon, poiLat);
		
		marker_lon[i] = cLonLat.lon;
		marker_lat[i] = cLonLat.lat;
		marker_cLonLat_lon += marker_lon[i];
		marker_cLonLat_lat += marker_lat[i];
		
		setTrailMarkerProp(i, 1, poiName);
		$("#route_menu_div").empty();
		$("#route_menu_div").append("<a href='javascript:searchRoute()'>소요 시간 및 거리 계산</a><br>");
		$("#trail_menu_div").find($("input#fixTrail")).removeAttr("disabled");
	});
}

//보행자 경로 안내
function searchRoute() {
	if(markerLayer.markers.length>0) {
		var startX = markerLayer.markers[0].lonlat.lon; //출발지 경도
		var startY = markerLayer.markers[0].lonlat.lat; //출발지 위도
		var endX = markerLayer.markers[markerLayer.markers.length-1].lonlat.lon; //목적지 경도
		var endY = markerLayer.markers[markerLayer.markers.length-1].lonlat.lat; //목적지 위도
		var startName = encodeURIComponent("출발");
		var endName = encodeURIComponent("목적");
		var passList;
		var speed = 4;
		var urlStr = "https://apis.skplanetx.com/tmap/routes/pedestrian?version=1&format=xml";
			urlStr += "&startX="+startX;
			urlStr += "&startY="+startY;
			urlStr += "&endX="+endX;
			urlStr += "&endY="+endY;
			urlStr += "&startName="+startName;
			urlStr += "&endName="+endName;
			urlStr += "&speed="+speed;
			urlStr += "&appKey="+appKey;
			
		if(markerLayer.markers.length==3) {
			passList = markerLayer.markers[1].lonlat.lon+","+markerLayer.markers[1].lonlat.lat;
			urlStr += "&passList="+passList;
		}else if(markerLayer.markers.length==4) {
			passList = markerLayer.markers[1].lonlat.lon+","+markerLayer.markers[1].lonlat.lat+"_"+markerLayer.markers[2].lonlat.lon+","+markerLayer.markers[2].lonlat.lat;
			urlStr += "&passList="+passList;
		}else if(markerLayer.markers.length==5) {
			passList = markerLayer.markers[1].lonlat.lon+","+markerLayer.markers[1].lonlat.lat+"_"+markerLayer.markers[2].lonlat.lon+","+markerLayer.markers[2].lonlat.lat+"_"+markerLayer.markers[3].lonlat.lon+","+markerLayer.markers[3].lonlat.lat;
			urlStr += "&passList="+passList;
		}
	
	
		var xmlHttp = new XMLHttpRequest();
		xmlHttp.onreadystatechange = routeLoader;
		xmlHttp.open("GET", urlStr, false);
		xmlHttp.send(null);
		var totalTime, totalDistance;
		function routeLoader() {
			if(xmlHttp.readyState==4) {
				if(xmlHttp.status==200) {
					var temp = xmlHttp.responseXML;
					totalTime = temp.getElementsByTagName("totalTime")[0].childNodes[0].nodeValue;
					totalDistance = temp.getElementsByTagName("totalDistance")[0].childNodes[0].nodeValue;
				}
			}
		}
		
		var time_hh = Math.floor(totalTime/3600);
		var time_mm = Math.ceil((totalTime-(time_hh*3600))/60);
		var distance = (totalDistance/1000).toFixed(2);
		
		if(time_hh<1) {
			$("#route_menu_div").empty();
			$("#route_menu_div").append("<a href='javascript:searchRoute()'>소요 시간 및 거리 계산</a><br>");
			$("#route_menu_div").append("<p>약 "+time_mm+"분&nbsp;약 "+distance+"km</p>");
		}else {	
			$("#route_menu_div").empty();
			$("#route_menu_div").append("<a href='javascript:searchRoute()'>소요 시간 및 거리 계산</a><br>");
			$("#route_menu_div").append("<p>약 "+time_hh+"시간 "+time_mm+"분&nbsp;약 "+distance+"km</p>");
		}
	}else {
		alert("마커를 한 개 이상 마크해주세요.")
	}
}

//산책로 리스트의 확인 버튼을 클릭했을 때 발생하는 이벤트 목록
function trailListSetOnClick() {
	$("#trail_list_div").on("click", "input.setName", function() {
		var modifyIndex = $(this).prev().val();
		var selectorIndex = parseInt(modifyIndex)+1;
		var modifyName = "modifyName"+selectorIndex.toString();
		
		if($("input[name='markerName"+selectorIndex+"']").val()!="") {
			markerName = $("input[name='markerName"+selectorIndex+"']").val();
			$("input[name='markerName"+selectorIndex+"']").parent().html("<a href='javascript:panToSelectMarker("+markerLayer.markers[selectorIndex-1].lonlat.lon+", "+markerLayer.markers[selectorIndex-1].lonlat.lat+", "+(selectorIndex-1)+", 0)'>"+markerName+"</a>");
			
			$("input[name='setName"+selectorIndex+"']").attr({class: "modifyName", name: modifyName, value: "수정"});
		}else {
			alert("마커 이름을 입력해주세요!");
		}
	});
}

//산책로 리스트의 수정 버튼을 클릭했을 때 발생하는 이벤트 목록
function trailListModifyOnClick() {
	$("#trail_list_div").on("click", "input.modifyName", function() {
		var modifyIndex = $(this).prev().val();
		var selectorIndex = parseInt(modifyIndex)+1;
		var modifyName = "setName"+selectorIndex.toString();

		$("input[name='modifyName"+selectorIndex+"']").attr({class: "setName", name: modifyName, value: "확인"});
		markerName = $("div[name='content"+selectorIndex+"']").text();
		$("div[name='content"+selectorIndex+"']").html("<input type='text' class='markerName' name='markerName"+selectorIndex+"' value='"+markerName+"'>");
	});
}

//삭제 버튼 클릭 이벤트 내에서 실행되는 함수
function mapBak(removeIndex) {
	var selectorIndex = removeIndex+1;
	
	for(var j=0; j<markerLayer.markers.length; j++) {
		markerLayer_bak.addMarker(markerLayer.markers[j]);
	}
	markerLayer.clearMarkers();
	i = markerLayer_bak.markers.length-1;
	
	$("input[name='removeMarker"+selectorIndex+"']").parent().parent().remove();
	
	marker_cLonLat_lon -= marker_lon[removeIndex];
	marker_cLonLat_lat -= marker_lat[removeIndex];

	while(markerLayer_bak.markers.length>removeIndex+1) {
		marker_lon[removeIndex] = marker_lon[removeIndex+1];
		marker_lat[removeIndex] = marker_lat[removeIndex+1];
		markerLayer_bak.markers[removeIndex].lonlat=markerLayer_bak.markers[removeIndex+1].lonlat;
		markerLayer_bak.markers[removeIndex].popup.contentHTML=markerLayer_bak.markers[removeIndex+1].popup.contentHTML;
		removeIndex++;
	}
	
	for(var j=0; j<markerLayer_bak.markers.length-1; j++) {
		var lonlat_bak = new Tmap.LonLat(markerLayer_bak.markers[j].lonlat.lon, markerLayer_bak.markers[j].lonlat.lat);
		var icon_bak = new Tmap.Icon(markerLayer_bak.markers[j].icon.url, markerLayer_bak.markers[j].icon.size, markerLayer_bak.markers[j].icon.offset);
		var label_bak = new Tmap.Label(markerLayer_bak.markers[j].popup.contentHTML);
		var marker_bak = new Tmap.Markers(lonlat_bak, icon_bak, label_bak);
		markerLayer.addMarker(marker_bak);
	}
	
	markerLayer_bak.clearMarkers();
}

//산책로 리스트의 삭제 버튼을 클릭했을 때 발생하는 이벤트 목록
function trailListRemoveOnClick() {
	//1번 마커 삭제 버튼 클릭시
	$("#trail_list_div").on("click", "input[name='removeMarker1']", function() {
		var removeIndex = 0;
		mapBak(removeIndex);
		var item = markerLayer.markers.length;

		var contentHTML;
		
		if(item==1) {
			contentHTML = markerLayer.markers[0].popup.contentHTML;
			replaceContentHTML = contentHTML.replace(/<\/?[^>]+>/gi, "");
			$("div[name='listDiv2']").empty();
			$("div[name='listDiv2']").attr('name', 'listDiv1');
			$("div[name='listDiv1']").append("<div class='marker' name='marker1'><a href='javascript:panToSelectMarker("+markerLayer.markers[0].lonlat.lon+", "+markerLayer.markers[0].lonlat.lat+", 0, 0)'><img src='https://developers.skplanetx.com/upload/tmap/marker/pin_r_m_1.png'/></a></div><div class='content' name='content1'><a href='javascript:panToSelectMarker("+markerLayer.markers[0].lonlat.lon+", "
					+markerLayer.markers[0].lonlat.lat+", 0, 0)'>"+replaceContentHTML+"</a></div>&nbsp;<div class='listOption' name='listOption1'><input type='hidden' class='markerIndex' value='0'><input type='button' class='modifyName' name='modifyName1' value='수정'><input type='button' class='removeMarker' name='removeMarker1' value='삭제'</div></div>");
		}
		else if(item==2) {
			contentHTML = markerLayer.markers[0].popup.contentHTML;
			replaceContentHTML = contentHTML.replace(/<\/?[^>]+>/gi, "");
			$("div[name='listDiv2']").empty();
			$("div[name='listDiv2']").attr('name', 'listDiv1');
			$("div[name='listDiv1']").append("<div class='marker' name='marker1'><a href='javascript:panToSelectMarker("+markerLayer.markers[0].lonlat.lon+", "+markerLayer.markers[0].lonlat.lat+", 0, 0)'><img src='https://developers.skplanetx.com/upload/tmap/marker/pin_r_m_1.png'/></a></div><div class='content' name='content1'><a href='javascript:panToSelectMarker("+markerLayer.markers[0].lonlat.lon+", "
					+markerLayer.markers[0].lonlat.lat+", 0, 0)'>"+replaceContentHTML+"</a></div>&nbsp;<div class='listOption' name='listOption1'><input type='hidden' class='markerIndex' value='0'><input type='button' class='modifyName' name='modifyName1' value='수정'><input type='button' class='removeMarker' name='removeMarker1' value='삭제'</div></div>");
		
			contentHTML = markerLayer.markers[1].popup.contentHTML;
			replaceContentHTML = contentHTML.replace(/<\/?[^>]+>/gi, "");
			$("div[name='listDiv3']").empty();
			$("div[name='listDiv3']").attr('name', 'listDiv2');
			$("div[name='listDiv2']").append("<div class='marker' name='marker2'><a href='javascript:panToSelectMarker("+markerLayer.markers[1].lonlat.lon+", "+markerLayer.markers[1].lonlat.lat+", 1, 0)'><img src='https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_2.png'/></a></div><div class='content' name='content2'><a href='javascript:panToSelectMarker("+markerLayer.markers[1].lonlat.lon+", "
					+markerLayer.markers[1].lonlat.lat+", 1, 0)'>"+replaceContentHTML+"</a></div>&nbsp;<div class='listOption' name='listOption2'><input type='hidden' class='markerIndex' value='1'><input type='button' class='modifyName' name='modifyName2' value='수정'><input type='button' class='removeMarker' name='removeMarker2' value='삭제'</div></div>");
		}
		else if(item==3) {
			contentHTML = markerLayer.markers[0].popup.contentHTML;
			replaceContentHTML = contentHTML.replace(/<\/?[^>]+>/gi, "");
			$("div[name='listDiv2']").empty();
			$("div[name='listDiv2']").attr('name', 'listDiv1');
			$("div[name='listDiv1']").append("<div class='marker' name='marker1'><a href='javascript:panToSelectMarker("+markerLayer.markers[0].lonlat.lon+", "+markerLayer.markers[0].lonlat.lat+", 0, 0)'><img src='https://developers.skplanetx.com/upload/tmap/marker/pin_r_m_1.png'/></a></div><div class='content' name='content1'><a href='javascript:panToSelectMarker("+markerLayer.markers[0].lonlat.lon+", "
					+markerLayer.markers[0].lonlat.lat+", 0, 0)'>"+replaceContentHTML+"</a></div>&nbsp;<div class='listOption' name='listOption1'><input type='hidden' class='markerIndex' value='0'><input type='button' class='modifyName' name='modifyName1' value='수정'><input type='button' class='removeMarker' name='removeMarker1' value='삭제'</div></div>");
		
			contentHTML = markerLayer.markers[1].popup.contentHTML;
			replaceContentHTML = contentHTML.replace(/<\/?[^>]+>/gi, "");
			$("div[name='listDiv3']").empty();
			$("div[name='listDiv3']").attr('name', 'listDiv2');
			$("div[name='listDiv2']").append("<div class='marker' name='marker2'><a href='javascript:panToSelectMarker("+markerLayer.markers[1].lonlat.lon+", "+markerLayer.markers[1].lonlat.lat+", 1, 0)'><img src='https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_2.png'/></a></div><div class='content' name='content2'><a href='javascript:panToSelectMarker("+markerLayer.markers[1].lonlat.lon+", "
					+markerLayer.markers[1].lonlat.lat+", 1, 0)'>"+replaceContentHTML+"</a></div>&nbsp;<div class='listOption' name='listOption2'><input type='hidden' class='markerIndex' value='1'><input type='button' class='modifyName' name='modifyName2' value='수정'><input type='button' class='removeMarker' name='removeMarker2' value='삭제'</div></div>");
		
			contentHTML = markerLayer.markers[2].popup.contentHTML;
			replaceContentHTML = contentHTML.replace(/<\/?[^>]+>/gi, "");
			$("div[name='listDiv4']").empty();
			$("div[name='listDiv4']").attr('name', 'listDiv3');
			$("div[name='listDiv3']").append("<div class='marker' name='marker3'><a href='javascript:panToSelectMarker("+markerLayer.markers[2].lonlat.lon+", "+markerLayer.markers[2].lonlat.lat+", 2, 0)'><img src='https://developers.skplanetx.com/upload/tmap/marker/pin_r_m_3.png'/></a></div><div class='content' name='content3'><a href='javascript:panToSelectMarker("+markerLayer.markers[2].lonlat.lon+", "
					+markerLayer.markers[2].lonlat.lat+", 2, 0)'>"+replaceContentHTML+"</a></div>&nbsp;<div class='listOption' name='listOption3'><input type='hidden' class='markerIndex' value='2'><input type='button' class='modifyName' name='modifyName3' value='수정'><input type='button' class='removeMarker' name='removeMarker3' value='삭제'</div></div>");
		}else if(item==4) {
			contentHTML = markerLayer.markers[0].popup.contentHTML;
			replaceContentHTML = contentHTML.replace(/<\/?[^>]+>/gi, "");
			$("div[name='listDiv2']").empty();
			$("div[name='listDiv2']").attr('name', 'listDiv1');
			$("div[name='listDiv1']").append("<div class='marker' name='marker1'><a href='javascript:panToSelectMarker("+markerLayer.markers[0].lonlat.lon+", "+markerLayer.markers[0].lonlat.lat+", 0, 0)'><img src='https://developers.skplanetx.com/upload/tmap/marker/pin_r_m_1.png'/></a></div><div class='content' name='content1'><a href='javascript:panToSelectMarker("+markerLayer.markers[0].lonlat.lon+", "
					+markerLayer.markers[0].lonlat.lat+", 0, 0)'>"+replaceContentHTML+"</a></div>&nbsp;<div class='listOption' name='listOption1'><input type='hidden' class='markerIndex' value='0'><input type='button' class='modifyName' name='modifyName1' value='수정'><input type='button' class='removeMarker' name='removeMarker1' value='삭제'</div></div>");
		
			contentHTML = markerLayer.markers[1].popup.contentHTML;
			replaceContentHTML = contentHTML.replace(/<\/?[^>]+>/gi, "");
			$("div[name='listDiv3']").empty();
			$("div[name='listDiv3']").attr('name', 'listDiv2');
			$("div[name='listDiv2']").append("<div class='marker' name='marker2'><a href='javascript:panToSelectMarker("+markerLayer.markers[1].lonlat.lon+", "+markerLayer.markers[1].lonlat.lat+", 1, 0)'><img src='https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_2.png'/></a></div><div class='content' name='content2'><a href='javascript:panToSelectMarker("+markerLayer.markers[1].lonlat.lon+", "
					+markerLayer.markers[1].lonlat.lat+", 1, 0)'>"+replaceContentHTML+"</a></div>&nbsp;<div class='listOption' name='listOption2'><input type='hidden' class='markerIndex' value='1'><input type='button' class='modifyName' name='modifyName2' value='수정'><input type='button' class='removeMarker' name='removeMarker2' value='삭제'</div></div>");
		
			contentHTML = markerLayer.markers[2].popup.contentHTML;
			replaceContentHTML = contentHTML.replace(/<\/?[^>]+>/gi, "");
			$("div[name='listDiv4']").empty();
			$("div[name='listDiv4']").attr('name', 'listDiv3');
			$("div[name='listDiv3']").append("<div class='marker' name='marker3'><a href='javascript:panToSelectMarker("+markerLayer.markers[2].lonlat.lon+", "+markerLayer.markers[2].lonlat.lat+", 2, 0)'><img src='https://developers.skplanetx.com/upload/tmap/marker/pin_r_m_3.png'/></a></div><div class='content' name='content3'><a href='javascript:panToSelectMarker("+markerLayer.markers[2].lonlat.lon+", "
					+markerLayer.markers[2].lonlat.lat+", 2, 0)'>"+replaceContentHTML+"</a></div>&nbsp;<div class='listOption' name='listOption3'><input type='hidden' class='markerIndex' value='2'><input type='button' class='modifyName' name='modifyName3' value='수정'><input type='button' class='removeMarker' name='removeMarker3' value='삭제'</div></div>");
		
			contentHTML = markerLayer.markers[3].popup.contentHTML;
			replaceContentHTML = contentHTML.replace(/<\/?[^>]+>/gi, "");
			$("div[name='listDiv5']").empty();
			$("div[name='listDiv5']").attr('name', 'listDiv4');
			$("div[name='listDiv4']").append("<div class='marker' name='marker4'><a href='javascript:panToSelectMarker("+markerLayer.markers[3].lonlat.lon+", "+markerLayer.markers[3].lonlat.lat+", 3, 0)'><img src='https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_4.png'/></a></div><div class='content' name='content4'><a href='javascript:panToSelectMarker("+markerLayer.markers[3].lonlat.lon+", "
					+markerLayer.markers[3].lonlat.lat+", 3, 0)'>"+replaceContentHTML+"</a></div>&nbsp;<div class='listOption' name='listOption3'><input type='hidden' class='markerIndex' value='3'><input type='button' class='modifyName' name='modifyName4' value='수정'><input type='button' class='removeMarker' name='removeMarker4' value='삭제'</div></div>");
		}
	});
	
	//2번 마커 삭제 버튼 클릭시
	$("#trail_list_div").on("click", "input[name='removeMarker2']", function() {
		var removeIndex = 1;
		mapBak(removeIndex);
		var item = markerLayer.markers.length;
		
		if(item==2) {
			contentHTML = markerLayer.markers[1].popup.contentHTML;
			replaceContentHTML = contentHTML.replace(/<\/?[^>]+>/gi, "");
			$("div[name='listDiv3']").empty();
			$("div[name='listDiv3']").attr('name', 'listDiv2');
			$("div[name='listDiv2']").append("<div class='marker' name='marker2'><a href='javascript:panToSelectMarker("+markerLayer.markers[1].lonlat.lon+", "+markerLayer.markers[1].lonlat.lat+", 1, 0)'><img src='https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_2.png'/></a></div><div class='content' name='content2'><a href='javascript:panToSelectMarker("+markerLayer.markers[1].lonlat.lon+", "
					+markerLayer.markers[1].lonlat.lat+", 1, 0)'>"+replaceContentHTML+"</a></div>&nbsp;<div class='listOption' name='listOption2'><input type='hidden' class='markerIndex' value='1'><input type='button' class='modifyName' name='modifyName2' value='수정'><input type='button' class='removeMarker' name='removeMarker2' value='삭제'</div></div>");
		}
		else if(item==3) {
			contentHTML = markerLayer.markers[1].popup.contentHTML;
			replaceContentHTML = contentHTML.replace(/<\/?[^>]+>/gi, "");
			$("div[name='listDiv3']").empty();
			$("div[name='listDiv3']").attr('name', 'listDiv2');
			$("div[name='listDiv2']").append("<div class='marker' name='marker2'><a href='javascript:panToSelectMarker("+markerLayer.markers[1].lonlat.lon+", "+markerLayer.markers[1].lonlat.lat+", 1, 0)'><img src='https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_2.png'/></a></div><div class='content' name='content2'><a href='javascript:panToSelectMarker("+markerLayer.markers[1].lonlat.lon+", "
					+markerLayer.markers[1].lonlat.lat+", 1, 0)'>"+replaceContentHTML+"</a></div>&nbsp;<div class='listOption' name='listOption2'><input type='hidden' class='markerIndex' value='1'><input type='button' class='modifyName' name='modifyName2' value='수정'><input type='button' class='removeMarker' name='removeMarker2' value='삭제'</div></div>");
		
			contentHTML = markerLayer.markers[2].popup.contentHTML;
			replaceContentHTML = contentHTML.replace(/<\/?[^>]+>/gi, "");
			$("div[name='listDiv4']").empty();
			$("div[name='listDiv4']").attr('name', 'listDiv3');
			$("div[name='listDiv3']").append("<div class='marker' name='marker3'><a href='javascript:panToSelectMarker("+markerLayer.markers[2].lonlat.lon+", "+markerLayer.markers[2].lonlat.lat+", 2, 0)'><img src='https://developers.skplanetx.com/upload/tmap/marker/pin_r_m_3.png'/></a></div><div class='content' name='content3'><a href='javascript:panToSelectMarker("+markerLayer.markers[2].lonlat.lon+", "
					+markerLayer.markers[2].lonlat.lat+", 2, 0)'>"+replaceContentHTML+"</a></div>&nbsp;<div class='listOption' name='listOption3'><input type='hidden' class='markerIndex' value='2'><input type='button' class='modifyName' name='modifyName3' value='수정'><input type='button' class='removeMarker' name='removeMarker3' value='삭제'</div></div>");
		}else if(item==4) {
			contentHTML = markerLayer.markers[1].popup.contentHTML;
			replaceContentHTML = contentHTML.replace(/<\/?[^>]+>/gi, "");
			$("div[name='listDiv3']").empty();
			$("div[name='listDiv3']").attr('name', 'listDiv2');
			$("div[name='listDiv2']").append("<div class='marker' name='marker2'><a href='javascript:panToSelectMarker("+markerLayer.markers[1].lonlat.lon+", "+markerLayer.markers[1].lonlat.lat+", 1, 0)'><img src='https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_2.png'/></a></div><div class='content' name='content2'><a href='javascript:panToSelectMarker("+markerLayer.markers[1].lonlat.lon+", "
					+markerLayer.markers[1].lonlat.lat+", 1, 0)'>"+replaceContentHTML+"</a></div>&nbsp;<div class='listOption' name='listOption2'><input type='hidden' class='markerIndex' value='1'><input type='button' class='modifyName' name='modifyName2' value='수정'><input type='button' class='removeMarker' name='removeMarker2' value='삭제'</div></div>");
		
			contentHTML = markerLayer.markers[2].popup.contentHTML;
			replaceContentHTML = contentHTML.replace(/<\/?[^>]+>/gi, "");
			$("div[name='listDiv4']").empty();
			$("div[name='listDiv4']").attr('name', 'listDiv3');
			$("div[name='listDiv3']").append("<div class='marker' name='marker3'><a href='javascript:panToSelectMarker("+markerLayer.markers[2].lonlat.lon+", "+markerLayer.markers[2].lonlat.lat+", 2, 0)'><img src='https://developers.skplanetx.com/upload/tmap/marker/pin_r_m_3.png'/></a></div><div class='content' name='content3'><a href='javascript:panToSelectMarker("+markerLayer.markers[2].lonlat.lon+", "
					+markerLayer.markers[2].lonlat.lat+", 2, 0)'>"+replaceContentHTML+"</a></div>&nbsp;<div class='listOption' name='listOption3'><input type='hidden' class='markerIndex' value='2'><input type='button' class='modifyName' name='modifyName3' value='수정'><input type='button' class='removeMarker' name='removeMarker3' value='삭제'</div></div>");
		
			contentHTML = markerLayer.markers[3].popup.contentHTML;
			replaceContentHTML = contentHTML.replace(/<\/?[^>]+>/gi, "");
			$("div[name='listDiv5']").empty();
			$("div[name='listDiv5']").attr('name', 'listDiv4');
			$("div[name='listDiv4']").append("<div class='marker' name='marker4'><a href='javascript:panToSelectMarker("+markerLayer.markers[3].lonlat.lon+", "+markerLayer.markers[3].lonlat.lat+", 3, 0)'><img src='https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_4.png'/></a></div><div class='content' name='content4'><a href='javascript:panToSelectMarker("+markerLayer.markers[3].lonlat.lon+", "
					+markerLayer.markers[3].lonlat.lat+", 3, 0)'>"+replaceContentHTML+"</a></div>&nbsp;<div class='listOption' name='listOption3'><input type='hidden' class='markerIndex' value='3'><input type='button' class='modifyName' name='modifyName4' value='수정'><input type='button' class='removeMarker' name='removeMarker4' value='삭제'</div></div>");
		}
	});
	
	//3번 마커 삭제 버튼 클릭시
	$("#trail_list_div").on("click", "input[name='removeMarker3']", function() {
		var removeIndex = 2;
		mapBak(removeIndex);
		var item = markerLayer.markers.length;
		
		if(item==3) {		
			contentHTML = markerLayer.markers[2].popup.contentHTML;
			replaceContentHTML = contentHTML.replace(/<\/?[^>]+>/gi, "");
			$("div[name='listDiv4']").empty();
			$("div[name='listDiv4']").attr('name', 'listDiv3');
			$("div[name='listDiv3']").append("<div class='marker' name='marker3'><a href='javascript:panToSelectMarker("+markerLayer.markers[2].lonlat.lon+", "+markerLayer.markers[2].lonlat.lat+", 2, 0)'><img src='https://developers.skplanetx.com/upload/tmap/marker/pin_r_m_3.png'/></a></div><div class='content' name='content3'><a href='javascript:panToSelectMarker("+markerLayer.markers[2].lonlat.lon+", "
					+markerLayer.markers[2].lonlat.lat+", 2, 0)'>"+replaceContentHTML+"</a></div>&nbsp;<div class='listOption' name='listOption3'><input type='hidden' class='markerIndex' value='2'><input type='button' class='modifyName' name='modifyName3' value='수정'><input type='button' class='removeMarker' name='removeMarker3' value='삭제'</div></div>");
		}else if(item==4) {
			contentHTML = markerLayer.markers[2].popup.contentHTML;
			replaceContentHTML = contentHTML.replace(/<\/?[^>]+>/gi, "");
			$("div[name='listDiv4']").empty();
			$("div[name='listDiv4']").attr('name', 'listDiv3');
			$("div[name='listDiv3']").append("<div class='marker' name='marker3'><a href='javascript:panToSelectMarker("+markerLayer.markers[2].lonlat.lon+", "+markerLayer.markers[2].lonlat.lat+", 2, 0)'><img src='https://developers.skplanetx.com/upload/tmap/marker/pin_r_m_3.png'/></a></div><div class='content' name='content3'><a href='javascript:panToSelectMarker("+markerLayer.markers[2].lonlat.lon+", "
					+markerLayer.markers[2].lonlat.lat+", 2, 0)'>"+replaceContentHTML+"</a></div>&nbsp;<div class='listOption' name='listOption3'><input type='hidden' class='markerIndex' value='2'><input type='button' class='modifyName' name='modifyName3' value='수정'><input type='button' class='removeMarker' name='removeMarker3' value='삭제'</div></div>");
		
			contentHTML = markerLayer.markers[3].popup.contentHTML;
			replaceContentHTML = contentHTML.replace(/<\/?[^>]+>/gi, "");
			$("div[name='listDiv5']").empty();
			$("div[name='listDiv5']").attr('name', 'listDiv4');
			$("div[name='listDiv4']").append("<div class='marker' name='marker4'><a href='javascript:panToSelectMarker("+markerLayer.markers[3].lonlat.lon+", "+markerLayer.markers[3].lonlat.lat+", 3, 0)'><img src='https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_4.png'/></a></div><div class='content' name='content4'><a href='javascript:panToSelectMarker("+markerLayer.markers[3].lonlat.lon+", "
					+markerLayer.markers[3].lonlat.lat+", 3, 0)'>"+replaceContentHTML+"</a></div>&nbsp;<div class='listOption' name='listOption3'><input type='hidden' class='markerIndex' value='3'><input type='button' class='modifyName' name='modifyName4' value='수정'><input type='button' class='removeMarker' name='removeMarker4' value='삭제'</div></div>");
		}
	});
	
	//4번 마커 삭제 버튼 클릭시
	$("#trail_list_div").on("click", "input[name='removeMarker4']", function() {
		var removeIndex = 3;
		mapBak(removeIndex);
		
		contentHTML = markerLayer.markers[3].popup.contentHTML;
		replaceContentHTML = contentHTML.replace(/<\/?[^>]+>/gi, "");
		$("div[name='listDiv5']").empty();
		$("div[name='listDiv5']").attr('name', 'listDiv4');
		$("div[name='listDiv4']").append("<div class='marker' name='marker4'><a href='javascript:panToSelectMarker("+markerLayer.markers[3].lonlat.lon+", "+markerLayer.markers[3].lonlat.lat+", 3, 0)'><img src='https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_4.png'/></a></div><div class='content' name='content4'><a href='javascript:panToSelectMarker("+markerLayer.markers[3].lonlat.lon+", "
				+markerLayer.markers[3].lonlat.lat+", 3, 0)'>"+replaceContentHTML+"</a></div>&nbsp;<div class='listOption' name='listOption3'><input type='hidden' class='markerIndex' value='3'><input type='button' class='modifyName' name='modifyName4' value='수정'><input type='button' class='removeMarker' name='removeMarker4' value='삭제'</div></div>");
	});
	
	//5번 마커 삭제 버튼 클릭시
	$("#trail_list_div").on("click", "input[name='removeMarker5']", function() {
		var removeIndex = 4;
		mapBak(removeIndex);
	});
}

//메뉴 버튼을 클릭했을 때 발생하는 이벤트 목록
function buttonOnClick() {
	$('.fa-bars').click(function () {
		$('#main-content').css({
			'margin-left': '180px'
		});
		$('#sidebar > ul').show();
		$('#sidebar').css({
			'margin-left': '0'
		});
		$("#container").removeClass("sidebar-closed");
	});
	
	$("#total_div").css("min-height", (document.body.scrollHeight-38.4)+"px");
	$(".modal-dialog").css("margin", ((document.body.scrollHeight-374)/2-30)+"px auto");
	
	/*
	//'산책로 등록' 버튼 클릭시 산책로에 대한 이름 및 설명 입력, 카테고리 선택하는 modal창
	$("#fixTrail").on("click", function() {
		$("#list_table").empty();
		$("#paging_div").empty();
		$("#keyword").val("");
		$("#route_menu_div").empty();
		$("#route_menu_div").append("<a href='javascript:searchRoute()' id='searchLink'>소요 시간 및 거리 계산</a><br>");
		markersLayer.clearMarkers();
		map.events.unregister("click", map, onClickMap);
	});
	*/
	
	//'산책로 등록하기' 버튼 클릭시 맵 클릭 이벤트 등록
	$("#registerTrail").on("click", function() {
		$("div#myModal1").find($("input[name=category]")).prop("checked", false);
		$("div#myModal1").find($("input[name=route1]")).val("");
		$("div#myModal1").find($("input[name=route2]")).val("");
		$("div#myModal1").find($("input[name=route3]")).val("");
		$("div#myModal1").find($("input[name=route4]")).val("");
		$("div#myModal1").find($("input[name=route5]")).val("");
		$("div#myModal1").find($("textarea[name=title]")).val("");
		$("div#myModal1").find($("textarea[name=content]")).val("");
		
		$("#trail_list_div").empty();
		$("#list_table").empty();
		$("#paging_div").empty();
		$("#keyword").val("");
		$("#route_menu_div").empty();
		$("#trail_menu_div").empty();
		$("#route_menu_div").append("<a href='javascript:searchRoute()' id='searchLink'>소요 시간 및 거리 계산</a>");
		$("#trail_menu_div").append("<a href='#confirmTrail' data-toggle='modal' data-target='#myModal1'><input type='button' value='등록' id='fixTrail' disabled='disabled'></a><input type='button' value='취소' id='cancelTrail'>");
		$("#keyword").next().attr("id", "searchPOI");
		map.events.unregister("click", map, onClickMap);
		markerLayer.clearMarkers(); //산책로 마커레이어 clear
		markersLayer.clearMarkers(); //POI 마커레이어 clear
		i = 0; //산책로 마커 index 초기화
		marker_cLonLat_lon = 0; //산책로 마커 중심 lon 합 초기화
		marker_cLonLat_lat = 0; //산책로 마커 중심 lat 합 초기화
		for(var k=0; k<5; k++) {
			marker_lon[k] = 0;
			marker_lat[k] = 0;
		}
		map.events.register("click", map, onClickMap);
	});
	
	//'산책로 등록완료' 버튼 클릭시 맵 클릭 이벤트 제거
	$("#finish").on("click", function() {
		$("div#myModal1").find($("input[name=category]")).prop("checked", false);
		$("div#myModal1").find($("input[name=route1]")).val("");
		$("div#myModal1").find($("input[name=route2]")).val("");
		$("div#myModal1").find($("input[name=route3]")).val("");
		$("div#myModal1").find($("input[name=route4]")).val("");
		$("div#myModal1").find($("input[name=route5]")).val("");
		$("div#myModal1").find($("textarea[name=title]")).val("");
		$("div#myModal1").find($("textarea[name=content]")).val("");
		
		$("#list_table").empty();
		$("#paging_div").empty();
		$("#keyword").val("");
		$("#keyword").next().attr("id", "searchTrail");
		markersLayer.clearMarkers();
		map.events.unregister("click", map, onClickMap);
	});
	
	//'산책로 마커 제거' 버튼 클릭시 산책로 마커 모두 제거, 마커 index 초기화, 마커 좌표 합 초기화
	$("#removeTrailMarker").on("click", function() {
		$("div#myModal1").find($("input[name=category]")).prop("checked", false);
		$("div#myModal1").find($("input[name=route1]")).val("");
		$("div#myModal1").find($("input[name=route2]")).val("");
		$("div#myModal1").find($("input[name=route3]")).val("");
		$("div#myModal1").find($("input[name=route4]")).val("");
		$("div#myModal1").find($("input[name=route5]")).val("");
		$("div#myModal1").find($("textarea[name=title]")).val("");
		$("div#myModal1").find($("textarea[name=content]")).val("");
		
		$("#trail_list_div").empty();
		$("#route_menu_div").find("a#searchLink").next().remove;
		markerLayer.clearMarkers();
		i = 0;
		marker_cLonLat_lon = 0;
		marker_cLonLat_lat = 0;
		for(var k=0; k<5; k++) {
			marker_lon[k] = 0;
			marker_lat[k] = 0;
		}
	});
	
	//'POI 마커 제거' 버튼 클릭시 POI 마커 모두 제거, 검색어 초기화
	$("#removePOIMarker").on("click", function() {
		$("div#myModal1").find($("input[name=category]")).prop("checked", false);
		$("div#myModal1").find($("input[name=route1]")).val("");
		$("div#myModal1").find($("input[name=route2]")).val("");
		$("div#myModal1").find($("input[name=route3]")).val("");
		$("div#myModal1").find($("input[name=route4]")).val("");
		$("div#myModal1").find($("input[name=route5]")).val("");
		$("div#myModal1").find($("textarea[name=title]")).val("");
		$("div#myModal1").find($("textarea[name=content]")).val("");
		
		$("#list_table").empty();
		$("#paging_div").empty();
		$("#keyword").val("");
		markersLayer.clearMarkers();
	});
	
	//검색어 입력 후 검색 버튼 클릭시 정확도 순으로 반경 5km이내 검색 //시간나면 검색반경 option
	$("#search_div").on("click", "#searchPOI", function() {
		$("div#myModal1").find($("input[name=category]")).prop("checked", false);
		$("div#myModal1").find($("input[name=route1]")).val("");
		$("div#myModal1").find($("input[name=route2]")).val("");
		$("div#myModal1").find($("input[name=route3]")).val("");
		$("div#myModal1").find($("input[name=route4]")).val("");
		$("div#myModal1").find($("input[name=route5]")).val("");
		$("div#myModal1").find($("textarea[name=title]")).val("");
		$("div#myModal1").find($("textarea[name=content]")).val("");
		
		$("#list_table").empty();
		markersLayer.clearMarkers();
		searchText = $("#keyword").val();
		searchPOI(searchText);
	});
	
	$("#searchTrail2").on("click", function() {
		$("#keyword").next().attr("id", "searchTrail");
	});
	
	$("#trail_menu_div").on("click", "#cancelTrail", function() {
		$("div#myModal1").find($("input[name=category]")).prop("checked", false);
		$("div#myModal1").find($("input[name=route1]")).val("");
		$("div#myModal1").find($("input[name=route2]")).val("");
		$("div#myModal1").find($("input[name=route3]")).val("");
		$("div#myModal1").find($("input[name=route4]")).val("");
		$("div#myModal1").find($("input[name=route5]")).val("");
		$("div#myModal1").find($("textarea[name=title]")).val("");
		$("div#myModal1").find($("textarea[name=content]")).val("");
		
		$("#trail_list_div").empty();
		$("#list_table").empty();
		$("#paging_div").empty();
		$("#keyword").val("");
		$("#route_menu_div").empty();
		$("#trail_menu_div").empty();
		$("#keyword").next().attr("id", "searchTrail");
		map.events.unregister("click", map, onClickMap);
		markerLayer.clearMarkers();
		markersLayer.clearMarkers();
		i = 0;
		marker_cLonLat_lon = 0;
		marker_cLonLat_lat = 0;
		for(var k=0; k<5; k++) {
			marker_lon[k] = 0;
			marker_lat[k] = 0;
		}
		
		iLonLat = new Tmap.LonLat(14149513.77048, 4495298.9298456);
		map.setCenter(iLonLat, 16);
	});
	
	$("#initializeMap").on("click", function() {
		$("div#myModal1").find($("input[name=category]")).prop("checked", false);
		$("div#myModal1").find($("input[name=route1]")).val("");
		$("div#myModal1").find($("input[name=route2]")).val("");
		$("div#myModal1").find($("input[name=route3]")).val("");
		$("div#myModal1").find($("input[name=route4]")).val("");
		$("div#myModal1").find($("input[name=route5]")).val("");
		$("div#myModal1").find($("textarea[name=title]")).val("");
		$("div#myModal1").find($("textarea[name=content]")).val("");
		
		$("#trail_list_div").empty();
		$("#list_table").empty();
		$("#paging_div").empty();
		$("#keyword").val("");
		$("#route_menu_div").empty();
		$("#trail_menu_div").empty();
		$("#keyword").next().attr("id", "searchTrail");
		map.events.unregister("click", map, onClickMap);
		markerLayer.clearMarkers();
		markersLayer.clearMarkers();
		i = 0;
		marker_cLonLat_lon = 0;
		marker_cLonLat_lat = 0;
		for(var k=0; k<5; k++) {
			marker_lon[k] = 0;
			marker_lat[k] = 0;
		}
		
		iLonLat = new Tmap.LonLat(14149513.77048, 4495298.9298456);
		map.setCenter(iLonLat, 16);
	});
	
	$("#search_div").on("click", "#searchTrail", function() {
		$("div#myModal1").find($("input[name=category]")).prop("checked", false);
		$("div#myModal1").find($("input[name=route1]")).val("");
		$("div#myModal1").find($("input[name=route2]")).val("");
		$("div#myModal1").find($("input[name=route3]")).val("");
		$("div#myModal1").find($("input[name=route4]")).val("");
		$("div#myModal1").find($("input[name=route5]")).val("");
		$("div#myModal1").find($("textarea[name=title]")).val("");
		$("div#myModal1").find($("textarea[name=content]")).val("");
		
		var searchKeyword = $("#keyword").val();
		for(var k=0; k<=trailIndex; k++) {
			no[k] = null;
			category[k] = null;
			title[k] = null;
			content[k] = null;
			route1[k] = null;
			route2[k] = null;
			route3[k] = null;
			route4[k] = null;
			route5[k] = null;
			memberId[k] = null;
		}
		trailIndex = 0;
		
		jQuery.ajaxSettings.traditional = true;
		$.ajax ({
			"url" : "/MMONG/trail/searchTrailByTitle.do",
			"type" : "POST",
			"data" : {"title": searchKeyword,"${_csrf.parameterName}":"${_csrf.token}"},
			"dataType" : "json",
			"success" : function(response) {
				$("#list_table").empty();
				$.each(response, function() {
					no[trailIndex] = this.no;
					category[trailIndex] = this.category;
					tArr[trailIndex] = this.title;
					content[trailIndex] = this.content;
					route1[trailIndex] = this.route1;
					route2[trailIndex] = this.route2;
					route3[trailIndex] = this.route3;
					route4[trailIndex] = this.route4;
					route5[trailIndex] = this.route5;
					memberId[trailIndex] = this.memberId;
					$("#list_table").append("<tr><td class='result'><div style='width:200px;text-overflow:ellipsis;overflow: hidden;white-space: nowrap; font-size:'><img src='/MMONG/resource/assets/img/map/noun_413210_cc.png'>&nbsp;&nbsp;&nbsp;"+tArr[trailIndex]+"</div></td><td><input type='button' class='viewDetail' value='상세보기' onClick='viewTrailDetail(no["+trailIndex+"],category["+trailIndex+"],tArr["+trailIndex+"],content["+trailIndex+"],route1["+trailIndex+"],route2["+trailIndex+"],route3["+trailIndex+"],route4["+trailIndex+"],route5["+trailIndex+"],memberId["+trailIndex+"]);'></td></tr>");
					trailIndex++;
				});
			}
		});
	});
}
	
function viewTrailDetail(trailNo, trailCategory, trailTitle, trailContent, trailRoute1, trailRoute2, trailRoute3, trailRoute4, trailRoute5, trailOwner) {
	$("#trail_list_div").empty();
	$("#route_menu_div").empty();
	$("#trail_menu_div").empty();
	markerLayer.clearMarkers();
	markersLayer.clearMarkers();
	i = 0;
	marker_cLonLat_lon = 0;
	marker_cLonLat_lat = 0;
	iLonLat = new Tmap.LonLat(14149513.77048, 4495298.9298456);
	map.setCenter(iLonLat, 16);
	
	var no = trailNo;
	var category = trailCategory.split(",");
	var title = trailTitle;
	var content = trailContent;
	var route1 = trailRoute1;
	var route2 = trailRoute2;
	var route3 = trailRoute3;
	var route4 = trailRoute4;
	var route5 = trailRoute5;
	var owner = trailOwner;

	if(route1!=null) {
		route1 = route1.split("_");
		
		cLonLat = new Tmap.LonLat(route1[0], route1[1]);
		marker_lon[0] = cLonLat.lon;
		marker_lat[0] = cLonLat.lat;
		marker_cLonLat_lon += marker_lon[0];
		marker_cLonLat_lat += marker_lat[0];
		
		setTrailMarkerProp(0, 2, route1[2]);
	}
	if(route2!=null) {
		route2 = route2.split("_");
		
		cLonLat = new Tmap.LonLat(route2[0], route2[1]);
		marker_lon[1] = cLonLat.lon;
		marker_lat[1] = cLonLat.lat;
		marker_cLonLat_lon += marker_lon[1];
		marker_cLonLat_lat += marker_lat[1];
		
		setTrailMarkerProp(0, 2, route2[2]);
	}
	if(route3!=null) {
		route3 = route3.split("_");
		
		cLonLat = new Tmap.LonLat(route3[0], route3[1]);
		marker_lon[2] = cLonLat.lon;
		marker_lat[2] = cLonLat.lat;
		marker_cLonLat_lon += marker_lon[2];
		marker_cLonLat_lat += marker_lat[2];
		
		setTrailMarkerProp(0, 2, route3[2]);
	}
	if(route4!=null) {
		route4 = route4.split("_");
		
		cLonLat = new Tmap.LonLat(route4[0], route4[1]);
		marker_lon[3] = cLonLat.lon;
		marker_lat[3] = cLonLat.lat;
		marker_cLonLat_lon += marker_lon[3];
		marker_cLonLat_lat += marker_lat[3];
		
		setTrailMarkerProp(0, 2, route4[2]);
	}
	if(route5!=null) {
		route5 = route5.split("_");
		
		cLonLat = new Tmap.LonLat(route5[0], route5[1]);
		marker_lon[4] = cLonLat.lon;
		marker_lat[4] = cLonLat.lat;
		marker_cLonLat_lon += marker_lon[4];
		marker_cLonLat_lat += marker_lat[4];
		
		setTrailMarkerProp(0, 2, route5[2]);
	}
	
	$("#trail_list_div").append("<input type='hidden' id='modifyNo' value='"+no+"'>");
	
	$("div#myModal2").find($("input[name=category]")).prop("checked", false);
	
	if($("div#myModal2").find($("input[name=category]")).eq(0).val()==category[0] || $("div#myModal2").find($("input[name=category]")).eq(0).val()==category[1] || $("div#myModal2").find($("input[name=category]")).eq(0).val()==category[2]) {
		$("div#myModal2").find($("input[name=category]")).eq(0).prop("checked", true);
	}
	if($("div#myModal2").find($("input[name=category]")).eq(1).val()==category[0] || $("div#myModal2").find($("input[name=category]")).eq(1).val()==category[1] || $("div#myModal2").find($("input[name=category]")).eq(1).val()==category[2]) {
		$("div#myModal2").find($("input[name=category]")).eq(1).prop("checked", true);
	}
	if($("div#myModal2").find($("input[name=category]")).eq(2).val()==category[0] || $("div#myModal2").find($("input[name=category]")).eq(2).val()==category[1] || $("div#myModal2").find($("input[name=category]")).eq(2).val()==category[2]) {
		$("div#myModal2").find($("input[name=category]")).eq(2).prop("checked", true);
	}

	$("div#myModal2").find($("textarea#trail_title")).text(title);
	$("div#myModal2").find($("textarea#trail_content")).text(content);
	
	$("#trail_menu_div").append("<input type='button' id='modifyMyTrail' value='수정하기' onClick='modifyMyTrail()'>");
}

function modifyMyTrail() {
	/* 추가해야할내용...
	&nbsp;<div class='listOption' name='listOption"+(index+1)+
		"'><input type='hidden' class='markerIndex' value='"+index+"'><input type='button' class='modifyName' name='modifyName"+(index+1)+
		"' value='수정'><input type='button' class='removeMarker' name='removeMarker"+(index+1)+"' value='삭제'></div>
	*/
	$("#trail_menu_div").empty();
	
	$("div.trailContent").attr("class", "content");
	
	$("div[name='listDiv1']").append("<div class='listOption' name='listOption1'><input type='hidden' class='markerIndex' value='0'><input type='button' class='modifyName' name='modifyName1' value='수정'><input type='button' class='removeMarker' name='removeMarker1' value='삭제'></div>");
	$("div[name='listDiv2']").append("<div class='listOption' name='listOption2'><input type='hidden' class='markerIndex' value='1'><input type='button' class='modifyName' name='modifyName2' value='수정'><input type='button' class='removeMarker' name='removeMarker2' value='삭제'></div>");
	$("div[name='listDiv3']").append("<div class='listOption' name='listOption3'><input type='hidden' class='markerIndex' value='2'><input type='button' class='modifyName' name='modifyName3' value='수정'><input type='button' class='removeMarker' name='removeMarker3' value='삭제'></div>");
	$("div[name='listDiv4']").append("<div class='listOption' name='listOption4'><input type='hidden' class='markerIndex' value='3'><input type='button' class='modifyName' name='modifyName4' value='수정'><input type='button' class='removeMarker' name='removeMarker4' value='삭제'></div>");
	$("div[name='listDiv5']").append("<div class='listOption' name='listOption5'><input type='hidden' class='markerIndex' value='4'><input type='button' class='modifyName' name='modifyName5' value='수정'><input type='button' class='removeMarker' name='removeMarker5' value='삭제'></div>");
	
	$("#trail_menu_div").append("<a href='#confirmTrail' data-toggle='modal' data-target='#myModal2'><input type='button' value='수정' id='modifyTrail'></a><input type='button' value='취소' onClick='cancelModifyTrail();'>");
}

function cancelModifyTrail() {
	$("#trail_menu_div").empty();
	$("#trail_menu_div").append("<input type='button' id='modifyMyTrail' value='수정하기' onClick='modifyMyTrail()'>");
	$("div.content").attr("class", "trailContent");
	$("div.listOption").remove();
}

function formSubmit() {
	if(markerLayer.markers.length==1) {
		$("input[name=route1]").val(markerLayer.markers[0].lonlat.lon+"_"+markerLayer.markers[0].lonlat.lat+"_"+markerLayer.markers[0].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
	}else if(markerLayer.markers.length==2) {
		$("input[name=route1]").val(markerLayer.markers[0].lonlat.lon+"_"+markerLayer.markers[0].lonlat.lat+"_"+markerLayer.markers[0].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
		$("input[name=route2]").val(markerLayer.markers[1].lonlat.lon+"_"+markerLayer.markers[1].lonlat.lat+"_"+markerLayer.markers[1].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
	}else if(markerLayer.markers.length==3) {
		$("input[name=route1]").val(markerLayer.markers[0].lonlat.lon+"_"+markerLayer.markers[0].lonlat.lat+"_"+markerLayer.markers[0].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
		$("input[name=route2]").val(markerLayer.markers[1].lonlat.lon+"_"+markerLayer.markers[1].lonlat.lat+"_"+markerLayer.markers[1].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
		$("input[name=route3]").val(markerLayer.markers[2].lonlat.lon+"_"+markerLayer.markers[2].lonlat.lat+"_"+markerLayer.markers[2].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
	}else if(markerLayer.markers.length==4) {
		$("input[name=route1]").val(markerLayer.markers[0].lonlat.lon+"_"+markerLayer.markers[0].lonlat.lat+"_"+markerLayer.markers[0].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
		$("input[name=route2]").val(markerLayer.markers[1].lonlat.lon+"_"+markerLayer.markers[1].lonlat.lat+"_"+markerLayer.markers[1].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
		$("input[name=route3]").val(markerLayer.markers[2].lonlat.lon+"_"+markerLayer.markers[2].lonlat.lat+"_"+markerLayer.markers[2].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
		$("input[name=route4]").val(markerLayer.markers[3].lonlat.lon+"_"+markerLayer.markers[3].lonlat.lat+"_"+markerLayer.markers[3].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
	}else if(markerLayer.markers.length==5) {
		$("input[name=route1]").val(markerLayer.markers[0].lonlat.lon+"_"+markerLayer.markers[0].lonlat.lat+"_"+markerLayer.markers[0].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
		$("input[name=route2]").val(markerLayer.markers[1].lonlat.lon+"_"+markerLayer.markers[1].lonlat.lat+"_"+markerLayer.markers[1].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
		$("input[name=route3]").val(markerLayer.markers[2].lonlat.lon+"_"+markerLayer.markers[2].lonlat.lat+"_"+markerLayer.markers[2].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
		$("input[name=route4]").val(markerLayer.markers[3].lonlat.lon+"_"+markerLayer.markers[3].lonlat.lat+"_"+markerLayer.markers[3].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
		$("input[name=route5]").val(markerLayer.markers[4].lonlat.lon+"_"+markerLayer.markers[4].lonlat.lat+"_"+markerLayer.markers[4].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
	}
	$("#insert_trail_form").submit();
}

function modifyFormSubmit() {
	var modifyIndex = $("input#modifyNo").val();
	$("input[name=no]").val(modifyIndex);
	
	if(markerLayer.markers.length==1) {
		$("input[name=route1]").val(markerLayer.markers[0].lonlat.lon+"_"+markerLayer.markers[0].lonlat.lat+"_"+markerLayer.markers[0].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
	}else if(markerLayer.markers.length==2) {
		$("input[name=route1]").val(markerLayer.markers[0].lonlat.lon+"_"+markerLayer.markers[0].lonlat.lat+"_"+markerLayer.markers[0].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
		$("input[name=route2]").val(markerLayer.markers[1].lonlat.lon+"_"+markerLayer.markers[1].lonlat.lat+"_"+markerLayer.markers[1].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
	}else if(markerLayer.markers.length==3) {
		$("input[name=route1]").val(markerLayer.markers[0].lonlat.lon+"_"+markerLayer.markers[0].lonlat.lat+"_"+markerLayer.markers[0].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
		$("input[name=route2]").val(markerLayer.markers[1].lonlat.lon+"_"+markerLayer.markers[1].lonlat.lat+"_"+markerLayer.markers[1].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
		$("input[name=route3]").val(markerLayer.markers[2].lonlat.lon+"_"+markerLayer.markers[2].lonlat.lat+"_"+markerLayer.markers[2].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
	}else if(markerLayer.markers.length==4) {
		$("input[name=route1]").val(markerLayer.markers[0].lonlat.lon+"_"+markerLayer.markers[0].lonlat.lat+"_"+markerLayer.markers[0].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
		$("input[name=route2]").val(markerLayer.markers[1].lonlat.lon+"_"+markerLayer.markers[1].lonlat.lat+"_"+markerLayer.markers[1].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
		$("input[name=route3]").val(markerLayer.markers[2].lonlat.lon+"_"+markerLayer.markers[2].lonlat.lat+"_"+markerLayer.markers[2].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
		$("input[name=route4]").val(markerLayer.markers[3].lonlat.lon+"_"+markerLayer.markers[3].lonlat.lat+"_"+markerLayer.markers[3].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
	}else if(markerLayer.markers.length==5) {
		$("input[name=route1]").val(markerLayer.markers[0].lonlat.lon+"_"+markerLayer.markers[0].lonlat.lat+"_"+markerLayer.markers[0].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
		$("input[name=route2]").val(markerLayer.markers[1].lonlat.lon+"_"+markerLayer.markers[1].lonlat.lat+"_"+markerLayer.markers[1].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
		$("input[name=route3]").val(markerLayer.markers[2].lonlat.lon+"_"+markerLayer.markers[2].lonlat.lat+"_"+markerLayer.markers[2].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
		$("input[name=route4]").val(markerLayer.markers[3].lonlat.lon+"_"+markerLayer.markers[3].lonlat.lat+"_"+markerLayer.markers[3].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
		$("input[name=route5]").val(markerLayer.markers[4].lonlat.lon+"_"+markerLayer.markers[4].lonlat.lat+"_"+markerLayer.markers[4].popup.contentHTML.replace(/<\/?[^>]+>/gi, ""));
	}
	$("#modify_trail_form").submit();
}

window.onload = function() {
	initialize();
	poiToMarkerOnClick();
	trailListSetOnClick();
	trailListModifyOnClick();
	trailListRemoveOnClick();
	buttonOnClick();
}
</script>
<style type="text/css">
a {
	text-decoration: none;
	color: black;
}
table#list_table {
	word-break: break-all;
	padding: 0;
	margin: 0;
	table-layout: fixed;
}
td.result {
	padding: 0 5px;
	margin: 0;
	height: 40px;
	width: 250px;
	font-size: 14px;
}
div.marker {
	margin: 5px 0;
}
div.content {
	width: 61%;
	margin: auto 5px;
	font-size: 13px;
	padding: 0;
}
div.trailContent {
	width: 88%;
	margin: auto 5px;
	font-size: 13px;
	padding: 0;
}
div.listOption {
	margin: auto 0 ;
	width: 27%;
}
div#poi_popup_div {
	margin: auto;
	padding: 0;
	text-align: center;
}
input:focus {
	outline: none;
}
input.markerName {
	width: 150px;
}
#lean_overlay {
    position: fixed;
    z-index:100;
    top: 0px;
    left: 0px;
    height:100%;
    width:100%;
    background: #000;
    display: none;
}
</style>
<body>
<div id="total_div" style="position:relative;">
	<div id="map_div" style="position: absolute; top:60px;"></div>
	<div id="search_div" style="position: absolute; top: 60px; left: 600px; width: 300px; display: flex">
			<input type="text" id="keyword" placeholder="검색어를 입력해주세요" style="width: 200px;"><input id="searchTrail" type="button" value="검색" style="width:100px">
	</div>
	<div id="result_list_div" style="position: absolute; top: 60px; left: 900px; width: 300px;">
		<table id="list_table">
			<tr>
				<td></td>
			</tr>
		</table>
	</div>
	<div id="paging_div" style="font-size: 12px; height: 25px; margin: 0; text-align: center; position: absolute; top: 480px; left: 900px; width: 300px;"></div>
	<div id="trail_list_div" style="font-size: 12px; position: absolute; top: 85px; left: 600px; height: 375px; width: 300px;">trail_list_div</div>
	<div id="route_menu_div" style="position: absolute; top: 400px; left: 600px; height: 50px; width: 300px; text-align:center;">
		
	</div>
	<div id="trail_menu_div" style="position: absolute; top: 460px; left: 600px; height: 24px; width: 85.34px; margin: 0 107.33px;">
		
	</div>

	<div style="position:absolute; top:460px;">
	<input type="button" value="산책로 조회" id="searchTrail2">
	<input type="button" value="산책로 등록" id="registerTrail">
	<input type="button" value="산책로 등록 완료" id="finish">
	<input type="button" value="산책로 마커 제거" id="removeTrailMarker">
	<input type="button" value="POI 마커 제거" id="removePOIMarker">
	<input type="button" value="지도 초기화" id="initializeMap">
	</div>
	
	<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">산책로 등록</h4>
				</div>
				<form id="insert_trail_form" name="insert_trail_form" action="/MMONG/trail/insertTrail.do" method="post">
					<div class="modal-body" style="height:250px;">
						<div class="modal-body-category" style="height:60px; text-align:center;">
							<label><input type="checkbox" name="category" value="힐링">힐링</label>
							<label><input type="checkbox" name="category" value="다이어트">다이어트</label>
							<label><input type="checkbox" name="category" value="산보">산보</label>
							<input type="hidden" name="route1">
							<input type="hidden" name="route2">
							<input type="hidden" name="route3">
							<input type="hidden" name="route4">
							<input type="hidden" name="route5">
						</div>
						<div class="modal-body-trailTitle">
							<textarea id="trail_title" name="title" cols="30" rows="1" style="width:268px; height:30px; text-align:center; resize:none;" placeholder="산책로 이름을 적어주세요"></textarea>
						</div>
						<div class="modal-body-trailDescription">
							<textarea id="trail_content" name="content" cols="30" rows="6" style="width:268px; height:120px; resize:none;"></textarea>
						</div>	
					</div>
					<div class="modal-footer">
						<input type="button" class="btn btn-primary" value="등록" onClick="formSubmit();">
					</div>
					<sec:csrfInput/>
				</form>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">산책로 수정</h4>
				</div>
				<form id="modify_trail_form" name="modify_trail_form" action="/MMONG/trail/updateTrail.do" method="post">
					<div class="modal-body" style="height:250px;">
						<div class="modal-body-category" style="height:60px; text-align:center;">
							<label><input type="checkbox" name="category" value="힐링">힐링</label>
							<label><input type="checkbox" name="category" value="다이어트">다이어트</label>
							<label><input type="checkbox" name="category" value="산보">산보</label><br>
							<input type="hidden" name="no">
							<input type="hidden" name="route1">
							<input type="hidden" name="route2">
							<input type="hidden" name="route3">
							<input type="hidden" name="route4">
							<input type="hidden" name="route5">
						</div>
						<div class="modal-body-trailTitle">
							<textarea id="trail_title" name="title" cols="30" rows="1" style="width:268px; height:30px; text-align:center; resize:none;"></textarea>
						</div>
						<div class="modal-body-trailDescription">
							<textarea id="trail_content" name="content" cols="30" rows="6" style="width:268px; height:120px; resize:none;"></textarea>
						</div>	
					</div>
					<div class="modal-footer">
						<input type="button" class="btn btn-primary" value="수정" onClick="modifyFormSubmit();">
					</div>
					<sec:csrfInput/>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>