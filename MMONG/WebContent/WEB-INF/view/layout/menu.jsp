<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%-- ========================menu 영역 =================== --%>
<%-- <ul>
	비회원 메뉴
	<sec:authorize access="!isAuthenticated()">      
		<li><a href="/MMONG/login_form.do">로그인</a></li>
		<li><a href="/MMONG/member/register_form.do">회원가입</a></li>
	</sec:authorize>
   
	회원메뉴
	<sec:authorize access="isAuthenticated()">
		<li><a href="javascript:logout()">로그아웃</a>
	</sec:authorize>
   
	회원 메뉴 : 개인회원 메뉴 /member로 시작
	<sec:authorize access="hasRole('ROLE_1')">
		<li><a href="/MMONG/member/mypage.do">회원 정보조회</a></li>
		<li><a href="/MMONG/message.do">쪽지 관리</a></li>          
	</sec:authorize>
	
	관리자 메뉴 : 관리자회원 메뉴 /admin으로 시작
	<sec:authorize access="hasRole('ROLE_0')">
		<li><a href="/MMONG/admin/mypage.do">관리자 정보조회</a></li>          
	</sec:authorize>
</ul>
<hr> --%>
<%-- =======================menu 영역 끝=================== --%>
<style>


/* 아이콘 적용 하기l */
</style>



<script type="text/javascript">
   function logout(){
      document.getElementById("logoutForm").submit();
   }
</script>
<form id="logoutForm" action="/MMONG/logout.do" method="post" style="display:none">
<sec:csrfInput/>
</form> 

  <!-- sidebar menu start-->
              <ul class="sidebar-menu" id="nav-accordion">
              
              	  <p class="centered"><a href="/MMONG/index.do"><img src="/MMONG/resource/assets/img/MMONG.png" class="img-circle" width="60"></a></p>
              	  <h5 class="centered">MENU</h5>
              	  	
                  <li class="mt">
                      <a href="/MMONG/index.do">
                          <i class="fa fa-dashboard"></i>
                          <span>MAIN</span>
                      </a>
                  </li>
           
                  
            <sec:authorize access="hasRole('ROLE_0')">
                   <li class="sub-menu">
                      <a href="/MMONG/admin/member_manage.do">
                          <i class="fa fa-dashboard"></i>
                          <span>회원관리</span>
                      </a>
                  </li>                 
            </sec:authorize>
                  
                  <li class="sub-menu">
                      <a href="javascript:;" > <!-- 다이어리 주소 넣기 -->
                          <i class="fa fa-book"></i>
                          <span>다이어리</span>
                      </a>
                  </li>
                  

                  <li class="sub-menu">
                      <a href="/MMONG/health/list.do" >
                          <i class="fa fa-cogs"></i>
                          <span>건강관리</span>
                      </a>
                  </li>
                  
                  <li class="sub-menu">
                      <a href="/MMONG/map/basic_map.do" >
                          <i class="fa fa-tasks"></i>
                          <span>산책로</span>
                      </a>
                  </li>
                  
                  <li class="sub-menu">
                      <a href="/MMONG/group/mygroup.do" >
                          <i class="fa fa-desktop"></i>
                          <span>소모임</span>
                      </a>
                   </li>

                  
                  <li class="sub-menu">
                      <a href="/MMONG/admin/customerCenter.do" >
                          <i class="fa fa-th"></i>
                          <span>고객센터</span>
                      </a>
                  </li>
                  
                  <li class="sub-menu">
                      <a href="javascript:;" >
                          <i class=" fa fa-bar-chart-o"></i>
                          <span>추가 더 할 것 있나여?</span>
                      </a>
                  </li>

              </ul>
              <!-- sidebar menu end-->
