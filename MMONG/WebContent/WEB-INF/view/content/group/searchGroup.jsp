<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
#errMsg{
	font-size : 8px;
	color : red;
}
</style>

	<!-- 새로운 테마  -->
    <!-- Bootstrap Core CSS -->
    <link href="/MMONG/resource/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>

    <!-- Theme CSS -->
    <link href="/MMONG/resource/assets/css/agency.min.css" rel="stylesheet">
    
	<!-- 기존테마가 우선시 (상단바 때문에) : 이후에 적용 -->
    <!-- Bootstrap core CSS -->
    <link href="/MMONG/resource/assets/css/bootstrap.css?var=1" rel="stylesheet">
    
    <!--external css-->
    <link href="/MMONG/resource/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="/MMONG/resource/assets/js/gritter/css/jquery.gritter.css" />
    <link rel="stylesheet" type="text/css" href="/MMONG/resource/assets/lineicons/style.css">        
   
    <!-- Custom styles for this template -->
    <link href="/MMONG/resource/assets/css/style.css?var=2" rel="stylesheet">
    <link href="/MMONG/resource/assets/css/style-responsive.css" rel="stylesheet">
    
    
    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
window.onload=function(){
	$("#total_div").css("min-height", (document.body.scrollHeight-38.4)+"px");
}

$(document).ready(function(){
	//로그인 안했을 때 소모임 생성 버튼 누르면 처리
	$("#createNone").on("click", function(){
		alert("먼저 로그인 해주세요.");
		return;
	});
	
	//소모임 하나 클릭했을 때 소모임 상세페이지로 이동 
	$("#groupResult").on("click", "form", function(){ 
		$(this).submit(); //선택된 form전송
	});

});

function searchNameChk(){//소모임 검색 버튼 누를때 값 검사
	if($("#wantedGroup").val()=="" || $("#wantedGroup").val()=="이름으로 소모임 검색"){
		$("#inputForm").attr('class', 'form-group has-error');
		$("#wantedGroup").focus();
		return;
	}else{
		$("#searchName").submit();
	}
}

</script>



<div id="total_div">
<section class="wrapper site-min-height">




<!-- 소모임 리스트 뿌리기  --> 
<section id="portfolio" class="bg-white">
	<!-- 타이틀 -->
	<div class="row" style="margin-top:50px;">
	      <div class="col-lg-12 text-center">
	          <h2 class="section-heading">All Groups</h2>
	      </div>
	</div>
	
	<!-- 소모임 검색창 : 이름으로 검색 -->
	<div style="margin-left:80%; display:inline-block; margin-bottom:10px;" id=inputForm class="form-group">
		<form class="form-inline" role="form" action="/MMONG/group/searchGroupName.do" id="searchName">
		    <div id="inputForm" class="form-group">
		        <input class="form-control" id="wantedGroup" name="groupName" placeholder="이름으로 소모임 검색">
		    </div>
		    <button type="button" class="btn btn-theme" id="searchNameBtn" onClick="searchNameChk(); return false;">search</button>
		    <div id="errMsg" style="display:none"></div>								  
		</form>
	</div>

	<!-- 그룹리스트 -->             
	<div class="row" id="groupResult">	
	<c:forEach var="allGroup" items="${allGroup }">
			<div class="col-md-4 col-sm-6 portfolio-item">
	                  <a href="/MMONG/group/groupDetail.do?groupNo=${allGroup.no }" class="portfolio-link" data-toggle="modal">	                  	  
	                      <div class="portfolio-hover">
	                          <div class="portfolio-hover-content">
	                              <i class="fa fa-plus fa-3x"></i>
	                          </div>
	                      </div>
	                      <img src="/MMONG/resource/assets/img/doggroup.jpg" class="img-responsive" alt="">	                      
	                  </a>
	                  <div class="portfolio-caption">
	                      <h4><b>${allGroup.name }</b></h4>
	                      <p class="text-muted">${allGroup.content }</p>
	                  </div>
	         </div>
	         <sec:csrfInput/>					
	</c:forEach>	
	</div>  
</section>


<!-- 나의 소모임으로 돌아가기 버튼 -->
<center><button type="button" class="btn btn-default" onClick="self.location='/MMONG/group/mygroup.do';">나의 소모임</button></center>

</section>
</div>

<script>
$(document).ready(function(){
	$(".img-responsive").each(function(){		
		var myimages = new Array();
		//랜덤으로 출력할 이미지 소스 주소 
		myimages[0] = "/MMONG/resource/assets/img/doggroup.jpg";
		myimages[1] = "/MMONG/resource/assets/img/groups.jpg";
		myimages[2] = "/MMONG/resource/assets/img/ny.jpg";
		var ry = Math.floor( Math.random() * (myimages.length-1) );
		$(this).attr('src', myimages[ry]);
		//$(this).attr('src', '/MMONG/resource/assets/img/groups.jpg');
	});

	 

});
</script>

