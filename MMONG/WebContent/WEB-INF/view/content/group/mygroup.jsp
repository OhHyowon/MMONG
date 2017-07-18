<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
$(document).ready(function(){
	//로그인 안했을 때 소모임 생성 버튼 누르면 처리
	$("#createNone").on("click", function(){
		alert("먼저 로그인 해주세요.");
		return;
	});
	
});
</script>

	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 소모임 페이지
		</h3>

<!-- 나의 소모임 뿌리기 -->
<br>

        <sec:authorize access="!isAuthenticated()">      
			로그인 해주세욥 <br>
		</sec:authorize>
		
		<sec:authorize access="isAuthenticated()">	
		<section id="portfolio" class="bg-white">
			 <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading">My Group</h2>
                </div>
             </div>
			 <div class="row">					
				<c:forEach var="myGroup" items="${myGroup }">
						<div class="col-md-4 col-sm-6 portfolio-item">
		                    <a href="/MMONG/group/groupDetail.do?groupNo=${myGroup.no }" class="portfolio-link" data-toggle="modal">
		                        <div class="portfolio-hover">
		                            <div class="portfolio-hover-content">
		                                <i class="fa fa-plus fa-3x"></i>
		                            </div>
		                        </div>
		                        <img src="/MMONG/resource/assets/img/portfolio/port02.jpg" class="img-responsive" alt="">
		                    </a>
		                    <div class="portfolio-caption">
		                        <h4><b>${myGroup.name }</b></h4>
		                        <p class="text-muted">${myGroup.content }</p>
		                    </div>
		                </div>
		                <sec:csrfInput/>					
				</c:forEach>
			</div>		
		</section>		
		</sec:authorize>
            

    
    
		<!-- 소모임 찾기 버튼 -->
		<input type="button" value="소모임 찾기" onClick="self.location='/MMONG/group/searchGroup.do';"> <br>
		
		<!-- 소모임 추가 버튼 -->
		<sec:authorize access="!isAuthenticated()"> 
			<button type="button" id="createNone">소모임 만들기</button>
		</sec:authorize>
		  <sec:authorize access="hasRole('ROLE_1')">  
			<button type="button" onclick="window.open('/MMONG/group/createGroup.do', '소모임 만들기', 'top=100px, left=100px, height=220px, width=500px')">소모임 만들기</button>
		</sec:authorize>


	</section>
	<!--wrapper -->