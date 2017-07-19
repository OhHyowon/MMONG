<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style type='text/css'>

	body {
		margin: 40px 10px;
		padding: 0;
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		font-size: 14px;
	}

	#calendar {
		max-width: 900px;
		margin: 0 auto;
	}
	
	.typeColor{
		display: inline;
		width: 100px;
	}
	
	.fc-sat { color:#0000FF; }     /* 토요일 */
   .fc-sun { color:#FF0000; }    /* 일요일 */


</style>

<script type="text/javascript" src="/MMONG/resource/calendar/jquery-ui.min.js"></script>
<script type="text/javascript" src="/MMONG/resource/calendar/moment.min.js"></script>
<script type="text/javascript" src="/MMONG/resource/calendar/fullcalendar.js"></script>
<script type="text/javascript" src="/MMONG/resource/calendar/locale-all.js"></script>
<script type="text/javascript" src="/MMONG/resource/calendar/gcal.js"></script>
<link type="text/css" rel="stylesheet" href="/MMONG/resource/calendar/fullcalendar.css"/>
<link type="text/css" rel="stylesheet" href="/MMONG/resource/calendar/fullcalendar.print.css"  media='print'/>


<!-- 리스트 형식으로 표현 필요!!!!!!!!!****************** -->
<script type='text/javascript'>

	$(document).ready(function(){

		var initialLocaleCode = 'ko'; //한글로 변환

		var date = new Date();
		
		//팝업창 크기 조절
		var width=520, height=520;
		var left = (screen.availWidth - width)/2;
		var top = (screen.availHeight - height)/2;
		var specs = "width=" + width;
		specs += ",height=" + height;
		specs += ",left=" + left;
		specs += ",top=" + top;
		
		$('#calendarFull').fullCalendar({
			header: {
				left: 'prev,next today',
				center: "title",
				right: 'month,basicWeek,basicDay,listMonth'
			},
			locale: 'ko',
			defaultDate: date,
			navLinks: true, // can click day/week names to navigate views
			editable: false, // events can be dragged and resizedevents can be dragged and resized
			eventLimit: true, // allow "more" link when too many events
			
			businessHours: [ // specify an array instead
			    {
			        dow: [ 1, 2, 3, 4, 5], // Monday, Tuesday, Wednesday, Thursday, Friday
			    }
			],
			
			googleCalendarApiKey: 'AIzaSyApQ5kq_N3tI_LwPI6sEoXyH8NCPhef7Nc',  /* 조회해올때 휴일이 우선순위가장높게!!!!!!!!!!&주말색깔바꾸기 */
			eventSources : { 
				googleCalendarId : 'ko.south_korea#holiday@group.v.calendar.google.com', // 구글과 연동해 휴일 가져오기
				className : "koHolidays",
				color : "#DB7093",
	            textColor : "#FFFFFF"
			},
			events:function(start, end, timezone, callback){
				$.ajax({
						url:"/MMONG/calendar/select.do",
						type:"post",
						dataType:"JSON",
						data: {"${_csrf.parameterName}":"${_csrf.token}"},
						success:function(list){
							
				 			var events = new Array();

							$.each(list, function(i){
								events[i] = {"title":this.title, 
													"content":this.content, 
													"start":new Date(this.startDate), 
													"end":new Date(this.endDate),
													"type":this.type,
													"no":this.no};
							}); 
									
							for(var j=0; j<events.length; j++){
								if(parseInt(events[j].type) == 0){ //개인 일정
									events[j].color="#b3ccff";
								}else if(parseInt(events[j].type) == 1){ //진료 일정
									events[j].color="#C9C0BB";
								}else{ // 2 : 소모임 일정
									events[j].color="#e6b3cc";
								}
							}
									
							callback(events);
						},
						error:function(){
							alert("Error");
						}
					});
			},
			eventClick:function(event) {
				if(event.no){
					window.open("/MMONG/calendar/viewSchedule.do?eventNo="+event.no, "일정추가", specs);
					return false;
				}
			}

		}); //end of .fullCalendar
		
		$("#add").on("click",function(){
			window.open("/MMONG/calendar/insertSchedule.do", "일정추가", specs);
		});
	});

</script> 

	<section class="wrapper site-min-height">
	<br><br>
	<div align="right">
		<input type="button" class="btn btn-default" style="background-color:#F2F2F2" value="일정 추가" id="add"><br><br>
		<div style="color:#b3ccff; background-color:#b3ccff;" class="typeColor">　　　</div><div class="typeColor">　개인 일정</div><br>
		<div style="color:#C9C0BB; background-color:#C9C0BB;" class="typeColor">　　　</div><div class="typeColor">　진료 일정</div><br>
		<div style="color:#e6b3cc; background-color:#e6b3cc;" class="typeColor">　　　</div><div class="typeColor">　모임 일정</div><br>
		<div style="color:#DB7093; background-color:#DB7093;" class="typeColor">　　　</div><div class="typeColor">　공휴일　&nbsp;</div><br>
	</div>
	<hr><br>

	<div id='calendarFull'></div>

	</section>
