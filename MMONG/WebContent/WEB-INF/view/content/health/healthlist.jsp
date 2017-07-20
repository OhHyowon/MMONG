<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">

// 건강관리 등록 팝업
function showPopup(){
	
	var popupTitle = "건강관리 등록";
	
	window.open("/MMONG/health/registform.do",popupTitle,"width=500, height=460");
}

// 건강관리 수정 팝업
function showPopup2(){
	
	var popupTitle = "건강관리 수정";
	var checkedNo = "";
	var checkedContent="";
	$("input[name='chek']:checked").each(function(){
		checkedNo=($(this).attr('id'));
		checkedContent=($(this).val());
		alert(checkedNo);
		alert(checkedContent);
	});	// end of checklist
	
	
	window.open("/MMONG/health/healthMod.do?checkedNo="+checkedNo+"&checkedContent="+checkedContent+"",popupTitle,"width=507, height=400")
	
}

 $(document).ready(function(){
	 $("#healthlist").hide();
	 $("#selectBtn").hide();
	 $("#chartTable").hide();
	 
	// radio 버튼 ajax 처리
	 $("input:radio[name=gender]").click(function(){
		 var radio = $(this).val();
		 
		 $(".checkList").remove();
		 $("#chartTable").hide();
		 $('input[name=chek]:checkbox').each(function(){
				$(this).prop('checked', false);
				$('#checkAll').prop('checked',false);
			});
		 $.ajax({
				"url":"/MMONG/health/healthlist.do",
				"type":"post",
				"data":{"gender":radio, "${_csrf.parameterName}":"${_csrf.token}"},
				"dataType":"json",
				"success":function(list){
					var txt ="";
					$.each(list, function(){
						// 성별을 받았을때 char 타입이라 다시 수컷,암컷,중성으로 바꿔준다.
						if(this.gender=='m'){
							this.gender='수컷';
						}else if(this.gender=='g'){
							this.gender='암컷';
						}else{
							this.gender='중성';
						}
						txt = txt+'<tr><td class="radioNo" id="'+this.content+'">'+this.no+"</td><td class='clickByHealth' id='"+this.no+"'>"+this.content+"</td><td>"
						+this.gender+'</td><td class="checkboxClass"><sec:authorize access="hasRole(\'ROLE_0\')"><input type="checkbox" name="chek" id="'+this.no+'" value='+this.content+'></sec:authorize></td></tr>'
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
	 
		
	 // 건강기록 옆에 체크박스 누르면 전체 체크박스 지우기
	$(document).on("click",'#checkbx',function(){
		if($("input[name=chek]").not(':checked').length>0){
			$("#checkAll").prop("checked",false);
		}
	});
	
	
	 // 체크해서 진료기록 조회하기 
	 $(document).on("click", '#selectBtn:button',function() {
		 var checkedList = [];
		 	
		 // 체크박스 선택 안하고 진료기록검색 눌렀을시
		 	if($("input:checkbox[name='chek']").is(":checked")==false){

		 		jQuery.ajaxSettings.traditional = true;
		 		$.ajax({
		 			"url":"/MMONG/chart/selectChartByWriter.do",
					"type":"post",
					"data":{"${_csrf.parameterName}":"${_csrf.token}"},
					"dataType":"json",
					"success":function(list){
						var txt ="";
						$.each(list, function(){
							//this //하나의 회원정보 - <tr>
							txt = txt+'<tr class="checkList"><td>'+this.time+'</td><td>'
							+this.content+'</td></tr>';
						});	// end of each
						$("#chartList").html(txt);
						$("#chartTable").show();
					} // end of success
		 		})	// end of ajax
		 		
		 	}else if($("input:checkbox[name='chek']").is(":checked")==true){
			 
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
						txt = txt+'<tr class="checkList"><td><td>'+this.time+'</td><td>'
						+this.content+'</td></tr>';
					});	// end of each
					$("#chartList").html(txt);
					$("#chartTable").show();
					
					}, // end of success
				"error":function(){
					alert("건강기록을 체크해 주세요")
				}	// end of error
		 	 }); // end of ajax
		 	} // end of else
		 });	// end of button
		 
		 //	 건강 기록 삭제
		$(document).on('click','#removeHealth:button',function(){
				var checkedList = [];
				
				$("input[name='chek']:checked").each(function(){
					checkedList.push($(this).attr('id'));
					
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
			$(".modForm").remove();
			$('input[name=chek]:checkbox').each(function(){
				$(this).prop('checked', false);
				$('#checkAll').prop('checked',false);
			});
			 $.ajax({
					"url":"/MMONG/chart/chartSelect.do",
					"type":"post",
					"data":{"chartNo":chartNo, "${_csrf.parameterName}":"${_csrf.token}"},
					"dataType":"json",
					"success":function(chart){
							$(that).parent().after('<tr class="chartContentForm"><td>진료 날짜</td><td>'+chartNo+'번 건강정보에 대한 내 진료기록</td><td>수정,삭제 여부</td></tr>'
						+'<tr class="chartDetail"><td  width=110>'+chart.time+'</td><td size="80">'+chart.content+'</td><td>'
						+'<input type="button" value="삭제" align="center" class="chartDelete" id="'+chart.healthNo+'">'
						+'<input type="button" value="수정" class="chartMod" align="center" id="'+chartNo+'"></td></tr>');
						
							$('input[id='+chartNo+']:checkbox').each(function() {
								$(this).prop('checked', true);
						});
					},	// end of success
					"error":function(){													
						$(that).parent().after('<tr class="chartForm"><td>진료날짜 입력</td><td>진료내용을 입력해 주세요</td><td>등록 여부</td></tr><tr class="chartAdd"><td><input type=date id="chartDate"></td><td><textarea rows="2" cols="50" id="chartContent" name="textarea"></textarea>'+'</td><td>'
								+'<center><input type="button" value="등록" class="insertChart" id="'+chartNo+'"><center>'+'</td></tr>');
						$('input[id='+chartNo+']:checkbox').each(function() {
							$(this).prop('checked', true);
						});
					}
			 }); // ajax 종료
		});	// end of clickByHealth
		
		$(document).on('click','.chartDetail',function(){
			$('.chartContentForm').remove();
			$(this).remove();
		}); // end of chartdetail

		
		
		// 진료 기록 추가
		$("#healthlist").on('click','.insertChart',function(){
			var chartNo = $(this).attr('id');
			var chartContent = $("#chartContent").val();
			var chartDate = $("#chartDate").val();
			
			var that = this; // event source
//			$(".chartForm").remove();
//			$(".chartContentForm").remove();
			 $.ajax({
					"url":"/MMONG/chart/chartInsert.do",
					"type":"post",
					dataType:"text",
					"data":{"chartNo":chartNo,"chartContent":chartContent,"chartDate":chartDate, "${_csrf.parameterName}":"${_csrf.token}"},
					"beforeSend":function(chart){
						if(!chartContent){
							alert("내용을 입력하세요");
							return false;
						}
						if(!chartDate){
							alert("날짜를 선택해 주세요");
							return false;
						}
					},
					"success":function(success){
						alert("등록이 완료 되었습니다.");
						$('.chartForm').empty();
						$('.chartAdd').empty();
			 		},
					"error":function(){
							alert("로그인을 하셔야 이용 하실 수 있습니다.")
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
						alert("삭제가 완료 되었습니다.");
						$('.chartForm').empty();
						$(that).parent().parent().parent().empty();
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
											'<tr class="modForm"><td><input type=date id="modeDate"></td><td>'+'<textarea rows="2" cols="40" id="chartContent" name="textarea"></textarea>'+'</td><td>'
						+'<input type="button" value="등록" class="mod" align="center" id="'+chartNo+'">'+'</td></tr>');
		}) // end of chartMod
														
		
		// 진료기록 수정 보내기
		$("#healthlist").on('click','.mod',function(){
			var healthNo = $(this).attr('id');
			var content = $("textarea").val();
			var chartDate = $("#modeDate").val();
			
			var that = this; // event source
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
					$('.chartForm').empty();
					$(that).parent().parent().empty();
					
				},
				"error":function(){
					alert("수정 실패!")
					location.reload();
				}
			 }); // ajax 종료 
		})	// end of mod
		
		
});	// end of ready
window.onload=function(){
	   $("#total_div").css("min-height", (document.body.scrollHeight-38.4)+"px");
	}
</script>

<!-- ############################### CSS ########################### -->
<style type="text/css">

.clickByHealth, .chartDetail{
		/*손가락 나오게 하는거*/
		cursor:pointer;
	}
	
.chartDetail{
	color : #797979;
} 
.chartContentForm, .chartForm{
	color : #f45ae5;	
	}

.radioNo{
	text-align: center;
}

/*########## button ############*/
.button{
    color: #333;
    font-size: 12px;
    border-radius: 4px;
    -webkit-border-radius: 4px;
    border: 1px solid #ccc !important;
    padding: 5px 15px;
    margin-right: 15px;
    background: #fff;
    margin-top: 15px;
}

.insertChart, .mod{
	color: #f2f2f2;
    font-size: 12px;
    border-radius: 4px;
    -webkit-border-radius: 4px;
    border: 1px solid #e5e5e5 !important;
    padding: 5px 15px;
    margin-right: 10px;
    margin-left: 10px;
    background: #b6b6b6;
    margin-top: 10px;
    margin-bottom: 10px;
}

.chartDelete,.chartMod{
	color: #f2f2f2;
    font-size: 12px;
    border-radius: 4px;
    -webkit-border-radius: 4px;
    border: 1px solid #e5e5e5 !important;
    padding: 5px 15px;
    background: #b6b6b6;
	margin-right: 5px;
    margin-left: 5px;
}

/*#################### RadioButton ###################*/
.radioButton{
	margin-top: 20px;
	margin-right: 380px;
    margin-left: 380px;
}
/*#################### table ###################*/
table.healthList{
    border-collapse: collapse;
    text-align: center;
    line-height: 2;
    border-top: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
    margin: 30px 20px;
}
table.healthList thead th {
    width: 150px;
    padding: 10px;
    text-align: center;
    font-weight: bold;
    vertical-align: top;
    color: #fff;
    background: #797979;
    margin: 20px 10px;
}
table.healthList tbody th {
    width: 150px;
    padding: 10px;
}
table.healthList td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
    align:center;
}
table.healthList .even {
    background: #fdf3f5;
}

table.checkboxClass{
	width: 100px;
}


/* ############## 진료기록 테이블 ##################*/
table.chartTable{
	align:center;
    border-collapse: collapse;
    text-align: center;
    line-height: 2;
    border-top: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
    margin: 30px 20px;
}
table.chartTable thead th {
    width: 150px;
    padding: 10px;
    text-align: center;
    font-weight: bold;
    vertical-align: top;
    color: #fff;
    background: #797979;
    margin: 20px 10px;
}
table.chartTable tbody th {
    width: 150px;
    padding: 10px;
}
table.chartTable td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
}
table.chartTable .even {
    background: #fdf3f5;
}

</style>
<div id="total_div">
<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 건강관리
		</h3>

<%-- ================건강관리 페이지 소메뉴=================== --%>

<!--건강기록 정보 라디오 버튼 누르면 리스트를 뜨게한다  -->
<div class="radioButton">
	<label><input type="radio" name="gender" value="m" >수컷</label>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
 	<label><input type="radio" name="gender" value="g" >암컷</label>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
	<label><input type="radio" name="gender" value="c" >중성</label>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
	<label><input type="radio" name="gender" value="d">전체 목록</label><br>
</div>

<!-- 건강기록 정보 리스트  -->
<table id="healthlist" class="healthList">
	<thead>
		<tr>
			<th width=70>번호</th>
			<th>내용</th>
			<th>성별</th>
		</tr>
	</thead>
	<tbody id="listTbody"></tbody>
</table>

<sec:authorize access="hasRole('ROLE_1')">
<input type ="button" id="selectBtn" value="진료기록 검색" class="button"><br>
</sec:authorize>
<sec:authorize access="hasRole('ROLE_1')">
<input type="button" value="건강 리스트 등록" onclick="showPopup();" class="button">
<input type="button" value="건강 리스트 삭제" id="removeHealth" class="button" onsubmit="return confirm('삭제하시겠습니까?')">
<input type="button" value="건강 리스트 수정" id="modifyHealth" class="button" onclick="showPopup2();">

</sec:authorize>

<!-- 진료기록 리스트  -->
<table id="chartTable" class="chartTable">
	<thead>
		<tr>
			<th width=120>진료날짜</th>
			<th>내용</th>
		</tr>
	</thead>
	<tbody id="chartList"></tbody>
</table>

<%-- ==============소모임 페이지 소메뉴 끝================== --%>
</section>
</div>