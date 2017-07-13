<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
function showPopup(){
	
	var popupTitle = "건강관리 등록";
	
	window.open("/MMONG/health/registform.do",popupTitle,"width=700, height=600");
}

 $(document).ready(function(){
	 $("#healthlist").hide();
	 $("#selectBtn").hide();
	 $("#chartTable").hide();
	 
	// radio 버튼 ajax 처리
	 $("input:radio[name=gender]").click(function(){
		 var radio = $(this).val();
		
		 $.ajax({
				"url":"/MMONG/health/healthlist.do",
				"type":"post",
				"data":{"gender":radio, "${_csrf.parameterName}":"${_csrf.token}"},
				"dataType":"json",
				"success":function(list){
					var txt ="";
					$.each(list, function(){
						//this //하나의 회원정보 - <tr>
						txt = txt+'<tr><td class="radioNo">'+this.no+"</td><td class='clickByHealth 'id='"+this.no+"'>"+this.content+"</td><td>"+'<input type="checkbox" name="chek" id="checkbx" value='+this.no+'>'+"</td></tr>";
						
					});	// end of each
					$("#listTbody").html(txt);
					$("#healthlist").show();
					$("#selectBtn").show();
				},
				"error":function(){
					alert("에러")
				}
		 }); // ajax 종료
	 }); // end of radio
	 
	 //체크박스 전체 선택
	 $('#checkAll').click(function() {
			if ($('#checkAll').prop('checked')) {
					$('input[name=chek]:checkbox').each(function() {
						$(this).prop('checked', true);
				});
				
		// checkedAll 이 checked 되어 있지 않다면
		} else {
		$('input[name=chek]:checkbox').each(function(){
				$(this).prop('checked', false);
			});
		};	// end of else
	});
	 
	$(document).on("click",'#checkbx',function(){
		if($("input[name=chek]").not(':checked').length>0){
			$("#checkAll").prop("checked",false);
		}
	});
		     
	 
	 // 체크해서 진료기록 조회하기 
	 $(document).on("click", '#selectBtn:button',function() {
		 var checkedList = [];
		 	 
		 	$("input[name='chek']:checked").each(function(){
		 		checkedList.push($(this).val());
		 		});	// end of checkbox
		 	
		 	jQuery.ajaxSettings.traditional = true;
		 	 $.ajax({
		 		"url":"/MMONG/chart/chartlist.do",
				"type":"post",
				"data":{"checkedList":checkedList, "${_csrf.parameterName}":"${_csrf.token}"},
				"dataType":"json",
				"success":function(list){ 
					var txt ="";
					$.each(list, function(){
						//this //하나의 회원정보 - <tr>
						txt = txt+'<tr><td>'+this.healthNo+'</td><td>'+this.time+'</td><td>'
						+this.content+'</td></tr>';
					});	// end of each
					$("#chartList").html(txt);
					$("#chartTable").show();
					
					}, // end of success
				"error":function(){
					alert("건강기록을 체크해 주세요")
				}	// end of error
		 		 
		 	 }); // end of ajax
		 });	// end of button
		 
		 //	 건강 기록 삭제
		$(document).on('click','#removeHealth:button',function(){
				var checkedList = [];
				
				$("input[name='chek']:checked").each(function(){
					checkedList.push($(this).val());
					
				});	// end of checklist
			 	
				jQuery.ajaxSettings.traditional = true;
			 	 $.ajax({
			 		"url":"/MMONG/health/deleteHealth.do",
					"type":"post",
					"data":{"checkedList":checkedList, "${_csrf.parameterName}":"${_csrf.token}"},
					"success":function(list){ 
							alert("삭제되었습니다.");
							location.reload();
						}, // end of success
					"error":function(){
						alert("삭제할 건강기록을 체크해 주세요")
					}	// end of error
				
			 }); // end dof ajax
			 
		});// end of remove
		
		
		// 선택한 건강기록 밑에 진료기록 뜨기
		$("#healthlist").on('click','.clickByHealth',function(){

			var chartNo = $(this).attr('id');	// healthNo
			var that = this; //event 소스 td
			$(".chartList").remove();
			$(".chartDetail").remove();
			$(".chartAdd").remove();
			$(".chartForm").remove();
			$(".chartContentForm").remove();
			 $.ajax({
					"url":"/MMONG/chart/chartSelect.do",
					"type":"post",
					"data":{"chartNo":chartNo, "${_csrf.parameterName}":"${_csrf.token}"},
					"dataType":"json",
					"success":function(chart){
							$(that).parent().after('<tr class="chartContentForm"><td>진료 날짜</td><td>'+chartNo+'번 건강정보에 대한 내 진료기록</td><td>수정,삭제 여부</td></tr>'
						+'<tr class="chartDetail"><td  width=110>'+chart.time+'</td><td size="80">'+chart.content+'</td><td>'
						+'&nbsp<input type="button" value="삭제" class="chartDelete" id="'+chart.healthNo+'" >&nbsp'
						+'<input type="button" value="수정" class="chartMod" id="'+chartNo+'"></td></tr>');
					},	// end of success
					"error":function(){													
						$(that).parent().after('<tr class="chartForm"><td>진료날짜 입력</td><td>진료내용을 입력해 주세요</td><td>등록 여부</td></tr><tr class="chartAdd"><td><input type=date id="chartDate"></td><td><textarea rows="2" cols="80" id="chartContent" name="textarea"></textarea>'+'</td><td>'
								+'<input type="button" value="등록" class="insertChart" id="'+chartNo+'">'+'</td></tr>');
					}
			 }); // ajax 종료
		});	// end of clickByHealth
		
		$(document).on('click','.chartDetail',function(){
			$(this).remove();
		}); // end of chartdetail

		
		
		// 진료 기록 추가
		$(document).on('click','.insertChart',function(){
			var chartNo = $(this).attr('id');
			var chartContent = $("#chartContent").val();
			var chartDate = $("#chartDate").val();
			 $.ajax({
					"url":"/MMONG/chart/chartInsert.do",
					"type":"post",
					dataType:"text",
					"data":{"chartNo":chartNo,"chartContent":chartContent,"chartDate":chartDate, "${_csrf.parameterName}":"${_csrf.token}"},
					"beforeSend":function(){
						if(!chartContent){
							alert("내용을 입력하세요");
							return false;
						}
						if(!chartDate){
							alert("날짜를 선택해 주세요");
							return false;
						}
					},
					"success":function(){
						alert("등록이 완료 되었습니다.")
						location.reload();
			 		},
					"error":function(xhr, code, msg){
							alert("로그인을 하셔야 이용 하실 수 있습니다."+msg)
							location.reload();
					}
			 }); // ajax 종료
		}); // end of insertChart
		
		
		// 진료기록 삭제
		$(document).on('click','.chartDelete',function(){
			var chartNo = $(this).attr('id')
			
			$.ajax({
					"url":"/MMONG/chart/chartDelete.do",
					"type":"post",
					"data":{"chartNo":chartNo, "${_csrf.parameterName}":"${_csrf.token}"},
					"success":function(){
						alert("삭제가 완료 되었습니다.")
						location.reload();
					},
					"error":function(){
						alert("에러")
					}
			 }); // ajax 종료
		});	// end of chartDelete
		
		// 진료기록 수정폼 만들기
		$("#healthlist").on('click','.chartMod',function(){
			var chartNo = $(this).attr('id');
			$(this).parent().parent().after('<tr class="chartForm"><td>진료날짜 입력</td><td>수정할 진료내용을 입력해 주세요</td><td>등록 여부</td></tr>'+
											'<tr><td><input type=date id="modeDate"></td><td>'+'<textarea rows="2" cols="80" id="chartContent" name="textarea"></textarea>'+'</td><td>'
						+'<input type="button" value="등록" class="mod" id="'+chartNo+'">'+'</td></tr>');
		}) // end of chartMod
														
		
		// 진료기록 수정 보내기
		$("#healthlist").on('click','.mod',function(){
			var healthNo = $(this).attr('id');
			var content = $("textarea").val();
			var chartDate = $("#modeDate").val();
			
			alert(healthNo)
			alert(content)
			alert(chartDate)
			$.ajax({
				"url":"/MMONG/chart/chartModify.do",
				"type":"post",
				"data":{"healthNo":healthNo,"chartDate":chartDate,"content":content,"${_csrf.parameterName}":"${_csrf.token}"},
				"beforeSend":function(){
					if(!content){
						alert("내용을 입력해 주세요");
						return false;
					}else if(!chartDate){
						alert("날짜를 입력해 주세요");
						return false;
					}
				},
				"success":function(){
					alert("수정이 완료 되었습니다.")
					location.reload();
				},
				"error":function(){
					alert("수정 실패!")
					location.reload();
				}
			 }); // ajax 종료 
		})	// end of .mod
		
		
		
});	// end of ready


</script>
<style type="text/css">
table{
	width: 800px;
	border-collapse: collapse;
}
table, td, th{
border: 1px solid black;
}
.clickByHealth{
		/*손가락 나오게 하는거*/
		cursor:pointer;
	}
	
.chartDetail,.chartForm{
	color : red;
} 
.chartContentForm{
	color : blue;	
	}

.radioNo{
	text-align: center;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>


<h1>건강 관리</h1>


<%-- ================건강관리 페이지 소메뉴=================== --%>

<!--건강기록 정보 라디오 버튼 누르면 리스트를 뜨게한다  -->
	<label><input type="radio" name="gender" value="m" >수컷</label>
 	<label><input type="radio" name="gender" value="g" >암컷</label>
	<label><input type="radio" name="gender" value="c" >중성</label>
	<label><input type="radio" name="gender" value="d">전체 목록</label><br>


<!-- 건강기록 정보 리스트  -->
<table id="healthlist">
	<thead>
		<tr>
			<th width=70>번호</th>
			<th>내용</th>
			<th width=110>전체선택<input type="checkbox" id="checkAll"></th>
		</tr>
	</thead>
	<tbody id="listTbody"></tbody>
</table>

<sec:authorize access="hasRole('ROLE_1')">
<input type ="button" id="selectBtn" value="진료기록 검색"><br>
</sec:authorize>

<!-- 진료기록 리스트  -->
<table id="chartTable">
	<thead>
		<tr>
			<th width=70>건강번호</th>
			<th width=120>진료날짜</th>
			<th>내용</th>
		</tr>
	</thead>
	<tbody id="chartList"></tbody>
</table>

<%-- ==============소모임 페이지 소메뉴 끝================== --%>
<sec:authorize access="hasRole('ROLE_1')">
<input type="button" value="건강 리스트 등록" onclick="showPopup();">
<input type="button" value="건강 리스트 삭제" id="removeHealth" onsubmit="return confirm('삭제하시겠습니까?')">
</sec:authorize>
