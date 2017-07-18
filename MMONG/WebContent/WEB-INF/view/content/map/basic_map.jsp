<%@ page contentType="text/html;charset=UTF-8"%>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript"
	src="https://apis.skplanetx.com/tmap/js?version=1&format=javascript&appKey=6627b1a4-d735-3501-8a0d-84ad3ce149c9"></script>
<script type="text/javascript">
var map, markerLayer;
var tdata;

var marker = new Array(5); //산책로 등록시 사용할 마커 5개
var markers; //POI검색시 사용할 마커
var i = 0; //마커 index
var cLonLat;

var marker_lonlat;
var marker_lon = new Array(5); //각 마커의 lon 좌표를 저장할 변수
var marker_lat = new Array(5); //각 마커의 lat 좌표를 저장할 변수
var marker_cLonLat; //마커들의 중심 좌표
var marker_cLonLat_lon = 0; //마커들의 lon 좌표의 합을 저장할 변수
var marker_cLonLat_lat = 0; //마커들의 lat 좌표의 합을 저장할 변수

var bounds;
var bound_left = 0; //마커들을 전부 포함할 bound의 left 좌표 (마커들 중 lon 좌표의 크기가 가장 작은 좌표를 삽입)
var bound_bottom = 0; //마커들을 전부 포함할 bound의 bottom 좌표 (마커들 중 lat 좌표의 크기가 가장 작은 좌표를 삽입)
var bound_right = 0; //마커들을 전부 포함할 bound의 right 좌표 (마커들 중 lon 좌표의 크기가 가장 큰 좌표를 삽입)
var bound_top = 0; //마커들을 전부 포함할 bound의 top 좌표 (마커들 중 lat 좌표의 크기가 가장 큰 좌표를 삽입)
var temp = true; //현재 bound가 모든 마커들을 포함하고 있는지 여부, 기본값 true, 포함하지 않을 때 false

var searchText = "keyword";

function initialize() {
	map = new Tmap.Map({div:"map_div", width:'800px', height:'450px'});
	map.addControl(new Tmap.Control.MousePosition());
	addMarkerLayer();
	
	//'산책로 등록하기' 버튼 클릭시 맵 클릭 이벤트 등록
	//검색 결과 div(result_list_div) display:none처리
	//산책로 리스트 div(trail_list_div) display:block
	$("#registerTrail").on("click", function() {
		$("#result_list_div").empty();
		$("#keyword").val("");
		//$("#trail_list_div").prop("z-index", 3);
		//$("#result_list_div").prop("z-index", 1);
		//$("#trail_list_div").css('display', 'block');
		markerLayer.clearMarkers();
		i = 0;
		marker_cLonLat_lon = 0;
		marker_cLonLat_lat = 0;
		map.events.register("click", map, onClickMap);
	});
	//'산책로 등록완료' 버튼 클릭시 맵 클릭 이벤트 제거
	$("#finish").on("click", function() {
		$("#result_list_div").empty();
		$("#keyword").val("");
		map.events.unregister("click", map, onClickMap);
	});
	//'마커 제거' 버튼 클릭시 맵 위의 마커 모두 제거, 마커 index 초기화, 마커 좌표 합 초기화
	$("#removeMarker").on("click", function() {
		$("#result_list_div").empty();
		$("#keyword").val("");
		markerLayer.clearMarkers();
		i = 0;
		marker_cLonLat_lon = 0;
		marker_cLonLat_lat = 0;
	});
	//검색어 입력 후 검색 버튼 클릭시 정확도 순으로 반경 5km이내 검색 //시간나면 검색반경 option
	$("#searchPOI").on("click", function() {
		$("#result_list_div").empty();
		markerLayer.clearMarkers();
		searchText = $("#keyword").val();
		searchPOI(searchText);
	});
}

function addMarkerLayer(){
    markerLayer = new Tmap.Layer.Markers("marker");
    map.addLayer(markerLayer);
}

function addMarker(options) {
	var size = new Tmap.Size(12,19);
	var offset = new Tmap.Pixel(-(size.w/2), -size.h);
	var icon = new Tmap.Icon("https://developers.skplanetx.com/upload/tmap/marker/pin_b_s_simple.png", size, offset);
	markers = new Tmap.Markers(options.lonlat,icon,options.label);
	markerLayer.addMarker(markers);
	markers.events.register("mouseover", markers, onOverMouse);
	markers.events.register("mouseout", markers, onOutMouse);
}

function onOverMouse(e){
	for(var j=0; j<markerLayer.markers.length; j++) {
		markerLayer.markers[j].popup.hide();
	}
	this.popup.show();
}

function onOutMouse(e){
	this.popup.hide();
}

//keyword로 주위 반경 5km 검색, 한 페이지당 10개 출력
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

function pagingView(searchText) {
	var totalCount = $(tdata.responseXML).find("searchPoiInfo totalCount").text(); //전체 리스트 갯수
	var currentPage = $(tdata.responseXML).find("searchPoiInfo page").text(); //현재 페이지
	alert(currentPage);
	var count = 10; //페이지당 보여줄 리스트 갯수
	var totalPage = Math.ceil((totalCount/count)); //전체 페이지 갯수
//	var startRow = (currentPage-1)*count+1; //시작 리스트 번호
//	var endRow = startRow+count-1; //끝 리스트 번호
	var pageBlock = 5; //페이지 그룹당 보여줄 페이지 갯수
	var startPage = Math.floor((currentPage-1)/pageBlock)*pageBlock+1; //시작 페이지
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
	
	//현재 페이지가 1이 아닐 경우 처음(◀◀)버튼 활성화
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
	
	//현재 페이지가 lastPage가 아닐 경우 끝(▶▶)버튼 활성화
	if(currentPage!=lastPage) {
		document.getElementById("paging_div").innerHTML += "<a href='javascript:searchKeyword(searchText,"+lastPage+")'>[끝]</a>";
	}else {
		document.getElementById("paging_div").innerHTML += "[끝]";
	}
}

//list 클릭시 해당 마커가 중심이 되도록 지도 이동
function selectPOI(lon, lat, index) {
	for(var j=0; j<markerLayer.markers.length; j++) {
		markerLayer.markers[j].popup.hide();
	}
	cLonLat = new Tmap.LonLat(lon, lat);
	markerLayer.markers[index].popup.show();
	map.panTo(cLonLat);
}

//맵 클릭할때마다 마커1~5 생성, 마커 최대 5개
function onClickMap(event) {
	cLonLat = this.getLonLatFromPixel(new Tmap.Pixel(event.clientX, event.clientY)); //마우스를 클릭한 위치(마커가 생성될 위치)의 좌표
	
	marker_lon[i] = cLonLat.lon;
	marker_lat[i] = cLonLat.lat;
	marker_cLonLat_lon += marker_lon[i];
	marker_cLonLat_lat += marker_lat[i];
	
	var size = new Tmap.Size(24,38);
	var offset = new Tmap.Pixel(-(size.w/2), -size.h);
	if(i==0) {
		var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_r_m_1.png', size, offset);
	}else if(i==1) {
		var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_2.png', size, offset);
		//marker_lon의 크기들을 비교하여 bound_left, bound_right 지정
		if(marker_lon[0]<marker_lon[1]) {
			bound_left = marker_lon[0];
			bound_right = marker_lon[1];
		}else {
			bound_left = marker_lon[1];
			bound_right = marker_lon[0];
		}
		//marker_lon의 크기들을 비교하여 bound_bottom, bound_top 지정
		if(marker_lat[0]<marker_lat[1]) {
			bound_bottom = marker_lat[0];
			bound_top = marker_lat[1];
		}else {
			bound_bottom = marker_lat[1];
			bound_top = marker_lat[0];
		}
	}else if(i==2) {
		var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_r_m_3.png', size, offset);
		//기존 bound_right보다 marker_lon[2]가 클 경우 bound_right에 marker_lon[2] 삽입, bound_left는 유지
		//-> 기존 bound_left보다 작을 경우 bound_left에 marker_lon[2] 삽입, bound_right는 유지
		if(bound_right<marker_lon[2]) {
			bound_right = marker_lon[2];
		}else if(marker_lon[2]<bound_left){
			bound_left = marker_lon[2];
		}
		//기존 bound_top보다 marker_lat[2]가 클 경우 bound_top에 marker_lat[2] 삽입, bound_bottom은 유지
		//-> 기존 bound_bottom보다 작을 경우 bound_bottom에 marker_lat[2] 삽입, bound_top은 유지
		if(bound_top<marker_lat[2]) {
			bound_top = marker_lat[2];
		}else if(marker_lat[2]<bound_bottom){
			bound_bottom = marker_lat[2];
		}
	}else if(i==3) {
		var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_4.png', size, offset);
		if(bound_right<marker_lon[3]) {
			bound_right = marker_lon[3];
		}else if(marker_lon[3]<bound_left){
			bound_left = marker_lon[3];
		}
		if(bound_top<marker_lat[3]) {
			bound_top = marker_lat[3];
		}else if(marker_lat[3]<bound_bottom){
			bound_bottom = marker_lat[3];
		}
	}else if(i==4) {
		var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_r_m_5.png', size, offset);
		if(bound_right<marker_lon[4]) {
			bound_right = marker_lon[4];
		}else if(marker_lon[4]<bound_left){
			bound_left = marker_lon[4];
		}
		if(bound_top<marker_lat[4]) {
			bound_top = marker_lat[4];
		}else if(marker_lat[4]<bound_bottom){
			bound_bottom = marker_lat[4];
		}
	}else {
		alert("마커는 최대 5개까지 마크 가능합니다.");
		return false;
	}
	
	//마커가 1개일 경우 해당 마커 좌표로 지도 이동, 2개 이상일 경우 bound가 모든 마커들을 포함하고 있는지 여부를 따져 지도 이동
	if(i==0) {
		map.panTo(cLonLat);
	}else {
		bounds = new Tmap.Bounds(map.getExtent().left, map.getExtent().bottom, map.getExtent().right, map.getExtent().top);
		for(var j=0; j<=i; j++) {
			marker_lonlat = new Tmap.LonLat(marker_lon[j], marker_lat[j])
			if(!bounds.containsLonLat(marker_lonlat, false)) {
				temp = false;
				break;
			}
		}
		//temp가 true일 경우 마커들의 중심 좌표로 이동, false일 경우 모든 마커를 포함하는 bound로 지도 extent
		if(temp==true) {
			//마커들의 중심 좌표 lon, lat
			marker_cLonLat_lon /= i+1;
			marker_cLonLat_lat /= i+1;
			marker_cLonLat = new Tmap.LonLat(marker_cLonLat_lon, marker_cLonLat_lat+150); //마커들의 중심 좌표 삽입
			map.panTo(marker_cLonLat); //지도를 marker_cLonLat으로 이동
			marker_cLonLat_lon *= i+1;
			marker_cLonLat_lat *= i+1;
		}else {
			bounds = new Tmap.Bounds(bound_left-50, bound_bottom-50, bound_right+50, bound_top+300);
			map.zoomToExtent(bounds);
		}
	}

	marker[i] = new Tmap.Marker(cLonLat, icon);
	markerLayer.addMarker(marker[i]);
	i++;
}

window.onload = function() {
	initialize();
}
</script>
<style type="text/css">
a {
	text-decoration: none;
	color: black;
}

span.index {
	display: inline-block;
	font-size: 20px;
	width: 20px;
	height: 40px;
	padding: 0 5px 0 5px;
	margin: 0;
	text-align: center;
}

span.result {
	display: inline-block;
	font-size: 16px;
	height: 40px;
	padding: 0 5px 0 5px;
	margin: 0;
}
</style>


	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 산책로
		</h3>

<body>
	<div id="map_div" style="position: relative;">
		<div id="search_div"
			style="position: absolute; top: 0px; left: 800px; width: 250px; display: flex">
			<input type="text" id="keyword" placeholder="검색어를 입력해주세요" style="width: 200px;"> <input type="button" id="searchPOI" value="검색" style="width: 100px">
		</div>
		<div id="result_list_div" style="position: absolute; top: 25px; left: 800px; width: 300px;">
			result_list_div
		</div>
		<div id="paging_div" style="font-size: 12px; height: 25px; margin: 0; text-align: center; position: absolute; top: 480px; left: 800px; width: 300px;"></div>
		<div id="trail_list_div" style="position: absolute; top: 25px; left: 800px; width: 300px; display:none">
			trail_list_div
		</div>
	</div>
	<input type="button" value="산책로 등록하기" id="registerTrail">
	<input type="button" value="산책로 등록완료" id="finish">
	<input type="button" value="마커 제거" id="removeMarker">
	
	</body>
	</section>
