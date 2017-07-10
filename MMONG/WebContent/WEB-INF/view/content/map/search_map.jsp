<%@ page contentType="text/html;charset=UTF-8"%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script language="javascript" src="https://apis.skplanetx.com/tmap/js?version=1&format=javascript&appKey=6627b1a4-d735-3501-8a0d-84ad3ce149c9"></script>
<script type="text/javascript">
function initialize() {
	var map = new Tmap.Map({div:"map_div", width:'800px', height:'450px'});
	
	map.addControl(new Tmap.Control.MousePosition());
	
	var markerLayer = new Tmap.Layer.Markers();
	map.addLayer(markerLayer);
}
window.onload = function() {
	initialize();
}
</script>



<div id="map_div">		
</div>
