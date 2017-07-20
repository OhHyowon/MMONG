//처음 검색시 실행되는 함수, 1페이지 검색
function searchPOI(keyword){
	tdata = new Tmap.TData();
	tdata.events.register("onComplete", tdata, onCompleteTData);
	searchLonLat = map.getCenter();
	searchKeyword(keyword, 1);
}

//입력된 keyword로 주위 반경 5km 검색, 한 페이지당 10개 출력하는 함수, 페이징리스트에서 클릭한 페이지 검색
function searchKeyword(keyword, searchPage) {
	var center = searchLonLat;
	tdata.getPOIDataFromSearch(encodeURIComponent(keyword), {centerLon:center.lon, centerLat:center.lat, radius:5, page:searchPage, count:5});
}

//POI 검색시 사용되는 마커 등록 함수
function addPOIMarker(options) {
	var size = new Tmap.Size(18, 29);
	var offset = new Tmap.Pixel(-(size.w/2), -size.h);
	var icon = new Tmap.Icon("https://developers.skplanetx.com/upload/tmap/marker/pin_b_s_simple.png", size, offset);
	markers = new Tmap.Markers(options.lonlat,icon,options.label); //POI 마커 생성
	markersLayer.addMarker(markers); //markersLayer에 POI 마커 등록
	markers.events.register("mouseover", markers, onOverMousePOI); //마커에 마우스 올렸을 때의 이벤트 등록
	markers.events.register("mouseout", markers, onOutMousePOI); //마커에서 마우스 내렸을 때의 이벤트 등록
}

//POI 마커에 마우스 올렸을 때의 이벤트
function onOverMousePOI(e){
	//markersLayer에 있는 모든 마커들의 popup 숨김
	for(var j=0; j<markersLayer.markers.length; j++) {
		markersLayer.markers[j].popup.hide();
	}
	this.popup.show(); //마우스가 올라간 마커의 popup 보여줌
}

//POI 마커에서 마우스 내렸을 때의 이벤트
function onOutMousePOI(e){
	this.popup.hide(); //마우스가 내려간 마커의 popup 숨김
}

//POI 검색이 정상적으로 완료되었을 때 실행되는 함수
function onCompleteTData(e){
	$("#list_table").empty(); //POI 검색 결과가 출력될 table#list_table의 자식 노드 제거
	markersLayer.clearMarkers(); //markersLayer에 있는 기존의 모든 마커 제거
	if($(this.responseXML).find("searchPoiInfo pois poi").text() != ''){ //검색 결과가 있을 경우 true
		var page = $(this.responseXML).find("searchPoiInfo page").text();
			$(this.responseXML).find("searchPoiInfo pois poi").each(function(){
				var name = $(this).find("name").text(); //해당 POI의 이름
				var lon = $(this).find("frontLon").text(); //해당 POI의 lon 좌표
				var lat = $(this).find("frontLat").text(); //해당 POI의 lat 좌표
				var options = {
					lonlat:new Tmap.LonLat(lon, lat),
					label:new Tmap.Label("<div id='poi_popup_div' style='word-wrap:break-word;word-break:break-all;width:100px;'>"+name+"</div>") //POI 장소 이름을 label로 생성
				};
				addPOIMarker(options); //var options을 가지고 addPOIMarker 함수 실행
				/*
				$("#list_table").append("<tr><th class='index'><a href='javascript:panToSelectMarker("+lon+","+lat+","+$(this).index()+",1)'>"
						+($(this).index()+(10*(page-1))+1)+"</a></th><td class='result'><div style='width:200px;text-overflow:ellipsis;overflow: hidden;white-space: nowrap;' title='"+name+"'><a href='javascript:panToSelectMarker("+lon+","+lat+","+$(this).index()+",1)'>"+name+
						"</a></div></td><td><input type='hidden' name='poiName' value='"+name+"'><input type='hidden' name='poiLon' value='"+lon+"'><input type='hidden' name='poiLat' value='"+lat+"'><input type='button' class='poiToMarker' value='등록'></td></tr>");
				*/
				$("#list_table").append("<tr><td class='result'><div style='width:240px;text-overflow:ellipsis;overflow: hidden;white-space: nowrap;' title='"+name+"'><label><a href='javascript:panToSelectMarker("+lon+","+lat+","+$(this).index()+",1)'><img src='/MMONG/resource/assets/img/map/noun_413210_cc.png'>&nbsp;&nbsp;&nbsp;"+name+
						"</a></label></div></td><td><input type='hidden' name='poiName' value='"+name+"'><input type='hidden' name='poiLon' value='"+lon+"'><input type='hidden' name='poiLat' value='"+lat+"'><input type='button' class='poiToMarker' value='등록' style='width:50px'></td></tr>");
				
			});
		map.zoomToExtent(markersLayer.getDataExtent()); //POI 마커들을 모두 가지고 있는 bound로 맵 줌 및 이동
		pagingView(searchText); //검색 키워드(searchText)를 가지고 pagingView 함수 실행
	}else {
		alert('검색결과가 없습니다.');
	}
}

//POI 마커 리스트 또는 산책로 마커 리스트 클릭시 해당 마커가 중심이 되도록 지도 이동
//파라미터 layer는 markerLayer(산책로 마커 레이어)에 있는 마커인지 markersLayer(POI 마커 레이어)에 있는 마커인지 판별
//layer==0일 경우 markerLayer, layer==1일 경우 markersLayer
function panToSelectMarker(lon, lat, index, layer) {
	for(var j=0; j<markerLayer.markers.length; j++) {
		markerLayer.markers[j].popup.hide();
	}
	for(var j=0; j<markersLayer.markers.length; j++) {
		markersLayer.markers[j].popup.hide();
	}
	
	if(layer==0) {
		markerLayer.markers[index].popup.show();
	}else if(layer==1) {
		markersLayer.markers[index].popup.show();
	}
	
	cLonLat = new Tmap.LonLat(lon, lat);
	if(map.getZoom()<14) {
		map.setCenter(cLonLat, 14);
	}else {
		map.panTo(cLonLat);
	}
}

//페이징하기 위한 함수
function pagingView(searchText) {
	var totalCount = $(tdata.responseXML).find("searchPoiInfo totalCount").text(); //전체 리스트 갯수
	var currentPage = $(tdata.responseXML).find("searchPoiInfo page").text(); //현재 페이지
	alert(currentPage);
	var count = 5; //페이지당 보여줄 리스트 갯수
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

//맵 클릭할때마다 마커1~5 생성, 마커 최대 5개
function onClickMap(event) {
	cLonLat = this.getLonLatFromPixel(new Tmap.Pixel(event.clientX-180, event.clientY-60)); //마우스를 클릭한 위치(마커가 생성될 위치)의 좌표
	
	marker_lon[i] = cLonLat.lon; //각 산책로 마커의 lon 좌표
	marker_lat[i] = cLonLat.lat; //각 산책로 마커의 lat 좌표
	marker_cLonLat_lon += marker_lon[i];
	marker_cLonLat_lat += marker_lat[i];
	
	setTrailMarkerProp(i, 0, null);
}

//markerSrc==0일 경우 맵을 클릭해서 얻은 마커
//markerSrc==1일 경우 POI에서 얻은 마커
//markerSrc==2일 경우 저장된 산책로에서 얻은 마커
//labelContent는 markerSrc==1일 경우에만 들어옴, markerSrc==0일 때는 null
function setTrailMarkerProp(index, markerSrc, labelContent) {
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

	var labelString;
	if(markerSrc==0) {
		var requestUrl = "https://apis.skplanetx.com/tmap/geo/reversegeocoding?version=1&lon="+cLonLat.lon+"&lat="+cLonLat.lat+"&addressType=A04&format=xml&appKey="+appKey;
		var xmlHttp = new XMLHttpRequest();
		xmlHttp.onreadystatechange = loader;
		xmlHttp.open("GET", requestUrl, false);
		xmlHttp.send(null);
		
		function loader() {
			if(xmlHttp.readyState==4) {
				if(xmlHttp.status==200) {
					var temp = xmlHttp.responseXML;
					labelString = temp.getElementsByTagName("fullAddress")[0].childNodes[0].nodeValue;
				}
			}
		}
	}else if(markerSrc==1 || markerSrc==2) {
		labelString = labelContent;
	}
	var label = new Tmap.Label("<div id='poi_popup_div' style='word-wrap:break-word;word-break:break-all;width:100px;'>"+labelString+"</div>");
	addTrailMarker(cLonLat, icon, label, markerSrc);
}

function addTrailMarker(markerCLonLat, markerIcon, markerLabel, markerSrc) {
	marker = new Tmap.Markers(markerCLonLat, markerIcon, markerLabel);
	markerLayer.addMarker(marker);
	marker.events.register("mouseover", marker, onOverMouseTrailMarker);
	marker.events.register("mouseout", marker, onOutMouseTrailMarker);
	
	if(markerSrc!=2) {
		addMarkerToList(marker, i); //산책로 마커를 산책로 리스트(div#trail_list_div)에 등록
	}else{
		addTrailToList(marker, i); //등록된 산책로 마커 리스트를 div#trail_list_div에 등록
	}
	
	//마커가 1개일 경우 해당 마커 좌표로 지도 이동, 2개 이상일 경우 bound가 모든 마커들을 포함하고 있는지 여부를 따져 지도 이동
	if(i==0) {
		map.panTo(cLonLat);
	}else {
		bounds = new Tmap.Bounds(map.getExtent().left, map.getExtent().bottom, map.getExtent().right, map.getExtent().top);
		for(var j=0; j<=i; j++) {
			marker_lonlat = new Tmap.LonLat(marker_lon[j], marker_lat[j])
			if(!bounds.containsLonLat(marker_lonlat, false)) { //하나의 마커라도 포함하고 있지 않을 경우 for문을 빠져나옴, temp=false
				temp = false;
				break;
			}
		}
		//temp가 true일 경우(현재 bound가 모든 마커를 포함하고 있을 경우) 마커들의 중심 좌표로 이동, false일 경우 모든 마커를 포함하는 bound로 지도 extent
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
	i++;
}

//산책로 마커에 마우스 올렸을 때 이벤트
function onOverMouseTrailMarker(e){
	for(var j=0; j<markerLayer.markers.length; j++) {
		markerLayer.markers[j].popup.hide();
	}
	this.popup.show();
}

//산책로 마커에서 마우스 내렸을 때 이벤트
function onOutMouseTrailMarker(e){
	this.popup.hide();
}