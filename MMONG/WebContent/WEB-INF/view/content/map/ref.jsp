<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
pagingView : function(startIndex) {
	//page 번호, 게시판 전체 count, 화면에 뿌려질 글 count, 네비게이터 count
	var pagingHTML 		= "";
	
	var page 			= parseInt($("#page").val());
	var totalCount		= parseInt($("#totalCount").val());
	var pageBlock		= parseInt($("#pageBlock").val());
	var navigatorNum    = 10;
	var firstPageNum	= 1;
	var lastPageNum		= Math.floor((totalCount-1)/pageBlock) + 1; //Max.floor(x) x보다 작거나 같은 정수
	var previewPageNum  = page == 1 ? 1 : page-1;
	var nextPageNum		= page == lastPageNum ? lastPageNum : page+1;
	var indexNum		= startIndex <= navigatorNum  ? 0 : parseInt((startIndex-1)/navigatorNum) * navigatorNum;

	if (totalCount > 1) {
		if (startIndex > 1) {
			pagingHTML += "<a class='btn_first disabled' href='#' id='"+firstPageNum+"'><em>Go First</em></a> ";
			pagingHTML += "<a class='btn_prev disabled' href='#' id='"+previewPageNum+"'><em>Preview</em></a> ";
		}
		for (var i=1; i<=navigatorNum; i++) {
			var pageNum = i + indexNum;
			if (pageNum == startIndex) 
				pagingHTML += "<a class='selected' href='#' id='"+pageNum+"'>"+pageNum+"</a> ";
			else 
				pagingHTML += "<a href='#' id='"+pageNum+"'>"+pageNum+"</a>  ";
			if (pageNum==lastPageNum)
				break;
		}
		if (startIndex < lastPageNum) {
			pagingHTML += "<a class='btn_next' href='#' id='"+nextPageNum+"'><em>Next</em></a> ";
			pagingHTML += "<a class='btn_end' href='#' id='"+lastPageNum+"'><em>Go End</em></a>";
		}
	}
	$(".paging").html(pagingHTML);
	$(".paging a").click(function (e) {
		paging($(this).attr('id'));
	});
}
</script>
<body>
	<div id="map_div"></div>
</body>
</html>