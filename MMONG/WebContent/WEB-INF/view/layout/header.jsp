<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>   
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
	//알람 개수 뿌리기
	$.ajax ({
			"url" : "/MMONG/alert/countAlert.do",
			"dataType" : "text",
			"success" : function(response) {//response = 안읽은 알람개수
				if(response==""){
					$("#alertDropdown").remove();
				}else{//로그인한 사용자라면 (로그인하지않은 사용자일땐 response에 빈 값 옴)
					$("#alert").html(response);
					if(response=="0"){
						$("#alertMsg").html("새로운 알람이 없습니다.");
					}else{
						$("#alertMsg").html("<b>"+response+"</b>개의 읽지않은 알람이 있습니다.");
					}					
				}					
			}
	});//ajax 끝
		
	//알람 아이콘 누르면 드롭다운 생기고 전체 알람 리스트 뿌리기
	$("#alertIcon").on("click", showAlertDropdown());	
	
	//알람 누르면 읽음 상태값 변경 처리
	$("#alertDropdown").on("click", "li", function(){
		var alertNo = $(this).children().children(".alertNo").val(); //해당 알람의 no값 
		$.ajax ({
			"url" : "/MMONG/alert/updateState.do",
			"data" : {"alertNo":alertNo},
			"success" : function() {//response = 안읽은 알람개수
				showAlertDropdown();			
			}
		});//ajax 끝
	});
	
});

$(function() { //3초에 한번 알람개수 뿌리는 함수
	timer = setInterval(function(){
		$.ajax ({
			"url" : "/MMONG/alert/countAlert.do",
			"dataType" : "text",
			"success" : function(response) {//response = 안읽은 알람개수
				if(response==""){
					$("#alertDropdown").remove();
				}else{//로그인한 사용자라면 (로그인하지않은 사용자, 관리자일땐 response에 빈 값 옴)
					$("#alert").html(response);
					if(response=="0"){
						$("#alertMsg").html("새로운 알람이 없습니다.");
					}else{
						$("#alertMsg").html("<b>"+response+"</b>개의 읽지않은 알람이 있습니다.");
					}					
				}					
			}
		});//ajax 끝
	}, 3000); // 3초에 한번씩 받아온다.
});

//전체 알람리스트 뿌리는 함수
function showAlertDropdown(){
	$.ajax ({
		"url" : "/MMONG/alert/showAllalert.do",
		"dataType" : "JSON",
		"success" : function(response) {//response = alert객체 
			if(response!=null){//로그인한 사용자라면 (로그인하지않은 사용자일땐 response에 null값 옴)
				//$("#alertDropdown").empty().append("<li> <p class='green' id='alertMsg'></p> </li>"); //수정필요 - 두번째리스트부터 empty함면 됨
				//var $except = $("#header_inbox_bar").find("ul>li.green");
				$("ul #alertDropdown>li:gt(1)").remove();
				$.each(response, function(){				
					if(this.type=="0"){ //소모임 초대 알림인 경우
						if(this.state=="0"){//안읽은 알람
							$("#alertDropdown").append("<li><a href='/MMONG/group/groupDetail.do?groupNo="+this.groupNo+"'>"+this.content
														   +"<input type='hidden' class='alertNo' value='"+this.no+"'><img src='/MMONG/resource/assets/img/noti.png' width='15px' height='15px' align='right'></a></li>");
						}else{//읽은 알람
							$("#alertDropdown").append("<li><a href='/MMONG/group/groupDetail.do?groupNo="+this.groupNo+"'>"+this.content
														+"<input type='hidden' class='alertNo' value='"+this.no+"'></a></li>");
						}							
					}else if(this.type=="1"){ //쪽지알림일 경우
						if(this.state=="0"){//안읽은 알람
							$("#alertDropdown").append("<li><a href='/MMONG/message/selectReceiveMsg.do'>"+this.content
														+"<input type='hidden' class='alertNo' value='"+this.no+"'><img src='/MMONG/resource/assets/img/noti.png' width='15px' height='15px' align='right'></a></li>");
						}else{//읽은 알람
							$("#alertDropdown").append("<li><a href='/MMONG/message/selectReceiveMsg.do'>"+this.content
														+"<input type='hidden' class='alertNo' value='"+this.no+"'></a></li>");
						}							
					}else if(this.type=="2"){ //새 댓글 알림인 경우
						if(this.state=="0"){//안읽은 알람
							$("#alertDropdown").append("<li><a href='/MMONG/group/board/board_view.do?boardNo="+this.groupNo+"'>"+this.content
														+"<input type='hidden' class='alertNo' value='"+this.no+"'><img src='/MMONG/resource/assets/img/noti.png' width='15px' height='15px' align='right'></a></li>");
						}else{//읽은 알람
							$("#alertDropdown").append("<li><a href='/MMONG/group/board/board_view.do?boardNo="+this.groupNo+"'>"+this.content
														+"<input type='hidden' class='alertNo' value='"+this.no+"'></a></li>");
						}							
					}else if(this.type=="3"){ //모임일정 삭제알림 인경우
						if(this.state=="0"){//안읽은 알람
							$("#alertDropdown").append("<li><a href='/MMONG/group/groupDetail.do?groupNo="+this.groupNo+"'>"+this.content
														   +"<input type='hidden' class='alertNo' value='"+this.no+"'><img src='/MMONG/resource/assets/img/noti.png' width='15px' height='15px' align='right'></a></li>");
						}else{//읽은 알람
							$("#alertDropdown").append("<li><a href='/MMONG/group/groupDetail.do?groupNo="+this.groupNo+"'>"+this.content
														+"<input type='hidden' class='alertNo' value='"+this.no+"'></a></li>");
						}							
					}else{ //모임일정 변경알림 인경우
						if(this.state=="0"){//안읽은 알람
							$("#alertDropdown").append("<li><a href='/MMONG/group/groupDetail.do?groupNo="+this.groupNo+"'>"+this.content
														   +"<input type='hidden' class='alertNo' value='"+this.no+"'><img src='/MMONG/resource/assets/img/noti.png' width='15px' height='15px' align='right'></a></li>");
						}else{//읽은 알람
							$("#alertDropdown").append("<li><a href='/MMONG/group/groupDetail.do?groupNo="+this.groupNo+"'>"+this.content
														+"<input type='hidden' class='alertNo' value='"+this.no+"'></a></li>");
						}							
					}
				});
			}
		}
	});//ajax 끝		
}

function alertMsg2(){
	$("#loginWaringMsg2").empty();
	$("#loginWaringMsg2").append("<div class='alert alert-warning alert-dismissable' style='height:30px;'>"
							   +"<button type='button' onClick='window.location.reload();' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button>"
							   +"&nbsp;&nbsp;<strong>Warning!</strong> 로그인이 필요한 서비스입니다.</div> ");
}

function logout(){
   document.getElementById("logoutForm").submit();
}
</script>

<div class="sidebar-toggle-box">
      <div class="fa fa-bars tooltips" data-placement="right" data-original-title="Toggle Navigation"></div>
</div>

            <!------메인로고-------->
            <a href="/MMONG/index.do" class="logo"><b>MMONG <img src="/MMONG/resource/assets/img/puppy/dogPrint.png"></b></a>
            <!------메인 로고 끝------>
            
            <!-- --------------상단 바 : 알림, 쪽지 아이콘------------- -->
            <div class="nav notify-row" id="top_menu">     
            	<ul class="nav top-menu"> 

					<!--  알림아이콘 -->
					<li id="header_inbox_bar" class="dropdown">
						<sec:authorize access="!isAuthenticated()"> 
						    <a onClick="alertMsg2(); return false;" >
						        <i class="fa fa-bell"></i>
						    </a>							
					    </sec:authorize>
					    <sec:authorize access="isAuthenticated()"> 
						    <a data-toggle="dropdown" class="dropdown-toggle" href="index.html#">
						        <i class="fa fa-bell" id="alertIcon"></i>
						        <span class="badge bg-theme" id="alert"></span> <%--알람개수 표시 --%>
							</a>
							<ul class="dropdown-menu extended inbox" id="alertDropdown">
							    <!-- <div class="notify-arrow notify-arrow-green"></div> -->
								<li> <p class="green" id="alertMsg"></p> </li> <%-- *개의 읽지않은 알람이있습니다 --%>
							</ul>
						</sec:authorize>
					</li>               
               
					<!--  쪽지아이콘 -->                   
					<li id="header_inbox_bar" class="dropdown">
						<sec:authorize access="!isAuthenticated()"> 
						    <a onClick="alertMsg2(); return false;" >
						        <i class="fa fa-envelope-o"></i>
						    </a>							
					    </sec:authorize>
					    <sec:authorize access="isAuthenticated()">
						    <a href="/MMONG/message/selectReceiveMsg.do">
						        <i class="fa fa-envelope-o"></i>
						    </a>
					    </sec:authorize>
					</li> 
					
					<!-- 로그인하지 않은 사용자가 로그인이 필요한 메뉴 접근시 경고메시지 뿌려줄 곳 -->
					<li id="loginWaringMsg2">
					</li>
				                   
                </ul>

            </div>
            <!-- --------------상단 바 : 알림, 쪽지 푸쉬알람 아이콘 끝------------- -->

            
            <!-- --------------상단 바 : 마이페이지, 로그인------------- -->
            <div class="top-menu">
            	<ul class="nav pull-right top-menu">
            	                


            	<li style="padding:21px">
 					<sec:authorize access="hasRole('ROLE_0')">
						<sec:authentication property="principal.adminId" /> 님 환영합니다.<br>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_1')">
						<sec:authentication property="principal.memberId" /> 님 환영합니다.<br>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_2')">
						현재 정지된 계정입니다.<br>
					</sec:authorize>           	
            	
            	</li>
            	
                 <sec:authorize access="isAuthenticated()">
                 	<sec:authorize access="hasRole('ROLE_1')">
    					<li><a class="logout" href="/MMONG/member/mypage.do">MyPage</a></li>
    				</sec:authorize>
    				<sec:authorize access="hasRole('ROLE_0')">
    					<li><a class="logout" href="/MMONG/admin/mypage.do">MyPage</a></li>
    				</sec:authorize>
    				
    				
          		 </sec:authorize>
           		 <sec:authorize access="isAuthenticated()">
    				<li><a class="logout" href="javascript:logout()">Logout</a>
          		 </sec:authorize>
            	<sec:authorize access="!isAuthenticated()">
                    <li><a class="logout" href="/MMONG/login_form.do">Login</a></li>
                 </sec:authorize>
            	</ul>       	     	
            </div>

            <!-- --------------상단 바 : 마이페이지, 로그인 끝------------- -->
