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
    var x = $(".mySlides");
    for (i = 0; i < x.length; i++) {
       x[i].style.display = "none";  
    }
    myIndex++;
    if (myIndex > x.length) {myIndex = 1}    
    x[myIndex-1].style.display = "block";  
    setTimeout(carousel, 2100); // Change image every 2 seconds
}
});

window.onload=function(){
	$("#total_div").css("min-height", (document.body.scrollHeight-38.4)+"px");
}
</script>

<style>
.mySlides {display:none;}
.w3-content{max-width:980px;margin:auto}
.w3-section{
	margin-top:16px!important;
	margin-bottom:16px!important;
	margin-left:16px;
	position:absolute;
	top:61px;
	left:200px;
}
</style>

<div id="total_div">
	<section class="wrapper site-min-height">

<img src="/MMONG/resource/assets/img/puppy/dogwalking.jpg" alt="Architecture" width="1000" height="700">
<!-- <div class="w3-content w3-section" style="max-width:500px">
  <img class="mySlides" src="/MMONG/resource/assets/img/puppy/puppy1.jpg" style="width:240%;filter: opacity(60%)">
  <img class="mySlides" src="/MMONG/resource/assets/img/puppy/puppy2.jpg" style="width:240%;filter: opacity(60%)">
  <img class="mySlides" src="/MMONG/resource/assets/img/puppy/puppy3.jpg" style="width:240%;filter: opacity(60%)">
</div> -->

	</section>
</div>
