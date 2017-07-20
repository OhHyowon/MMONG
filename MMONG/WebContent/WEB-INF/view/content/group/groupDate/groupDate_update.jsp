<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- Bootstrap core CSS -->
<link href="/MMONG/resource/assets/css/bootstrap.css?var=1"
	rel="stylesheet">

<!--external css-->
<link href="/MMONG/resource/assets/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="/MMONG/resource/assets/js/gritter/css/jquery.gritter.css" />
<link rel="stylesheet" type="text/css"
	href="/MMONG/resource/assets/lineicons/style.css">

<!-- Custom styles for this template -->
<link href="/MMONG/resource/assets/css/style.css?var=2" rel="stylesheet">
<link href="/MMONG/resource/assets/css/style-responsive.css"
	rel="stylesheet">
<script type="text/javascript"
	src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript"
	src="https://apis.skplanetx.com/tmap/js?version=1&format=javascript&appKey=6627b1a4-d735-3501-8a0d-84ad3ce149c9"></script>
<script type="text/javascript">
var map;
var markerLayer, markersLayer;
var tdata;
var marker, markers;
var cLonLat;
var searchText = "keyword";
var searchLonLat;

function initialize() {
	$("#total_div").css("min-height", (document.body.scrollHeight-38.4)+"px");
	
	map = new Tmap.Map({div:"map_div", width:'500px', height:'350px'});
	cLonLat = new Tmap.LonLat(14149513.77048, 4495298.9298456);
	map.setCenter(cLonLat, 16);
	map.addControl(new Tmap.Control.MousePosition());
	
	markerLayer = new Tmap.Layer.Markers("marker");
	markersLayer = new Tmap.Layer.Markers("markers");
	map.addLayer(markersLayer);
	map.addLayer(markerLayer);
}

function eventInitialize() {
	$("#searchPOI").on("click", function() {
		markersLayer.clearMarkers();
		searchText = $("#keyword").val();
		searchPOI(searchText);
	});
	
	$("#result_list_div").on("click", "input.poiToMarker", function() {
		for(var j=0; j<markersLayer.markers.length; j++) {
			markersLayer.markers[j].popup.hide();
		}
		markerLayer.clearMarkers();
		
		var size = new Tmap.Size(24,38);
		var offset = new Tmap.Pixel(-(size.w/2), -size.h);
		var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_r_b_a.png', size, offset);

		var poiName = $(this).prev().prev().prev().val();
		var poiLon = $(this).prev().prev().val();
		var poiLat = $(this).prev().val();
		cLonLat = new Tmap.LonLat(poiLon, poiLat);
		$("input#keyword").val(poiName);
		$("input[name=place]").val(poiLon+"_"+poiLat+"_"+poiName);
		
		var poiLabel = new Tmap.Label(poiName);
		
		marker = new Tmap.Markers(cLonLat, icon, poiLabel);
		markerLayer.addMarker(marker);
		marker.events.register("mouseover", marker, onOverMouseGroupMarker);
		marker.events.register("mouseout", marker, onOutMouseGroupMarker);
		
		map.panTo(cLonLat);
	});
}

function onOverMouseGroupMarker(e){
	for(var j=0; j<markerLayer.markers.length; j++) {
		markerLayer.marker[j].popup.hide();
	}
	this.popup.show();
}

function onOutMouseGroupMarker(e){
	this.popup.hide();
}

function searchPOI(keyword){
	tdata = new Tmap.TData();
	tdata.events.register("onComplete", tdata, onCompleteTData);
	searchLonLat = map.getCenter();
	searchKeyword(keyword, 1);
}

function searchKeyword(keyword, searchPage) {
	var center = searchLonLat;
	tdata.getPOIDataFromSearch(encodeURIComponent(keyword), {centerLon:center.lon, centerLat:center.lat, radius:5, page:searchPage, count:8});
}

function addPOIMarker(options) {
	var size = new Tmap.Size(18, 29);
	var offset = new Tmap.Pixel(-(size.w/2), -size.h);
	var icon = new Tmap.Icon("https://developers.skplanetx.com/upload/tmap/marker/pin_b_s_simple.png", size, offset);
	markers = new Tmap.Markers(options.lonlat,icon,options.label);
	markersLayer.addMarker(markers);
	markers.events.register("mouseover", markers, onOverMousePOI);
	markers.events.register("mouseout", markers, onOutMousePOI);
}

function onCompleteTData(e){
	$("#list_table").empty();
	markersLayer.clearMarkers();
	if($(this.responseXML).find("searchPoiInfo pois poi").text() != ''){
		var page = $(this.responseXML).find("searchPoiInfo page").text();
			$(this.responseXML).find("searchPoiInfo pois poi").each(function(){
				var name = $(this).find("name").text();
				var lon = $(this).find("frontLon").text();
				var lat = $(this).find("frontLat").text();
				var options = {
					lonlat:new Tmap.LonLat(lon, lat),
					label:new Tmap.Label("<div id='poi_popup_div' style='word-wrap:break-word;word-break:break-all;width:100px;'>"+name+"</div>")
				};
				addPOIMarker(options);
				$("#list_table").append("<tr><td class='result'><div style='width:290px;text-overflow:ellipsis;overflow: hidden;white-space: nowrap;' title='"+name+"'><label><a href='javascript:panToSelectMarker("+lon+","+lat+","+$(this).index()+")'><img src='/MMONG/resource/assets/img/map/noun_413210_cc.png'>&nbsp;&nbsp;&nbsp;"+name+
						"</a></label></div></td><td><input type='hidden' name='poiName' value='"+name+"'><input type='hidden' name='poiLon' value='"+lon+"'><input type='hidden' name='poiLat' value='"+lat+"'><input type='button' class='poiToMarker' value='등록' style='width:50px'></td></tr>");
				
			});
		map.zoomToExtent(markersLayer.getDataExtent());
		pagingView(searchText);
	}else {
		$("#list_table").append("<tr><td class='result'><div style='width:340px; text-align:cetner;'>검색 결과가 없습니다.</div></td></tr>");
	}
}

function panToSelectMarker(lon, lat, index) {
	for(var j=0; j<markersLayer.markers.length; j++) {
		markersLayer.markers[j].popup.hide();
	}
	
	markersLayer.markers[index].popup.show();
	
	cLonLat = new Tmap.LonLat(lon, lat);
	if(map.getZoom()<14) {
		map.setCenter(cLonLat, 14);
	}else {
		map.panTo(cLonLat);
	}
}

function pagingView(searchText) {
	var totalCount = $(tdata.responseXML).find("searchPoiInfo totalCount").text(); //전체 리스트 갯수
	var currentPage = $(tdata.responseXML).find("searchPoiInfo page").text(); //현재 페이지
	var count = 8; //페이지당 보여줄 리스트 갯수
	var totalPage = Math.ceil((totalCount/count)); //전체 페이지 갯수
	var pageBlock = 5; //페이지 그룹당 보여줄 페이지 갯수
	var startPage = Math.floor((currentPage-1)/pageBlock)*pageBlock+1;
	var endPage = startPage+pageBlock-1; //끝 페이지
	var firstPage = 1; //첫 페이지
	var lastPage = totalPage; //마지막 페이지
	
	if(totalPage>20) { //검색 가능 데이터 갯수가 최대 200개 이므로 페이지도 최대 20페이지
		totalPage = 20;
		lastPage = totalPage;
	}
	if(endPage>totalPage) {
		endPage = totalPage;
	}
	
	//현재 페이지가 1이 아닐 경우 처음 버튼 활성화
	if(currentPage!=1) {
		document.getElementById("paging_div").innerHTML = "<a href='javascript:searchKeyword(searchText,"+firstPage+")'>[처음] </a>";
	}else {
		document.getElementById("paging_div").innerHTML = "[처음] ";
	}
	
	//현재 페이지가 2이상일 경우 이전(◀)버튼 활성화
	//현재 페이지 2~5일 경우 firstPage로 이동, 그 외에는 startPage-pageBlock으로 이동
	if(currentPage>1 && currentPage<6) {
   		document.getElementById("paging_div").innerHTML += "<a href='javascript:searchKeyword(searchText,"+startPage+")'>◀ </a>";
   		//$("#paging_div").append("<a href='javascript:searchKeyword("+searchText+","+1+")'>◀ </a>");
	}else if(currentPage>=6){
		document.getElementById("paging_div").innerHTML += "<a href='javascript:searchKeyword(searchText,"+(startPage-pageBlock)+")'>◀ </a>";
	}else if(currentPage<2) {
	//	$("#paging_div").append("◀ ");
		document.getElementById("paging_div").innerHTML += "◀ ";
	}
	
	//시작 페이지부터 끝 페이지까지 1~5/6~10/11~15
	for(var j=startPage; j<=endPage; j++) {
		if(j==currentPage) { //현재 페이지는 링크 처리 X
			document.getElementById("paging_div").innerHTML += "<font color='red'>"+j+" </font>";
		}else { //현재 페이지가 아닐 경우 링크 처리
			document.getElementById("paging_div").innerHTML += "<a href='javascript:searchKeyword(searchText,"+j+")'>"+j+" </a>";
		}
	}
	
	//끝 페이지가 전체 페이지 수보다 작을 경우 다음(▶)버튼 활성화
	//끝 페이지의 다음 페이지가 있을 경우 다음(▶)버튼 활성화
	if(endPage<totalPage && totalPage>=(endPage+1)) {
		document.getElementById("paging_div").innerHTML += "<a href='javascript:searchKeyword(searchText,"+(startPage+pageBlock)+")'>▶ </a>";
	}else if(endPage==totalPage && currentPage<endPage) {
		document.getElementById("paging_div").innerHTML += "<a href='javascript:searchKeyword(searchText,"+endPage+")'>▶ </a>";
	}else if(currentPage==totalPage) {
		document.getElementById("paging_div").innerHTML += "▶ ";
	}
	
	//현재 페이지가 lastPage가 아닐 경우 끝 버튼 활성화
	if(currentPage!=lastPage) {
		document.getElementById("paging_div").innerHTML += "<a href='javascript:searchKeyword(searchText,"+lastPage+")'>[끝]</a>";
	}else {
		document.getElementById("paging_div").innerHTML += "[끝]";
	}
}

function onOverMousePOI(e){
	for(var j=0; j<markersLayer.markers.length; j++) {
		markersLayer.markers[j].popup.hide();
	}
	this.popup.show();
}

function onOutMousePOI(e){
	this.popup.hide();
}

$(document).ready(function(){
	var placeSplit = $("#placeSplit").val();
	var place = placeSplit.split("_");
	$("#placeSplit").next().val(place[2]);
	
	cLonLat = new Tmap.LonLat(place[0], place[1]);
	map.setCenter(cLonLat, 14);
	
	var size = new Tmap.Size(24,38);
	var offset = new Tmap.Pixel(-(size.w/2), -size.h);
	var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_r_b_a.png', size, offset);
	var placeName = new Tmap.Label("<div style='text-align:center; font-size:14px;'>"+place[2]+"</div>");
	
	marker = new Tmap.Marker(cLonLat, icon);
	markerLayer.addMarker(marker);
});

window.onload = function(){
	initialize();
	eventInitialize();
	window.resizeTo(1100, 720);
}
</script>
<style type="text/css">
.error {
	color: red;
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
</style>

<div class="col-lg-8">
	<div class="form-panel" >
		<div>&nbsp;</div>
		<form action="/MMONG/group/groupDate/updateGroupDate2.do" method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			일정 이름 :
			<div>
				<input type="text" name="title" value="${requestScope.groupDate.title }" class="form-control"><span class="error"><form:errors path="groupDate.title" deilimiter="&nbsp;&nbsp;" /></span>
			</div>
			날짜 :
			<div>
				<input type="datetime-local" name="groupDate" class="form-control" value="<fmt:formatDate value="${requestScope.groupDate.groupDate }" pattern="yyyy-MM-dd'T'HH:mm"/>"><span class="error"><form:errors path="groupDate.groupDate" deilimiter="&nbsp;&nbsp;" /></span>
			</div>
			장소 :
			<div style="display: flex;">
				<input type="hidden" class="form-control" id="placeSplit" value="${requestScope.groupDate.place }"><input type="text" id="keyword" class="form-control" style="width:90%"><input type="button" value="검색" id="searchPOI" style="width: 10%" class="btn btn-default"><input type="hidden" name="place">
			</div>
			<input type="hidden" name="memberId" value="${requestScope.groupDate.memberId}">
			<div id="wrap_map_div" style="height: 420px; position: relative">
				<div id="map_div" style="width: 500px; height: 350px; position: absolute; top: 30px; left: 15px;"></div>
				<div id="result_list_div" style="width: 350px; height: 300px; position: absolute; top: 30px; left: 650px">
					<table id="list_table">
						<tr>
							<td></td>
						</tr>
					</table>
				</div>
				<div id="paging_div" style="font-size: 12px; width: 350px; height: 25px; text-align: center; position: absolute; top: 370px; left: 650px;"></div>
			</div>
			<input type="hidden" name="groupDateNo" value="${requestScope.groupDate.no }">
			<div style="margin-left: 510px">
				<input type="submit" value="수정" class="btn btn-default btn-sm">
				<input type="button" value="취소" onclick="window.close()" class="btn btn-default btn-sm">
			</div>
		</form>
	</div>
</div>
