<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	
<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var myIndex = 0;
	carousel();

	function carousel() {
	    var i;
	    var x = document.getElementsByClassName("mySlides");
	    for (i = 0; i < x.length; i++) {
	      x[i].style.display = "none";  
	    }
	    myIndex++;
	    if (myIndex > x.length) {myIndex = 1}    
	    x[myIndex-1].style.display = "block";  
	    setTimeout(carousel, 5000);    
	}
	$('#sidebar').css({
        'margin-left': '-180px'
    });
	$('#sidebar > ul').hide();
	$("#container").addClass("sidebar-closed");
	$("#total_div").css("min-height", (document.body.scrollHeight-38.4)+"px");
	$(".mySlides").css("width", (document.body.scrollWidth)+"px");
	
	$('.fa-bars').click(function () {
	    if ($('#sidebar > ul').is(":visible") === true) {
	        $('#main-content').css({
	            'margin-left': '180px'
	        });
	        $('#sidebar').css({
	            'margin-left': '0'
	        });
	        $('#sidebar > ul').show();
	        $("#container").addClass("sidebar-closed");
	    } else {
	        $('#main-content').css({
	            'margin-left': '180 px'
	        });
	        $('#sidebar').css({
	            'margin-left': '-180px'
	        });
	        $('#sidebar > ul').hide();
	        $("#container").removeClass("sidebar-closed");
	    }
	});
});

window.onload=function(){
	
}



    
</script>

<style>
.mySlides {display:none;}
/* .w3-content{max-width:980px;margin:auto} */
/* .w3-section{
	margin-top:16px!important;
	margin-bottom:16px!important;
	position:absolute;
	top:61px;
	left:200px;
} */
.w3-animate-left{
	/* position:relative; */
	animation:animateleft 0.4s
}
/* @keyframes animateleft{from{left:-300px;opacity:0} to{left:0;opacity:1} */
.mySlides {
	display:none;
	margin-left:-180px;
}
</style>

<div id="total_div">
	<<%-- section class="wrapper site-min-height">
 --%>

<div class="w3-content w3-section" style="max-width:500px">
  <img class="mySlides w3-animate-left" src="/MMONG/resource/assets/img/puppy/puppy1.jpg" style="width:100px;">
  <img class="mySlides w3-animate-left" src="/MMONG/resource/assets/img/puppy/puppy2.jpg" style="width:100px;" >
  <img class="mySlides w3-animate-left" src="/MMONG/resource/assets/img/puppy/puppy3.jpg" style="width:100px;">
   <img class="mySlides w3-animate-left" src="/MMONG/resource/assets/img/puppy/puppy4.jpg" style="width:100px;">
   <img class="mySlides w3-animate-left" src="/MMONG/resource/assets/img/puppy/puppy5.jpg" style="width:100px;">
</div>


	<%-- </section> --%>
</div>
