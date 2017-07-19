<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Bootstrap Core CSS -->
<link href="/MMONG/resource/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Theme CSS -->
<link href="/MMONG/resource/assets/css/freelancer.min.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="/MMONG/resource/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">
    
    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//로그인 안했을 때 소모임 생성 버튼 누르면 처리
	$("#createNone").on("click", function(){
		alert("먼저 로그인 해주세요.");
		return;
	});
	
	//소모임 하나 클릭했을 때 소모임 상세페이지로 이동 
	$(".myGroup").on("click", function(){
		$(this).parent().submit();
	});
});
</script>

	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 소모임 페이지
		</h3>

<!-- 나의 소모임 뿌리기 -->
<p><b>나의 소모임</b></p>


<br>


 <!-- Portfolio Grid Section -->
    <section id="portfolio">
    
        <div class="container">
        
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2>나의 소모임</h2>
                    <hr class="star-primary">
                </div>
            </div>
            
        <sec:authorize access="!isAuthenticated()">      
			로그인 해주세욥 <br>
		</sec:authorize>
		<sec:authorize access="isAuthenticated()">		
			<div class="row">	
				<c:forEach var="myGroup" items="${myGroup }">
					<form id="groupInfo" action="/MMONG/group/groupDetail.do">
						<div class="myGroup" id="${myGroup.no }" style="border:1px solid; padding:10px; margin:10px; width:300px;">
							소모임 이름 : ${myGroup.name } <br>
							모임 설명 : ${myGroup.content }
						</div>
						<input type="hidden" name="groupNo" value="${myGroup.no }">
						<sec:csrfInput/>
					</form>
					
					<div class="col-sm-4 portfolio-item">
	                    <a href="#portfolioModal1" class="portfolio-link" data-toggle="modal">
	                        <div class="caption">
	                            <div class="caption-content">
	                                <i class="fa fa-search-plus fa-3x"></i>
	                            </div>
	                        </div>
	                        <img src="/MMONG/resource/assets/img/portfolio/port06.jpg" class="img-responsive" alt="Cabin">
	                    </a>
	                </div> 
				</c:forEach>	
			</div>			
		</sec:authorize>
            
            
            

        </div>  <!-- container 끝 -->        
    </section>
    
    
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
=======
	<!--wrapper -->

