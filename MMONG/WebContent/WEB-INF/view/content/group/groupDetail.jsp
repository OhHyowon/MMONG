<%@page import="com.mmong.vo.GroupMember"%>
<%@page import="java.util.List"%>
<%@page import="com.mmong.vo.Member"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.mmong.vo.Group"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
window.onload=function(){
	$("#total_div").css("min-height", (document.body.scrollHeight-38.4)+"px");
}
$(document).ready(function(){
	//로그인 안했을 때 소모임 가입 버튼 누르면 처리
	$("#createNone").on("click", function(){
		alert("먼저 로그인 해주세요.");
		return;
	});
	
	//소모임 가입 처리
	$("#create").on("click", function(){
		if(confirm("소모임에 가입하시겠습니까?")){
			$.ajax({
				"url" : "/MMONG/groupMember/insertGroupMember.do",
				"data" : {"no":0, "groupNo":$("#groupNo").val(), "memberId":$("#memberId").val(), "${_csrf.parameterName}":"${_csrf.token}"},
				"dataType" : "text",
				"success":function(response) {
					if(response=="1"){
						alert("가입이 완료되었습니다.");
						opener.parent.location.reload();
					}else{
						alert("이미 가입된 소모임 입니다.");
					}
				}
			});//ajax 끝
		}
	});
	
	//주인장이 소모임 수정 버튼 클릭시
	$("#editGroupBtn").on("click", function(){
		alert("수정하기");
		window.open("/MMONG/group/updateGroup1.do","모임 수정하기","top=100px, left=100px, height=220px, width=500px");
	});
	
	$("#deleteBtn").on("click",function(){
		var groupName=$("#groupName").val();
	
		if(!confirm("'"+groupName+"'"+" 소모임을 삭제하시겠습니까?")){
			return
		}else{
			$.ajax({
				url:"/MMONG/group/deleteGroup.do",
				type:"post",
				data:{"${_csrf.parameterName}":"${_csrf.token}"},
				dataType:"text",
				success:function(txt){
					if(txt=="1"){
						alert("삭제되었습니다.");
						location.href="/MMONG/group/mygroup.do"
					}else{
						alert("소모임에 참여중인 멤버가 있습니다. 삭제 불가");
					}
				}
			}); //ajax 끝
		}
	});
	
	
	//소모임 하나 클릭했을 때 소모임 상세페이지로 이동 
	$(".myGroup").on("click", function(){
		$(this).parent().submit();
	});
});
</script>

<div id="total_div">
	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 소모임 페이지
		</h3>

<%-- =============소모임 상세페이지 소메뉴 : 밑에 세메뉴안에도 이것 포함시키기! ================ --%>
  <sec:authorize access="hasRole('ROLE_1')"> 
<ul>
	<li><a href="/MMONG/group/groupDate/allGroupDateList.do">모임 일정 목록</a></li> <!-- 소모임 상세페이지 첫 화면 -->
	<li><a href="/MMONG/group/board/allBoardList.do">자유게시판</a></li>
	<li><a href="/MMONG/groupMember/searchGroupMember.do">참여 멤버 목록</a></li>
</ul>
</sec:authorize>
<%-- =============소모임 상세페이지 소메뉴 끝================ --%>


<!-- 그룹 상세페이지가 열릴 때마다 해당 소모임NO를 세션에 담음 -->
<%
	int groupNo = ((Group)request.getAttribute("group")).getNo();
	session.setAttribute("groupNo", groupNo);	
%>
<!-- 그룹 가입 시 그룹멤버 객체 만들어주기위해 넘겨줄 값 : 이건 예전에 만든거라 세션처리 못함 - 이주현 -->
<input type="hidden" id="groupNo" value="${requestScope.group.no}">
<sec:authorize access="hasRole('ROLE_1')">
	<input type="hidden" id="memberId" value="<sec:authentication property="principal.memberId"/>">
</sec:authorize>
<input type="hidden" id="groupName" value="${requestScope.group.name }">

<!-- 소모임 정보 -->
<p><b>모임 정보</b></p>
모임 이름 : ${requestScope.group.name } <br>
모임 장 : ${requestScope.group.leader } <br>

<!-- 가입하기 버튼 -->
<sec:authorize access="!isAuthenticated()"> <!-- 로그인 안했을시  -->       
   <button type="button" id="createNone" class='btn btn-default'>가입하기</button>
</sec:authorize>
<sec:authorize access="isAuthenticated()"> <!-- 로그인 했을시 -->
   <%
   //관리자, 주인장, 새로온 사람 별 버튼 달기 로직 --이주현
   List authList = (List)SecurityContextHolder.getContext().getAuthentication().getAuthorities(); //로그인한 사용자 권한정보 리스트
   String au = String.valueOf(authList.get(0));
   if(au.equals("ROLE_1")){//관리자인 경우 아무것도 안뜸 
      Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();      
      if(((Group)request.getAttribute("group")).getLeader().equals(member.getMemberId())){ //주인장은 가입하기 버튼 대신 소모임 정보수정 버튼 필요
         out.println("<button type='button' id='editGroupBtn' class='btn btn-default'>소모임 수정하기</button>");
      	 out.println("<button type='button' id='deleteBtn' class='btn btn-default'>소모임 삭제하기</button>");
      }else{//주인장이 아닌경우 그룹멤버에 이미 내가 포함되어있는지 검사후 안되어있으면 가입하기버튼
    	  List<GroupMember> groupMemberList = (List)(request.getAttribute("groupMemberList"));
    	  boolean flag = false;
    	  for(GroupMember gm : groupMemberList){
    		  if(gm.getMemberId().equals(member.getMemberId())){
    			  flag = true; //내가 가입되어있음 
    			  break;
    		  }
    	  }
    	  if(flag==false){ //가입 안되어있는 경우 - 가입하기 버튼 
    		  out.println("<button type='button' id='create' class='btn btn-default'>가입하기</button>");
    	  }
      }
   }
   %>
</sec:authorize>

<br>

 

</section>
</div>